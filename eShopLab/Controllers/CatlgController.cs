using eShopLab.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PagedList;

namespace eShopLab.Controllers
{
    public class CatlgController : Controller
    {
        private eShopDBEntities db = new eShopDBEntities();

        //
        // GET: /Catlg/

        public ActionResult Index(string currentFilter, string searchString, int? page, string sortOrder)
        {
            ViewBag.CurrentSort = sortOrder;
            ViewBag.NameSortParm = String.IsNullOrEmpty(sortOrder) ? "Name_desc" : "";
            ViewBag.PriceSortParm = sortOrder == "Price" ? "Price_desc" : "Price";

            ViewBag.Categories = db.Categories.Where(c => c.CategoryIsMenu == true);

            IEnumerable<Product> products = db.Products;
            if (!String.IsNullOrEmpty(searchString))
            {
                products = products.Where(s => s.ProductName.ToUpper().Contains(searchString.ToUpper())
                                       || s.ProductDescription.ToUpper().Contains(searchString.ToUpper()));
            }

            switch (sortOrder)
            {
                case "Name_desc":
                    products = products.OrderByDescending(s => s.ProductName);
                    break;
                case "Price_asc":
                    products = products.OrderBy(p => p.LastPrice);
                    break;
                case "Price_desc":
                    products = products.OrderByDescending(p => p.LastPrice);
                    break;
                default:
                    products = products.OrderBy(s => s.ProductName);
                    break;
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

            int pageSize = 4;
            int pageNumber = (page ?? 1);
            return View(products.ToPagedList(pageNumber, pageSize));
        }

    }
}
