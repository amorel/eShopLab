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
        controls();
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
        var isRemoveLinks = true;
        if ($("#accordion").exists()) {
            isRemoveLinks = false;
        }
        var myDropzone = $("#mydropzone").dropzone({
            addRemoveLinks: isRemoveLinks,
            acceptedFiles: "image/*",
            init: function () {
                $("#tabImage").on("click", function () {
                    var dz = Dropzone.forElement("#mydropzone");
                    dz.removeAllFiles();
                });
                this.on("removedfile", function (file) {
                    var fileName = file.name;
                    $.ajax({
                        type: "POST",
                        url: "/Admin/Product/DeleteFile",
                        data: {filePath: "~/Uploads/SandBox/" + fileName},
                        dataType: "Json"
                    });
                });
            }
        });
    }

    var controls = function () {
        //Money mask on price
        $("#PriceValue").mask('000000000000000,00', { reverse: true });
        //WYSIWYG on Long description
        $('#textareadescription').wysihtml5();
        //Custom SelectBox
        $("select").selectBoxIt();
    }
    //End {

    //return functions
    return {
        init: init,
    };
}();

//Load global functions
$(document).ready(function () {
    Dropzone.autoDiscover = false;
    app.init();
    

});


//Angular.js
var appsModule = angular.module('SizeCat', []);

        appsModule.controller("ShowSizeCtrl", function ($scope) {
            $scope.Qty = {};
            $scope.checkedSize = {};
            this.changed = function (i) {
                if ($scope.Qty[i] <= 0) {
                    $scope.Qty[i] = 0;
                }
            }
            this.reinit = function (i) {
                if ($scope.checkedSize[i]) $scope.Qty[i] = '';
            }
        });

        appsModule.controller("GalleryCtrl", function ($scope, $http) {
            $scope.VirtualPath = new Array();

            $scope.getGallery = function (productID) {
                $http({ method: "POST", url: "/Admin/Product/GetImage", data: { ProductID: productID } }).
                    success(function (data, status) {
                        $scope.VirtualPath = data;
                    }).
                    error(function (data, status) {
                    });
            };

            $scope.deleteImg = function (filePath) {
                var index = $scope.VirtualPath.indexOf(filePath)
                $scope.VirtualPath.splice(index, 1);

                var filePathClean = /(.*)\?/.exec(filePath);
                $http({ method: "POST", url: "/Admin/Product/DeleteFile", data: { filePath: filePathClean[1] } }).
                    success(function (data, status) {
                    }).
                    error(function (data, status) {
                    });
            };
        });