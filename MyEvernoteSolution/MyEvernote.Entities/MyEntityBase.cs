using System;
using System.Collections.Generic;

using System.Linq;
using System.Text;
using System.Threading.Tasks;



//ekledik
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;


namespace MyEvernote.Entities
{
    public class MyEntityBase
    {
        [Key, DatabaseGenerated(DatabaseGeneratedOption.Identity)]//primary key olduğunu belirttik
        public int Id { get; set; }

        [Required]//not null yaptık(zorunlu)
        public DateTime CreatedOn { get; set; }

        [Required]//not null yaptık
        public DateTime ModifiedOn { get; set; }

        [Required,StringLength(30)]//not null yaptık//30 karakter olsun.
        public string ModifiedUserName { get; set; }


    }
}
