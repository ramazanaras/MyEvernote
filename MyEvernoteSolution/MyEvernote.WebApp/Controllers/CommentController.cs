using MyEvernote.BusinessLayer;
using MyEvernote.Entities;
using MyEvernote.WebApp.Filters;
using MyEvernote.WebApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace MyEvernote.WebApp.Controllers
{
    [Exc] //exception filter uyguladık.yani bu controllerdaki herhangi bir actionda hata olduğunda yapılacakları belirttik bu classta
    public class CommentController : Controller
    {

        private NoteManager noteManager = new NoteManager();
        //Index.cshtml    $("#modal_comment_body").load("/Comment/ShowNoteComments"); bu şekilde çağırdık 
        public ActionResult ShowNoteComments(int? id) //noteid
        {

            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            Note note = noteManager.Find(x => x.Id == id);
            //Note note = noteManager.ListQueryable().Include("Commnets").FirstOrDefault(x => x.Id == id);

            if (note == null)
            {
                return HttpNotFound();
            }

            return PartialView("_PartialComments", note.Comments);
        }






        CommentManager commentManager = new CommentManager();

        [Auth] //giriş yapmamışsa erişemicek //filter ekledik.giriş yapmamışsa yönlendirme yapıyoruz 
        [HttpPost]
        public ActionResult Edit(int? id, string text)  // Index.cshtml--> url: "/Comment/Edit/"+commentid,      data: {text:txt} parametreler aynı olmalı
        {

            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);//geriye hata dönder
            }

            Comment comment = commentManager.Find(x => x.Id == id);

            if (comment == null)
            {
                return HttpNotFound();//geriye hata dönder
            }


            comment.Text = text;
            if (commentManager.Update(comment) > 0)
            {//başarılı ise
                return Json(new { result = true }, JsonRequestBehavior.AllowGet);
            }

            //başarısız ise
            return Json(new { result = false }, JsonRequestBehavior.AllowGet);

            /*
             view tarafında (Index.cshtml)
             * 
             *   if (data.result) {
                            //yorumlar partial tekrar yüklenir
                        } else {
                            alert("Yorum güncellenemedi");
                        }
             * 
             * bu şekilde kontrol ediyoruz
             
             
             */
        }

        [Auth]
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);//geriye hata dönder
            }

            Comment comment = commentManager.Find(x => x.Id == id);

            if (comment == null)
            {
                return HttpNotFound();//geriye hata dönder
            }



            if (commentManager.Delete(comment) > 0)
            {//başarılı ise
                return Json(new { result = true }, JsonRequestBehavior.AllowGet);
            }

            //başarısız ise
            return Json(new { result = false }, JsonRequestBehavior.AllowGet);

            /*
             view tarafında (Index.cshtml)
             * 
             *   if (data.result) {
                            //yorumlar partial tekrar yüklenir
                        } else {
                            alert("Yorum silinemedi");
                        }
             * 
             * bu şekilde kontrol ediyoruz
             
             
             */
        }

        [Auth]
        [HttpPost]
        public ActionResult Create(Comment comment, int noteid)
        {
            //modelstate den kaldırdık bu bilgileri bizden istemez.zaten Insert anında bunları dolduruyoruz.
            //modelstate den kaldırdık.zaten Insert anında bunları dolduruyoruz.bir daha burda bizden istemesin diye yaptık
            ModelState.Remove("CreatedOn");
            ModelState.Remove("ModifiedOn");
            ModelState.Remove("ModifiedUserName");


            if (ModelState.IsValid) //model yanlış gelmişse  ModelState.IsValid=false olur.doğru gelmişse true olur
            {

                if (noteid == null)
                {
                    return new HttpStatusCodeResult(HttpStatusCode.BadRequest);//geriye hata dönder
                }

                Note note = noteManager.Find(x => x.Id == noteid);


                if (note == null)
                {
                    return HttpNotFound();//geriye hata dönder
                }





                comment.Note = note;
                comment.Owner = CurrentSession.User;




                if (commentManager.Insert(comment) > 0)
                {//başarılı ise
                    return Json(new { result = true }, JsonRequestBehavior.AllowGet);
                }



                /*
                 view tarafında (Index.cshtml)
                 * 
                 *   if (data.result) {
                                //yorumlar partial tekrar yüklenir
                            } else {
                                alert("Yorum silinemedi");
                            }
                 * 
                 * bu şekilde kontrol ediyoruz
             
             
                 */


            }

            //başarısız ise
            return Json(new { result = false }, JsonRequestBehavior.AllowGet);


        }


    }
}