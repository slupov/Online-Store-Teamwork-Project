﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using OnlineStore.Models;
using Microsoft.AspNet.Identity;

namespace OnlineStore.Controllers
{
    public class CartsController : Controller
    {
        private OnlineStorePSGMEntities db = new OnlineStorePSGMEntities();

        // GET: Carts
        public ActionResult Index()
        {
            var carts = db.Carts.Include(c => c.Member).Include(c => c.Product);
            return View(carts.ToList());
        }

        // GET: Carts/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Cart cart = db.Carts.Find(id);
            if (cart == null)
            {
                return HttpNotFound();
            }
            return View(cart);
        }

        // GET: Carts/Create
        public ActionResult Create()
        {
            ViewBag.MemberID = new SelectList(db.Members, "MemberID", "Username");
            ViewBag.ProductID = new SelectList(db.Products, "ProductID", "ProductName");
            return View();
        }

        // POST: Carts/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "CartID,MemberID,ProductID,Quantity")] Cart cart)
        {
            if (ModelState.IsValid)
            {
                db.Carts.Add(cart);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.MemberID = new SelectList(db.Members, "MemberID", "Username", cart.MemberID);
            ViewBag.ProductID = new SelectList(db.Products, "ProductID", "ProductName", cart.ProductID);
            return View(cart);
        }

        // GET: Carts/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Cart cart = db.Carts.Find(id);
            if (cart == null)
            {
                return HttpNotFound();
            }
            ViewBag.MemberID = new SelectList(db.Members, "MemberID", "Username", cart.MemberID);
            ViewBag.ProductID = new SelectList(db.Products, "ProductID", "ProductName", cart.ProductID);
            return View(cart);
        }

        // POST: Carts/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "CartID,MemberID,ProductID,Quantity")] Cart cart)
        {
            if (ModelState.IsValid)
            {
                db.Entry(cart).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.MemberID = new SelectList(db.Members, "MemberID", "Username", cart.MemberID);
            ViewBag.ProductID = new SelectList(db.Products, "ProductID", "ProductName", cart.ProductID);
            return View(cart);
        }

        // GET: Carts/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Cart cart = db.Carts.Find(id);
            if (cart == null)
            {
                return HttpNotFound();
            }
            return View(cart);
        }

        // POST: Carts/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Cart cart = db.Carts.Find(id);
            db.Carts.Remove(cart);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        public ActionResult MyCart()
        {
            var aspUserName = User.Identity.GetUserName();
            var dbUser = db.Members.Where(m => m.Username == aspUserName).First(); // db user <-> asp user linked by Username
            var myCartItems = db.Carts.Where(c => c.MemberID == dbUser.MemberID); // returns only the logged user's cart

            return View(myCartItems);
        }


        public void AddToCart(int id, int amount)
        {
            Cart cart = new Cart();

            var aspUserName = User.Identity.GetUserName();
            var dbUser = db.Members.Where(m => m.Username == aspUserName).First();
            cart.MemberID = dbUser.MemberID;
            cart.ProductID = id;
            cart.Quantity = amount;

            if (ModelState.IsValid)
            {
                db.Carts.Add(cart);
                db.SaveChanges();
            }

            ViewBag.MemberID = new SelectList(db.Members, "MemberID", "Username", cart.MemberID);
        }

        public ActionResult BuyCart(int memberID)
        {
            ViewBag.Message = "Thank you for your purchase!";

            foreach (Product product in db.Carts.Where(c => c.MemberID == memberID).Select(c => c.Product).ToList())
            {
                product.Stock = product.Stock - db.Carts.Single(c => c.ProductID == product.ProductID && c.MemberID == memberID).Quantity;
                db.SaveChanges();
            }

            db.Carts.RemoveRange(db.Carts.Where(c => c.MemberID == memberID));
            db.SaveChanges();

            return View();
        }
    }
}
