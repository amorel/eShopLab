using eShopLab.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace eShopLab.Controllers
{
    public class CatlgController : Controller
    {
        private eShopDBEntities db = new eShopDBEntities();

        //
        // GET: /Catlg/

        public ActionResult Index(string searchString)
        {
            ViewBag.Categories = db.Categories.Where(c => c.CategoryIsMenu == true);

            var products = (dynamic)null;
            if (!String.IsNullOrEmpty(searchString))
            {
                products = db.Products.Where(s => s.ProductName.ToUpper().Contains(searchString.ToUpper())
                                       || s.ProductDescription.ToUpper().Contains(searchString.ToUpper()));
            }
            else { products = db.Products; }

            return View(products);
        }

    }
}
