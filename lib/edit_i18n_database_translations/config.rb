module EditI18nDatabaseTranslations
  class Config
    attr_accessor :user_name, :password, :path_prefix, :allowed_keys

    def save_translation_path
      EditI18nDatabaseTranslations::Engine.routes.url_helpers.i18n_editor_save_translation_path
    end
  end
end
