require 'spec_helper'

describe GuestImporter do
  let(:importer) { GuestImporter.new(Rails.root.join("testdata", "guests.csv")) }

  describe "#import" do
    let(:basil) { Guest.find_by_email("basil@example.com") }
    let(:bulleit) { Guest.find_by_email("bulleit@example.com") }

    subject { importer.import }

    it "creates guests" do
      expect {subject}.to change{ Guest.count }.from(0).to(4)
    end

    context "invitations" do
      let(:cat_invitation) { Invitation.find_by_name("cats") }

      it "groups guests into invitations" do
        expect {subject}.to change{ Invitation.count }.from(0).to(2)
      end

      it "groups guests in to the right invitations" do
        subject
        expect(basil.invitation).to eq cat_invitation
        expect(bulleit.invitation).to eq cat_invitation
      end
    end

    context "RSVPS" do
      let(:rsvps) { basil.invitation.rsvps }
      let(:wedding) { Event.find_by_title "wedding" }
      let(:brunch) { Event.find_by_title "brunch" }

      it "creates RSVP for each event the invitation includes" do
        expect {subject}.to change{ Rsvp.count }.from(0).to(5)
      end

      it "creates the right RSVPs" do
        subject
        expect(rsvps.first.event_id).to eq(wedding.id)
        expect(rsvps.last.event_id).to eq(brunch.id)
      end
    end
  end
end
