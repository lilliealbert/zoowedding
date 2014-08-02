require "spec_helper"

describe ShuttleController do
  let(:invitation) { create :invitation }

  describe "GET #new" do
    subject { get :new, external_id: invitation.external_id }

    it "succeeds" do
      expect(subject).to be_success
    end

    it "finds the invitation" do
      subject
      expect(assigns[:invitation]).to eq invitation
    end
  end

  describe "PATCH #create" do
    context "with good params" do
      subject { patch :create, invitation_id: invitation.id, invitation: { shuttle: "1" } }

      it "records the shuttle RSVP" do
        expect { subject }.to change { invitation.reload.shuttle }.from(nil).to(true)
      end

      it "sets the flash message" do
        subject
        expect(flash[:message]).to eq "Great, thanks for letting us know!"
      end

      it "redirects to root" do
        expect(subject).to redirect_to faq_path
      end
    end
  end
end
