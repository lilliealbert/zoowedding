class InvitationSender
  def self.send_invitations
    guests = Guest.with_email
    guests.each do |guest|
      unless guest.invitation.sent_at?
        InvitationMailer.invitation(guest.invitation).deliver
        guest.invitation.update_attribute(:sent_at, Time.now)
      end
    end
  end

  def self.send_reminders
    invitations_without_rsvps = Invitation.all.map do |i|
      i if i.rsvps.pluck(:attending).compact.empty?
    end
    invitations_without_rsvps.compact.each do |invitation|
      InvitationMailer.reminder(invitation).deliver
    end
  end
end
