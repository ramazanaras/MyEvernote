using MyEvernote.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MyEvernote.WebApp.Models
{
    //sessiona erişmek için
    public class CurrentSession
    {

        public static EvernoteUser User
        {
            get
            {
                return Get<EvernoteUser>("login");
            }

        }

        public static void Set<T>(string key, T obj)
        {
            HttpContext.Current.Session[key] = obj;
        }



        public static T Get<T>(string key)
        {
            if (HttpContext.Current.Session[key] != null)
            {
                return (T)HttpContext.Current.Session[key];
            }

            return default(T);//class vermişsek null döner.int vermişsek 0 döner.boolean vermişsesk false döner.string vermişsek null döner  gibi.

        }


        //session silme
        public static void Remove(string key)
        {
            if (HttpContext.Current.Session[key] != null)
            {
                 HttpContext.Current.Session.Remove(key);
            }
        }


        public static void Clear()
        {
            //tüm sessionları sil.
            HttpContext.Current.Session.Clear();
           
        }
    }
}