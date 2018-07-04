
using MyEvernote.BusinessLayer.Abstract;
using MyEvernote.BusinessLayer.Results;
using MyEvernote.Common.Helpers;
using MyEvernote.DataAccessLayer.EntityFramework;
using MyEvernote.Entities;
using MyEvernote.Entities.Messages;
using MyEvernote.Entities.ValueObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MyEvernote.BusinessLayer
{
    public class EvernoteUserManager : ManagerBase<EvernoteUser>
    {



        public BusinessLayerResult<EvernoteUser> RegisterUser(RegisterViewModel data)
        {
            //Kullanıcı username kontrolü 
            //Kullanıcı eposta kontrolü..
            //Kayıt İşlemi..
            // Aktivasyon epostası gönderimi


            EvernoteUser user = Find(x => x.UserName == data.UserName || x.Email == data.EMail);
            BusinessLayerResult<EvernoteUser> layerResult = new BusinessLayerResult<EvernoteUser>();

            //böyle bir kullanıcı varsa
            if (user != null)
            {
                if (user.UserName == data.UserName)
                {
                    layerResult.AddError(ErrorMessageCode.UserNameAlreadyExists, "Kullanıcı adı kayıtlı");
                }

                if (user.Email == data.EMail)
                {
                    layerResult.AddError(ErrorMessageCode.EmailAlreadyExists, "Eposta adresi kayıtlı");
                }


            }
            else
            {//kayıt işlemi
                int dbResult = base.Insert(new EvernoteUser()
                   {
                       UserName = data.UserName,
                       Email = data.EMail,
                       Password = data.Password,
                       IsActive = false,
                       IsAdmin = false,
                       ActivateGuid = Guid.NewGuid(),
                       ProfileImageFileName = "user_boy.png"

                   });

                if (dbResult > 0)
                {
                    layerResult.Result = Find(x => x.Email == data.EMail && x.UserName == data.UserName);

                    //Aktivasyon maili Atma


                    string siteUri = ConfigHelper.Get<string>("SiteRootUri");
                    string activateUri = siteUri + "/Home/UserActivate/" + layerResult.Result.ActivateGuid;//aktivasyon linki 
                    string body = "Merhaba " + layerResult.Result.Name + " <br/><br/>Hesabınızı aktifleştirmek için <a href='" + activateUri + "' target='_blank'>tıklayınız.</a>";
                    MailHelper.SendMail(body, layerResult.Result.Email, "My Evernote Hesap Aktifleştirme");






                }
            }


            return layerResult;

        }

        public BusinessLayerResult<EvernoteUser> LoginUser(LoginViewModel data)
        {
            //Giriş kontrolü 
            //Hesap aktive edilmiş mi
            BusinessLayerResult<EvernoteUser> res = new BusinessLayerResult<EvernoteUser>();
            res.Result = Find(x => x.UserName == data.UserName && x.Password == data.Password);




            //böyle bir kullanıcı varsa
            if (res.Result != null)
            {
                if (!res.Result.IsActive)//aktif mi
                {
                    res.AddError(ErrorMessageCode.UserIsNotActive, "Kullanıcı aktifleştirilmemiştir.");
                    res.AddError(ErrorMessageCode.CheckYourEmail, "Lütfen eposta adresinizi kontrol ediniz.");

                }
            }
            else
            {
                res.AddError(ErrorMessageCode.UsernameOrPassWrong, "Kullanıcı adı yada şifre uyuşmuyor..");
            }


            return res;


        }



        public BusinessLayerResult<EvernoteUser> ActivateUser(Guid activateId)
        {
            BusinessLayerResult<EvernoteUser> res = new BusinessLayerResult<EvernoteUser>();
            res.Result = Find(x => x.ActivateGuid == activateId);


            if (res.Result != null)
            {
                if (res.Result.IsActive)
                {
                    res.AddError(ErrorMessageCode.UserAllReadyActive, "Kullanıcı zaten aktif edilmiştir.");

                    return res;
                }


                //aktifleştirme yapıyoruz

                res.Result.IsActive = true;

                Update(res.Result);

            }
            else
            {
                res.AddError(ErrorMessageCode.ActivateIdDoesNotExists, "Aktifleştirilecek kullanıcı bulunamadı");
            }

            return res;




        }


        public BusinessLayerResult<EvernoteUser> GetUserById(int id)
        {
            BusinessLayerResult<EvernoteUser> res = new BusinessLayerResult<EvernoteUser>();

            res.Result = Find(x => x.Id == id);


            if (res.Result == null)
            {
                res.AddError(ErrorMessageCode.UserNotFound, "Kullanıcı bulunamadı");
            }



            return res;

        }

        public BusinessLayerResult<EvernoteUser> UpdateProfile(EvernoteUser data)
        {
            EvernoteUser db_user = Find(x => x.UserName == data.UserName || x.Email == data.Email);
            BusinessLayerResult<EvernoteUser> res = new BusinessLayerResult<EvernoteUser>();

            if (db_user != null && db_user.Id != data.Id)
            {
                if (db_user.UserName == data.UserName)
                {
                    res.AddError(ErrorMessageCode.UsernameAlreadyExists, "Kullanıcı adı kayıtlı.");
                }

                if (db_user.Email == data.Email)
                {
                    res.AddError(ErrorMessageCode.EmailAlreadyExists, "E-posta adresi kayıtlı.");
                }

                return res;
            }

            res.Result = Find(x => x.Id == data.Id);
            res.Result.Email = data.Email;
            res.Result.Name = data.Name;
            res.Result.Surname = data.Surname;
            res.Result.Password = data.Password;
            res.Result.UserName = data.UserName;

            if (string.IsNullOrEmpty(data.ProfileImageFileName) == false)
            {
                res.Result.ProfileImageFileName = data.ProfileImageFileName;
            }

            if (base.Update(res.Result) == 0)
            {
                res.AddError(ErrorMessageCode.ProfileCouldNotUpdated, "Profil güncellenemedi.");
            }

            return res;
        }

        public BusinessLayerResult<EvernoteUser> RemoveUserById(int id)
        {

            BusinessLayerResult<EvernoteUser> res = new BusinessLayerResult<EvernoteUser>();
            EvernoteUser user = Find(x => x.Id == id);

            if (user != null)
            {
                if (Delete(user) == 0)
                {
                    res.AddError(ErrorMessageCode.UserCouldNotRemove, "Kullanıcı silinemedi.");
                    return res;
                }
            }
            else
            {
                res.AddError(ErrorMessageCode.UserCouldNotFind, "Kullanıcı bulunamadı.");
            }

            return res;






        }

        //Metot hiding
        //new anahtar sözcüğü yazarak üst casstaki metodu değil bu metodu kullan diyoruz(override' a benziyor ama burdaki fark geriye dönüş tipini değiştirebiliyoruz. )
        public new BusinessLayerResult<EvernoteUser> Insert(EvernoteUser data)
        {


            //Kullanıcı username kontrolü 
            //Kullanıcı eposta kontrolü..
            //Kayıt İşlemi..
            // Aktivasyon epostası gönderimi


            EvernoteUser user = Find(x => x.UserName == data.UserName || x.Email == data.Email);
            BusinessLayerResult<EvernoteUser> layerResult = new BusinessLayerResult<EvernoteUser>();
            layerResult.Result = data;
            //böyle bir kullanıcı varsa
            if (user != null)
            {
                if (user.UserName == data.UserName)
                {
                    layerResult.AddError(ErrorMessageCode.UserNameAlreadyExists, "Kullanıcı adı kayıtlı");//hatalara ekle
                }

                if (user.Email == data.Email)
                {
                    layerResult.AddError(ErrorMessageCode.EmailAlreadyExists, "Eposta adresi kayıtlı");
                }


            }
            else
            {//kayıt işlemi
                layerResult.Result.ProfileImageFileName = "user_boy.png";
                layerResult.Result.ActivateGuid = Guid.NewGuid();



                if (base.Insert(layerResult.Result) == 0)
                {
                    layerResult.AddError(ErrorMessageCode.UserCouldNotInserted, "Kullanıcı Eklenemedi");
                }

            }


            return layerResult;







        }

        //Metot hiding
        public new BusinessLayerResult<EvernoteUser> Update(EvernoteUser data)
        {
            EvernoteUser db_user = Find(x => x.UserName == data.UserName || x.Email == data.Email);
            BusinessLayerResult<EvernoteUser> res = new BusinessLayerResult<EvernoteUser>();
            res.Result = data;

            if (db_user != null && db_user.Id != data.Id)
            {
                if (db_user.UserName == data.UserName)
                {
                    res.AddError(ErrorMessageCode.UsernameAlreadyExists, "Kullanıcı adı kayıtlı.");
                }

                if (db_user.Email == data.Email)
                {
                    res.AddError(ErrorMessageCode.EmailAlreadyExists, "E-posta adresi kayıtlı.");
                }

                return res;
            }

            res.Result = Find(x => x.Id == data.Id);
            res.Result.Email = data.Email;
            res.Result.Name = data.Name;
            res.Result.Surname = data.Surname;
            res.Result.Password = data.Password;
            res.Result.UserName = data.UserName;
            res.Result.IsActive = data.IsActive;
            res.Result.IsAdmin = data.IsAdmin;


            if (base.Update(res.Result) == 0)
            {
                res.AddError(ErrorMessageCode.UserCouldNotUpdated, "Kullanıcı güncellenemedi.");
            }

            return res;
        }

    }
}
