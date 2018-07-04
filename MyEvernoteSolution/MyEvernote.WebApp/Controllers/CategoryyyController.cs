using MyEvernote.BusinessLayer;
using MyEvernote.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace MyEvernote.WebApp.Controllers
{
    public class CategoryyyController : Controller
    {
        //Tempdata ile kategoriye göre notlar  listeleme
        //public ActionResult Select(int? id)
        //{
        //    if (id == null)
        //    {
        //        return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
        //    }

        //    CategoryManager cm = new CategoryManager();
        //    Category cat = cm.GetCategoryById(id.Value);

        //    if (cat==null)
        //    {
        //        return HttpNotFound();
        //    }


        //    //bir actiondan diğer actiona geçerken kullanılabilir.data taşıma
        //    TempData["mm"] = cat.Notes; ;

        //    return RedirectToAction("Index","Home");
        //}


    }

}
