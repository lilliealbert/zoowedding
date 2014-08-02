class ShuttleController < ApplicationController

  def new
    session[:external_id] = params[:external_id]
    @invitation = Invitation.find_by_external_id params[:external_id]
  end

  def create
    @invitation = Invitation.find(params[:invitation_id])
    if @invitation.update_attributes(shuttle_params)
      flash[:success] = "Great, thanks for letting us know!"
      redirect_to faq_path
    else
      flash[:warning] = "Whoops, something went wrong"
      render :new
    end
  end

  private

  def shuttle_params
    params.require(:invitation).permit(:shuttle)
  end
end
