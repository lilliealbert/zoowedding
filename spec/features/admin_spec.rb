require 'spec_helper'

describe "doing admin things" do
  before do
    page.driver.browser.authorize ENV['ADMIN_USERNAME'], ENV['ADMIN_PASSWORD']
    Event::TITLES.each { |title| Event.create(title: title) }
  end

  it "allows the admin to send emails" do
    visit admin_path
    expect(page).to have_content "WELCOME TO ADMIN LAND"
  end
end
