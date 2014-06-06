

using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using eShopLab.Models;
using System.IO;
using PagedList;
namespace eShopLab.Controllers
{
    public class HomeController : Controller
    {
        //
        // GET: /Home/

        private EShopEntities db = new EShopEntities();

        public ActionResult Index(string sortOrder, string currentFilter, string searchString, int? page)
        {           
            ViewBag.Category = "FEATURED PRODUCTS";
            ViewBag.Categories = db.Categories.ToList();
            var products = db.Products.Include(c => c.Media).Include(p => p.Prices);
            if (!String.IsNullOrEmpty(searchString))
            {
                products = products.Where(s => s.ProductName.ToUpper().Contains(searchString.ToUpper()));
            }


            if (searchString != null)
            {
                page = 1;
            }
            else
            {
                searchString = currentFilter;
            }

            ViewBag.CurrentFilter = searchString;
            int pageSize = 6;
            int pageNumber = (page ?? 1);

            return View(products.OrderBy(o => o.ProductName).ToPagedList(pageNumber, pageSize));

        }

      

    }
}
