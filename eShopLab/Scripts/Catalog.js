function ProductsViewModel() {
    var self = this;
    self.products = ko.observableArray();
    self.search = ko.observable("");
    var baseUri = '/ProductCatalog/getProductCatalogView';
    $.getJSON(baseUri, self.products);

    //self.update = function (product) {
    //    $.ajax({ type: "PUT", url: baseUri + '/' + product.Id, data: product });
    //}
    //self.remove = function (product) {
    //    // First remove from the server, then from the UI
    //    $.ajax({ type: "DELETE", url: baseUri + '/' + product.Id })
    //        .done(function () { self.products.remove(product); });
    //}
}

$(document).ready(function () {
    ko.applyBindings(new ProductsViewModel());
})
