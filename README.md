# Live editing I18n texts and images for content managers

How it seems:

- todo: insert video or gif of live editing images and texts
- toto: insert video or gif of editing texts and images in admin panel

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


## License

This project rocks and uses MIT-LICENSE.