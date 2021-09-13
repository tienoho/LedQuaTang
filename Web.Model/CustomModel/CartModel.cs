﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Web.Model.CustomModel
{
    public class CartModel: tbl_Order
    {
        public int Quantity { get; set; }
        public string ProductName { get; set; }
        public Decimal Price { get; set; }
    }
}
