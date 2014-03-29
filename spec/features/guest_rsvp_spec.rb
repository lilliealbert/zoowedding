require 'spec_helper'

describe "rsvping to the wedding" do
  let!(:guest) { create(:guest) }
  let(:invitation) { guest.invitation.reload }
  let!(:wedding_rsvp) { create(:rsvp, invitation: invitation) }
  let!(:brunch_rsvp) { create(:rsvp, invitation: invitation, event: create(:brunch)) }

  it "allows users to visit their invitation page" do
    visit secretive_path(invitation.external_id)

    expect(find_by_id('invitation_guests_attributes_0_name').value).to eq guest.name
  end

  it "allows users to RSVP to events" do
    visit secretive_path(invitation.external_id)
    check("Ceremony & Reception")
    check("Picnic Brunch")
    click_button("Yes! See you soon")

    expect(page).to have_content "Thanks for your RSVP!"
    expect(wedding_rsvp.reload.attending).to be_true
    expect(brunch_rsvp.reload.attending).to be_true
  end

  it "allows users to update names" do
    visit secretive_path(invitation.external_id)
    fill_in "invitation_guests_attributes_0_name", with: "One Lemur"
    click_button("Yes! See you soon")

    expect(guest.reload.name).to eq "One Lemur"
  end

  context "with two guests" do
    let!(:guest_two) { create(:guest, invitation: invitation) }

    it "allows users to remove guests" do
      visit secretive_path(invitation.external_id)

      expect(find_by_id('invitation_guests_attributes_0_name').value).to eq guest.name
      expect(find_by_id('invitation_guests_attributes_1_name').value).to eq guest_two.name

      within(first("#guest_name_field")) do
        check("Remove from RSVP")
      end

      click_button("Yes! See you soon")

      expect(find_by_id('invitation_guests_attributes_0_name').value).to eq guest_two.name
    end
  end
end
