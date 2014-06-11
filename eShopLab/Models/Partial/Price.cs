using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace eShopLab.Models
{
    public partial class Price : IComparable
    {
        public int CompareTo(object obj)
        {
            Price TheOther = obj as Price;
            if (TheOther == null){
                return -999;
            }

            if (this.PriceValue > TheOther.PriceValue)
            {
                return 1;
            }
            else if (TheOther.PriceValue > this.PriceValue)
            {
                return -1;
            }

            return 0;
        }
    }
}