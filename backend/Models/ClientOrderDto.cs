using System;
using System.Collections.Generic;

namespace food_ordering_server.Models
{
    public class ClientOrderDto
    {
        public int UserId { get; set; }
        public DateTime Date { get; set; }
        public List<int> DishIds { get; set; }
    }
}
