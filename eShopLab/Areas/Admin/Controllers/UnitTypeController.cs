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
    public class UnitTypeController : Controller
    {
        private eShopDBEntities db = new eShopDBEntities();

        //
        // GET: /Admin/UnitType/

        public ActionResult Index()
        {
            return View(db.UnitTypes.ToList());
        }

        //
        // GET: /Admin/UnitType/Details/5

        public ActionResult Details(int id = 0)
        {
            UnitType unittype = db.UnitTypes.Find(id);
            if (unittype == null)
            {
                return HttpNotFound();
            }
            return View(unittype);
        }

        //
        // GET: /Admin/UnitType/Create

        public ActionResult Create()
        {
            return View();
        }

        //
        // POST: /Admin/UnitType/Create

        [HttpPost]
        public ActionResult Create(UnitType unittype)
        {
            if (ModelState.IsValid)
            {
                db.UnitTypes.Add(unittype);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(unittype);
        }

        //
        // GET: /Admin/UnitType/Edit/5

        public ActionResult Edit(int id = 0)
        {
            UnitType unittype = db.UnitTypes.Find(id);
            if (unittype == null)
            {
                return HttpNotFound();
            }
            return View(unittype);
        }

        //
        // POST: /Admin/UnitType/Edit/5

        [HttpPost]
        public ActionResult Edit(UnitType unittype)
        {
            if (ModelState.IsValid)
            {
                db.Entry(unittype).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(unittype);
        }

        //
        // GET: /Admin/UnitType/Delete/5

        public ActionResult Delete(int id = 0)
        {
            UnitType unittype = db.UnitTypes.Find(id);
            if (unittype == null)
            {
                return HttpNotFound();
            }
            return View(unittype);
        }

        //
        // POST: /Admin/UnitType/Delete/5

        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(int id)
        {
            UnitType unittype = db.UnitTypes.Find(id);
            db.UnitTypes.Remove(unittype);
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