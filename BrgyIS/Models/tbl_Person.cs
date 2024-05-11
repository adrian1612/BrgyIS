using BrgyIS.Classes;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BrgyIS.Models
{
    public class tbl_Person
    {
        dbcontrol s = new dbcontrol();
        [Display(Name = "ID")]
        public Int32 ID { get; set; }

        [Display(Name = "First name")]
        [Required]
        public String fname { get; set; }

        [Display(Name = "Middle name")]
        public String mn { get; set; }

        [Display(Name = "Last name")]
        [Required]
        public String lname { get; set; }

        public string Suffix { get; set; }

        public string Fullname { get; set; }

        [Display(Name = "Family Head")]
        public int? FamilyHead { get; set; }

        [Display(Name = "Family Head")]
        public string FamilyHeadName { get; set; }

        [Display(Name = "Date of Birth")]
        [Required]
        [DisplayFormat(ApplyFormatInEditMode = true, DataFormatString = "{0:yyyy-MM-dd}")]
        [DataType(DataType.Date)]
        public DateTime? bday { get; set; }

        public int Age { get; set; }

        public bool isSenior { get; set; }

        [Display(Name = "Gender")]
        [Required]
        public String gender { get; set; }

        [Display(Name = "Civil Status")]
        public String CivilStatus { get; set; }

        [Display(Name = "Shelter Type")]
        public String ShelterType { get; set; }

        [Display(Name = "Occupation")]
        public String Occupation { get; set; }

        [Display(Name = "Father")]
        public int? Father { get; set; }

        [Display(Name = "Father")]
        public string FatherName { get; set; }

        [Display(Name = "Mother")]
        public int? Mother { get; set; }

        [Display(Name = "Mother")]
        public string MotherName { get; set; }

        [Display(Name = "Guardian")]
        public int? Guardian { get; set; }

        [Display(Name = "Guardian")]
        public string GuardianName { get; set; }

        [Display(Name = "Partner")]
        public int? Partner { get; set; }

        [Display(Name = "Partner")]
        public string PartnerName { get; set; }

        [Display(Name = "PWD")]
        [DataType("checkbox")]
        public Boolean isPWD { get; set; }

        [Display(Name = "Relationship")]
        public String RelationshipToHead { get; set; }

        [Display(Name = "St. No")]
        public String StNo { get; set; }

        [Display(Name = "Address")]
        public String Address { get; set; }

        [Display(Name = "House Hold#")]
        public string HouseHoldNo { get; set; }

        [Display(Name = "Remarks")]
        public String Remarks { get; set; }

        [Display(Name = "Encoder")]
        public Int32 Encoder { get; set; }

        [Display(Name = "Timestamp")]
        [DisplayFormat(ApplyFormatInEditMode = true, DataFormatString = "{0:yyyy-MM-dd}")]
        [DataType(DataType.Date)]
        public DateTime? Timestamp { get; set; }

        public tbl_Person()
        {
        }
        public List<tbl_Person> List()
        {

            return s.Query<tbl_Person>("tbl_Person_Proc", p => { p.Add("@Type", "Search"); }, CommandType.StoredProcedure)
            .Select(r =>
            {

                return r;
            }).ToList();
        }

        public List<tbl_Person> Household(int ID)
        {

            return s.Query<tbl_Person>("tbl_Person_Proc", p => { p.Add("@Type", "Household"); p.Add("@ID", ID); }, CommandType.StoredProcedure)
            .Select(r =>
            {

                return r;
            }).ToList();
        }

        public List<tbl_Person> List(int ID)
        {

            return s.Query<tbl_Person>("tbl_Person_Proc", p => { p.Add("@Type", "Find"); p.Add("@ID", ID); }, CommandType.StoredProcedure)
            .Select(r =>
            {

                return r;
            }).ToList();
        }

        public SelectList ListPerson()
        {
            return new SelectList(List(), "ID", "Fullname");
        }

        public SelectList ListPerson(int? PersonID)
        {
            return new SelectList(List().Where(f => f.ID != PersonID), "ID", "Fullname");
        }

        public tbl_Person Find(int ID)
        {

            return s.Query<tbl_Person>("tbl_Person_Proc", p => { p.Add("@Type", "Find"); p.Add("@ID", ID); }, CommandType.StoredProcedure)
            .Select(r =>
            {

                return r;
            }).SingleOrDefault();
        }

        public void Create(tbl_Person obj)
        {
            s.Query("tbl_Person_Proc", p =>
            {
                p.Add("@Type", "Create");
                p.Add("@fname", obj.fname);
                p.Add("@mn", obj.mn);
                p.Add("@lname", obj.lname);
                p.Add("@Suffix", obj.Suffix);
                p.Add("@FamilyHead", obj.FamilyHead);
                p.Add("@bday", obj.bday);
                p.Add("@gender", obj.gender);
                p.Add("@CivilStatus", obj.CivilStatus);
                p.Add("@ShelterType", obj.ShelterType);
                p.Add("@Occupation", obj.Occupation);
                p.Add("@Father", obj.Father);
                p.Add("@Mother", obj.Mother);
                p.Add("@Guardian", obj.Guardian);
                p.Add("@Partner", obj.Partner);
                p.Add("@isPWD", obj.isPWD);
                p.Add("@RelationshipToHead", obj.RelationshipToHead);
                p.Add("@StNo", obj.StNo);
                p.Add("@Address", obj.Address);
                p.Add("@HouseHoldNo", obj.HouseHoldNo);
                p.Add("@Remarks", obj.Remarks);
                p.Add("@Encoder", UserSession.User.ID);

            }, CommandType.StoredProcedure);
        }

        public void Update(tbl_Person obj)
        {
            s.Query("tbl_Person_Proc", p =>
            {
                p.Add("@Type", "Update");
                p.Add("@ID", obj.ID);
                p.Add("@fname", obj.fname);
                p.Add("@mn", obj.mn);
                p.Add("@lname", obj.lname);
                p.Add("@Suffix", obj.Suffix);
                p.Add("@FamilyHead", obj.FamilyHead);
                p.Add("@bday", obj.bday);
                p.Add("@gender", obj.gender);
                p.Add("@CivilStatus", obj.CivilStatus);
                p.Add("@ShelterType", obj.ShelterType);
                p.Add("@Occupation", obj.Occupation);
                p.Add("@Father", obj.Father);
                p.Add("@Mother", obj.Mother);
                p.Add("@Guardian", obj.Guardian);
                p.Add("@Partner", obj.Partner);
                p.Add("@isPWD", obj.isPWD);
                p.Add("@RelationshipToHead", obj.RelationshipToHead);
                p.Add("@StNo", obj.StNo);
                p.Add("@Address", obj.Address);
                p.Add("@HouseHoldNo", obj.HouseHoldNo);
                p.Add("@Remarks", obj.Remarks);

            }, CommandType.StoredProcedure);
        }
        public void Delete(tbl_Person obj)
        {
            s.Query("DELETE FROM [tbl_Person] WHERE ID = @ID", p =>
            {
                p.Add("@ID", obj.ID);
            });
        }
    }

    public enum FormType
    {
        BrgyClearance,
        Residency,
        BrgyClearanceLateBirthFiling,
        Guardianship,
        Indigency,
        SoloParents,
    }
}