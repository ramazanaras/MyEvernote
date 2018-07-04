using System;
using System.Collections.Generic;
using System.ComponentModel;
//ekledik
using System.ComponentModel.DataAnnotations;
//bu dll'ide ekledik
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace MyEvernote.Entities
{
    [Table("Categories")] //veritabanında oluşturucağı tablo ismi
    public class Category : MyEntityBase  //miras verdik.
    {

        public Category()
        {
            Notes = new List<Note>();//null hatası vermesin
        }

        //DisplayName("Adı") görünecek label 
        [DisplayName("Adı"),Required,StringLength(50)]
        public string Title { get; set; }

        [StringLength(150)]
        public string Description { get; set; }





        //bir kategoride bir den çok notu var
        //navigation propertileri (ilişkili tabloları)
        public virtual List<Note> Notes { get; set; }



       



    }
}
