class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("activation.acc_activ")
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: t("reset.pass")
  end
end
