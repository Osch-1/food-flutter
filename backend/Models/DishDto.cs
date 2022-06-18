namespace food_ordering_server.Models
{
    public class DishDto
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public decimal Price { get; set; }
        public string Description { get; set; }
        public int Type { get; set; }
        public decimal Weight { get; set; }
        public string ImagePath { get; set; }

        public static DishDto CreateFromId(int id) => new DishDto()
        {
            Id = id,
            Name = "",
            Price = 0,
            Description = "",
            Type = 0,
            Weight = 0,
            ImagePath = "",
        };
    }
}
