class Api::V1::HospitalsController < ApplicationController
  before_action :validate_token
  before_action :authenticate_user

  def index
    # hospitals = Hospital.get_all_hospital
    hospitals = Hospital.all
    data = []
    hospitals.each do |hospital|
      data << {hospital_id: hospital.id, hospital_name: hospital.name}
    end
    render :json => {meta:{code: 200, messages: "success"}, data: data}
  end
end
