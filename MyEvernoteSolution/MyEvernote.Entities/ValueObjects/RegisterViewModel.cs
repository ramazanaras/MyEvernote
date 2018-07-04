using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;


//Dto nesneleri gibidir.

namespace MyEvernote.Entities.ValueObjects
{
    public class RegisterViewModel
    {

        [DisplayName("Kullanıcı adı"), Required(ErrorMessage = "{0} Alanı boş geçilemez."), StringLength(25, ErrorMessage = "{0} max {1} karakter olmalı")] //data annotation ile validations 
        public string UserName { get; set; }
        [DisplayName("Eposta"), Required(ErrorMessage = "{0} Alanı boş geçilemez."), StringLength(25, ErrorMessage = "{0} max {1} karakter olmalı"),EmailAddress(ErrorMessage="Lütfen {0} alanı için geçerli bir eposta adresi giriniz.")]
        public string EMail { get; set; }

        [DisplayName("Şifre"), Required(ErrorMessage = "{0} Alanı boş geçilemez."), StringLength(25, ErrorMessage = "{0} max {1} karakter olmalı")]
        public string Password { get; set; }

        [DisplayName("Şifre Tekrar"), Required(ErrorMessage = "{0} Alanı boş geçilemez."), StringLength(25, ErrorMessage = "{0} max {1} karakter olmalı"),Compare("Password",ErrorMessage="{0} ile {1} uyuşmuyor")]
        public string RePassword { get; set; }

    }
}