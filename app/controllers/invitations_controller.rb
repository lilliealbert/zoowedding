class InvitationsController < ApplicationController
  before_filter :load_invitation, only: :edit

  def edit
    session[:external_id] = params[:external_id]
  end

  def update
    @invitation = Invitation.find(params[:id])
    if @invitation.update_attributes(invitation_params)
      flash[:success] = thanks_message(params[:commit])
    else
      flash[:warning] = @invitation.errors.full_messages
    end

    redirect_to secretive_path(@invitation.external_id)
  end

  private

  def invitation_params
    params.require(:invitation).permit(:shuttle, guests_attributes: [:name, :_destroy, :id], rsvps_attributes: [:attending, :id])
  end

  def load_invitation
    @invitation = Invitation.find_by_external_id(params[:external_id])
  end

  def thanks_message(button_text)
    if button_text == "Yes! See you soon!"
      "Woo hoo! We can't wait to see you!"
    elsif button_text == "Shoot, we can't make it at all."
      "Aw, bummer you can't make it. Thanks for RSVPing, though!"
    else
      "Thanks for RSVPing!"
    end
  end
end
