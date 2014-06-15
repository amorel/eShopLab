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

});


//Angular.js
var SizeCatModule = angular.module('ShoppingCart', []).controller("CartForm", function ($scope, $window) {

    $scope.invoice = {};

    if ($window.localStorage.getItem("cart") != null) {
        $scope.invoice = angular.fromJson($window.localStorage.getItem("cart"));
    }

    //$scope.invoice = {
    //    items: [{
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

    //$window.localStorage.setItem("cart", angular.toJson($scope.invoice));



    $scope.total = function () {
        var total = 0;
        angular.forEach($scope.invoice.items, function (item, key) {
            total += item.Price * item.Quantity;
        });
        return total;
    }

    $scope.removeItem = function (index) {
        $scope.invoice.items.splice(index, 1);
        $window.localStorage.setItem("cart", angular.toJson($scope.invoice));
    }
});


var SizeCatModule = angular.module('appDetails', []).controller("btn", function ($scope, $window) {

    $scope.invoice = {};

    $scope.sizeScope = {};

    if ($window.localStorage.getItem("cart") != null) {
        $scope.invoice = angular.fromJson($window.localStorage.getItem("cart"));
    }

    $scope.setSize = function (data) {
        $scope.sizeScope = data;
    }

    $scope.addItem = function (productID, productName) {

        alert(angular.toJson($scope.sizeScope  ));

        $scope.invoice.items.push({
            ProductID: productID,
            MediaUrl: $(".prod-detail").first().attr("src"),
            ProductName: productName,
            SizeCategory: $scope.sizeScope,
            Quantity: 10,
            Price: 9.95
        });

        $window.localStorage.setItem("cart", angular.toJson($scope.invoice));
    }



});