class Api::V1::BookingsController < ApplicationController
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
      data << {schedule_id: schedule.id, hospital_doctor_id: schedule.hospital_doctor_id, doctor_name: schedule.try(:hospital_doctor).try(:doctor).try(:name), hospital_name: schedule.try(:hospital_doctor).try(:hospital).try(:name), schedule_date: schedule.schedule_date.strftime("%d %B %Y"), schedule_time: schedule.schedule_date.strftime("%H:%M:%S")}
    end
    render :json => {meta:{code: 200, messages: "success"}, data: data}
  end

  def create
  	if check_maximum_time_booking(params[:booking])
  	  if check_maximum_patients(params[:booking])
        booking = Booking.new(booking_params)
    	if booking.save
          render :json => {meta:{code: 200, messages: "success"}, data: booking}
        end
      else
        render :json => {meta:{code: 400, messages: "The total queue has reached the maximum limit of 10 patients."}, data: {}}
      end
    else
      render :json => {meta:{code: 400, messages: "Booking can only be made 30 minutes before the doctor's schedule starts."}, data: {}}
    end
  end

  private
  	def check_maximum_patients(params)
  	  booking = Booking.where(schedule_id: params[:schedule_id]).count

      if booking <= 10
        return true
      else
        return false
      end
    end

    def check_maximum_time_booking(params)
  	  schedule = Schedule.find(params[:schedule_id])
      schedule_date = schedule.schedule_date
      booking_date = Time.parse(params[:booking_date])
      check_time = (schedule_date - booking_date) / 1.minutes
      if check_time >= 30
        return true
      else
        return false
      end
    end

    def booking_params
      params.require(:booking).permit(:user_id, :schedule_id, :hospital_doctor_id, :booking_date, :queue_number)
    end
end
