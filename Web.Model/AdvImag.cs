//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Web.Model
{
    using System;
    using System.Collections.Generic;
    
    public partial class AdvImag
    {
        public int ID { get; set; }
        public string Title { get; set; }
        public string Image { get; set; }
        public string Link { get; set; }
        public int Position { get; set; }
        public Nullable<int> Type { get; set; }
        public Nullable<bool> TagetBlank { get; set; }
        public Nullable<int> DisplayOrder { get; set; }
        public bool Status { get; set; }
        public System.DateTime CreatedDate { get; set; }
    }
}
