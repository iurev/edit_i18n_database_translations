# Live editing I18n texts and images for content managers

How it looks:

Text editing:

[![image](https://cloud.githubusercontent.com/assets/3179564/8648973/c69fb904-298f-11e5-98e8-e462e0fdd39b.png)](https://cloud.githubusercontent.com/assets/3179564/8648887/ee457012-298e-11e5-8a89-1e16869e7b91.gif)

Images editing:

[![image](https://cloud.githubusercontent.com/assets/3179564/8649293/46ea418a-2993-11e5-8d15-463f767c4af8.png)](https://cloud.githubusercontent.com/assets/3179564/8648888/ee47f3b4-298e-11e5-9ffc-2cae56705793.gif)

## How to install:

At first, you need to install a gem [**i18n-active_record**](https://github.com/svenfuchs/i18n-active_record) using instructions.

Install gem **edit_i18n_database_translations** from github

```
gem 'edit_i18n_database_translations', github: 'wwju/edit_i18n_database_translations'
```

Put

```
rails g edit_i18n_database_translations:install
```

in the project console

Add

```
    include EditI18nDatabaseTranslations::ControllerModule
```

in ApplicationController.rb

Restart your development server.

## How to use

Now you can use helper method **text** in the application's views instead of **t** method.

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

It accepts all the options, which function **image_tag**

can accept. And an option **default**.

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

### Keybindings

Cmd(Ctrl) + Enter = Submit

Esc = Undo

## License

This project rocks and uses MIT-LICENSE.
