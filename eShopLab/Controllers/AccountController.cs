using eShopLab.Models;
using eShopLab.Provider;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace eShopLab.Controllers
{
    public class AccountController : Controller
    {

        CustomMembershipProvider membershipProvider = new CustomMembershipProvider();

        //
        // GET: /Account/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Login()
        {
            ReturnUrlViewBag((string)TempData["returnUrl"]);
            ViewBag.username = Request.Cookies["eShopLab"] != null ? Request.Cookies["eShopLab"].Values["username"] : "";
            return View();
        }

        [HttpPost]
        public ActionResult Login(LoginViewModel loginViewModel, string returnUrl)
        {
            if (loginViewModel.RememberMe)
            {
                HttpCookie cookie = new HttpCookie("eShopLab");
                cookie.Values.Add("username", loginViewModel.UserName);
                cookie.Expires = DateTime.Now.AddDays(15);
                Response.Cookies.Add(cookie);
            }

            User user = new User();
            if (membershipProvider.ValidateUser(loginViewModel, out user))
            {
                FormsAuthentication.SetAuthCookie(loginViewModel.UserName, loginViewModel.RememberMe);
                if (!string.IsNullOrEmpty(returnUrl) && returnUrl.Length > 1)
                {
                    return Redirect(returnUrl);
                }
                else
                {
                    return RedirectToAction("Index", "Home");
                }
            }
            return View();
        }

        //
        // GET: /Account/Register
        [AllowAnonymous]
        public ActionResult Register(string returnUrl)
        {
            ReturnUrlViewBag(returnUrl);
            return View();
        }

        //
        // POST: /Account/Register
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public ActionResult Register(RegisterViewModel model, string returnUrl)
        {
            if (ModelState.IsValid)
            {
                User user;
                List<string> errors;
                if (membershipProvider.CreateAccount(model, out errors, out user))
                {
                    FormsAuthentication.SetAuthCookie(model.UserName, true);
                    if (!string.IsNullOrEmpty(returnUrl) && returnUrl.Length > 1)
                    {
                        return Redirect(returnUrl);
                    }
                    else
                    {
                        return RedirectToAction("Index", "Home");
                    }
                }

                AddErrors(errors);
            }
            return View(model);
        }

        public ActionResult Logout(string returnUrl)
        {
            FormsAuthentication.SignOut();
            if (!string.IsNullOrEmpty(returnUrl) && returnUrl.Length > 1)
            {
                return Redirect(returnUrl);
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }
        }

        private void AddErrors(List<string> errors)
        {
            foreach (string error in errors)
            {
                ModelState.AddModelError("", error);
            }
        }

        private void ReturnUrlViewBag(string returnUrl)
        {
            if (string.IsNullOrEmpty(returnUrl) && Request.UrlReferrer != null)
                returnUrl = Server.UrlEncode(Request.UrlReferrer.PathAndQuery);

            if (!string.IsNullOrEmpty(returnUrl))
            {
                ViewBag.ReturnURL = returnUrl;
            }
        }
    }
}
