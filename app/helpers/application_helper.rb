module ApplicationHelper
  include Pagy::Frontend

  DEFAULT_IMAGE_URL =
    'https://img.freepik.com/free-photo/modern-living-room-style_53876-144814.jpg?w=1380&t=st=1679986771~exp=1679987371~hmac=8f503fc971412595ec3a4b7508c2ca8228137bcc8a11ed170d602519fecb6a12'

  HOME = 'Home'
  ABOUT = 'About'
  CONTACT = 'Contact'
  HELP = 'Help'
  PAGES_TITLES = [HOME, ABOUT, CONTACT, HELP]

  def define_image_url(model)
    model.images.attached? ? model.images.first : DEFAULT_IMAGE_URL
  end

  def define_path(entity)
    if entity == HOME
      '/'
    else
      entity.downcase
    end
  end
end
