module AdminHelper
  def event_rsvp(invitation, event_title)
    invitation.rsvps.where(event: Event.find_by_title(event_title)).first.attending
  end

  def total_event_guest_count(event)
    event = Event.where(title: event).first
    Rsvp.where(event: event).map(&:invitation).map(&:guests).map(&:length).sum
  end

  def yes_event_guest_count(event)
    event = Event.where(title: event).first
    Rsvp.yeses.where(event: event).map(&:invitation).map(&:guests).map(&:length).sum
  end

  def nos_event_guest_count(event)
    event = Event.where(title: event).first
    Rsvp.nos.where(event: event).map(&:invitation).map(&:guests).map(&:length).sum
  end
end
