require 'spec_helper'

describe Invitation do
  let(:invitation) { create(:invitation) }

  it "should have an external ID" do
    expect(invitation.external_id).to be_present
    expect(invitation.external_id.length).to eq 22
  end

  describe "#is_coming?" do
    let(:guest) { create(:guest) }
    let(:event) { create(:event) }
    let(:invitation) { guest.invitation }
    let(:rsvp) { create(:rsvp, invitation: invitation, event: event)}

    context "with no responses" do
      it "should return false" do
        expect(invitation.is_coming?).to eq false
      end
    end

    context "with a response" do
      before { rsvp.update_attribute(:attending, true) }
      it "should return true" do
        expect(invitation.is_coming?).to be_true
      end
    end

  end
end
