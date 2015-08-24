$(document).on 'ready page:load', ->
  $('#tip-tags').tagit
    fieldName:   'tip[tag_list]'
    singleField: true
    availableTags: gon.available_tags

  if gon.tip_tags?
    for tag in gon.tip_tags
      $('#tip-tags').tagit 'createTag', tag
