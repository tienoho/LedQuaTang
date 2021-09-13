﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Web.Model;

namespace Web.Repository
{
    public interface ISlideIRepository
    {
        List<Slide> GetAll();
        Slide Find(int id);
        void Add(Slide obj);
        void Edit(Slide obj);
        void Delete(int id);
    }
}
