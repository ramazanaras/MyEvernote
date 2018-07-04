using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MyEvernote.Entities
{
    //çoka çok yapısındaki ara tablodur.

    [Table("Likes")] //veritabanında oluşturucağı tablo ismi
    public class Liked
    {
        [Key,DatabaseGenerated(DatabaseGeneratedOption.Identity)]//primary key
        public int Id { get; set; }

        //navigation propertileri (ilişkili tabloları)
        public virtual Note Note { get; set; }
        public virtual EvernoteUser  LikedUser { get; set; }
    }
}


//bir note u birden fazla user like'layabilir.Bir user birden fazla note likelayabilir.(Çoka çok)