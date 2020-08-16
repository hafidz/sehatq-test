class Api::V1::SchedulesController < ApplicationController
  before_action :validate_token
  before_action :authenticate_user

  def index
  	condition = []
    condition << "hospital_doctors.doctor_id = #{params[:doctor_id]}" if params[:doctor_id].present?
    condition << "hospital_doctors.hospital_id = #{params[:hospital_id]}" if params[:hospital_id].present?
    condition << "DATE(schedules.schedule_date) ='#{params[:date].to_date.strftime('%Y-%m-%d')}'" if params[:date].present?
    # condition << ""
    schedules = Schedule.joins(:hospital_doctor).where(condition.join(' AND '))
    # schedules = Schedule.all
    data = []
    condition = []
    schedules.each do |schedule|
      bookings = []
      schedule.bookings.each do |booking|
        bookings << {booking_id: booking.id, user_id: booking.user_id, user_name: booking.try(:user).try(:full_name), booking_date: booking.booking_date.strftime("%H:%M:%S")}
      end

      data << {schedule_id: schedule.id, hospital_doctor_id: schedule.hospital_doctor_id, doctor_name: schedule.try(:hospital_doctor).try(:doctor).try(:name), hospital_name: schedule.try(:hospital_doctor).try(:hospital).try(:name), schedule_date: schedule.schedule_date.strftime("%d %B %Y"), schedule_time: schedule.schedule_date.strftime("%H:%M:%S"), bookings: bookings}
    end
    render :json => {meta:{code: 200, messages: "success"}, data: data}
  end
end
