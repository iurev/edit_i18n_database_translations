module EditI18nDatabaseTranslations
  module ControllerModule
    def are_you_i18n_editor?
      params[:i18n_editor] == 'true'
    end

    def self.included(base)
      base.class_eval do
        helper_method :are_you_i18n_editor?

        config = EditI18nDatabaseTranslations.config
        options = {
          name: config.user_name,
          password: config.password,
          if: :are_you_i18n_editor?
        }
        http_basic_authenticate_with options
      end
    end
  end
end
