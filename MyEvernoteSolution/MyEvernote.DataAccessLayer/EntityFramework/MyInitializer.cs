using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

//ekledik
using System.Data.Entity;
using MyEvernote.Entities;
using System.Data.Entity.Validation;
using System.Data.Entity.Infrastructure;

namespace MyEvernote.DataAccessLayer.EntityFramework
{

    //test verisi ekliyeceğimiz sınıf (Fakedata dll'i eklemiştik)

    public class MyInitializer : CreateDatabaseIfNotExists<DatabaseContext> //database yoksa çalışşsın
    {
        protected override void Seed(DatabaseContext context)
        {
            //Adding admin user
            EvernoteUser admin = new EvernoteUser()
            {
                Name = "Murat",
                Surname = "Başeren",
                Email = "muratbaseren@gmail.com",
                ActivateGuid = Guid.NewGuid(),
                IsActive = true,
                IsAdmin = true,
                UserName = "muratbaseren",
                ProfileImageFileName="user_boy.png",
                Password = "123456",
                CreatedOn = DateTime.Now,
                ModifiedOn = DateTime.Now.AddMinutes(5),
                ModifiedUserName = "muratbaseren"

            };
            //adding standart user
            EvernoteUser standartUser = new EvernoteUser()
            {
                Name = "Kadir",
                Surname = "Başeren",
                Email = "kadirbaseren@gmail.com",
                ActivateGuid = Guid.NewGuid(),
                IsActive = true,
                IsAdmin = false,
                ProfileImageFileName = "user_boy.png",
                UserName = "kadirbaseren",
                Password = "654321",
                CreatedOn = DateTime.Now.AddHours(1),
                ModifiedOn = DateTime.Now.AddMinutes(65),
                ModifiedUserName = "muratbaseren"
            };




            context.EvernoteUsers.Add(admin);
            context.EvernoteUsers.Add(standartUser);


            for (int i = 0; i < 8; i++)
            {
                EvernoteUser user = new EvernoteUser()
            {
                Name = FakeData.NameData.GetFirstName(),
                Surname = FakeData.NameData.GetSurname(),
                Email = FakeData.NetworkData.GetEmail(),
                ActivateGuid = Guid.NewGuid(),
                IsActive = true,
                IsAdmin = false,
                ProfileImageFileName = "user_boy.png",
                UserName = "user" + i,
                Password = "123",
                CreatedOn = FakeData.DateTimeData.GetDatetime(DateTime.Now.AddYears(-1), DateTime.Now),
                ModifiedOn = FakeData.DateTimeData.GetDatetime(DateTime.Now.AddYears(-1), DateTime.Now),
                ModifiedUserName = "user" + i,
            };

                context.EvernoteUsers.Add(user);

            }





            context.SaveChanges();

            //User List for using 
            List<EvernoteUser> userlist = context.EvernoteUsers.ToList();

            //Addding Fake Categories
            for (int i = 0; i < 10; i++)
            {
                Category cat = new Category()
                {
                    Title = FakeData.PlaceData.GetStreetName(),
                    Description = FakeData.PlaceData.GetAddress(),
                    CreatedOn = DateTime.Now,
                    ModifiedOn = DateTime.Now,
                    ModifiedUserName = "muratbaseren"
                };

                context.Categories.Add(cat);


                //adding fake notes
                for (int k = 0; k < FakeData.NumberData.GetNumber(5, 9); k++)
                {
                    EvernoteUser owner = userlist[FakeData.NumberData.GetNumber(0, userlist.Count - 1)];

                    Note note = new Note()
                    {
                        Title = FakeData.TextData.GetAlphabetical(FakeData.NumberData.GetNumber(5, 25)),
                        Text = FakeData.TextData.GetSentences(FakeData.NumberData.GetNumber(1, 3)),

                        IsDraft = false,
                        LikeCount = FakeData.NumberData.GetNumber(1, 9),
                        Owner = owner,
                        CreatedOn = FakeData.DateTimeData.GetDatetime(DateTime.Now.AddYears(-1), DateTime.Now),
                        ModifiedOn = FakeData.DateTimeData.GetDatetime(DateTime.Now.AddYears(-1), DateTime.Now),
                        ModifiedUserName = owner.UserName
                    };

                    cat.Notes.Add(note);//categorinin notlarına ekledik.


                    //adding fake comments
                    for (int j = 0; j < FakeData.NumberData.GetNumber(3, 5); j++)
                    {

                        EvernoteUser comment_owner = userlist[FakeData.NumberData.GetNumber(0, userlist.Count - 1)];


                        Comment comment = new Comment()
                        {
                            Text = FakeData.TextData.GetSentence(),

                            Owner = comment_owner, //evernote user
                            CreatedOn = FakeData.DateTimeData.GetDatetime(DateTime.Now.AddYears(-1), DateTime.Now),
                            ModifiedOn = FakeData.DateTimeData.GetDatetime(DateTime.Now.AddYears(-1), DateTime.Now),
                            ModifiedUserName = comment_owner.UserName

                        };


                        note.Comments.Add(comment);//noteun commentlerine ekledik.


                    }



                    //adding fake  likes



                    for (int m = 0; m < note.LikeCount; m++)
                    {
                        Liked liked = new Liked()
                        {
                            LikedUser = userlist[m],//likeları likelayan user

                        };

                        note.Likes.Add(liked);//noteların likelarına ekledik
                    }


                }


            }
            try
            {
                context.SaveChanges();//veritabanı oluşucak ve fake veriler eklencek.
            }
            catch (DbEntityValidationException ex) //entity framework hatalarını daha iyi görebilmek için .hangi kolonlar doldurulmalı diye falan söylüyor  //http://www.binaryintellect.net/articles/c1bff938-1789-4501-8161-3f38bc465a8b.aspx
            {
                foreach (DbEntityValidationResult item in ex.EntityValidationErrors)
                {
                    // Get entry

                    DbEntityEntry entry = item.Entry;
                    string entityTypeName = entry.Entity.GetType().Name;

                    // Display or log error messages

                    foreach (DbValidationError subItem in item.ValidationErrors)
                    {
                        string message = string.Format("Error '{0}' occurred in {1} at {2}",
                                 subItem.ErrorMessage, entityTypeName, subItem.PropertyName);
                        Console.WriteLine(message);
                    }


                }
            }











        }



    }
}





