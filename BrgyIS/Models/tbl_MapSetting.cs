using BrgyIS.Classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BrgyIS.Models
{
    public class tbl_MapSetting
    {
        dbcontrol s = new dbcontrol();
        public decimal? Latitude { get; set; }
        public decimal? Longitude { get; set; }

        public tbl_MapSetting()
        {

        }

        public tbl_MapSetting Get()
        {
            return s.Query<tbl_MapSetting>("tbl_MapSetting_Proc", p => p.Add("@Type", "Get"), System.Data.CommandType.StoredProcedure).SingleOrDefault();
        }

        public void Update(tbl_MapSetting obj)
        {
            s.Query("tbl_MapSetting_Proc", p =>
            {
                p.Add("@Type", "Update");
                p.Add("@Latitude", obj.Latitude);
                p.Add("@Longitude", obj.Longitude);
            }, System.Data.CommandType.StoredProcedure);
        }
    }
}