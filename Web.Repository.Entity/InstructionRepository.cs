using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Web.Core;
using Web.Model;

namespace Web.Repository.Entity
{
    public class InstructionRepository : IInstructionRepository
    {
        readonly LedQuaTangEntities _entities = new LedQuaTangEntities();
       
        public bool Add(Model.Instruction obj)
        {
            try
            {
                _entities.Instructions.Add(obj);
                _entities.SaveChanges();
                return true;
            }catch(Exception ex)
            {
                return false;
            }
           
        }

        public bool Delete(int id)
        {
            try
            {
                var obj = Find(id);
                _entities.Instructions.Remove(obj);
                _entities.SaveChanges();
                return true;
            }catch(Exception ex)
            {
                return false;
            }
           
        }

        public bool Edit(Model.Instruction obj)
        {
            try
            {
                _entities.Entry(obj).State = EntityState.Modified;
                _entities.SaveChanges();
                return true;
            }catch(Exception ex)
            {
                return false;
            }
          
        }

        public Model.Instruction Find(int id)
        {
            return _entities.Instructions.Find(id);
        }

        public List<Instruction> GetAll()
        {
            var lstData = _entities.Instructions.ToList();
            return lstData;
        }
    }
}
