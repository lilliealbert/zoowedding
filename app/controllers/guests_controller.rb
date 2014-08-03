class GuestsController < ApplicationController
  http_basic_authenticate_with name: ENV["ADMIN_USERNAME"], password: ENV["ADMIN_PASSWORD"] unless Rails.env.development? || Rails.env.test?

  def index
    @guests = Guest.all
  end

  def new
    @guest = Guest.new
  end

  def create
    invitation = Invitation.find_or_create_by(name: invitation_params[:name])
    guest = invitation.guests.build(guest_params)

    if guest.save
      create_rsvps(invitation) if invitation.rsvps.count < 3
      flash[:success] = "Guest added with invitation name #{invitation.name} & relationship type #{guest.relationship_type}"
      redirect_to new_guest_path
    else
      flash.now[:error] = "No such luck"
      render :new
    end
  end

  private

  def guest_params
    params.require(:guest).permit(:name, :email, :relationship_type)
  end

  def invitation_params
    params.require(:invitation).permit(:name)
  end

  def create_rsvps(invitation)
    (2..4).each do |event_id|
      rsvp = invitation.rsvps.build(event_id: event_id)
      rsvp.save!
    end
  end
end
