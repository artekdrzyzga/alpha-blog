module ApplicationHelper
  def gravatar_for(user, options = {size: 80})
    email_address = user.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    size = options[:size]
    gravatr_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
    image_tag(gravatr_url, alt: user.username, class: "rounded shadow shadow-warning mx-auto d-block")
  end
end
