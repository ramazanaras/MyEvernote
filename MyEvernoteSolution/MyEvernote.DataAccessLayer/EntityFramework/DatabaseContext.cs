using MyEvernote.Entities;
using System;
using System.Collections.Generic;

//entity framework dllinde geliyor.
using System.Data.Entity; 

using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MyEvernote.DataAccessLayer.EntityFramework
{
    //bunları kendimiz yazıyoruz.veritabanını kendi oluşturucak(Code First)
    public class DatabaseContext:DbContext
    {
        public DbSet<EvernoteUser> EvernoteUsers { get; set; }
        public DbSet<Category> Categories { get; set; }
        public DbSet<Note> Notes { get; set; }
        public DbSet<Comment> Comments { get; set; }
        public DbSet<Liked> Likes { get; set; }



        public DatabaseContext()
        {
            Database.SetInitializer(new MyInitializer());//veritabanını oluşturur vede fake veriler ekler.
        }






    }
}


//dataAccesslayera manage nugettan entity framework yükle(FirstOrdefault() gibi metotların çıkması için veya DbContext sınıfını kullanabilmek içni falan gerekli)
//dataAccesslayera manage nugettan fakedata yükle

/*
 webconfige aşğıdakini ekledik
 *  <add name="DatabaseContext"  -->isim ile context ismi aynı olmalı
 *  ;Database=MyEvernoteDB; -->oluşturulacak veritabanı adı
 * 
 *   <connectionString>
    <add name="DatabaseContext"  providerName="System.Data.SqlClient" connectionString="Server=.;Database=MyEvernoteDB;Integrated Security=true"/>
  </connectionString>
 
 */