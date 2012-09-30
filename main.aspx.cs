using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Net;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Web.Services;


namespace SLC_Classview_CSharp
{
    public partial class main : System.Web.UI.Page
    {        
        /// <summary>
        /// Ac webmethod all to get all the students for the current login user
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string GetStudents()
        {
            if (HttpContext.Current.Session["access_token"] != null)
            {
                string apiEndPoint = "https://api.sandbox.slcedu.org/api/rest/v1/students";
                return Global.Utility.GetJsonData(apiEndPoint);
            }
            return "";
        }

        
    }
}