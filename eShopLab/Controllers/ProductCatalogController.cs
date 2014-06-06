using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using eShopLab.Models;
using PagedList;
namespace eShopLab.Controllers
{
    public class ProductCatalogController : Controller
    {
        private eShopDBEntities db = new eShopDBEntities();
 
        // GET: /ProductCatalog/
        public ActionResult Index()
        {
            var products = db.Products.Include(p => p.Category).Select(s => new ProductCatalog() { ProductName = s.ProductName, ProductDescription = s.ProductDescription, ProductLongDescription = s.ProductLongDescription, ProductPrice = s.Prices.LastOrDefault().PriceValue.ToString() });
            return View(products.ToList());
        }

        //
        // GET: /ProductCatalog/Details/5

        public ActionResult Details(int id = 0)
        {
            Product product = db.Products.Find(id);
            ViewBag.Categories = db.Categories.ToList();
            ProductCatalog catalog = new ProductCatalog() { ProductName = product.ProductName, ProductDescription = product.ProductDescription, ProductLongDescription = product.ProductLongDescription, ProductPrice = product.Prices.LastOrDefault().PriceValue.ToString() };
            if (product == null)
            {
                return HttpNotFound();
            }
            return View(catalog);
        }

        [HttpGet]
        public ActionResult getProductCatalogView(string Category, string sortOrder, string currentFilter, string searchString, int? page)
        {

            ViewBag.Categories = db.Categories.ToList();
            //for Catalog title
            ViewBag.Category = Category;
            List<ProductCatalog> products = new List<ProductCatalog>();
            ProductCatalog product;
            Category category = db.Categories.Where(p => p.CategoryName == Category).FirstOrDefault();

            if (!String.IsNullOrEmpty(searchString))
            {
                products = products.Where(s => s.ProductName.ToUpper().Contains(searchString.ToUpper())).ToList();
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
            if (!String.IsNullOrEmpty(Category))
                if (!Category.Equals("FEATURED PRODUCTS"))
                {
                    foreach (var item in db.Products.Include(c => c.Media).Include(p => p.Prices).Include(c => c.Category).Where(m => m.Category.CategoryName == Category))
                    {
                        string price = item.Prices.LastOrDefault().PriceValue.ToString();
                        product = new ProductCatalog() { id = item.ProductID, ProductName = item.ProductName, ProductDescription = item.ProductDescription, ProductLongDescription=item.ProductLongDescription,ProductPrice = price };
                        products.Add(product);
                    }

                    switch (sortOrder)
                    {
                        case "Name_desc":
                            products = products.OrderByDescending(s => s.ProductName).ToList();
                            break;
                        case "Price_asc":
                            products = products.OrderBy(s => s.ProductPrice).ToList();
                            break;
                        case "Price_desc":
                            products = products.OrderByDescending(s => s.ProductPrice).ToList();
                            break;
                        default:
                            products = products.OrderBy(s => s.ProductName).ToList();
                            break;
                    }
                }
                else
                {
                    foreach (var item in db.Products.Include(c => c.Media).Include(p => p.Prices).Include(c => c.Category))
                    {
                        string price = item.Prices.LastOrDefault().PriceValue.ToString();
                        product = new ProductCatalog() { ProductName = item.ProductName, ProductDescription = item.ProductDescription, ProductLongDescription = item.ProductLongDescription, ProductPrice = price };
                        products.Add(product);
                    }

                    switch (sortOrder)
                    {
                        case "Name_desc":
                            products = products.OrderByDescending(s => s.ProductName).ToList();
                            break;
                        case "Price_asc":
                            products = products.OrderBy(s => s.ProductPrice).ToList();
                            break;
                        case "Price_desc":
                            products = products.OrderByDescending(s => s.ProductPrice).ToList();
                            break;
                        default:
                            products = products.OrderBy(s => s.ProductName).ToList();
                            break;
                    }
                }

            int pageSize = 6;
            int pageNumber = (page ?? 1);

            return View("_Catalog", products.ToPagedList(pageNumber, pageSize));
        }


        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }


        //for Knockout view Model
        public JsonResult getProductCatalog(string Category)
        {
            List<ProductCatalog> products = new List<ProductCatalog>();
            ProductCatalog product;

            foreach (var item in db.Products.Include(c => c.Media).Include(p => p.Prices).Include(c => c.Category).Where(m => m.Category.CategoryName == Category))
            {
                string price = item.Prices.LastOrDefault().PriceValue.ToString();
                product = new ProductCatalog() { ProductName = item.ProductName, ProductDescription = item.ProductDescription, ProductPrice = price };
                products.Add(product);
            }

            return Json(products, JsonRequestBehavior.AllowGet);
        }

       
    }
}