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


// ANGULARJS
var appsModule = angular.module('angularApps', ['ngAnimate']);

/*************************************
* Management of shopping cart
*
**************************************/
appsModule.controller("AngularCtrl", function ($scope, $window) {

    $scope.sizeScope = {};

    $scope.invoice = [];

    if ($window.localStorage.getItem("cart") != null) {
        $scope.invoice = angular.fromJson($window.localStorage.getItem("cart"));
    }

    $scope.change = function (productID) {
        
        deleteDouble($scope, productID);

        $window.localStorage.setItem("cart", angular.toJson($scope.invoice));

    }

    $scope.total = function () {
        var total = 0;
        angular.forEach($scope.invoice, function (item, key) {
            total += item.Price * item.Quantity;
        });
        return total;
    }

    $scope.removeItem = function (index) {
        $scope.invoice.splice(index, 1);
        $window.localStorage.setItem("cart", angular.toJson($scope.invoice));
    }

    $scope.setSize = function (data) {
        $scope.sizeScope = data;
    }

    $scope.addItem = function (productID, productName, price) {
        $scope.invoice.push({
            ProductID: productID,
            MediaUrl: $(".prod-detail").first().attr("src"),
            ProductName: productName,
            SizeCategory: $scope.sizeScope.SizeCategoryList,
            Quantity: $(".input-qty").val(),
            Price: price.replace(",", "."),
            choice: $scope.sizeScope.choice
        });

        deleteDouble($scope, productID);

        $window.localStorage.setItem("cart", angular.toJson($scope.invoice));
    }

});

/*************************************
* deleteDouble($scope, productID):
* Remove double size by product in shopping cart.
* parameter: $scope of Angular, productID
**************************************/
var deleteDouble = function ($scope, productID)
{
    var map = {};

    angular.forEach($scope.invoice, function (value, key) {
        if (value.ProductID == productID) {

            if (value.choice in map) {
                map[value.choice] = map[value.choice] + 1;
            } else {
                map[value.choice] = 1;
            }

        }
    });
    var quantity;
    var indexKey;
    var first = true;
    angular.forEach(map, function (somme, sizeKey) {
        if (somme > 1) {
            angular.forEach($scope.invoice, function (cartLine, index) {
                if (cartLine.choice == sizeKey) {
                    if (first) {
                        indexKey = index;
                        quantity = cartLine.Quantity;
                    } else {
                        $scope.invoice[index].Quantity = parseFloat($scope.invoice[index].Quantity) + parseFloat(quantity);
                    }
                    first = false;
                }
            });
        }
    });
    if (!first) $scope.invoice.splice(indexKey, 1);
}