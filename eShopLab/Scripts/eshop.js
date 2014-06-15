$.fn.exist = function () { return $(this).length > 0; }

var appeshop = function () {

    var init = function () {
        bxslider();
        touchspine();
        centerimage();
        scroll();
        controls();
    };

    var bxslider = function () {
        if ($('.bxslider').exist()) {
            $('.bxslider').bxSlider({
                auto: true,
                pause: 3000,
                pager: false
            });
        }
    }
    var touchspine = function () {
        if ($('.input-qty').exist()) {
            $('.input-qty').TouchSpin();
        }
    }

    var centerimage = function () {
        if ($(window).width() > 750) {
            $('.link-p img').centerImage();
        }
        $(window).resize(function () {
            var width = $(this).width();
            if (width > 750) {
                $('.link-p img').centerImage();
                $('.link-p img').removeClass('def-img');
            } else {
                $('.link-p img').addClass('def-img');
            }
        })
    }
    var scroll = function () {
        $(window).scroll(function () {
            if ($(this).scrollTop() > 70) {
                $('.back-top').fadeIn();
            } else {
                $('.back-top').fadeOut();
            }
        });
    }
    var controls = function () {
        $("select").selectBoxIt({ autoWidth: false });
        $('.sp-wrap').smoothproducts();
    }
    //End {

    //return functions
    return {
        init: init,
    };
}();

//Load global functions
$(document).ready(function () {
    appeshop.init();
    $("#addToCart").on("click", function () { $(".input-qty").val(1); $("#GoToCart").css("display", "inline-block"); })

});


//Angular.js
var SizeCatModule = angular.module('ShoppingCart', []).controller("CartForm", function ($scope, $window) {

    $scope.invoice = {};

    //alert($window.sessionStorage.getItem("cart"));

    if ($window.sessionStorage.getItem("cart") != null) {
        $scope.invoice = angular.fromJson($window.sessionStorage.getItem("cart"));
    }

    //$scope.invoice = {
    //    items: [{
    //        ID: "0",
    //        ProductID: "1",
    //        MediaUrl: "/Uploads/Product/1/1.jpg",
    //        ProductName: "China",
    //        SizeCategory: [
    //            { SizeCategoryID: "1", SizeCategoryInitial: "S", selected: false },
    //            { SizeCategoryID: "2", SizeCategoryInitial: "L", selected: true, },
    //            { SizeCategoryID: "3", SizeCategoryInitial: "XL", selected: false, }
    //        ],
    //        Quantity: 10,
    //        Price: 9.95
    //    }, {
    //        ID: "1",
    //        ProductID: "2",
    //        MediaUrl: "/Uploads/Product/2/1.jpg",
    //        ProductName: "Cachos",
    //        SizeCategory: [
    //            { SizeCategoryID: "1", SizeCategoryInitial: "S", selected: false },
    //            { SizeCategoryID: "2", SizeCategoryInitial: "XL", selected: true, },
    //            { SizeCategoryID: "3", SizeCategoryInitial: "XXL", selected: false, }
    //        ],
    //        Quantity: 3,
    //        Price: 19.95
    //    }]
    //};

    //$window.sessionStorage.setItem("cart", angular.toJson($scope.invoice));

    

    $scope.total = function () {
        var total = 0;
        angular.forEach($scope.invoice.items, function (item, key) {
            total += item.Price * item.Quantity;
        });
        return total;
    }

    $scope.removeItem = function (index) {
        $scope.invoice.items.splice(index, 1);
        $window.sessionStorage.setItem("cart", angular.toJson($scope.invoice));
    }
});