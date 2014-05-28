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
    }
}