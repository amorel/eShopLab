//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace eShopLab.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Medium
    {
        public Medium()
        {
            this.Categories = new HashSet<Category>();
            this.CommandStatus = new HashSet<CommandStatu>();
            this.Products = new HashSet<Product>();
            this.Products1 = new HashSet<Product>();
        }
    
        public int MediaID { get; set; }
        public string MediaName { get; set; }
        public string MediaAlt { get; set; }
        public string MediaUrl { get; set; }
        public Nullable<int> MediaTypeID { get; set; }
    
        public virtual ICollection<Category> Categories { get; set; }
        public virtual ICollection<CommandStatu> CommandStatus { get; set; }
        public virtual MediaType MediaType { get; set; }
        public virtual ICollection<Product> Products { get; set; }
        public virtual ICollection<Product> Products1 { get; set; }
    }
}
