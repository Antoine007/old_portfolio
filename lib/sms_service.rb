# Deliver SMS messages to a Phone instance.
#
# This class wraps an external service. When we switch service, this class' interface should remain the same.
#   SmsService.new(phone).deliver("this is a message")
#   SmsService.new(phone).deliver("this is a message", "Widgets") # => optional Sender ID, defaults to SIGN2PAY
require 'plivo'

class SmsService

  def initialize(phone)
    @phone = phone
  end

  def deliver(message, src="SIGN2HEAL")
    plivo.send_message({
      src: filtered(src),
      dst: @phone,
      text: message
      })
  end

  private

  def plivo
    Plivo::RestAPI.new(ENV['PLIVO_AUTH_ID'], ENV['PLIVO_AUTH_TOKEN'])
  end

  # Filter out disallowed characters in the Caller ID.
  def filtered(string)
    string.
      tr('^A-Za-z0-9 ', '').
      squeeze(' ').
      strip
  end

end
