require 'spec_helper'

describe InvitationsController do
  let!(:invitation) { create(:invitation) }
  let!(:guest) { create(:guest, invitation: invitation) }
  let!(:wedding_rsvp) { create(:rsvp, invitation: invitation) }
  let!(:brunch_rsvp) { create(:rsvp, invitation: invitation, event: create(:brunch)) }

  describe "GET edit" do
    subject { get :edit, external_id: invitation.reload.external_id }

    it "succeeds" do
      subject
      expect(response).to be_success
    end

    it "assigns the correct guests" do
      subject
      expect(assigns[:invitation]).to eq invitation
    end
  end

  describe "PATCH update" do
    subject { patch :update, params }
    let(:params) { {
      invitation: {
        rsvps_attributes: { "0" => {attending: "1", id: wedding_rsvp.id}, "1" => { attending: 1, id: brunch_rsvp.id} },
        guests_attributes: { "0" => {name: guest.name, id: guest.id} },
      },
      id: invitation.id
    } }

    context "attending all the things" do
      it "marks each RSVP attending field as yes" do
        subject
        expect(wedding_rsvp.reload.attending).to be_true
        expect(brunch_rsvp.reload.attending).to be_true
      end
    end

    context "attending just one thing" do
      before { params[:invitation][:rsvps_attributes]["1"][:attending] = 0 }

      it "marks rsvps accordingly" do
        subject
        expect(wedding_rsvp.reload.attending).to be_true
        expect(brunch_rsvp.reload.attending).to be_false
      end
    end

    context "with a new name" do
      before { params[:invitation][:guests_attributes]["0"][:name] = "basil cat" }

      it "updates the guest name" do
        expect { subject }.to change{ guest.reload.name }.to("basil cat")
      end
    end

    context "not attending at all" do
      before do
        params[:invitation][:rsvps_attributes]["1"][:attending] = 0
        params[:invitation][:rsvps_attributes]["0"][:attending] = 0
      end

      it "marks rsvps accordingly" do
        subject
        expect(wedding_rsvp.reload.attending).to be_false
        expect(brunch_rsvp.reload.attending).to be_false
      end
    end
  end
end
