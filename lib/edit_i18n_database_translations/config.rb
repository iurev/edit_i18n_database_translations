module EditI18nDatabaseTranslations
  class Config
    attr_accessor :user_name, :password, :path_prefix, :allowed_keys, :favorite_pages, :show_images_tab, :check_images_proc

    def initialize
      Rails.application.config.assets.precompile +=
        %w( edit_i18n_database_translations.js edit_i18n_database_translations.css editor.css )
    end

    def save_translation_path
      url_helpers.i18n_editor_save_translation_path
    end

    def admin_path(options = {})
      url_helpers.i18n_editor_admin_path(options)
    end

    private
    def url_helpers
      EditI18nDatabaseTranslations::Engine.routes.url_helpers
    end
  end
end
