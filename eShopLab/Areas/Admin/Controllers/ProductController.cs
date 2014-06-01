﻿using System;
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
        public ActionResult Create(Product product, ICollection<ProduSizeCat> prodSizeCat, int Price)
        {
            foreach (var prodSize in prodSizeCat)
            {
                if (prodSize.check == "on")
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
                db.Prices.Add(new Price()
                {
                    PriceValue = Price,
                    PriceDate = DateTime.Now,
                    ProductID = product.ProductID
                });
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(product);
        }

        //
        // GET: /Admin/Product/Edit/5

        public ActionResult Edit(int id = 0)
        {
            //int? price = db.Prices.Where(p => p).Select(p => p.PriceValue).Max(p => p.PriceDate);
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