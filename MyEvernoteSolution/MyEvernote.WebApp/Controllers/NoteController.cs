using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using MyEvernote.Entities;
using MyEvernote.BusinessLayer;
using MyEvernote.WebApp.Models;
using MyEvernote.WebApp.Filters;


namespace MyEvernote.WebApp.Controllers
{
    [Exc] //exception filter uyguladık.yani bu controllerdaki herhangi bir actionda hata olduğunda yapılacakları belirttik bu classta
    public class NoteController : Controller
    {
        private NoteManager noteManager = new NoteManager();
        private LikedManager likedManager = new LikedManager();


        [Auth]  //filter ekledik.giriş yapmamışsa yönlendirme yapıyoruz bu classta(Filters klasöründe)(authenticationfilterlogin)
        public ActionResult Index()
        {

            //Include("Category")-->>Noteu çekerkende Categorisinide çek dedik.(Navigation properti adını yazmalıyız)
            var notes = noteManager.ListQueryable().Include("Category").Include("Owner").Where(x => x.Owner.Id == CurrentSession.User.Id).OrderByDescending(x => x.ModifiedOn);
            return View(notes.ToList());
        }

        [Auth]  //filter ekledik.giriş yapmamışsa yönlendirme yapıyoruz bu classta(Filters klasöründe)(authenticationfilterlogin)
        public ActionResult MyLikedNotes()
        {
            //userın likeledığı notları aldık(çoka çok tablodan veri çektik.)
            var notes = likedManager.ListQueryable().Include("LikedUser").Include("Note").Where(x => x.LikedUser.Id == CurrentSession.User.Id).Select(x => x.Note).Include("Category").Include("Owner").OrderByDescending(x => x.ModifiedOn);



            return View("Index", notes.ToList());






        }


        [Auth]  //filter ekledik.giriş yapmamışsa yönlendirme yapıyoruz bu classta(Filters klasöründe)(authenticationfilterlogin)
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Note note = noteManager.Find(x => x.Id == id);
            if (note == null)
            {
                return HttpNotFound();
            }
            return View(note);
        }
        CategoryManager categoryManager = new CategoryManager();


        [Auth]  //filter ekledik.giriş yapmamışsa yönlendirme yapıyoruz bu classta(Filters klasöründe)(authenticationfilterlogin)
        public ActionResult Create()
        {
            //combobox için
            ViewBag.CategoryId = new SelectList(categoryManager.List(), "Id", "Title");
            return View();
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Note note)
        {

            //modelstate den kaldırdık.zaten Insert anında bunları dolduruyoruz.bir daha burda bizden istemesin diye yaptık
            ModelState.Remove("CreatedOn");
            ModelState.Remove("ModifiedOn");
            ModelState.Remove("ModifiedUserName");

            if (ModelState.IsValid)
            {
                note.Owner = CurrentSession.User;//noteun sahibi(yazan)
                noteManager.Insert(note);


                return RedirectToAction("Index");
            }

            //combobox için
            //ViewBag.CategoryId = new SelectList(categoryManager.List(), "Id", "Title", note.CategoryId);
            //cacheden değerlerleri okuduk
            ViewBag.CategoryId = new SelectList(CacheHelper.GetCategoriesFromCache(), "Id", "Title", note.CategoryId);
            return View(note);
        }

        // GET: Note/Edit/5
        [Auth]  //filter ekledik.giriş yapmamışsa yönlendirme yapıyoruz bu classta(Filters klasöründe)(authenticationfilterlogin)
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Note note = noteManager.Find(x => x.Id == id.Value);
            if (note == null)
            {
                return HttpNotFound();
            }

            //cacheden değerlerleri okuduk
            ViewBag.CategoryId = new SelectList(CacheHelper.GetCategoriesFromCache(), "Id", "Title", note.CategoryId);
            return View(note);
        }

        // POST: Note/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.

        [Auth]  //filter ekledik.giriş yapmamışsa yönlendirme yapıyoruz bu classta(Filters klasöründe)(authenticationfilterlogin)
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(Note note)
        {

            //modelstate den kaldırdık.zaten Insert anında bunları dolduruyoruz.bir daha burda bizden istemesin diye yaptık
            ModelState.Remove("CreatedOn");
            ModelState.Remove("ModifiedOn");
            ModelState.Remove("ModifiedUserName");

            if (ModelState.IsValid)
            {
                Note db_note = noteManager.Find(x => x.Id == note.Id);
                db_note.IsDraft = note.IsDraft;
                db_note.CategoryId = note.CategoryId;
                db_note.Text = note.Text;
                db_note.Title = note.Title;

                noteManager.Update(db_note);


                return RedirectToAction("Index");
            }
            ViewBag.CategoryId = new SelectList(categoryManager.List(), "Id", "Title", note.CategoryId);
            return View(note);
        }

        [Auth]  //filter ekledik.giriş yapmamışsa yönlendirme yapıyoruz bu classta(Filters klasöründe)(authenticationfilterlogin)
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Note note = noteManager.Find(x => x.Id == id.Value);
            if (note == null)
            {
                return HttpNotFound();
            }
            return View(note);
        }

        // POST: Note/Delete/5
        [Auth]  //filter ekledik.giriş yapmamışsa yönlendirme yapıyoruz bu classta(Filters klasöründe)(authenticationfilterlogin)
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Note note = noteManager.Find(x => x.Id == id);

            noteManager.Delete(note);
            return RedirectToAction("Index");
        }




        [HttpPost]
        public ActionResult GetLiked(int[] getdizi)
        {
            //List<int> likedNoteIds = likedManager.List(x => x.LikedUser.Id == CurrentSession.User.Id && ids.Contains(x.Note.Id)).Select(x => x.Note.Id).ToList();//kullanıcını likedladığı note'ların idleri 

            if (CurrentSession.User == null)
            {
                return null;
            }
            if (getdizi == null)
            {
                return null;
            }

            //çoka çok tablodan veri çekme
            List<int> likedNoteIds = likedManager.List().Where(x => x.LikedUser.Id == CurrentSession.User.Id && getdizi.Contains(x.Note.Id)).Select(x => x.Note.Id).ToList();//kullanıcını likedladığı note'ların idleri 




            return Json(new { result = likedNoteIds });//json döndürdük.
        }

        [HttpPost]
        public ActionResult SetLikeState(int noteid, bool liked)
        {
            int res = 0;

            Liked like = likedManager.Find(x => x.Note.Id == noteid && x.LikedUser.Id == CurrentSession.User.Id);
            Note note = noteManager.Find(x => x.Id == noteid);


            if (like != null && liked == false)
            {
                res = likedManager.Delete(like);
            }
            else if (like == null && liked == true)
            {

                res = likedManager.Insert(new Liked()
                {
                    LikedUser = CurrentSession.User,
                    Note = note
                });
            }


            if (res > 0)
            {
                if (liked)
                {
                    note.LikeCount++;

                }
                else
                {
                    note.LikeCount--;
                }

                res = noteManager.Update(note);

                return Json(new { hasError = false, errorMessage = string.Empty, result = note.LikeCount }, JsonRequestBehavior.AllowGet);
            }


            return Json(new { hasError = true, errorMessage = "Beğenme İşlemi Gerçekleştirilemedi!", result = note.LikeCount }, JsonRequestBehavior.AllowGet);

        }


        public ActionResult GetNoteText(int? id)
        {

            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Note note = noteManager.Find(x => x.Id == id);
            if (note == null)
            {
                return HttpNotFound();
            }
            return PartialView("_PartialNoteText", note); //partial view döner
        }






    }
}
