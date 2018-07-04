using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MyEvernote.Entities;
using MyEvernote.DataAccessLayer;
using System.Data.Entity;


using System.Data.Entity.Validation;
using System.Data.Entity.Infrastructure;
using MyEvernote.Common;
using MyEvernote.Core.DataAccess;
namespace MyEvernote.DataAccessLayer.EntityFramework
{


    //REPOSİTORY PATTERN MİMARİSİ

    public class Repository<T> : RepositoryBase, IDataAccess<T> where T : class
    {

        private DbSet<T> _objectSet;

        public Repository()
        {
            _objectSet = context.Set<T>();
        }


        public List<T> List()
        {
            return _objectSet.ToList();//hangi tip gelirse onun veritabanındaki verilerini getir.
        }


        public IQueryable<T> ListQueryable()
        {
            return _objectSet.AsQueryable<T>();
        }




        public List<T> List(System.Linq.Expressions.Expression<Func<T, bool>> where)   //x=>x.Id=3 gibi ifade yazmak için
        {
            return _objectSet.Where(where).ToList();
        }

        //tek kayıt çekmek için
        public T Find(System.Linq.Expressions.Expression<Func<T, bool>> where)
        {

            return _objectSet.FirstOrDefault(where);

        }

        public int Insert(T obj)
        {
            _objectSet.Add(obj);

            //üç propertiyi burda yönettik.
            if (obj is MyEntityBase) //MyEntityBase tipinde ise yani miras almışsa  gibi yani aslında bizim entitimiz ise
            {


                MyEntityBase o = obj as MyEntityBase;//cast ettik.
                DateTime now = DateTime.Now;

                o.CreatedOn = now;
                o.ModifiedOn = now;
                o.ModifiedUserName = App.Common.GetCurrentUserName();//web yada masaüstü farketmeden  bu şekilde yaparak kullanıcı bilgisine erişebildik. 


            }

            return Save();
        }


        public int Update(T obj)
        {


            if (obj is MyEntityBase) //MyEntityBase tipinde ise yani miras almışsa  gibi yani aslında bizim entitimiz ise
            {

                //üç propertiyi burda yönettik.
                MyEntityBase o = obj as MyEntityBase;//cast ettik.


                o.ModifiedOn = DateTime.Now;
                o.ModifiedUserName = App.Common.GetCurrentUserName();


            }



            return Save();//değişiklikeri kaydetmek yeterli.
        }

        public int Delete(T obj)
        {

            _objectSet.Remove(obj);
            return Save();
        }


        public int Save()
        {
            //try
            //{
            return context.SaveChanges();
            //}
            //catch (DbEntityValidationException ex) //entity framework hatalarını daha iyi görebilmek için .hangi kolonlar doldurulmalı diye falan söylüyor  //http://www.binaryintellect.net/articles/c1bff938-1789-4501-8161-3f38bc465a8b.aspx
            //{
            //    foreach (DbEntityValidationResult item in ex.EntityValidationErrors)
            //    {
            //        // Get entry

            //        DbEntityEntry entry = item.Entry;
            //        string entityTypeName = entry.Entity.GetType().Name;

            //        // Display or log error messages

            //        foreach (DbValidationError subItem in item.ValidationErrors)
            //        {
            //            string message = string.Format("Error '{0}' occurred in {1} at {2}",
            //                     subItem.ErrorMessage, entityTypeName, subItem.PropertyName);
            //            Console.WriteLine(message);
            //        }


            //    }

            //    return -1;
            //}
        }





    }
}


//Hata :T referans tipli olmalı
// Error	1	The type 'T' must be a reference type in order to use it as parameter 'TEntity' in the generic type or method 'System.Data.Entity.DbContext.Set<TEntity>()'	C:\Users\RAMAZAN\Desktop\MyEvernoteSolution\MyEvernote.BusinessLayer\Repository.cs	18	13	MyEvernote.BusinessLayer
//Çözümü
//yukarı where T:class ekledik.