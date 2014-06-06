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
        [StringLength(30,MinimumLength=3)]
        [Display(Name = "Name")]
        public string CategoryName { get; set; }

        [Required(ErrorMessage = "Description is required please.")]
        [StringLength(200,MinimumLength = 3)]
        [Display(Name = "Description")]
        public string CategoryDescription { get; set; }

        [Display(Name = "IsMenu")]
        public bool CategoryIsMenu { get; set; }
    }
}