class RailwayMailer < ApplicationMailer
  default from: "kunal.r@preciousinfosystem.com"

  def welcome_email
    @ticket = params[:ticket]
    @url  = 'http://example.com/login'
    mail(to: @ticket.email, subject: 'Ticked booked')
  end
end
