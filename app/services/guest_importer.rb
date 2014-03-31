require 'csv'

class GuestImporter

  def initialize(file)
    @guests = CSV.read(
      file,
      headers: true,
      header_converters: :symbol
    ).map(&:to_hash)
  end

  def import
    make_events
    @guests.each do |guest_details|
      guest = Guest.create(
        name: guest_details[:name],
        email: guest_details[:email],
        relationship_type: guest_details[:type]
      )
      make_invitations(guest, guest_details)
      make_rsvps(guest, guest_details)
    end
  end

  private

  def make_invitations(guest, guest_details)
    invite = Invitation.find_or_create_by(name: guest_details[:invitation_group])
    invite.guests << guest
  end

  def make_rsvps(guest, guest_details)
    events = guest_details[:events].split
    events.each do |event_name|
      event = Event.find_by(title: event_name)
      Rsvp.where(invitation_id: guest.invitation.id, event_id: event.id).first_or_create
    end
  end

  def make_events
    Event::TITLES.each do |event_title|
      Event.find_or_create_by(title: event_title)
    end
  end
end
