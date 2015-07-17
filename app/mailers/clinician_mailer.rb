class ClinicianMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.clinician_mailer.welcome.subject
  #
  def welcome(clinician, link)
    @user = clinician
    @link = link

    mail(to: @user.email, subject: (t('subject') + t('app_title')))
  end

  def new_patient(patient, link, email = "antoine@sign2pay.com")
    # method sends email to doctor if patient has no smartphone

    # if clinician has no email and patient no smartphone, issue@sign2.com receives email
    # TODO switch antoine@ to issue@ or something once in production

    @user = patient
    @link = link

    mail(to: email, subject: t('subject_patient'))
  end

end
