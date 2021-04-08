(function ($) {

    $.fn.setGreeting = function (username) {
        var now = new Date().getHours();
        var text, color;

        if (now >= 5 && now < 12) {
            text = 'Good Morning,';
            color = '#66bb6a';
        }

        else if (now == 12) {
            text = 'Good Day,';
            color = '#607d8b';
        }

        else if (now > 12 && now < 17) {
            text = 'Good Afternoon,';
            color = '#f57f17';
        }

        else if (now >= 17 && now < 21) {
            text = 'Good Evening,';
            color = '#6d4c41';
        }
        else {
            text = 'Good Night,';
            color = '#616161';
        }

        return this.each(function () {
            var $div = $(this);

            $div.html(text + ' ' + username);
            $div.css({
                'padding': '10px',
                'backgroundColor': color,
                'color': '#fff',
                'width': '100%'
            });
        });
    }

}(jQuery));