using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace eShopLab.Models
{
    internal sealed class ValidationProduct
    {
        [Display(Name="Name")]
        public string ProductName { get; set; }
        [Display(Name = "Description")]
        public string ProductDescription { get; set; }
        [Display(Name = "LongDescription")]
        public string ProductLongDescription { get; set; }
        [Display(Name = "Ref")]
        public string ProductReference { get; set; }
        [Display(Name = "ManRef")]
        public string ProductManufacturerReference { get; set; }
        [Display(Name = "BarCode")]
        public string ProductBarCode { get; set; }
        [Display(Name = "AddingDate")]
        public System.DateTime ProductAddingDate { get; set; }
        [Display(Name = "Discontinued")]
        public bool ProductDiscontinued { get; set; }
    }
}