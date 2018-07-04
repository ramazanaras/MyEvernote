using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MyEvernote.Entities;
using MyEvernote.DataAccessLayer;
using System.Data.Entity;


using MyEvernote.Core.DataAccess;
namespace MyEvernote.DataAccessLayer.MySql
{


    //REPOSİTORY PATTERN MİMARİSİ

    public class Repository<T>:RepositoryBase,IDataAccess<T> where T : class
    {

        public List<T> List()
        {
            throw new NotImplementedException();
        }

        public List<T> List(System.Linq.Expressions.Expression<Func<T, bool>> where)
        {
            throw new NotImplementedException();
        }

        public T Find(System.Linq.Expressions.Expression<Func<T, bool>> where)
        {
            throw new NotImplementedException();
        }

        public int Insert(T obj)
        {
            throw new NotImplementedException();
        //    MysqlConnection conn;
        //    conn.open;
        //    Mysqllcommand cmd = new Mysqllcommand("insert into");
        //cmd.execute()
        
        }

        public int Update(T obj)
        {
            throw new NotImplementedException();
        }

        public int Delete(T obj)
        {
            throw new NotImplementedException();
        }

        public int Save()
        {
            throw new NotImplementedException();
        }


        public IQueryable<T> ListQueryable()
        {
            throw new NotImplementedException();
        }
    }
}


