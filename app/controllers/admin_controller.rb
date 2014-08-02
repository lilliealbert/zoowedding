class AdminController < ApplicationController
  http_basic_authenticate_with name: ENV["ADMIN_USERNAME"], password: ENV["ADMIN_PASSWORD"] unless Rails.env.development?

  before_action :load_guests, :load_rsvps, :load_invitations

  def index
  end

  def send_invitations
    InvitationSender.send_invitations
    flash[:success] = "Invitations sent!"
    redirect_to admin_path
  end

  def send_reminders
    InvitationSender.send_reminders
    flash[:success] = "Reminders sent, probably!"
    redirect_to admin_path
  end

  private

  def load_guests
    @guests = Guest.joins(:invitation).order("invitations.name")
  end

  def load_rsvps
    @rsvps = Rsvp.all
  end

  def load_invitations
    @invitations = Invitation.includes(:guests)
  end
end
