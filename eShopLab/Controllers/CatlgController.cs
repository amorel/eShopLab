using eShopLab.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace eShopLab.Controllers
{
    public class CatlgController : Controller
    {
        private eShopDBEntities db = new eShopDBEntities();

        //
        // GET: /Catlg/

        public ActionResult Index()
        {
            ViewBag.Categories = db.Categories.Where(c=>c.CategoryIsMenu == true);
            return View(db.Products);
        }

    }
}
