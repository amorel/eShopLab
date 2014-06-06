using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using eShopLab.Models;
using System.IO;

namespace eShopLab.Areas.Admin.Controllers
{
    public class CategoryController : Controller
    {
        private eShopDBEntities db = new eShopDBEntities();

        //
        // GET: /Admin/Category/

        public ActionResult Index()
        {
            var categories = db.Categories.Include(c => c.Medium);
            return View(categories.ToList());
        }

        //
        // GET: /Admin/Category/Details/5

        public ActionResult Details(int id = 0)
        {
            Category category = db.Categories.Find(id);
            if (category == null)
            {
                return HttpNotFound();
            }
            return View(category);
        }

        //
        // GET: /Admin/Category/Create

        public ActionResult Create()
        {
            return View();
        }

        //
        // POST: /Admin/Category/Create

        [HttpPost]
        public ActionResult Create(Category category)
        {
            if (category.File != null && category.File.ContentLength > 0)
            {
                string ext  = Path.GetExtension(category.File.FileName);
                category.File.SaveAs(Server.MapPath("~/Uploads/" + category.CategoryName + category.CategoryID + ext));
                category.Medium = new Medium()
                {
                    MediaName = category.CategoryName + category.CategoryID,
                    MediaAlt = category.CategoryName,
                    MediaUrl = "~/Uploads/" + category.CategoryName + category.CategoryID + ext
                };
            }

            if (ModelState.IsValid)
            {
                db.Categories.Add(category);
                db.SaveChanges();
            }
            return RedirectToAction("Index");;
        }

        //
        // GET: /Admin/Category/Edit/5

        public ActionResult Edit(int id = 0)
        {
            Category category = db.Categories.Find(id);
            if (category == null)
            {
                return HttpNotFound();
            }
            ViewBag.MediaID = new SelectList(db.Media, "MediaID", "MediaName", category.MediaID);
            return View(category);
        }

        //
        // POST: /Admin/Category/Edit/5

        [HttpPost]
        public ActionResult Edit(Category category)
        {
            if (ModelState.IsValid)
            {
                db.Entry(category).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.MediaID = new SelectList(db.Media, "MediaID", "MediaName", category.MediaID);
            return View(category);
        }

        //
        // GET: /Admin/Category/Delete/5

        public ActionResult Delete(int id = 0)
        {
            Category category = db.Categories.Find(id);
            if (category == null)
            {
                return HttpNotFound();
            }
            return View(category);
        }

        //
        // POST: /Admin/Category/Delete/5

        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(int id)
        {
            try
            {
                Category category = db.Categories.Find(id);
                if(category.Medium != null) category.Medium.DeleteFile(Server.MapPath("~/Uploads/"));
                db.Categories.Remove(category);
                db.SaveChanges();
            }
            catch(Exception e)
            {
                
            }
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}