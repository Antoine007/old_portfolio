class CliniciansController < ApplicationController

  def show
    @clinician = Clinician.find_by_token(params[:token])
    @patients = @clinician.patients

    # set number of patietns shown with .take(x)
    @patients = @patients.sort { |a,b| b.updated_at <=> a.updated_at }.take(5)
  end

  def new
  end

  def create
    @clinician = Clinician.create(clinician_params)
    @clinician[:token] = SecureRandom.urlsafe_base64(16, true)

    if @clinician.save
      #used to set locale
      flash.now[:notice] = 'Clinician created!'
      link = locale_link
      ClinicianMailer.welcome(@clinician, link).deliver_now
      redirect_to thank_you_path, notice: 'Clinician was successfully created.'
    else
      # TODO make the alerts work
      p "shit"
      redirect_to new_clinician_path, alert: "That's not an email!"
      # flash.now[:alert] = "That's not an email!"
      p "shit2"
    end
  end

  private

  def clinician_params
    params.require(:clinician).permit(:email, :first_name, :last_name)
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

end
