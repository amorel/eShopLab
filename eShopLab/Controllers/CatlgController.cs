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

            IEnumerable<Product> products;
            //= db.Products;
            if (!String.IsNullOrEmpty(searchString))
            {
                products = products.Where(s => s.ProductName.ToUpper().Contains(searchString.ToUpper())
                                       || s.ProductDescription.ToUpper().Contains(searchString.ToUpper()));
            } else { products = db.Products; }

            switch (sortOrder)
            {
                case "Name_desc":
                    products = products.OrderByDescending(s => s.ProductName);
                    break;
                case "Price_asc":
//@String.Format("{0:C}", Model.First().Prices.Where(p => p.PriceDate == Model.First().Prices.Max(d => d.PriceDate)).First().PriceValue)
//@String.Format("{0:C}", product.Prices.Where(p => p.PriceDate == product.Prices.Max(d => d.PriceDate)).First().PriceValue)

                    //products = products.OrderBy(s => s.Prices).Where(p => p.PriceDate == product.Prices.Max(d => d.PriceDate)).First().PriceValue);

                //                ViewBag.prod_size = db.SizeCategories
                //.GroupJoin(db.ProductSizeCategories,
                //p=>p.SizeCategoryID, 
                //s=>s.SizeCategoryID,
                //(p, g) => g.Select(s => new {
                //    SizeCategoryInitial = p.SizeCategoryInitial, Quantity = s.Quantity
                //}).DefaultIfEmpty(new {SizeCategoryInitial = p.SizeCategoryInitial, Quantity = 0})).SelectMany( g => g ).ToList();
                //.GroupJoin(db.ProductSizeCategories.Where(pc => pc.ProductID == id),
                //p => p.SizeCategoryID,
                //s => s.SizeCategoryID,
                //(p, g) => g.Select(s => new SizeProd_Qty()
                //{
                //    SizeCategoryID = p.SizeCategoryID,
                //    SizeCategoryInitial = p.SizeCategoryInitial,
                //    Quantity = s.Quantity
                //}).DefaultIfEmpty(new SizeProd_Qty() { SizeCategoryID = p.SizeCategoryID, SizeCategoryInitial = p.SizeCategoryInitial, Quantity = 0 })).SelectMany(g => g).ToList();

                    //products = products.GroupJoin(db.Prices,
                    //    p=>p.ProductID,
                    //    s=>s.ProductID,
                    //    (prop, g) => g.GroupBy(s => s.ProductID).

                    //products = products.Where(p => p.PriceDate == product.Prices.Max(d => d.PriceDate)).First().PriceValue);
                    break;
                case "Price_desc":
                    products = products.OrderByDescending(s => s.ProductPrice);
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

            //products = products.OrderBy(p => p.ProductName);

            int pageSize = 3;
            int pageNumber = (page ?? 1);
            return View(products.ToPagedList(pageNumber, pageSize));
        }

    }
}
