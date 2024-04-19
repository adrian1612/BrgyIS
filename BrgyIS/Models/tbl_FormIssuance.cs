using BrgyIS.Classes;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data;
using System.Linq;
using System.Security.Permissions;
using System.Web;

namespace BrgyIS.Models
{
    public class tbl_FormIssuance
    {
        dbcontrol s = new dbcontrol();
        [Display(Name = "ID")]
        [ScaffoldColumn(false)]
        public Int32 ID { get; set; }

        [Display(Name = "Person")]
        public Int32 Person { get; set; }

        [Display(Name = "Fullname")]
        public string Fullname { get; set; }

        [Display(Name = "Form")]
        public String Form { get; set; }

        [Display(Name = "Encoder")]
        [ScaffoldColumn(false)]
        public Int32 Encoder { get; set; }

        [Display(Name = "Timestamp")]
        [ScaffoldColumn(false)]
        [DisplayFormat(ApplyFormatInEditMode = true, DataFormatString = "{0:yyyy-MM-dd}")]
        [DataType(DataType.Date)]
        public DateTime? Timestamp { get; set; }

        public tbl_FormIssuance()
        {
        }
        public List<tbl_FormIssuance> List()
        {

            return s.Query<tbl_FormIssuance>("SELECT * FROM [vw_FormIssuance]")
            .Select(r =>
            {

                return r;
            }).ToList();
        }

        public List<tbl_FormIssuance> List(int Person)
        {

            return s.Query<tbl_FormIssuance>("SELECT * FROM [vw_FormIssuance] WHERE Person = @Person ORDER BY ID DESC", p => p.Add("@Person", Person))
            .Select(r =>
            {

                return r;
            }).ToList();
        }

        public tbl_FormIssuance Find(int ID)
        {

            return s.Query<tbl_FormIssuance>("SELECT * FROM vw_FormIssuance where ID = @ID", p => p.Add("@ID", ID))
            .Select(r =>
            {

                return r;
            }).SingleOrDefault();
        }

        public int Create(tbl_FormIssuance obj)
        {
            var ID = s.Insert("[tbl_FormIssuance]", p =>
            {
                p.Add("Person", obj.Person);
                p.Add("Form", obj.Form);
                p.Add("Encoder", UserSession.User.ID);
            });
            return ID;
        }

        public void Update(tbl_FormIssuance obj)
        {
            s.Update("[tbl_FormIssuance]", obj.ID, p =>
            {
                p.Add("Person", obj.Person);
                p.Add("Form", obj.Form);

            });
        }
        public void Delete(tbl_FormIssuance obj)
        {
            s.Query("DELETE FROM [tbl_FormIssuance] WHERE ID = @ID", p =>
            {
                p.Add("@ID", obj.ID);
            });
        }
    }


}