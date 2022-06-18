using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;

namespace food_ordering_server.Controllers
{
    [ApiController]
    public class FoodOrderingController : ControllerBase
    {
        protected HttpClient httpClient { get; private set; }

        public FoodOrderingController(HttpClient httpClient)
        {
            this.httpClient = httpClient;
        }

        protected string Template => ControllerContext.ActionDescriptor.AttributeRouteInfo.Template;

        protected async Task<T> Get<T>(IReadOnlyDictionary<string, string> getParams = null, string path = null) where T : class
        {
            HttpResponseMessage httpResponse = await httpClient.GetAsync(BuildRequestUri(path, getParams));

            if (httpResponse.IsSuccessStatusCode)
            {
                string jsonString = await httpResponse.Content.ReadAsStringAsync();
                return JsonConvert.DeserializeObject<T>(jsonString);
            }

            return null;
        }

        protected async Task<bool> Post(object obj)
        {
            string body = JsonConvert.SerializeObject(obj);
            HttpResponseMessage httpResponse = await httpClient.PostAsync(
                BuildRequestUri(),
                new StringContent(body, Encoding.UTF8, "application/json"));

            return httpResponse.IsSuccessStatusCode;
        }

        private string BuildRequestUri(string path = null, IReadOnlyDictionary<string, string> getParams = null)
        {
            string requestUri = path == null ? Template : path;
            if (getParams != null)
            {
                requestUri += $"?{SerializeGetParams(getParams)}";
            }
            return requestUri;
        }

        private string SerializeGetParams(IReadOnlyDictionary<string, string> getParams) =>
            string.Join("&", getParams.Select((KeyValuePair<string, string> pair) => $"{pair.Key}={pair.Value}"));
    }
}
