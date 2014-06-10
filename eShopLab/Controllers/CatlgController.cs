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

        public ActionResult Index(string sortOrder, string currentFilter, string searchString, int? page)
        {
            ViewBag.CurrentSort = sortOrder;
            ViewBag.NameSortParm = String.IsNullOrEmpty(sortOrder) ? "name_desc" : "";
            ViewBag.PriceSortParm = sortOrder == "Price" ? "price_desc" : "Price";

            ViewBag.Categories = db.Categories.Where(c => c.CategoryIsMenu == true);

            IEnumerable<Product> products = db.Products;
            if (!String.IsNullOrEmpty(searchString))
            {
                products = products.Where(s => s.ProductName.ToUpper().Contains(searchString.ToUpper())
                                       || s.ProductDescription.ToUpper().Contains(searchString.ToUpper()));
            }

            //switch (sortOrder)
            //{
            //    case "Name_desc":
            //        products = products.OrderByDescending(s => s.ProductName);
            //        break;
            //    case "Price_asc":
            //        products = products.OrderBy(s => s.Prices.Where(p=>p.PriceDate == );
            //        break;
            //    case "Price_desc":
            //        products = products.OrderByDescending(s => s.ProductPrice);
            //        break;
            //    default:
            //        products = products.OrderBy(s => s.ProductName);
            //        break;
            //}

            if (searchString != null)
            {
                page = 1;
            }
            else
            {
                searchString = currentFilter;
            }

            ViewBag.CurrentFilter = searchString;

            //products = products.OrderBy(p => p.ProductName);

            int pageSize = 3;
            int pageNumber = (page ?? 1);
            return View(products.ToPagedList(pageNumber, pageSize));
        }

    }
}
