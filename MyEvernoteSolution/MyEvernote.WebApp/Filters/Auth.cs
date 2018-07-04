using MyEvernote.WebApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MyEvernote.WebApp.Filters
{

    //bu classı attribute olarak kullancaz
    public class Auth:FilterAttribute,IAuthorizationFilter
    {
        public void OnAuthorization(AuthorizationContext filterContext)
        {
            if (CurrentSession.User==null)//giriş yapmamışsa Home Login e yönlendircez
            {
                filterContext.Result = new RedirectResult("/Home/Login");
            }
        }
    }
}