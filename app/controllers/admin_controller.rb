class AdminController < ApplicationController
  http_basic_authenticate_with name: ENV["ADMIN_USERNAME"], password: ENV["ADMIN_PASSWORD"]

  before_action :load_guests, :load_rsvps, :load_invitations

  def index
    @guests = Guest.includes(:invitation).order("invitations.name")
    @rsvps = Rsvp.all
  end

  def send_invitations
    InvitationSender.send_invitations
    flash[:success] = "Invitations sent!"
    render :index
  end

  private

  def load_guests
    @guests = Guest.joins(:invitation).order("invitations.name")
  end

  def load_rsvps
    @rsvps = Rsvp.all
  end

  def load_invitations
    @invitations = Invitation.all
  end
end
