$ ->
  $body = $('body')
  $form = $('.js-images-uploader-form')
  $preview_image = $('.js-images-uploader-form .js-image')
  $key_input = $('.js-images-uploader-form .js-i18n-key')
  $redirect_to = $('.js-images-uploader-form .js-redirect-to')

  $redirect_to.val(location.href)

  stop_watching = false

  get_src = ($dom_element) ->
    if $dom_element.is('img')
      $dom_element.attr('src')
    else
      value = $dom_element.css('background-image')
      value.replace('url(', '').replace(')', '')

  $body.on 'contextmenu', '*', (e) ->
    return if stop_watching

    e.preventDefault()
    $this = $(@)
    src = get_src($this)
    key = src.split('?')[1]

    return unless key

    stop_watching = true

    $preview_image.attr('src', src)
    $key_input.val(key)
    $form.show()

  clear = ->
    stop_watching = false
    $form.hide()

  $body.on 'click', '.js-images-uploader-form .js-undo', clear
