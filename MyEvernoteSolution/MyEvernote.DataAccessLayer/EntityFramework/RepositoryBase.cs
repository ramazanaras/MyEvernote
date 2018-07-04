using MyEvernote.DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MyEvernote.DataAccessLayer.EntityFramework
{
    public class RepositoryBase
    {



        /*
      Hata! -->Farklı contextlerden getirdiğin nesneleri aynı anda save edersen patlar.Bunun çözümü tek context yapmaktır.(Singleton pattern )
      * Additional information: An entity object cannot be referenced by multiple instances of IEntityChangeTracker.
      */
        //SINGLETON PATTERN (Tek bir Context nesnesi üretme)

        protected static DatabaseContext context;
        private static object _lockSync = new object();

        //classı new 'leyemeyiz artık
        protected RepositoryBase() //protected constructor
        {
             CreateContext();//single pattern(tek context üretme )
        }


        private static void CreateContext()
        {
            if (context == null)//boşsa contexti new 'le
            {
                lock (_lockSync)
                {
                    if (context == null)
                    {
                        context = new DatabaseContext();
                    }

                }

            }

        }






    }
}
