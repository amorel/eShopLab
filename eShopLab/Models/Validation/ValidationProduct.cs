using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace eShopLab.Models
{
    internal sealed class ValidationProduct
    {
        [Required(ErrorMessage = "Name is required please.")]
        [StringLength(128)]
        [Display(Name="Name")]
        public string ProductName { get; set; }
        [Required(ErrorMessage = "Short description is required please.")]
        [StringLength(255)]
        [Display(Name = "Description")]
        public string ProductDescription { get; set; }
        [Required(ErrorMessage = "Long description is required please.")]
        [Display(Name = "LongDescription")]
        public string ProductLongDescription { get; set; }
        [Required(ErrorMessage = "Reference is required please.")]
        [StringLength(32)]
        [Display(Name = "Ref")]
        public string ProductReference { get; set; }
        [Required(ErrorMessage = "Manufacture reference is required please.")]
        [StringLength(128)]
        [Display(Name = "ManRef")]
        public string ProductManufacturerReference { get; set; }
        [Required(ErrorMessage = "Bar code is required please.")]
        [StringLength(16)]
        [Display(Name = "BarCode")]
        public string ProductBarCode { get; set; }
        [Display(Name = "AddingDate")]
        public System.DateTime ProductAddingDate { get; set; }
        [Display(Name = "Discontinued")]
        public bool ProductDiscontinued { get; set; }
    }
}