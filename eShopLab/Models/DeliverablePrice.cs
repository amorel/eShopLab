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
    
    public partial class DeliverablePrice
    {
        public int DeliverablePriceID { get; set; }
        public string DeliverablePriceName { get; set; }
        public byte DeliverablePriceTimeEstimation { get; set; }
        public decimal DeliverablePriceValue { get; set; }
        public int DeliverablePriceCountryID { get; set; }
    
        public virtual DeliverableCountry DeliverableCountry { get; set; }
    }
}
