// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
// require jquery
// require jquery_ujs
// require turbolinks
//= require_tree .

$(document).ready(function () {
    $(".datetimepicker").datetimepicker();
    BookingModule.init();
});

var BookingModule = (function () {

    var bind_add_new_payment_record = function () {
        $('body').on('click', '.add_new_payment_record', function () {
            var new_record = get_new_payment_record_block();
            $(".payment_records_list").append(new_record);
        });
    }

    var get_new_payment_record_block = function () {

        var date_now = Date.now();
        var html = '';
        html = html + "<div class= 'each_payment_record' >";

        html = html + "<div class= 'form-section' > ";
        html = html + "<label> Payment Mode  </label><br/>"
        html = html + "<select name= 'online_payment[" + date_now + "][payment_mode]' >";
        html = html + "<option> Select </option>";
        html = html + "<option value='paytm'> PayTM </option>";
        html = html + "<option value='citrus_gateway'> CITRUS </option>";
        html = html + "</select>";
        html = html + "</div>";

        html = html + "<div class= 'form-section' >";
        html = html + "<label> Amount  </label><br/>";
        html = html + "<input name= 'online_payment[" + date_now + "][amount]' class='form-control' type='text' value='0.0'> </input>";
        html = html + "</div>";

        html = html + "</div>";
        return html;
    }

    var initialize_events = function () {
        bind_add_new_payment_record();
    }

    // public
    var init = function () {
        initialize_events();
    }

    return {init: init}

}());
