FactoryGirl.define do
  factory :invitation do
    name { Faker::Lorem.word }
    external_id SecureRandom.urlsafe_base64
  end

  factory :guest do
    name  { "#{Faker::Name.first_name} #{Faker::Name.last_name}" }
    email { Faker::Internet.email }
    invitation
  end

  factory :event, aliases: [:wedding] do
    title "wedding"

    factory :brunch do
      title "brunch"
    end
  end

  factory :rsvp, aliases: [:wedding_rsvp] do
    invitation
    event

    factory :brunch_rsvp do
      invitation
      brunch
    end
  end

end
