class AdminController < ApplicationController
  def index
    @guests = Guest.all
    @rsvps = Rsvp.all
  end
end
