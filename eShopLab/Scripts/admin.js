jQuery.fn.exists = function () { return this.length > 0; }

var app = function () {

    var init = function () {

        tooltips();
        toggleMenuLeft();
        toggleMenuRight();
        menu();
        togglePanel();
        closePanel();
        dropzone();
        mask();
    };

    var tooltips = function () {
        $('#toggle-left').tooltip();
    };

    var togglePanel = function () {
        $('.actions > .fa-chevron-down').click(function () {
            $(this).parent().parent().next().slideToggle('fast');
            $(this).toggleClass('fa-chevron-down fa-chevron-up');
        });

    };

    var toggleMenuLeft = function () {
        $('#toggle-left').bind('click', function (e) {
            if (!$('.sidebarRight').hasClass('.sidebar-toggle-right')) {
                $('.sidebarRight').removeClass('sidebar-toggle-right');
                $('.main-content-wrapper').removeClass('main-content-toggle-right');
            }
            $('.sidebar').toggleClass('sidebar-toggle');
            $('.main-content-wrapper').toggleClass('main-content-toggle-left');
            e.stopPropagation();
        });
    };

    var toggleMenuRight = function () {
        $('#toggle-right').bind('click', function (e) {

            if (!$('.sidebar').hasClass('.sidebar-toggle')) {
                $('.sidebar').addClass('sidebar-toggle');
                $('.main-content-wrapper').addClass('main-content-toggle-left');
            }

            $('.sidebarRight').toggleClass('sidebar-toggle-right animated bounceInRight');
            $('.main-content-wrapper').toggleClass('main-content-toggle-right');

            if ($(window).width() < 660) {
                $('.sidebar').removeClass('sidebar-toggle');
                $('.main-content-wrapper').removeClass('main-content-toggle-left main-content-toggle-right');
            };

            e.stopPropagation();
        });
    };

    var closePanel = function () {
        $('.actions > .fa-times').click(function () {
            $(this).parent().parent().parent().fadeOut();
        });

    }

    var menu = function () {
        $("#leftside-navigation .sub-menu > a").click(function (e) {
            $("#leftside-navigation ul ul").slideUp();
            if (!$(this).next().is(":visible")) {
                $(this).next().slideDown();
            }
            e.stopPropagation();
        });
    };

    var dropzone = function () {
        var myDropzone = $("#mydropzone").dropzone({
            previewsContainer: ".dropzone-previews",
            maxFiles: 1,
            addRemoveLinks: true,
            autoProcessQueue: false,
            acceptedFiles: "image/*",
            init: function () {

                var myDropzone = this;

                this.on("addedfile", function (file) {
                    if (myDropzone.files.length > 1) {
                        myDropzone.removeFile(myDropzone.files[0])
                    }
                });

                // First change the button to actually tell Dropzone to process the queue.
                this.element.querySelector("input[type=submit]").addEventListener("click", function (e) {
                    // Make sure that the form isn't actually being sent.
                    if (Dropzone.forElement("#mydropzone").files.length > 0) {
                        e.preventDefault();
                        e.stopPropagation();
                        if ($("#mydropzone").valid()) {
                            myDropzone.processQueue();
                        }
                    }
                });
                if ($("input[name='fileUrl']").exists())
                    if ($("input[name='fileUrl']").val() != "") {
                        var fakeFile = {
                            name: "",
                            size: 2323 // in bytes,
                        };

                        myDropzone.emit("addedfile", fakeFile);
                        myDropzone.emit("thumbnail", fakeFile, location.protocol + '//' + location.host + $("input[name='fileUrl']").val());
                        myDropzone.files.push(fakeFile);
                    }
            },
            complete: function () {
                window.location = "./";
            }
        });
    }

    var mask = function () {
        $("#PriceValue").mask('000000000000000,00', { reverse: true });
    }
    //End {

    //return functions
    return {
        init: init,
    };
}();

//Load global functions
$(document).ready(function () {
    app.init();
    $('#textareadescription').wysihtml5();

});
