using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MyEvernote.WebApp.Filters
{
    //herhangi bir actionda hata olduğunda yönettiğimiz filter
    public class Exc:FilterAttribute,IExceptionFilter
    {
        public void OnException(ExceptionContext filterContext)
        {

            filterContext.Controller.TempData["LastError"] = filterContext.Exception;

            filterContext.ExceptionHandled = true;//hatayı ben yöneticem dedik.

            //herhangi bir actionda hata olduğunda /Home/HassError 'a yönlenir.
            filterContext.Result = new RedirectResult("/Home/HasError");


        }
    }
}