using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;

namespace SLC_Classview_CSharp
{
    public partial class StudentProfile : System.Web.UI.Page
    {
        /// <summary>
        /// Get all related data for a student
        /// </summary>
        /// <param name="studentId">the unique indentifier of the student</param>
        /// <returns></returns>
        [WebMethod]
        public static string GetSingleStudentData(string studentId)
        {
            if (HttpContext.Current.Session["access_token"] != null)
            {
                string apiEndPoint = string.Format("{0}{1}", Global.Constants.API_URI, Global.Constants.Student.STUDENT.Replace(Global.Constants.Student.STUDENT_ID, studentId));
                return Global.Utility.GetJsonData(apiEndPoint);
            }
            return "";
        }

        /// <summary>
        /// Get all the schools that a student have attended
        /// </summary>
        /// <param name="studentId">the unique indentifier of the student</param>
        /// <returns></returns>
        [WebMethod]
        public static string GetStudentSchoolsData(string studentId)
        {
            if (HttpContext.Current.Session["access_token"] != null)
            {
                string apiEndPoint = string.Format("{0}{1}", Global.Constants.API_URI, Global.Constants.Student.SCHOOLS.Replace(Global.Constants.Student.STUDENT_ID, studentId));
                return Global.Utility.GetJsonData(apiEndPoint);
            }
            return "";
        }

        /// <summary>
        /// Get the student parents
        /// </summary>
        /// <param name="studentId">the unique indentifier of the student</param>
        /// <returns></returns>
        [WebMethod]
        public static string GetStudentParents(string studentId)
        {
            if (HttpContext.Current.Session["access_token"] != null)
            {
                string apiEndPoint = string.Format("{0}{1}", Global.Constants.API_URI, Global.Constants.Student.PARENTS.Replace(Global.Constants.Student.STUDENT_ID, studentId));
                return Global.Utility.GetJsonData(apiEndPoint);
            }
            return "";
        }
    }
}