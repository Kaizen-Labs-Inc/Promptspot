class InviteMailer < ApplicationMailer
  default from: 'hello@promptspot.fun'

  def invitation_email(invite)
    @invite = invite
    @url = new_user_registration_url(invitation_token: @invite.token)
    mail(to: @invite.email, subject: 'You have been invited to PromptSpot')
  end
end
