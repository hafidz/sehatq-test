class Api::V1::DoctorsController < ApplicationController
  before_action :validate_token
  before_action :authenticate_user

  def index
    if params[:hospital_id].present?
      hospital_doctors = HospitalDoctor.where("hospital_id = ?", params[:hospital_id])
      data = []
      hospital_doctors.each do |hospital_doctor|
        data << {doctor_id: hospital_doctor.doctor_id, doctor_name: hospital_doctor.try(:doctor).try(:name), hospital_id: hospital_doctor.hospital_id, hospital_name: hospital_doctor.try(:hospital).try(:name)}
      end
    else
      hospital_doctors = HospitalDoctor.all
      data = []
      hospital_doctors.each do |hospital_doctor|
        data << {doctor_id: hospital_doctor.doctor_id, doctor_name: hospital_doctor.try(:doctor).try(:name), hospital_id: hospital_doctor.hospital_id, hospital_name: hospital_doctor.try(:hospital).try(:name)}
      end
    end
    render :json => {meta:{code: 200, messages: "success"}, data: data}
  end
end
