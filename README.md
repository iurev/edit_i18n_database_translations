# Live editing I18n texts and images for content managers

How it seems:

- todo: insert video or gif of live editing images and texts
- toto: insert video or gif of editing texts and images in admin panel

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
  config.path_prefix = '/example/path'
  config.allowed_keys = [:pages, :seo_values, :sharing_texts]
  
  # where images will be uploaded
  config.save_images_path = 'uploads/i18n_images'
  
  # requires to add a new model (see below)
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
```

### Saving all changes in DB
You need to create a new model for it.

```
rails g model TranslationsChangesHistory key:string previous_value:string new_value:string
```

If you do no wants to do that, just put

```
  config.save_changes_history = true
```

in config file.

Restart your development server.

Now you can use helper method **text** in the application's views instead of **t** method.

## How to use

Add **i18n_editor=true** into browser url.

Enter your very strong login and password (yes, there are http base auth).

**Enjoy!!!**

### For texts

```
= text("pages.main_title")
```

### For images

en.**yml**

```
pages:
	page1:
		image: 'http://example.org/example.png'
		
```

#### index.**slim**:

```
= image_tag_i18n('pages.page1.image')
```

It accepts all the options, which function

```image_tag```

can accept. And an option

```default```.

```
= image_tag_i18n('pages.page1.image', default: image_url('place.jpg'))
```

It will add

```
onerror="this.onerror=null;this.src='place.jpg'"
```

in the image tag.


#### or, even more, you can use **sass**-helper

```
background-image: image_url_i18n('pages.page1.image')
```

But it **requires** assets recompilation.


## License

This project rocks and uses MIT-LICENSE.