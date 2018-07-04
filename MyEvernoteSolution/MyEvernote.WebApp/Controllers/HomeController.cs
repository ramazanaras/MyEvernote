
using MyEvernote.BusinessLayer;
using MyEvernote.BusinessLayer.Results;
using MyEvernote.Entities;
using MyEvernote.Entities.Messages;
using MyEvernote.Entities.ValueObjects;
using MyEvernote.WebApp.Filters;
using MyEvernote.WebApp.Models;
using MyEvernote.WebApp.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace MyEvernote.WebApp.Controllers
{
    [Exc] //exception filter uyguladık.yani bu controllerdaki herhangi bir actionda hata olduğunda yapılacakları belirttik bu classta
    public class HomeController : Controller
    {
        private NoteManager nm = new NoteManager();
        private EvernoteUserManager eum = new EvernoteUserManager();
        private CategoryManager cm = new CategoryManager();


        public ActionResult Index()
        {
            //exception filterı test etmek için yaptım.
            //object o = 0;
            //int a = 1;
            //int c = a / (int)o;




            #region Veritabanı olusturma ve Test metotları
            //veritabanı oluşturmak için
            //   MyEvernote.BusinessLayer.Test t = new MyEvernote.BusinessLayer.Test(); //businesslayerda veritabanı oluşturan classtır.veritabanını oluşturucaz.

            //   MyEvernote.BusinessLayer.Test t = new MyEvernote.BusinessLayer.Test();
            //    t.InsertTest();
            //t.UpdateTest();  
            //t.DeleteTest();
            // t.CommentTest(); 
            #endregion

            //Category controlller üzerinden gelen view talebi.
            //if (TempData["mm"]!=null)//Category controllerdan gelmiş 
            //{

            //    return View(TempData["mm"] as List<Note>);
            //}

            NoteManager nm = new NoteManager();
            //burası çalışıncada veritabanı oluşur.sonuçta contexti çağırıyor.
            return View(nm.ListQueryable().Where(x=>x.IsDraft==false).OrderByDescending(x => x.ModifiedOn).ToList());//son yazılan notları çektik
            //return View(nm.GetAllNotesQueryable().OrderByDescending(x => x.ModifiedOn).ToList());
        }

        public ActionResult ByCategory(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            CategoryManager cm = new CategoryManager();
            Category cat = cm.Find(x => x.Id == id.Value);

            if (cat == null)
            {
                return HttpNotFound();
            }


            return View("Index", cat.Notes.Where(x => x.IsDraft == false).OrderByDescending(x => x.ModifiedOn).ToList());//Index view'ini aç ve modelide yolla
        }


        public ActionResult MostLiked()
        {
            NoteManager nm = new NoteManager();

            return View("Index", nm.ListQueryable().OrderByDescending(x => x.LikeCount).ToList());//en çok beğeni alanlar 
        }


        public ActionResult About()
        {


            return View();
        }

        public ActionResult Login()
        {
            //https://bootsnipp.com/
            //https://bootsnipp.com/snippets/pjDne






            return View();
        }

        [HttpPost]
        public ActionResult Login(LoginViewModel model)
        {
            //Giriş kontrolü ve yönlendirme yapılacak
            //Session'a kullanıcı bilgi saklama



            if (ModelState.IsValid)    //model doğru gelmişse
            {
                EvernoteUserManager eum = new EvernoteUserManager();
                BusinessLayerResult<EvernoteUser> res = eum.LoginUser(model);


                //demekki hata var
                if (res.Errors.Count > 0)
                {
                    res.Errors.ForEach(x => ModelState.AddModelError("", x.Message));//ilgili hatayı metoda ekle dedik.foreach ile .bu hatayıda view tarafında Validation summary ile okuyor.

                    //business layerdan dönen hataların yönetimi
                    if (res.Errors.Find(x => x.Code == ErrorMessageCode.UserIsNotActive) != null)
                    {
                        ViewBag.SetLink = "http://Home/Activate/1313-4344345-345345";
                    }



                    return View(model);
                }

                //giriş başarılı ise 
                Session["login"] = res.Result;  //sessiona kullanıcı bilgisini at

                return RedirectToAction("Index");   //yönlendirme ..


            }




            return View(model);
        }




        public ActionResult Register()
        {



            return View();
        }

        [HttpPost]
        public ActionResult Register(RegisterViewModel model)
        {
            //Kullanıcı username kontrolü 
            //Kullanıcı eposta kontrolü..
            //Kayıt İşlemi..
            // Aktivasyon epostası gönderimi

            if (ModelState.IsValid) //model RegisterViewModel modelindeki data annotation daki kurallara uyuyorsa 
            {




                EvernoteUserManager eum = new EvernoteUserManager();
                BusinessLayerResult<EvernoteUser> res = eum.RegisterUser(model);


                //demekki hata var
                if (res.Errors.Count > 0)
                {

                    res.Errors.ForEach(x => ModelState.AddModelError("", x.Message));//ilgili hatayı metoda ekle dedik.foreach ile .bu hatayıda view tarafında Validation summary ile okuyor.

                    return View(model);
                }







                #region Yorumsatırları
                //EvernoteUser user = null;
                //try
                //{

                //    user = eum.RegisterUser(model);
                //}
                //catch (Exception ex)
                //{
                //    ModelState.AddModelError("", ex.Message);

                //}



                //if (model.UserName == "aaa")
                //{
                //    ModelState.AddModelError("", "Kullanıcı adı kullanılıyor");//kendimiz hata mesajı veriyoruz.ValidationSummaryde gözükecek

                //}



                //if (model.EMail == "aaa@aa.com")
                //{
                //    ModelState.AddModelError("", "Eposta adresi kullanılıyor");

                //}



                //foreach (var item in ModelState)
                //{
                //    if (item.Value.Errors.Count > 0)
                //    {
                //        return View(model);
                //    }
                //}

                //demekki hata var
                //if (user == null)
                //{
                //    return View(model);
                //} 
                #endregion


                //kayıt başarılı olunca yönlendir.
                OkViewModel notifyObj = new OkViewModel
                {

                    Title = @"Kayıt Başarılı",
                    RedirectingUrl = "/Home/Login",

                };
                notifyObj.Items.Add(@"Lütfen eposta adresinize gönderdiğimiz aktivasyon linkine tıklayarak hesabınızı aktive ediniz.
Hesabınızı aktive etmeden not ekleyemez ve beğenme yapamazsınız,");




                return View("Ok", notifyObj);
            }



            return View(model);
        }


        //Gmailden aktivasyon linkinden  buraya gelcez 
        public ActionResult UserActivate(Guid id)
        {
            //Kullanıcı aktivasyonu sağlanacak
            EvernoteUserManager eum = new EvernoteUserManager();
            BusinessLayerResult<EvernoteUser> res = eum.ActivateUser(id);

            if (res.Errors.Count > 0)
            {
                ErrorViewModel errorNotifyObj = new ErrorViewModel
                {
                    Title = "Geçersiz işlem",
                    Items = res.Errors


                };


                return View("Error", errorNotifyObj); //shareddaki viewi aç
            }


            OkViewModel okNotifyObj = new OkViewModel
            {
                Title = @"Hesabınız aktifleştirildi",
                RedirectingUrl = "/Home/Login",//yönlendir.
            };
            okNotifyObj.Items.Add("Hesabınız aktifleştirildi.Artık not paylaşabilir ve beğenme yapabilirsiniz.");


            //aktifleştirme başarılı ise 
            return View("Ok", okNotifyObj);
        }



        public ActionResult Logout()
        {
            Session.Clear();//sessionı sil

            return RedirectToAction("Index");
        }







        [Auth]  //filter ekledik.giriş yapmamışsa yönlendirme yapıyoruz bu classta(Filters klasöründe)(authenticationfilterlogin)
        public ActionResult ShowProfile()
        {
            //EvernoteUser currentUser = Session["login"] as EvernoteUser;

            BusinessLayer.EvernoteUserManager eum = new EvernoteUserManager();
            //BusinessLayerResult<EvernoteUser> res = eum.GetUserById(currentUser.Id);
            BusinessLayerResult<EvernoteUser> res = eum.GetUserById(CurrentSession.User.Id);

            //hata var demekki
            if (res.Errors.Count > 0)
            {

                //Kullanıcıyı bir hata ekranına yönlendirmemiz gerekiyor.
                ErrorViewModel errorNotifyObj = new ErrorViewModel
                {
                    Title = "Hata Oluştu",
                    Items = res.Errors


                };


                return View("Error", errorNotifyObj); //shareddaki viewi aç


            }


            return View(res.Result);
        }

        [Auth]  //filter ekledik.giriş yapmamışsa yönlendirme yapıyoruz bu classta(Filters klasöründe)(authenticationfilterlogin)
        public ActionResult EditProfile()
        {

            //EvernoteUser currentUser = Session["login"] as EvernoteUser;

            BusinessLayer.EvernoteUserManager eum = new EvernoteUserManager();
            BusinessLayerResult<EvernoteUser> res = eum.GetUserById(CurrentSession.User.Id);

            //hata var demekki
            if (res.Errors.Count > 0)
            {

                //Kullanıcıyı bir hata ekranına yönlendirmemiz gerekiyor.
                ErrorViewModel errorNotifyObj = new ErrorViewModel
                {
                    Title = "Hata Oluştu",
                    Items = res.Errors


                };


                return View("Error", errorNotifyObj); //shareddaki viewi aç


            }


            return View(res.Result);
        }

        [Auth]  //filter ekledik.giriş yapmamışsa yönlendirme yapıyoruz bu classta(Filters klasöründe)(authenticationfilterlogin)
        [HttpPost]
        public ActionResult EditProfile(EvernoteUser model, HttpPostedFileBase ProfileImage)//   <input type="file" name="ProfileImage" id="ProfileImage" class="form-control" /><br /> name ler aynı olmalı
        {
            //Html validation summaryde bu hata gözükmez.
            ModelState.Remove("ModifiedUsername");

            if (ModelState.IsValid)//model hatalı geldiyse Isvalid=false olur.
            {

                //resmi kaydediyoruz.

                //dosya tipi
                if (ProfileImage != null &&
                    (ProfileImage.ContentType == "image/jpeg" ||
                    ProfileImage.ContentType == "image/jpg" ||
                    ProfileImage.ContentType == "image/png"))
                {
                    string filename = "user_" + model.Id + "." + ProfileImage.ContentType.Split('/')[1];

                    ProfileImage.SaveAs(Server.MapPath("~/images/" + filename));//belirtilen yola resmi kaydediyoruz.
                    model.ProfileImageFileName = filename;
                }

                EvernoteUserManager evernoteUserManager = new EvernoteUserManager();

                BusinessLayerResult<EvernoteUser> res = evernoteUserManager.UpdateProfile(model);

                if (res.Errors.Count > 0)
                {
                    ErrorViewModel errorNotifyObj = new ErrorViewModel()
                    {
                        Items = res.Errors,
                        Title = "Profil Güncellenemedi.",
                        RedirectingUrl = "/Home/EditProfile"
                    };

                    return View("Error", errorNotifyObj);
                }

                // Profil güncellendiği için session güncellendi.

                CurrentSession.Set<EvernoteUser>("login",res.Result);
                //Session["login"] = res.Result;

                return RedirectToAction("ShowProfile");
            }

            return View(model);
        }
        [Auth]  //filter ekledik.giriş yapmamışsa yönlendirme yapıyoruz bu classta(Filters klasöründe)(authenticationfilterlogin)
        public ActionResult DeleteProfile()
        {
            EvernoteUser currentUser = Session["login"] as EvernoteUser;

            EvernoteUserManager eum = new EvernoteUserManager();
            BusinessLayerResult<EvernoteUser> res =
                    eum.RemoveUserById(currentUser.Id);

            if (res.Errors.Count > 0)
            {
                ErrorViewModel errorNotifyObj = new ErrorViewModel()
                {
                    Items = res.Errors,
                    Title = "Profil Silinemedi.",
                    RedirectingUrl = "/Home/ShowProfile" //yönlendir.
                };

                return View("Error", errorNotifyObj);
            }

            //sessionı sil.
            Session.Clear();

            return RedirectToAction("Index");
        }


        //İşlem bildirim ekranı test
        public ActionResult TestNotify()
        {

            OkViewModel model = new OkViewModel
            {
                Header = "Yönlendirme..",
                Title = "Ok Test",
                RedirectingTimeout = 3000,//yönlendirme süresi
                Items = new List<string>() { "TEst başarılı 1", "Test başarılı 2" }


            };

            return View("Ok", model);//shared daki Ok viewine git
        }

        public ActionResult AccessDenied()
        {
            return View();
        }
        public ActionResult HasError()
        {
            return View();
        }
        


    }
}

