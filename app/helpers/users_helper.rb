module UsersHelper
  include Digest

  def gravatar_for user, size: 80
    gravatar_id = MD5.new.hexdigest user.email.downcase
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag gravatar_url, alt: user.name, class: "gravatar"
  end
end
