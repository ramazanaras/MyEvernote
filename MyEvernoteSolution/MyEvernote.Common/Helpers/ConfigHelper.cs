using System;
using System.Collections.Generic;
using System.Configuration;//dll'ide ekledik
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MyEvernote.Common.Helpers
{
    public class ConfigHelper
    {
        //ne tip verirsek o tipi döndürür.appconfigde istersek int tipinde string istersek string tipinde değeri döndürür.
        public static T Get<T>(string key)
        {
            return (T)Convert.ChangeType(ConfigurationManager.AppSettings[key], typeof(T));//eğer T ye int vermişsek appconigden string olarak değeri alcak.T ye int tipi vermişsek appconfigden int tipinde değeri alcak.
        }
    }
}


/*
 webconfige aşağıdakini ekledik
 *     <!--ekledik-->
    <add key="MailHost" value="smtp.gmail.com"/>
    <add key="MailPort" value="587"/>
    <add key="MailUser" value="aaa@gmail.com"/>
    <add key="MailPass" value="123456"/>
 
 */