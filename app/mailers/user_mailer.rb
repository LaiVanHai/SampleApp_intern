class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("activation.acc_activ")
  end

  def password_reset
    @greeting = t "activation.hi"

    mail to: "to@example.org"
  end
end
