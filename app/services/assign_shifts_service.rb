class AssignShiftsService < ApplicationService
  def initialize(service, week)
    @service = service
    @agents = User.agents
    @blocks = service.schedule_blocks.where(schedule_day_id: @service.schedule_days.by_week(week).ids)
    @taken_hours_by_agent = {}
  end

  def call
    reset_assignments
    fill_uniq_blocks
    update_taken_hours
    assign_shifts_algorithm
  end

  def reset_assignments
    @blocks.update_all(status: nil, user_id: nil)
  end

  def fill_uniq_blocks
    @blocks.each do |block|
      block.update(user_id: block.user_ids.first, status: 'assigned') if block.user_ids.length == 1
    end
  end

  def update_taken_hours
    @agents.each do |agent|
      @taken_hours_by_agent[agent.id] = @blocks.where(user_id: agent.id).size
    end
  end

  def assign_shifts_algorithm
    @blocks.each do |block|
      next if block.user_ids.empty?
      next if block.user_id.present? && block.user_ids.length == 1
      next if block.status == 'assigned'

      unless assign_consecutive_shifts_by_single_agent(block) 
        assign_shift_by_min_hours(block)
      end
      update_taken_hours
    end
  end

  private

  def assign_consecutive_shifts_by_single_agent(block)
    consecutive_blocks = blocks_consecutives_by_agent(block)
    max_blocks = consecutive_blocks.last[1].size

    if consecutive_blocks.select { |_k, v| v.size == max_blocks }.size == 1
      agent_id, block_ids = consecutive_blocks.last
      @blocks.where(id: block_ids).update_all(user_id: agent_id, status: 'assigned')
      true
    else
      false
    end
  end

  def assign_shift_by_min_hours(block)
    new_user = if block.previous&.user_id.in?(block.user_ids)
                 block.previous.user_id
               else
                 @taken_hours_by_agent.select { |k, _v| k.in?(block.user_ids) }.min_by { |_k, v| v }[0]
               end
    block.update(user_id: new_user, status: 'assigned')
  end

  def blocks_consecutives_by_agent(block)
    agent_possible_blocks = Hash.new { |a, v| a[v] = [] }
    block.users.each do |agent|
      agent_possible_blocks[agent.id] = calculate_possible_blocks(block, agent.id)
    end

    agent_possible_blocks.sort_by { |_k, v| v.size }
  end

  def calculate_possible_blocks(init_block, agent_id)
    block_ids = []
    day = init_block.schedule_day

    (init_block.hour..(day.end_time - 1)).to_a.each do |hour|
      current_block = day.block_by_hour(hour)
      break unless current_block.user_ids.include?(agent_id)

      block_ids << current_block.id
    end
    block_ids
  end
end
