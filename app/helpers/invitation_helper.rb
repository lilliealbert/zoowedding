module InvitationHelper
  def event_description(event)
    case event
    when "rehearsal_dinner"
      "Rehearsal Dinner - Friday, October 3, 2014 at 7:00pm"
    when "zoo_walk"
      "Walk Around the Zoo in Fancy Clothes - Saturday, October 4, 2014 at 3:30pm"
    when "wedding"
      "Ceremony & Reception - Saturday, October 4, 2014 at 5:30pm"
    when "brunch"
      "Picnic Brunch - Sunday, October 5, 2014 at 11:00am"
    end
  end
end
