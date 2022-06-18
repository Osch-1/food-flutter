using System;
using System.Collections.Generic;

namespace food_ordering_server.Models
{
    public class DishSet
    {
        public DishDto Salad { get; set; }
        public DishDto Soup { get; set; }
        public DishDto Roast { get; set; }
        public DishDto Garnish { get; set; }
        public static DishSet CreateFromList(List<DishDto> dishes)
        {
            return new DishSet()
            {
                Salad = dishes.Find((DishDto dish) => dish.Type == 0),
                Soup = dishes.Find((DishDto dish) => dish.Type == 1),
                Roast = dishes.Find((DishDto dish) => dish.Type == 3),
                Garnish = dishes.Find((DishDto dish) => dish.Type == 2),
            };
        }
    }
}
