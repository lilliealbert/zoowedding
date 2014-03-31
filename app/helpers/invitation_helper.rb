module InvitationHelper
  def event_description(event)
    case event
    when "rehearsal_dinner"
      "Rehearsal Dinner - Friday 10/3/2014 at 7:00pm — Location TBD"
    when "zoo_walk"
      "Walk Around the Zoo in Fancy Clothes - Saturday 10/4/14 at 3:30pm in the SF Zoo"
    when "wedding"
      "Ceremony & Reception - Saturday, 10/4/14 at 5:30pm in the SF Zoo"
    when "brunch"
      "Picnic Brunch - Sunday, 10/5/14 at 11:00am in Precita Park"
    end
  end
end
