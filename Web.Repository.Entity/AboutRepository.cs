﻿using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Web.Core;
using Web.Model;

namespace Web.Repository.Entity
{
    public class AboutRepository : IAboutRepository
    {
        readonly LedQuaTangEntities _entities = new LedQuaTangEntities();
       
        public void Add(About obj)
        {
            _entities.Abouts.Add(obj);
            _entities.SaveChanges();
        }

        public void Delete(int id)
        {
            var obj = Find(id);
            _entities.Abouts.Remove(obj);
            _entities.SaveChanges();
        }

        public void Edit(About model)
        {
            object[] parameters =
            {
                new SqlParameter("@ID", model.ID),
                new SqlParameter("@MetaTitle", (object)model.MetaTitle?? DBNull.Value),
                new SqlParameter("@Contents", model.Contents),
                new SqlParameter("@Tags", (object)model.Tags?? DBNull.Value)
            };
            _entities.Database.ExecuteSqlCommand("Sp_About_Update @ID,@MetaTitle,@Contents,@Tags", parameters);
        }
        public About Find(int id)
        {
            return _entities.Abouts.Find(id);
        }

        public List<About> GetAll()
        {
            var lstData = _entities.Abouts.ToList();
            return lstData;
        }
    }
}
