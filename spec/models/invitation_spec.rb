require 'spec_helper'

describe Invitation do
  let(:invitation) { create(:invitation) }

  it "should have an external ID" do
    expect(invitation.external_id).to be_present
    expect(invitation.external_id.length).to eq 22
  end
end
