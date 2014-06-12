using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace eShopLab.Models
{
    [System.ComponentModel.DataAnnotations.MetadataType(typeof(ValidationProduct))]
    public partial class Product
    {
        public HttpPostedFileBase[] File { get; set; }

        public Price LastPrice
        {
            get
            {
                return this.Prices.OrderByDescending(p => p.PriceDate).FirstOrDefault();
            }
        }

        public int TotalQuantity
        {
            get
            {
                return this.ProductSizeCategories.Sum(s => s.Quantity);
            }
        }
    }
}