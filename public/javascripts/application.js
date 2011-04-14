jQuery(function ($) {
  $(document).ready(function(){
    $('#discipline_initial').focus();
  });
  
  $('a.missing-tagline').live('click', function(){
    $('#discipline_initial').val($(this).attr('data-initial'));
    $('#discipline_expanded').val($(this).attr('data-expanded'));
    $('#discipline_tagline').focus();
    return false;
  });
});


