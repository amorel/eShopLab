using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace eShopLab.Models
{
    internal sealed class ValidationUnitType
    {
        [Required(ErrorMessage = "Name is required please.")]
        [StringLength(10,MinimumLength=3)]
        public string UnitTypeName { get; set; }

        [Required(ErrorMessage = "Description is required please.")]
        [StringLength(3,MinimumLength = 1)]
        public string UnitTypeSymbol { get; set; }
    }
}