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
    public class SizeCategoryController : Controller
    {
        private eShopDBEntities db = new eShopDBEntities();

        //
        // GET: /Admin/SizeCategory/

        public ActionResult Index()
        {
            return View(db.SizeCategories.ToList());
        }

        //
        // GET: /Admin/SizeCategory/Details/5

        public ActionResult Details(int id = 0)
        {
            SizeCategory sizecategory = db.SizeCategories.Find(id);
            if (sizecategory == null)
            {
                return HttpNotFound();
            }
            return View(sizecategory);
        }

        //
        // GET: /Admin/SizeCategory/Create

        public ActionResult Create()
        {
            return View();
        }

        //
        // POST: /Admin/SizeCategory/Create

        [HttpPost]
        public ActionResult Create(SizeCategory sizecategory)
        {
            if (ModelState.IsValid)
            {
                db.SizeCategories.Add(sizecategory);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(sizecategory);
        }

        //
        // GET: /Admin/SizeCategory/Edit/5

        public ActionResult Edit(int id = 0)
        {
            SizeCategory sizecategory = db.SizeCategories.Find(id);
            if (sizecategory == null)
            {
                return HttpNotFound();
            }
            return View(sizecategory);
        }

        //
        // POST: /Admin/SizeCategory/Edit/5

        [HttpPost]
        public ActionResult Edit(SizeCategory sizecategory)
        {
            if (ModelState.IsValid)
            {
                db.Entry(sizecategory).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(sizecategory);
        }

        //
        // GET: /Admin/SizeCategory/Delete/5

        public ActionResult Delete(int id = 0)
        {
            SizeCategory sizecategory = db.SizeCategories.Find(id);
            if (sizecategory == null)
            {
                return HttpNotFound();
            }

            return View(sizecategory);
        }

        //
        // POST: /Admin/SizeCategory/Delete/5

        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(int id)
        {
            SizeCategory sizecategory = db.SizeCategories.Find(id);
            db.SizeCategories.Remove(sizecategory);
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