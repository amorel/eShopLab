using eShopLab.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace eShopLab.Controllers
{
    public class AdminController : Controller
    {
        eShopDBEntities db = new eShopDBEntities();
        //
        // GET: /Admin/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Categories()
        {
            return View(db.Categories.ToList());
        }

        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Create(Category category)
        {
            db.Entry<Category>(category).State = System.Data.EntityState.Added;
            db.SaveChanges();

            return RedirectToAction("Categories");
        }
    }
}
