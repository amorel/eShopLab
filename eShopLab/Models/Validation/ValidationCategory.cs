using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace eShopLab.Models
{
    internal sealed class ValidationCategory
    {
        [Required(ErrorMessage = "Name is required please.")]
        [StringLength(5)]
        public string CategoryName;

        [Required(ErrorMessage = "Description is required please.")]
        [StringLength(5)]
        public string CategoryDescription { get; set; }
    }
}