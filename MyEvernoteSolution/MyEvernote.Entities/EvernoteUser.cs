using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;///ekledik
using System.ComponentModel.DataAnnotations.Schema;///ekledik
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MyEvernote.Entities
{

    [Table("EvernoteUsers")] //veritabanında oluşturucağı tablo ismi
    public class EvernoteUser : MyEntityBase
    {
        //ScaffoldColumn(false) scaffoldingde kullanılmaz demek
        [StringLength(25,ErrorMessage="{0} alanı max {1} karakter olmalıdır"), DisplayName("İSim")]//DisplayName("") hata mesajlarında ve labellarda gözükecek değer.
        public string Name { get; set; }

        [StringLength(25), DisplayName("Soyad")]
        public string Surname { get; set; }

        [ StringLength(25), DisplayName("Kullanıcı Adı"), Required(ErrorMessage = "{0} alanı gereklidir.")]//Hata mesajında Kullanıcı Adı alanı gereklidir. diye çıkar.
        public string UserName { get; set; }

        [Required, StringLength(70)]
        public string Email { get; set; }

        [Required, StringLength(25)]
        public string Password { get; set; }

        [DisplayName("Is Active")]
        public bool IsActive { get; set; }

          [DisplayName("Is Admin")]
        public bool IsAdmin { get; set; }
        [Required, ScaffoldColumn(false)]
        public Guid ActivateGuid { get; set; }

        [StringLength(70), ScaffoldColumn(false)]  //images/user_12.png
        public string ProfileImageFileName { get; set; }

        //navigation propertileri (ilişkili tabloları)
        public virtual List<Note> Notes { get; set; }
        public virtual List<Comment> Comments { get; set; }

        //çoka çoktaki ilişki
        public virtual List<Liked> Likes { get; set; }


        public EvernoteUser()
        {
            Notes = new List<Note>();
            Comments = new List<Comment>();
            Likes = new List<Liked>();
        }

    }
}
