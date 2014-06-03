using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using eShopLab.Models;
using System.Globalization;
using System.IO;

namespace eShopLab.Areas.Admin.Controllers
{
    public class ProductController : Controller
    {
        private eShopDBEntities db = new eShopDBEntities();

        //
        // GET: /Admin/Product/

        public ActionResult Index()
        {
            var products = db.Products.Include(p => p.Category);
            return View(products.ToList());
        }

        //
        // GET: /Admin/Product/Details/5

        public ActionResult Details(int id = 0)
        {
            Product product = db.Products.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            return View(product);
        }

        //
        // GET: /Admin/Product/Create

        public ActionResult Create()
        {
            ViewBag.MyCategories = new SelectList(db.Categories, "CategoryID", "CategoryName");
            ViewBag.MySize = db.SizeCategories;
            return View();
        }

        //
        // POST: /Admin/Product/Create

        [HttpPost]
        public ActionResult Create(Product product, ICollection<ProduSizeCat> prodSizeCat, string PriceValue)
        {
            foreach (var prodSize in prodSizeCat)
            {
                if (prodSize.check == "on" && prodSize.Quantity != 0)
                {
                    ProductSizeCategory productSizeCategory = new ProductSizeCategory
                    {
                        SizeCategoryID = prodSize.SizeCategoryID,
                        Quantity = prodSize.Quantity
                    };

                    product.ProductSizeCategories.Add(productSizeCategory);

                }
            }
            if (ModelState.IsValid)
            {
                db.Products.Add(product);
                db.SaveChanges();
                int id = product.ProductID;

                decimal result;
                decimal.TryParse(PriceValue, out result);

                db.Prices.Add(new Price()
                {
                    PriceValue = result,
                    PriceDate = DateTime.Now,
                    ProductID = product.ProductID
                });
                db.SaveChanges();

                DirectoryInfo directory = new DirectoryInfo(Server.MapPath(@"~\Uploads\SandBox"));
                var filesName = directory.GetFiles().ToList();
                if (filesName.Count > 0)
                {
                    var path = Server.MapPath("~/Uploads/Product/" + product.ProductID);
                    Directory.CreateDirectory(path);
                    int i = 1;
                    foreach (var fileName in filesName)
                    {
                        
                        var pathRoot = Server.MapPath("~/Uploads");
                        string Fromfile = pathRoot + "/SandBox/" + fileName;
                        string Tofile = path + "/" + i + Path.GetExtension(path + fileName);
                        System.IO.File.Move(Fromfile, Tofile);

                        Medium medium = new Medium()
                        {
                            MediaName = product.ProductName,
                            MediaAlt = "",
                            MediaUrl = "~/SandBox/" + fileName.ToString()
                        };

                        db.Media.Add(medium);
                        i++;
                    }
                    db.SaveChanges();
                }

                return RedirectToAction("Index");
            }
            return View(product);
        }

        [HttpPost]
        public ActionResult Upload()
        {
            foreach (string fileName in Request.Files)
            {
                HttpPostedFileBase file = Request.Files[fileName];
                file.SaveAs(Server.MapPath("~/Uploads/SandBox/" + file.FileName));
            }

            return Json(new { Message = string.Empty });
        }

        [HttpPost]
        public ActionResult GetImage(int id)
        {
            DirectoryInfo directory = new DirectoryInfo(Server.MapPath(@"~\Uploads\Product\" + id));
            List<string> VirtualPathList = new List<string>();
            if (directory.Exists)
            {
                var PhysicalPaths = directory.GetFiles().ToList();
                foreach (var PhysicalPath in PhysicalPaths)
                {
                    string virtualPath = Globals.resolveVirtual(PhysicalPath.DirectoryName) + "/" + PhysicalPath.Name;
                    VirtualPathList.Add(virtualPath.Replace("~/", ""));
                    
                }
            }

            return Json(VirtualPathList);
        }
        [HttpPost]
        public ActionResult DeleteFile(string fileName)
        {
            var fullPath = Server.MapPath("~/Uploads/SandBox/" + fileName);
            if (System.IO.File.Exists(fullPath))
            {
                System.IO.File.Delete(fullPath);
            }
            return Json(new { Message = string.Empty });
        }

        //
        // GET: /Admin/Product/Edit/5

        public ActionResult Edit(int id)
        {
            var priceByProduct = db.Prices.Where(p => p.ProductID == id);
            var maxDate = priceByProduct.Max(p => p.PriceDate);
            var price = priceByProduct.Where(p => p.PriceDate == maxDate).FirstOrDefault();

            ViewBag.price = Math.Round(price.PriceValue, 2);

            Product product = db.Products.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }

            ViewBag.prod_size = db.SizeCategories
                .GroupJoin(db.ProductSizeCategories.Where(pc => pc.ProductID == id),
                p => p.SizeCategoryID,
                s => s.SizeCategoryID,
                (p, g) => g.Select(s => new SizeProd_Qty()
                {
                    SizeCategoryID = p.SizeCategoryID,
                    SizeCategoryInitial = p.SizeCategoryInitial,
                    Quantity = s.Quantity
                }).DefaultIfEmpty(new SizeProd_Qty() { SizeCategoryID = p.SizeCategoryID, SizeCategoryInitial = p.SizeCategoryInitial, Quantity = 0 })).SelectMany(g => g).ToList();

            ViewBag.CategoryID = new SelectList(db.Categories, "CategoryID", "CategoryName", product.CategoryID);
            return View(product);
        }

        //
        // POST: /Admin/Product/Edit/5

        [HttpPost]
        public ActionResult Edit(Product product)
        {
            if (ModelState.IsValid)
            {
                db.Entry(product).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.CategoryID = new SelectList(db.Categories, "CategoryID", "CategoryName", product.CategoryID);
            return View(product);
        }

        //
        // GET: /Admin/Product/Delete/5

        public ActionResult Delete(int id = 0)
        {
            Product product = db.Products.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            return View(product);
        }

        //
        // POST: /Admin/Product/Delete/5

        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(int id)
        {
            Product product = db.Products.Find(id);
            db.Products.Remove(product);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}