module AdminHelper
  def event_rsvp(invitation, event_title)
    invitation.rsvps.where(event: Event.find_by_title(event_title)).first.attending
  end
end
