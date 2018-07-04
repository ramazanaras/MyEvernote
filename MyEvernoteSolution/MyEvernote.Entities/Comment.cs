using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MyEvernote.Entities
{
    [Table("Comments")] //veritabanında oluşturucağı tablo ismi
    public class Comment : MyEntityBase
    {
        [Required, StringLength(300)]
        public string Text { get; set; }



        //navigation propertileri (ilişkili tabloları) 
        public virtual Note Note { get; set; }
        public virtual EvernoteUser Owner { get; set; }



    }
}
