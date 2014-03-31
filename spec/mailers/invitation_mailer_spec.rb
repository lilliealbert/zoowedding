require 'spec_helper'

describe InvitationMailer do
  let!(:guest) { create(:guest) }
  let(:invitation) { guest.invitation.reload }
  let(:mail) { InvitationMailer.invitation(invitation) }

  describe "the invitation email" do
    it "is sent to the RSVP'd person" do
      expect(mail.to).to eq([guest.email])
    end

    it "includes the invitation link" do
      expect(mail.subject).to eq "A Zoo Wedding, featuring Lillie and Travis!"
      expect(mail.body).to include "Together with their families,"
    end
  end
end
