# to use for secure postback
# require 'openssl'
require 'sms_service'

class PatientsController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:done]

  before_action :find_clinician,        only: [:create]
  before_action :find_patient_by_phone, only: [:completed]
  before_action :find_patient_by_token, only: [:show]
  before_action :find_patient,          only: [:edit, :update]

  def new
  end

  def create
    # TODO find all users of phone number x
    @existing_patient = []
    @returning_patient = []
    Patient.all.each do |patient|
      if patient.phone == params[:patient][:phone]
        @existing_patient << patient
        if patient.clinician_id == @clinician.id
          @returning_patient << patient
        end
      end
    end

    if @existing_patient.empty?
      @patient = creation_of_patient
    elsif @returning_patient.empty?
      @patient = new_clinician_for(@existing_patient.first)
      @patient[:smartphone] = params[:patient][:smartphone]
      @patient[:clinician_id] = @clinician.id
    else
      @patient = @returning_patient.first
      if @patient.update_attributes(update_smartphone_params)
        send_sms_or_email(@patient,@clinician)
        redirect_to edit_clinician_patient_path(@clinician, @patient)
        return
      else
        # TODO raise error if failed to save
        redirect_to :back
        return
      end
    end
    if @patient.save
      send_sms_or_email(@patient,@clinician)
      redirect_to edit_clinician_patient_path(@clinician, @patient)
    else
      # TODO raise error if failed to save
      redirect_to :back
    end
  end

  def show
    @clinician = @patient.clinician
  end

  def done
    render json: {
      status: "success",
      params: {},
      redirect_to: "https://sign2health.herokuapp.com/patients/payment_completed/#{params[:ref_id]}"
    }
  end

  def completed
    @patient[:paid] = true
    @patient.save
    # TODO this should trigger the ajax in clinician show
  end

  def edit
  end

  def update
    @clinician = @patient.clinician
    @patient.update_attributes(update_patient_params)
    # reset status as unpaid for next transaction
    @patient[:paid] = false
      if @patient.save
        # TODO raise error if failed to save
        redirect_to clinician_show_path(@clinician.token)
      else
        # TODO raise error if failed to save

      end
  end

  private #-------------------------------------------------------------------------------

  def patient_params
    params.require(:patient).permit(:phone, :ref_id, :smartphone)
  end

  def find_clinician
    @clinician = Clinician.find(params[:id])
  end

  def find_patient
    @patient = Patient.find(params[:id])
  end

  def find_patient_by_phone
    @patient = Patient.find_by_phone(params[:phone])
  end

  def find_patient_by_token
    @patient = Patient.find_by_token(params[:token])
  end

  def update_patient_params
    params.require(:patient).permit(:amount)
  end

  def update_smartphone_params
    params.require(:patient).permit(:smartphone)
  end

  def locale_link
    if  locale == :nl
      return "nl/"
    elsif  locale == :fr
      return "fr/"
    else
      return ""
    end
  end



  def creation_of_patient
    patient = @clinician.patients.new(patient_params)
    patient[:paid] = false
    patient[:token] = SecureRandom.urlsafe_base64(16, true)

    # for testing only
    patient[:email] = [*('A'..'Z')].sample(5).join + @clinician.email
    # patient[:first_name] = @clinician.first_name + [*('A'..'Z')].sample(5).join
    # patient[:last_name] = @clinician.last_name + [*('A'..'Z')].sample(5).join
    patient[:address] = "Lange Klarenstraat 19"
    patient[:postal_code] = "2000"
    patient[:city] = "Antwerpen"
    patient[:region] = "Antwerp"
    patient[:country] = 'BE'

    patient
  end

  def new_clinician_for(patient)
    new_patient = Patient.new
    new_patient[:paid] = false
    new_patient[:token] = SecureRandom.urlsafe_base64(16, true)

    # TODO make this clean!
    new_patient[:phone] = patient[:phone]
    new_patient[:ref_id] = patient[:ref_id]
    new_patient[:email] = patient[:email]
    new_patient[:first_name] = patient[:first_name]
    new_patient[:last_name] = patient[:last_name]
    new_patient[:address] = patient[:address]
    new_patient[:postal_code] = patient[:postal_code]
    new_patient[:city] = patient[:city]
    new_patient[:region] = patient[:region]
    new_patient[:country] = patient[:country]

    new_patient
  end

  def send_sms_or_email(patient, clinician)
    if patient[:smartphone]
      # will text the patient with the link to pay

      # email remains for testing
      link = locale_link
      ClinicianMailer.new_patient(patient, link).deliver_now

      send_text(patient[:phone][1..-1],patient.clinician_id,patient.token)
    else
      # will send link to clinician's email for signature on tablet as patient has no smartphone

      link = locale_link
      # add next line once out of trial, wills send email to the clinician
      # clinician.email = "antoine@sign2pay.com"
      ClinicianMailer.new_patient(patient, link, clinician.email).deliver_now
    end
  end

  def send_text(intl_phone,clinician_id,patient_token)
    link = locale_link
    message = "Here is your link to pay your clinician: http://sign2health.herokuapp.com/#{@link}clinicians/#{clinician_id}/patients/#{patient_token} #{t('sms_sign_out')}"
    SmsService.new(intl_phone).deliver(message)
  end

end
