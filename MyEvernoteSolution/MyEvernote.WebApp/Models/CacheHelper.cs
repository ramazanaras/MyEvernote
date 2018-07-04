using MyEvernote.BusinessLayer;
using MyEvernote.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Helpers;

namespace MyEvernote.WebApp.Models
{
    //performans açısından yaptık 
    public class CacheHelper
    {
        public static List<Category> GetCategoriesFromCache()
        {

            var result = WebCache.Get("category-cache");//cacheden değerleri okuyoruz
            if (result == null)
            {
                CategoryManager categoryManager = new CategoryManager();
                
                result=categoryManager.List();
                
                WebCache.Set("category-cache",result,20,true);//cache'a attık
               
            }


            return result;

        }


        public static void RemoveCategoriesFromCache()
        {
            //categorileri cacheden silme
            Remove("category-cache");
        }

        public static void Remove(string key)
        {
            WebCache.Remove(key);//cache i sil
        }

    }
}


//Install-Package Microsoft.AspNet.WebHelpers -Version 3.2.3 --WebCache sınıfı için ykledik