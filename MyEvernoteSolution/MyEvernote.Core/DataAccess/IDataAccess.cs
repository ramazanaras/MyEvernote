using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MyEvernote.Core.DataAccess
{
    //İlerde Sistemi mysqle falan geçirirsek diye bu soyut sınıfı yazdık
    public interface IDataAccess<T>  //önceden IRepository adında   DataAcccesslayerdaki Abstrack klasöründeydi.ama şimdi buraya aldık.çünkü bu metotları businesslayerda ve doğal olarak UI dada kullanabilmek için Core katmanı yapıp buraya aldık.Core katmanını UI katmanında referanslara ekliyoruz.Aslında core katmanı yapmamızın nedeni UI katmanında Data katmnına ihtiyaç olmadan bu metotları kullanabilmek 
    {
        List<T> List();
        IQueryable<T> ListQueryable();
        List<T> List(System.Linq.Expressions.Expression<Func<T, bool>> where);
        T Find(System.Linq.Expressions.Expression<Func<T, bool>> where);
        int Insert(T obj);
        int Update(T obj);
        int Delete(T obj);
        int Save();




    }
}
