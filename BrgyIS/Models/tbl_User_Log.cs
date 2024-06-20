using BrgyIS.Classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BrgyIS.Models {
    public class tbl_User_Log {
        dbcontrol s = new dbcontrol();

        public int ID { get; set; }
        public int User { get; set; }
        public string UserName { get; set; }
        public DateTime Timestamp { get; set; }
        public List<tbl_User_Log> List() {
            return s.Query<tbl_User_Log>("SELECT * FROM vw_User_Log ORDER BY ID DESC");
        }
    }
}