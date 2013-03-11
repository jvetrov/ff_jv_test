$(function(){
    $('.field_with_errors').attr("class", "form_error_css");

    $(".modal_link").bind('ajax:complete', function(event, data) {

        $('#modal_div').modal();

        $('.modal-body').html(data.responseText);
        $('.modal-header').remove();
    });
});