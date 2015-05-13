# Live editing I18n texts for content managers

How it seems:

- todo: insert video or gif of live editing
- toto: insert video or gif of editing texts in admin panel

## How to install:

At first, you need to install a gem [**i18n-active_record**](https://github.com/svenfuchs/i18n-active_record) using instructions.

Please, use more advanced initializer, which uses both database and yaml translations.

```
require 'i18n/backend/active_record'

Translation  = I18n::Backend::ActiveRecord::Translation

I18n.backend = I18n::Backend::ActiveRecord.new

I18n::Backend::ActiveRecord.send(:include, I18n::Backend::Memoize)
I18n::Backend::ActiveRecord.send(:include, I18n::Backend::Flatten)
I18n::Backend::Simple.send(:include, I18n::Backend::Memoize)
I18n::Backend::Simple.send(:include, I18n::Backend::Pluralization)

I18n.backend = I18n::Backend::Chain.new(I18n.backend, I18n::Backend::Simple.new)
```

Install gem **edit_i18n_database_translations** from github

```
gem 'edit_i18n_database_translations', github: 'wwju/edit_i18n_database_translations'
```

Create an initialization file in **config/initializers** folder

```
EditI18nDatabaseTranslations.configure do |config|
  config.user_name = 'site_admin'
  config.password = 'very_strong_password'
  config.path_prefix = ''
  config.allowed_keys = [:pages, :seo_values, :sharing_texts]
end
```

Restart your development server.

Now you can use helper method **text** in the application's views instead of **t** method.

```
= text("pages.main_title")
```

Add **i18n_editor=true** into browser url.

Enter your very strong login and password (yes, there are http base auth).

**Enjoy!!!**

This project rocks and uses MIT-LICENSE.