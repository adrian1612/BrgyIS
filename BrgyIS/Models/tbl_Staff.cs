using BrgyIS.Classes;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data;
using System.Linq;
using System.Web;

namespace BrgyIS.Models
{
    public class tbl_Staff
    {
        dbcontrol s = new dbcontrol();
        [Display(Name = "ID")]
        [ScaffoldColumn(false)]
        public Int32 ID { get; set; }

        [Display(Name = "Name")]
        public String Name { get; set; }

        [Display(Name = "Position")]
        public Int32 Position { get; set; }

        [Display(Name = "Position")]
        public string PositionName { get; set; }

        [Display(Name = "Instated")]
        [DisplayFormat(ApplyFormatInEditMode = true, DataFormatString = "{0:yyyy-MM-dd}")]
        [DataType(DataType.Date)]
        public DateTime? Instated { get; set; }

        [Display(Name = "Active")]
        public Boolean? Active { get; set; }

        [Display(Name = "Encoder")]
        [ScaffoldColumn(false)]
        public Int32 Encoder { get; set; }

        [Display(Name = "Timestamp")]
        [ScaffoldColumn(false)]
        [DisplayFormat(ApplyFormatInEditMode = true, DataFormatString = "{0:yyyy-MM-dd}")]
        [DataType(DataType.Date)]
        public DateTime? Timestamp { get; set; }

        public tbl_Staff()
        {
        }
        public List<tbl_Staff> List()
        {

            return s.Query<tbl_Staff>("tbl_Staff_Proc", p => { p.Add("@Type", "Search"); }, CommandType.StoredProcedure)
            .Select(r =>
            {

                return r;
            }).ToList();
        }

        public tbl_Staff Find(int ID)
        {

            return s.Query<tbl_Staff>("tbl_Staff_Proc", p => { p.Add("@Type", "Find"); p.Add("@ID", ID); }, CommandType.StoredProcedure)
            .Select(r =>
            {

                return r;
            }).SingleOrDefault();
        }

        public void Create(tbl_Staff obj)
        {
            s.Query("tbl_Staff_Proc", p =>
            {
                p.Add("@Type", "Create");
                p.Add("@Name", obj.Name);
                p.Add("@Position", obj.Position);
                p.Add("@Instated", obj.Instated);
                p.Add("@Encoder", UserSession.User.ID);

            }, CommandType.StoredProcedure);
        }

        public void Update(tbl_Staff obj)
        {
            s.Query("tbl_Staff_Proc", p =>
            {
                p.Add("@Type", "Update");
                p.Add("@ID", obj.ID);
                p.Add("@Name", obj.Name);
                p.Add("@Position", obj.Position);
                p.Add("@Instated", obj.Instated);
                p.Add("@Active", obj.Active);

            }, CommandType.StoredProcedure);
        }
        public void Delete(tbl_Staff obj)
        {
            s.Query("DELETE FROM [tbl_Staff] WHERE ID = @ID", p =>
            {
                p.Add("@ID", obj.ID);
            });
        }
    }


}