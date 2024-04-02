using BrgyIS.Classes;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data;
using System.Linq;
using System.Web;

namespace BrgyIS.Models
{
    public class tbl_ref_Position
    {
        dbcontrol s = new dbcontrol();
        [Display(Name = "ID")]
        [ScaffoldColumn(false)]
        public Int32 ID { get; set; }

        [Display(Name = "Position")]
        [Required]
        public String Position { get; set; }

        [Display(Name = "Encoder")]
        [ScaffoldColumn(false)]
        public Int32 Encoder { get; set; }

        [Display(Name = "Timestamp")]
        [ScaffoldColumn(false)]
        [DisplayFormat(ApplyFormatInEditMode = true, DataFormatString = "{0:yyyy-MM-dd}")]
        [DataType(DataType.Date)]
        public DateTime? Timestamp { get; set; }

        public tbl_ref_Position()
        {
        }
        public List<tbl_ref_Position> List()
        {

            return s.Query<tbl_ref_Position>("tbl_ref_Position_Proc", p => { p.Add("@Type", "Search"); }, CommandType.StoredProcedure)
            .Select(r =>
            {

                return r;
            }).ToList();
        }

        public tbl_ref_Position Find(int ID)
        {

            return s.Query<tbl_ref_Position>("tbl_ref_Position_Proc", p => { p.Add("@Type", "Find"); p.Add("@ID", ID); }, CommandType.StoredProcedure)
            .Select(r =>
            {

                return r;
            }).SingleOrDefault();
        }

        public bool Create(tbl_ref_Position obj)
        {
            var result = false;
            s.Query("tbl_ref_Position_Proc", p =>
            {
                p.Add("@Type", "Create");
                p.Add("@Position", obj.Position);
                p.Add("@Encoder", UserSession.User.ID);

            }, CommandType.StoredProcedure).
            ForEach(r => result = (bool)r[0]);
            return result;
        }

        public bool Update(tbl_ref_Position obj)
        {
            var result = false;
            s.Query("tbl_ref_Position_Proc", p =>
            {
                p.Add("@Type", "Update");
                p.Add("@ID", obj.ID);
                p.Add("@Position", obj.Position);

            }, CommandType.StoredProcedure).
            ForEach(r => result = (bool)r[0]);
            return result;
        }
        public void Delete(tbl_ref_Position obj)
        {
            s.Query("DELETE FROM [tbl_ref_Position] WHERE ID = @ID", p =>
            {
                p.Add("@ID", obj.ID);
            });
        }
    }


}