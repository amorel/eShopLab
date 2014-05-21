using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace eShopLab.Models
{
    [System.ComponentModel.DataAnnotations.MetadataType(typeof(ValidationCategory))]
    public partial class Category
    {
        public HttpPostedFileBase File { get; set; }
    }
}