using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Work_test2
{
    public class Table
    {
        public Table(string name, string salary)
        {
            Name = name;
            Salary = Int32.Parse(salary);
        }

        public string Name { get; set; }
        public int Salary { get; set; }
    }
}
