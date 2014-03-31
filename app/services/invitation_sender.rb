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
end
