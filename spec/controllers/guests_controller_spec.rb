require "spec_helper"

describe GuestsController do
  describe "GET new" do
    subject { get :new }

    it { should be_success }
  end

  describe "POST create" do
    let(:guest_params) { {
      name: "Basil",
      email: "basil@example.com",
      relationship_type: "lillie_family"
    } }
    let(:invitation_params) { { name: "cats" } }
    let(:params) { { guest: guest_params, invitation: invitation_params } }

    subject { post :create, params }

    it "should create a new guest" do
      expect { subject }.to change { Guest.count }.from(0).to(1)
    end

    context "when there is not an existing invitation" do
      it "should create a new invitation" do
        expect { subject }.to change { Invitation.count }.by(1)
      end

      it "should create RSVP" do
        expect { subject }.to change { Rsvp.count }.by(3)
      end
    end

    context "when there is an existing invitation" do
      let!(:invitation) { create :invitation }
      let(:invitation_params) { { name: invitation.name } }

      before do
        Invitation.any_instance.stub_chain(:rsvps, :count).and_return(4)
      end

      it "should not create a new invitation" do
        expect { subject }.not_to change { Invitation.count }
      end

      it "should create RSVP" do
        expect { subject }.not_to change { Rsvp.count }
      end

      it "should associate the guest with the correct invitation" do
        expect(Guest.last).to eq(invitation.guests.first)
      end
    end
  end
end
