using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using food_ordering_server.Models;

namespace food_ordering_server.Controllers
{
    [ApiController]
    [Route("menu")]
    public class MenuController : FoodOrderingController
    {
        public MenuController(HttpClient httpClient) : base(httpClient)
        {

        }

        [HttpGet]
        [Route("available-dates")]
        public async Task<IEnumerable<long>> AvailableDates()
        {
            return (await Get<IEnumerable<DateTime>>()).Select(ToUnixTimeMilliseconds);
        }

        [HttpGet]
        [Route("available-dishes")]
        public async Task<IEnumerable<DishDto>> AvailableDishes(DateTime date)
        {
            MenuDto menuDto = await Get<MenuDto>(
                new Dictionary<string, string>
                {
                    ["date"] = date.ToString("yyyy-MM-dd")
                });

            return menuDto.Dishes;
        }

        private static long ToUnixTimeMilliseconds(DateTime dateTime) =>
            new DateTimeOffset(dateTime).ToUnixTimeMilliseconds();
    }
}
