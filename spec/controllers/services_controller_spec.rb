require 'rails_helper'

RSpec.describe ServicesController do
  describe 'create service' do
    let(:params) do
      {
        service: {
          "company_id": 1,
          "name": 'Servicio XZ',
          "init_date": '2022-11-11',
          "end_date": '2022-12-01'},
        days: {
          "0": [10, 14],
          "1": [10, 14],
          "2": [10, 15],
          "3": [8, 12],
          "4": [8, 14],
          "5": [14, 18],
          "6": []
        }
      }
    end
    ## TODO
  end
end
