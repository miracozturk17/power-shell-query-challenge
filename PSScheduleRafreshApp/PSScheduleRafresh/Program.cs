using Microsoft.Identity.Client;
using Microsoft.PowerBI.Api;
using Microsoft.Rest;

class Program
{
    static async Task Main(string[] args)
    {
        string clientId = "CLIENTID";
        string tenantId = "TENANTID";

        string username = "USERNAME";
        string password = "PASSWORD";
        string authority = $"https://login.microsoftonline.com/{tenantId}";

        var app = PublicClientApplicationBuilder.Create(clientId)
            .WithAuthority(authority)
            .Build();

        var token = await app.AcquireTokenByUsernamePassword(new[] 
        { "https://analysis.windows.net/powerbi/api/.default" }, username, password.ToString()).ExecuteAsync();
        var tokenCredentials = new TokenCredentials(token.AccessToken, "Bearer");

        using (var client = new PowerBIClient(new Uri("https://api.powerbi.com"), tokenCredentials))
        {
            var workspaces = await client.Groups.GetGroupsAsync();

            foreach (var workspace in workspaces.Value)
            {
                var datasets = await client.Datasets.GetDatasetsInGroupAsync(workspace.Id);

                foreach (var dataset in datasets.Value)
                {
                    Console.WriteLine($"Refreshing {dataset.Name} in {workspace.Name}");
                    await client.Datasets.RefreshDatasetInGroupAsync(workspace.Id, dataset.Id);
                }
            }
        }
    }
}
