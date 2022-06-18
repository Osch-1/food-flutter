using System.Net.Http;
using Microsoft.AspNetCore.Mvc;
using food_ordering_server.Models;
using System.Threading.Tasks;
using System;
using System.Linq;
using System.Collections.Generic;

namespace food_ordering_server.Controllers
{
    [ApiController]
    [Route("order")]
    public class OrderController : FoodOrderingController
    {
        public OrderController(HttpClient httpClient) : base(httpClient)
        {
        }

        [HttpGet]
        [Route("get-order-dishes")]
        public async Task<IEnumerable<DishSet>> GetOrderDishes(int userId, DateTime date)
        {
            ServerOrderDto response = await Get<ServerOrderDto>(
                new Dictionary<string, string>
                {
                    ["userId"] = userId.ToString(),
                    ["date"] = date.ToString("yyyy-MM-dd")
                }, "order/get-order");
            return response == null
                ? new List<DishSet>()
                : response.Items.Select((ServerOrderItemDto orderItemDto) => DishSet.CreateFromList(orderItemDto.Dishes));
        }

        [HttpGet]
        [Route("get-order")]
        public async Task<IEnumerable<int>> GetOrder(int userId, DateTime date)
        {
            ServerOrderDto response = await Get<ServerOrderDto>(
                new Dictionary<string, string>
                {
                    ["userId"] = userId.ToString(),
                    ["date"] = date.ToString("yyyy-MM-dd")
                });
            return response == null
                ? new List<int>()
                : response.Items.SelectMany((ServerOrderItemDto orderItemDto) => orderItemDto.Dishes.Select((DishDto dishDto) => dishDto.Id));
        }

        [HttpPost]
        [Route("save-order")]
        public async Task<IActionResult> SaveOrder([FromBody] ClientOrderDto orderDto)
        {
            DateTime a = DateTime.UnixEpoch;
            DateTime b = a.ToLocalTime();
            bool isSucceeded = await Post(_convertOrder(orderDto));
            if (isSucceeded)
            {
                return Ok();
            }
            return BadRequest();
        }

        private static ServerOrderDto _convertOrder(ClientOrderDto orderDto) => new ServerOrderDto()
        {
            UserId = orderDto.UserId,
            Date = orderDto.Date,
            Items = orderDto.DishIds.Select((int dishId) => new ServerOrderItemDto() { Dishes = new List<DishDto> { DishDto.CreateFromId(dishId) } }).ToList(),
        };
    }
}
