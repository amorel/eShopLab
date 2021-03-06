﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace eShopLab.Models
{
    internal sealed class ValidationProduct
    {
        [Required(ErrorMessage = "Name is required please.")]
        [StringLength(128)]
        [Display(Name = "Name")]
        public string ProductName { get; set; }

        [Required(ErrorMessage = "Short description is required please.")]
        [StringLength(255)]
        [Display(Name = "Description")]
        public string ProductDescription { get; set; }

        [AllowHtml]
        [DataType(DataType.Html)]
        [Display(Name = "LongDescription")]
        public string ProductLongDescription { get; set; }

        [Required(ErrorMessage = "Reference is required please.")]
        [StringLength(32)]
        [Display(Name = "Reference")]
        public string ProductReference { get; set; }

        [Required(ErrorMessage = "Manufacture reference is required please.")]
        [StringLength(128)]
        [Display(Name = "ManufactureReference")]
        public string ProductManufacturerReference { get; set; }

        [Required(ErrorMessage = "Bar code is required please.")]
        [StringLength(16)]
        [Display(Name = "BarCode")]
        public string ProductBarCode { get; set; }

        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}", ApplyFormatInEditMode = true)]
        [Display(Name = "Adding")]
        public System.DateTime ProductAddingDate { get; set; }

        [Display(Name = "Discontinued")]
        public bool ProductDiscontinued { get; set; }
    }
}