using MyEvernote.WebApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MyEvernote.WebApp.Filters
{
    //bu classı attribute olarak kullancaz
    public class AuthAdmin : FilterAttribute, IAuthorizationFilter
    {
        public void OnAuthorization(AuthorizationContext filterContext)
        {
            if (CurrentSession.User!=null && CurrentSession.User.IsAdmin==false) //admin değilse 
            {
                filterContext.Result = new RedirectResult("/Home/AccessDenied");  //Home controllerdaki AccessDenied actionına  yönlendir.
            }
        }
    }
}