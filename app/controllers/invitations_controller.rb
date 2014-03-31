class InvitationsController < ApplicationController
  before_filter :load_invitation, only: :edit

  def edit
    session[:external_id] = params[:external_id]
  end

  def update
    @invitation = Invitation.find(params[:id])
    if @invitation.update_attributes(invitation_params)
      flash[:success] = "Thanks for your RSVP!"
    else
      flash[:warning] = @invitation.errors.full_messages
    end

    redirect_to secretive_path(@invitation.external_id)
  end

  private

  def invitation_params
    params.require(:invitation).permit(guests_attributes: [:name, :_destroy, :id], rsvps_attributes: [:attending, :id])
  end

  def load_invitation
    @invitation = Invitation.find_by_external_id(params[:external_id])
  end
end
