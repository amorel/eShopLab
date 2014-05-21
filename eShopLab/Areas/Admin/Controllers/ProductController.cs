using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using eShopLab.Models;

namespace eShopLab.Areas.Admin.Controllers
{
    public class ProductController : Controller
    {
        private eShopDBEntities db = new eShopDBEntities();

        //
        // GET: /Admin/Product/

        public ActionResult Index()
        {
            var products = db.Products.Include(p => p.Category).Include(p => p.Medium).Include(p => p.UnitType).Include(p => p.SizeCategory);
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
            ViewBag.CategoryID = new SelectList(db.Categories, "CategoryID", "CategoryName");
            ViewBag.MediaID = new SelectList(db.Media, "MediaID", "MediaName");
            ViewBag.UnitTypeID = new SelectList(db.UnitTypes, "UnitTypeID", "UnitTypeName");
            ViewBag.VATCategoryID = new SelectList(db.SizeCategories, "SizeCategoryID", "SizeCategoryName");
            return View();
        }

        //
        // POST: /Admin/Product/Create

        [HttpPost]
        public ActionResult Create(Product product)
        {
            if (ModelState.IsValid)
            {
                db.Products.Add(product);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.CategoryID = new SelectList(db.Categories, "CategoryID", "CategoryName", product.CategoryID);
            ViewBag.MediaID = new SelectList(db.Media, "MediaID", "MediaName", product.MediaID);
            ViewBag.UnitTypeID = new SelectList(db.UnitTypes, "UnitTypeID", "UnitTypeName", product.UnitTypeID);
            ViewBag.VATCategoryID = new SelectList(db.SizeCategories, "SizeCategoryID", "SizeCategoryName", product.VATCategoryID);
            return View(product);
        }

        //
        // GET: /Admin/Product/Edit/5

        public ActionResult Edit(int id = 0)
        {
            Product product = db.Products.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            ViewBag.CategoryID = new SelectList(db.Categories, "CategoryID", "CategoryName", product.CategoryID);
            ViewBag.MediaID = new SelectList(db.Media, "MediaID", "MediaName", product.MediaID);
            ViewBag.UnitTypeID = new SelectList(db.UnitTypes, "UnitTypeID", "UnitTypeName", product.UnitTypeID);
            ViewBag.VATCategoryID = new SelectList(db.SizeCategories, "SizeCategoryID", "SizeCategoryName", product.VATCategoryID);
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
            ViewBag.MediaID = new SelectList(db.Media, "MediaID", "MediaName", product.MediaID);
            ViewBag.UnitTypeID = new SelectList(db.UnitTypes, "UnitTypeID", "UnitTypeName", product.UnitTypeID);
            ViewBag.VATCategoryID = new SelectList(db.SizeCategories, "SizeCategoryID", "SizeCategoryName", product.VATCategoryID);
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