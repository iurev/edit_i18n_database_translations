module EditI18nDatabaseTranslations
  module Helper
    def text(path)
      if are_you_i18n_editor?
        content_tag(:span, t(path),
                    data: {i18n_path: path},
                    class: 'i18n-translation js-i18n-translation')
      else
        content_tag(:span, t(path))
      end
    end

    def i18n_editor
      return unless are_you_i18n_editor?
      render template: 'edit_i18n_database_translations/editor.html.erb'
    end
  end

  ActionView::Base.send(:include, Helper)
end
