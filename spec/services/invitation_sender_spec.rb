require "spec_helper"

describe InvitationSender do
  let!(:guest) { create(:guest) }
  let(:invitation) { guest.invitation.reload }

  describe "#send_invitations" do
    subject { InvitationSender.send_invitations }


    it "sends invitations" do
      expect { subject }.to change(ActionMailer::Base.deliveries, :count).by(1)
    end

    it "records that the invitation was sent" do
      expect { subject }.to change{invitation.reload.sent_at}.from(nil)
    end

    context "with previously sent invitations" do
      let(:guest_two) { create(:guest) }
      let(:new_invite) { guest_two.invitation }

      before { subject }

      it "only sends to new invitations" do
        expect(invitation.sent_at).to be_present
        expect(new_invite.sent_at).to be_nil

        expect { InvitationSender.send_invitations }.to change(ActionMailer::Base.deliveries, :count).by(1)
        expect { InvitationSender.send_invitations }.not_to change{invitation.sent_at}

        expect(new_invite.reload.sent_at).to be_present
      end
    end
  end

  describe "#send_reminders" do
    subject { InvitationSender.send_reminders }

    it "sends reminders" do
      expect { subject }.to change(ActionMailer::Base.deliveries, :count).by(1)
    end

    context "with already RSVP'd guests" do
      let(:guest_two) { create(:guest) }
      let(:new_invite) { guest_two.invitation }
      let(:wedding) { create(:wedding) }

      before do
        new_invite.rsvps << Rsvp.new(event: wedding, attending: true)
        new_invite.save
      end

      it "emails guests without RSVPs" do
        expect { subject }.to change(ActionMailer::Base.deliveries, :count).by(1)
      end

      it "doesn't email guests with RSVPs" do
        subject
        expect(ActionMailer::Base.deliveries.first.to).to eq([guest.email])
        expect(ActionMailer::Base.deliveries.first.to).not_to include([guest_two.email])
      end
    end
  end
end
