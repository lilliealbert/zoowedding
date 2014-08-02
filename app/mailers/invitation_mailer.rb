class InvitationMailer < ActionMailer::Base

  def invitation(invitation)
    @invitation = invitation
    mail(
      to: invitation.guests.pluck(:email),
      from: 'Lillie & Travis <lillie.chilen@gmail.com>',
      subject: "A Zoo Wedding, featuring Lillie and Travis!"
    )
  end

  def reminder(invitation)
    @invitation = invitation
    mail(
      to: invitation.guests.pluck(:email),
      from: 'Lillie & Travis <lillie.chilen@gmail.com>',
      subject: "Don't forget to RSVP for this zoo wedding"
    )
  end

  def shuttle(invitation)
    @invitation = invitation
    mail(
      to: invitation.guests.pluck(:email),
      from: 'Lillie & Travis <lillie.chilen@gmail.com>',
      subject: "Zoo wedding logistics: want a ride back from the zoo?"
    )
  end
end
