using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SLC_Classview_CSharp.Student
{
    public class Student
    {
        public string sex { get; set; }
        public List<string> studentCharacteristics { get; set; }
        public bool hispanicLatinoEthnicity { get; set; }
        public List<int> cohortYears { get; set; }
        public List<string> section504Disabilities { get; set; }
        public string entityType { get; set; }
        public List<string> race { get; set; }

    }
}