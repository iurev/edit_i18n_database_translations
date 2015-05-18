module Sass::Script::Functions
  def image_url_i18n(key)
    key = key.value
    url = I18n.t(key)
    ::Sass::Script::String.new("url(" + url + '?' + key + ")")
  end
  declare :image_url_i18n, [:string]
end

module ActionView::Helpers::AssetUrlHelper
  def image_url_i18n(key, options = {})
    url = I18n.t(key)
    source = "#{url}?#{key}"
    url_to_asset(source, {type: :image}.merge!(options))
  end
end

module ActionView::Helpers::AssetTagHelper
  def image_tag_i18n(key, options = {})
    url = if options[:default]
            default_image = "#{options[:default]}?#{key}"
            I18n.t(key, default: default_image)
          else
            I18n.t(key)
          end

    source = "#{url}?#{key}"

    if options[:default]
      onerror = "this.onerror=null;this.src=#{default_image}"
      options.merge!({onerror: onerror})
    end

    image_tag(source, options)
  end
end
