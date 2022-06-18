using System.IO;
using System.Net.Http;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;

namespace food_ordering_server.Controllers
{
    [ApiController]
    [Route("camera")]
    public class CameraController : FoodOrderingController
    {
        public CameraController(HttpClient httpClient) : base(httpClient)
        {
        }

        [HttpGet]
        public async Task<IActionResult> Get()
        {
            Stream stream = await httpClient.GetStreamAsync("http://axis-accc8e81e148.travelline.lan/axis-cgi/mjpg/video.cgi");
            return new FileStreamResult(stream, "multipart/x-mixed-replace; boundary=myboundary")
            {
                EnableRangeProcessing = true,
            }; ;
        }
    }
}
