require 'spec_helper'

describe InvitationMailer do
  let!(:guest) { create(:guest) }
  let(:invitation) { guest.invitation.reload }

  describe "#invitation" do
    let(:mail) { InvitationMailer.invitation(invitation) }

    describe "the invitation email" do
      it "is sent to the invited person" do
        expect(mail.to).to eq([guest.email])
      end

      it "includes the invitation link" do
        expect(mail.subject).to eq "A Zoo Wedding, featuring Lillie and Travis!"
        expect(mail.body).to include "Together with their families,"
      end
    end
  end

  describe "#reminder" do
    let(:mail) { InvitationMailer.reminder(invitation) }

    describe "the reminder email" do
      it "is sent to the slow RSVP'er" do
        expect(mail.to).to eq([guest.email])
      end

      it "includes the invitation link" do
        expect(mail.subject).to eq "Don't forget to RSVP for this zoo wedding"
        expect(mail.body).to include "Don't forget to RSVP for the Zoo Wedding of the century!"
      end
    end
  end
end
