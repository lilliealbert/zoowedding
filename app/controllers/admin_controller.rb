class AdminController < ApplicationController
  http_basic_authenticate_with name: ENV["ADMIN_USERNAME"], password: ENV["ADMIN_PASSWORD"]

  def index
    @guests = Guest.all
    @rsvps = Rsvp.all
  end
end
