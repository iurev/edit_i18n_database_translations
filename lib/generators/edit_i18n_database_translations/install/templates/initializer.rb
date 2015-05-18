EditI18nDatabaseTranslations.configure do |config|
  config.user_name = 'site_admin'
  config.password = 'very_strong_password'
  config.path_prefix = '/example/path'
  config.allowed_keys = [:pages, :seo_values, :sharing_texts]

  # where images will be uploaded
  config.save_images_path = 'uploads/i18n_images'

  config.save_changes_history = true

  # adds admin page with list of images
  config.show_images_tab = true

  config.check_images_proc = Proc.new do |i18n_key|
    next if i18n_key.empty?
    allowed_extnames = %w{.png .jpg}
    translation = I18n.t(i18n_key)
    next unless translation.is_a? String
    extname = File.extname translation
    allowed_extnames.include? extname
  end

  config.favorite_pages = [
    {name: 'Header', key: :header},
    {name: 'Main', key: :main}
  ]
end
