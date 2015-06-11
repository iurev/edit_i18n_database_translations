module Sass::Script::Functions
  def image_url_i18n(key)
    key = key.value
    url = I18n.t(key)
    ::Sass::Script::String.new("url(" + url + '?i18n_key=' + key + ")")
  end
  declare :image_url_i18n, [:string]
end

module ActionView::Helpers::AssetUrlHelper
  def image_url_i18n(key, options = {})
    if defined?(are_you_i18n_editor?) && are_you_i18n_editor?
      url = I18n.t(key)
      source = "#{url}?i18n_key=#{key}"
      url_to_asset(source, {type: :image}.merge!(options))
    else
      url = I18n.t(key)
      url_to_asset(source, {type: :image})
    end
  end
end

module ActionView::Helpers::AssetTagHelper
  def image_tag_i18n(key, options = {})
    default_image = ''
    default_image_with_key = ''
    url = ''

    if options[:default]
      default_image = options[:default]
      begin
        url = I18n.t(key, raise: true)
      rescue I18n::MissingTranslationData
        if defined?(are_you_i18n_editor?) && are_you_i18n_editor?
          default_image_with_key = "#{default_image}?i18n_key=#{key}"
        else
          default_image_with_key = default_image
        end

        url = default_image
      end
    else
      url = I18n.t(key)
    end

    if defined?(are_you_i18n_editor?) && are_you_i18n_editor?
      source_with_key = "#{url}?i18n_key=#{key}"
    else
      source_with_key = url
    end

    if options[:default]
      onerror = "this.onerror=null;this.src=#{default_image_with_key}"
      options.merge!({onerror: onerror})
    end

    unless options[:alt]
      options[:alt] = nil
    end

    image_tag(source_with_key, options)
  end
end
