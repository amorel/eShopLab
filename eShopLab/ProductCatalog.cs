 
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace eShopLab.Models
{
    public class ProductCatalog
    {
    public int id { get; set; }
    public string ProductName { get; set; }
    public string ProductDescription { get; set; }
    public string ProductLongDescription { get; set; }
    public string ProductPrice { get; set; }
    }
}