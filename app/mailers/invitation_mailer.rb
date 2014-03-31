class InvitationMailer < ActionMailer::Base

  def invitation(invitation)
    @invitation = invitation
    mail(
      to: invitation.guests.pluck(:email),
      from: 'Lillie & Travis <lillie.chilen@gmail.com>',
      subject: "A Zoo Wedding, featuring Lillie and Travis!"
    )
  end
end
