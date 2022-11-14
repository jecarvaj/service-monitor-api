class ServicesController < ApplicationController
  before_action :set_service, only: %i[show update destroy update_availability_and_confirm_shifts]
  before_action :set_week, only: %i[show update_availability_and_confirm_shifts]
  # GET /services
  def index
    @services = Service.all
    @companies = Company.all
    @agents = User.agents

    render(
      json: Panko::Response.create do |r|
        {
          agents: @agents,
          companies: @companies,
          services: Panko::ArraySerializer.new(@services,
                                                    each_serializer: ServiceSerializer)
        }
      end
    )
  end

  # GET /services/:id/:week
  def show
    render(
      json: Panko::Response.create do |r|
        {
          service: r.serializer(@service, ServiceSerializer),
          schedule_days: Panko::ArraySerializer.new(@service.schedule_days.where(week: @week),
                                                    each_serializer: ScheduleDaySerializer)
        }
      end
    )
  end

  # POST /services
  def create
    @service = Service.new(service_params)

    GenerateScheduleService.call(@service, days_params_hashed)

    if @service.save
      render json: @service, status: :created, location: @service
    else
      render json: @service.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /services/1
  def update
    if @service.update(service_params)
      render json: @service
    else
      render json: @service.errors, status: :unprocessable_entity
    end
  end

  # DELETE /services/1
  def destroy
    @service.destroy
  end

  def update_availability_and_confirm_shifts
    params['data'].each { |d| edit_availability(d['block_id'], d['agent_id'], d['action']) }

    AssignShiftsService.call(@service, @week) && show
  end

  private

  def set_service
    @service = Service.find(params[:id] || params[:service_id])
  end

  def set_week
    @week = params[:week]
  end

  def service_params
    params.require(:service).permit(:company_id, :name, :init_date, :end_date)
  end

  def days_params_hashed
    params.require(:days).to_enum.to_h # {'0": [8, 12], "1": [8,12], "2": [8,12]...etc}
  end

  def edit_availability(block_id, agent_id, action)
    block = ScheduleBlock.find(block_id)
    agent = User.find(agent_id)

    case action
    when 'remove'
      block.users.delete(agent)
      block.user_id = nil if agent.id == block.user_id
    when 'add'
      block.users << agent unless block.user_ids.include?(agent.id)
    end
    block.save
  end
end
