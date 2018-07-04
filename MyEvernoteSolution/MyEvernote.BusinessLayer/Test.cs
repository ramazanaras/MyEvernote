using MyEvernote.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MyEvernote.DataAccessLayer.EntityFramework;//ekledik
//using MyEvernote.DataAccessLayer.MySql; //mysqle geçiş yaparsak bunu kullanabiliriz
namespace MyEvernote.BusinessLayer
{
    public class Test
    {
        private Repository<EvernoteUser> repo_user = new Repository<EvernoteUser>();
        private Repository<Category> repo_category = new Repository<Category>();
        private Repository<Comment> repo_comment = new Repository<Comment>();
        private Repository<Note> repo_note = new Repository<Note>();

        public Test()
        {
            #region Veritabanı otomatik oluşturmak için
            //Codefirst
            //veritabınını otomatik oluşturması için  Böyle bir class yaptık.Conntroller sayfasında   Test t = new Test(); bu şekilde çağırınca oluşturdu veritabanını
            // DataAccessLayer.DatabaseContext db = new DataAccessLayer.DatabaseContext();
            //   db.EvernoteUsers.ToList();//bunu yazında constructora gider vede oradanda MyInitializer sınıfına gidip veritabanını oluşturur vede fake veriler ekler.
            //db.Database.CreateIfNotExists();//bu şekildede veritabanını otomatik oluşturabiliriz. 
            #endregion

            //List<Category> a = repo_category.List();
            //List<Category> categories_filtered=repo_category.List(x=>x.Id>5).ToList();


        }

        public void InsertTest()
        {

            int result = repo_user.Insert(new EvernoteUser
            {
                Name = "asdsa",
                Surname = "dasdewqq",
                Email = "wqeqw@hotmail.com",
                ActivateGuid = Guid.NewGuid(),
                IsActive = true,
                IsAdmin = true,
                UserName = "ewqwq",
                Password = "e21313",
                CreatedOn = DateTime.Now,
                ModifiedOn = DateTime.Now,
                ModifiedUserName = "ewqeqwe"



            });
        }
        public void UpdateTest()
        {
            EvernoteUser user = repo_user.Find(x => x.UserName == "ewqwq");
            if (user != null)
            {
                user.UserName = "xxx";
                int result = repo_user.Update(user);
            }
        }
        public void DeleteTest()
        {
            EvernoteUser user = repo_user.Find(x => x.UserName == "xxx");
            if (user != null)
            {
                int result = repo_user.Delete(user);

            }
        }




        public void CommentTest()
        {
            EvernoteUser user = repo_user.Find(x=>x.Id==1);
            Note note = repo_note.Find(x=>x.Id==3);

            Comment comment = new Comment()
            {
                Text="Bu bir testdir",
                CreatedOn=DateTime.Now,
                ModifiedOn=DateTime.Now,
                ModifiedUserName="murat",
                Note=note, //note nesnesini verdik.
                Owner=user,//Eveernote nesnesini verdik
                
            };

            int result=repo_comment.Insert(comment);

            /*
             Hata! -->Farklı contextlerden getirdiğin nesneleri aynı anda save edersen patlar.Bunun çözümü tek context yapmaktır.(Singleton pattern )
             * Additional information: An entity object cannot be referenced by multiple instances of IEntityChangeTracker.
             
             
             */



        }







    }
}


////business layera manage nugettan entity framework yükle(db.Comments. dedikten sonra Tolist veya Firstordefault gibi metotların çıkması için:)