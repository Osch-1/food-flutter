using System;
using System.Collections.Generic;

namespace food_ordering_server.Models
{
    public class ServerOrderDto
    {
        public int UserId { get; set; }
        public DateTime Date { get; set; }
        public List<ServerOrderItemDto> Items { get; set; }
    }

    public class ServerOrderItemDto
    {
        public List<DishDto> Dishes { get; set; }
    }
}
