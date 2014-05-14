using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace eShopLab.Models
{
    public class CategoryMedia
    {
        public Category NewCategory { get; set; }
        public HttpPostedFileBase File { get; set; }
    }
}