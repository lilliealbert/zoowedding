require "spec_helper"

describe InvitationSender do
  let!(:guest) { create(:guest) }
  let(:invitation) { guest.invitation.reload }

  subject { InvitationSender.send_invitations }

  it "sends survey emails to all the attendees who checked in" do
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
