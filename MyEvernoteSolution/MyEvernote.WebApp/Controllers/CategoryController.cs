using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using MyEvernote.Entities;
using MyEvernote.BusinessLayer;
using MyEvernote.WebApp.Models;
using MyEvernote.WebApp.Filters;

namespace MyEvernote.WebApp.Controllers
{
    //class düzeyinde yazmışsak tüm actionlarda bu geçerli demektir.
    [AuthAdmin] //sadece adminler bu actionları çalıştırır dedik.yoksa  /Home/AccessDenied burdaki actiona yönlendirir dedik.
    [Auth]  //filter ekledik.giriş yapmamışsa yönlendirme yapıyoruz bu classta(Filters klasöründe)(authenticationfilterlogin)
    [Exc] //exception filter uyguladık.yani bu controllerdaki herhangi bir actionda hata olduğunda yapılacakları belirttik bu classta
    public class CategoryController : Controller
    {

        CategoryManager categoryManager = new CategoryManager();


        //[Auth]
        public ActionResult Index()
        {
            return View(categoryManager.List());
        }

        //[Auth]
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                //hata sayfası çıksın diye.
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Category category = categoryManager.Find(x => x.Id == id);
            if (category == null)
            {
                return HttpNotFound();
            }
            return View(category);
        }


        public ActionResult Create()
        {
            return View();
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Category category)
        {
            //modelstate den kaldırdık.zaten Insert anında bunları dolduruyoruz.bir daha burda bizden istemesin diye yaptık
            ModelState.Remove("CreatedOn");
            ModelState.Remove("ModifiedOn");
            ModelState.Remove("ModifiedUserName");



            if (ModelState.IsValid)
            {
                categoryManager.Insert(category);
                CacheHelper.RemoveCategoriesFromCache();//cache i sildik.cachein update olabilmesi için

                return RedirectToAction("Index");
            }

            return View(category);
        }


        public ActionResult Edit(int? id)
        {



            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Category category = categoryManager.Find(x => x.Id == id.Value);
            if (category == null)
            {
                return HttpNotFound();
            }
            return View(category);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(Category category)
        {

            //modelstate den kaldırdık.zaten Insert anında bunları dolduruyoruz.bir daha burda bizden istemesin diye yaptık
            ModelState.Remove("CreatedOn");
            ModelState.Remove("ModifiedOn");
            ModelState.Remove("ModifiedUserName");

            if (ModelState.IsValid)
            {
                Category cat = categoryManager.Find(x => x.Id == category.Id);
                cat.Title = category.Title;
                cat.Description = category.Description;
                categoryManager.Update(cat);
                CacheHelper.RemoveCategoriesFromCache();//cache i sildik.cachein update olabilmesi için


                return RedirectToAction("Index");
            }
            return View(category);
        }


        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Category category = categoryManager.Find(x => x.Id == id.Value);
            if (category == null)
            {
                return HttpNotFound();
            }
            return View(category);
        }


        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Category category = categoryManager.Find(x => x.Id == id);
            categoryManager.Delete(category);
            CacheHelper.RemoveCategoriesFromCache();//cache i sildik.cachein update olabilmesi için
            return RedirectToAction("Index");
        }


    }
}
