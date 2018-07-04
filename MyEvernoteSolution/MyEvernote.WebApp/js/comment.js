//global değişkenler
var modalCommentBodyId = "#modal_comment_body";
var noteid = -1;

$(document).ready(function () {

    //modal popup olduğunda
    $("#modal_comment").on('show.bs.modal', function (e) {//e -->hangi butona bastığımızı söylüyor.
        //console.log('test');

        var btn = $(e.relatedTarget); //tıklanan butonu yakaladık

        noteid = btn.data("noteid");//tıklanan butondaki data-id attributendaki değeri okuduk//  <button data-noteid="note.Id"


        $("#modal_comment_body").load("/Comment/ShowNoteComments/" + noteid); ///Comment controllerdaki ShowNoteComments actionını çağırıp  Partial view'i bu elementin içine bascak


    });

});

//_PartialComments.cshtml -->>    bu şekilde yazmıştık
    
function doComment(btn,e,commentid,spanid) {

    var button = $(btn);//elementi jquerye çevirdik.
    var mode = button.data("edit-mode");


    if (e == "edit_clicked")
    {
        if (!mode)
        {
            button.data("edit-mode", true);//attributea değer atadık  ////data-edit-mode="true" 
            button.removeClass("btn-warning"); //classsı sildik
            button.addClass("btn-success");

            var btnSpan = button.find("span");
            btnSpan.removeClass("glyphicon-edit");
            btnSpan.addClass("glyphicon-ok");

            $(spanid).attr("contenteditable", true);//attributea değer atadık
            $(spanid).focus();
        }
        else
        {

            button.data("edit-mode", false);//attributea değer atadık  
            button.addClass("btn-warning"); //classsı sildik
            button.removeClass("btn-success");

            var btnSpan = button.find("span");
            btnSpan.addClass("glyphicon-edit");
            btnSpan.removeClass("glyphicon-ok");

            $(spanid).attr("contenteditable", false);//attributea değer atadık


            var txt=$(spanid).text();//değeri al

            //UPDATE İŞLEMİ

            $.ajax({
                method: "POST",
                url: "/Comment/Edit/"+commentid,
                data: {text:txt}


            }).done(function (data) { //başarılı ise //actiondan gelen veri datanın içindedir.//Controllerda  return Json(new { result = true }, JsonRequestBehavior.AllowGet); bu şekilde geliyor. json veriyi alıp kontrol edicez.
    
                if (data.result) {
                    //yorumlar partial tekrar yüklenir
                    $("#modal_comment_body").load("/Comment/ShowNoteComments/" + noteid);


                } else {
                    alert("Yorum güncellenemedi");
                }



            }).fail(function () {//hatalı ise
                alert("Sunucu ile bağlantı kurulamadı");
            }) ;






        }

             


    }
    else if(e=="delete_clicked"){
        var dialog_res = confirm("Yorum Silinsin mi?");

        if (!dialog_res)
        {
            return false;
        }


        //silme yapıcaz
        $.ajax({
            method: "GET",
            url: "/Comment/Delete/" + commentid,

        }).done(function (data) {


            if (data.result)
            {
                //yorumlar partial tekrar yüklenir
                $("#modal_comment_body").load("/Comment/ShowNoteComments/" + noteid);


            } else
            {
                alert("Yorum Silinemedi");
            }



        }).fail(function () {
            alert("Sunucu ile bağlantı kurulamadı");
        });




    }
    else if (e == "new_clicked") {//yeni yorum ekleme

        var txt = $("#new_comment_text").val();//değeri al

        $.ajax({
            method: "POST",
            url: "/Comment/Create/",
            data: {"text":txt,"noteid":noteid}  //json verisi yolladık

        }).done(function (data) {


            if (data.result) {
                //yorumlar partial tekrar yüklenir
                $("#modal_comment_body").load("/Comment/ShowNoteComments/" + noteid);


            } else {
                alert("Yorum Eklenemedi");
            }



        }).fail(function () {
            alert("Sunucu ile bağlantı kurulamadı");
        });



    }


           





}




