routes_proc = Proc.new do
  prefix = EditI18nDatabaseTranslations.config.path_prefix
  scope "#{prefix}/i18n_editor" do
    post "/save_translation",
         to: 'edit_i18n_database_translations/translation#save',
         as: :i18n_editor_save_translation

    get "/admin",
        to: 'edit_i18n_database_translations/translation#admin',
        as: :i18n_editor_admin
  end
end

EditI18nDatabaseTranslations::Engine.routes.draw(&routes_proc)

Rails.application.routes.draw(&routes_proc)
