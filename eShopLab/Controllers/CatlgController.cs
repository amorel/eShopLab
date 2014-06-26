using eShopLab.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using PagedList;
using Newtonsoft.Json;

namespace eShopLab.Controllers
{
    public class CatlgController : Controller
    {
        private eShopDBEntities db = new eShopDBEntities();

        //
        // GET: /Catlg/

        public ActionResult Index(int? categoryID, string sortOrder, string currentFilter, string searchString, int? page)
        {
            ViewBag.categoryID = categoryID;

            ViewBag.CurrentSort = sortOrder;
            ViewBag.NameSortParm = String.IsNullOrEmpty(sortOrder) ? "Name_desc" : "";
            ViewBag.PriceSortParm = sortOrder == "Price" ? "Price_desc" : "Price";

            if (searchString != null)
            {
                page = 1;
            }
            else
            {
                searchString = currentFilter;
            }

            ViewBag.CurrentFilter = searchString;

            ViewBag.Categories = db.Categories.Where(c => c.CategoryIsMenu == true);

            IEnumerable<Product> products;
            if (categoryID != null)
            {
                products = db.Products.Where(p => p.CategoryID == categoryID);
            }
            else
            {
                products = db.Products;
            }

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

            int pageSize = 4;
            int pageNumber = (page ?? 1);
            return View(products.ToPagedList(pageNumber, pageSize));
        }

        public ActionResult Details(int id)
        {
            List<string> size = db.Products.Find(id).ProductSizeCategories.Select(s => s.SizeCategory.SizeCategoryInitial).ToList();

            SizeC sizeC = new SizeC()
            {
                SizeCategoryList = size,
                choice = size.FirstOrDefault()
            };

            string json = JsonConvert.SerializeObject(sizeC, Formatting.Indented);

            ViewBag.SizeCategoryJson = json;

            ViewBag.product = db.Products.Find(id);
            return View();
        }
    }
}
