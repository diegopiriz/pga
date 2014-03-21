$('img').each(function() -> $('.croppable').each(function() {
    $(this).attr('data-img-height', $(this).attr('height'));
    $(this).attr('data-img-width', $(this).attr('width'));
    $(this).removeAttr('height');
    $(this).removeAttr('width');

    $(this).wrap('<div style="height:'+$(this).attr("data-img-height")+'px;width:'+$(this).attr("data-img-width")+'px;overflow:hidden;position:relative;padding:0;margin:0;"></div>');
    $(this).parent().append('<div style="position:absolute;z-index:99999;"><input type="button" class="plus" value="+" style="position:absolute;height:32px;width:32px;left:0;" onclick="$(this).parent().siblings().first().css(\'width\', parseInt($(this).parent().siblings().first().width())*1.05+\'px\');$(this).parent().siblings().first().css(\'height\', parseInt($(this).parent().siblings().first().height())*1.05+\'px\');"> <input type="button" class="minus" value="-" style="position:absolute;height:32px;width:32px;left:32px;" onclick="$(this).parent().siblings().first().css(\'width\', parseInt($(this).parent().siblings().first().width())*0.95+\'px\');$(this).parent().siblings().first().css(\'height\', parseInt($(this).parent().siblings().first().height())*0.95+\'px\');"></div>');
    $(this).css("position", "absolute");
    $(this).css("padding", 0);
    $(this).css("margin", 0);
    $(this).css("top", -((parseInt($(this).css('height'))-parseInt($(this).attr("data-img-height")))/2)+"px");
    $(this).css("left", -((parseInt($(this).css('width'))-parseInt($(this).attr("data-img-width")))/2)+"px");
    console.log($(this).offset().top);
        $(this).draggable({
            revert: false,
            revertDuration: 100,
            drag: function(event, ui) {
                if (parseInt($(this).offset().top) > 0)
                {
                    $(this).draggable("option", "revert", true);
                }
                else if (parseInt($(this).offset().left) > 0)
                {
                    $(this).draggable("option", "revert", true);
                }
                else if (parseInt($(this).offset().left) < parseInt($(this).parent().css('width'))-parseInt($(this).css('width')))
                {
                    $(this).draggable("option", "revert", true);
                }
                else if (parseInt($(this).offset().top) < parseInt($(this).parent().css('width'))-parseInt($(this).css('width')))
                {
                    $(this).draggable("option", "revert", true);
                }
                else
                {
                    $(this).draggable("option", "revert", false);
                }
            }
        });
});