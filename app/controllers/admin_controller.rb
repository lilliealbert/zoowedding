class AdminController < ApplicationController
  http_basic_authenticate_with name: ENV["ADMIN_USERNAME"], password: ENV["ADMIN_PASSWORD"]

  def index
    @guests = Guest.joins(:invitation).order("invitations.name")
    @rsvps = Rsvp.all
  end
end
