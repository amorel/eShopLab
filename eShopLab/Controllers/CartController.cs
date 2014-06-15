using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using eShopLab.Models;

namespace eShopLab.Controllers
{
    public class CartController : Controller
    {
        eShopDBEntities db = new eShopDBEntities();

        //
        // GET: /Cart/

        public ActionResult Index()
        {
            return View();
        }

    }
}
