class UserMailer < ApplicationMailer
  default from: 'guillaumdemonie@gmail.com'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user)
    @user = user.first_name
    mail(to: user.account.email, subject: 'Welcome to the woods')
  end

  def confirm_booking(booking)
    @appartment = booking.appartment
    @user = booking.user
    @appartment_address = @appartment.address
    @start_date = booking.start_date
    @end_date = booking.end_date
    number_nights = (@start_date..@end_date).count
    @booking_cost = @appartment.price * number_nights

    mail(to: @user.account.email, subject: 'Thanks for your booking')
  end

end



