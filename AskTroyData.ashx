<%@ WebHandler Language="C#" Class="AskTroyData" %>

using System;
using System.IO;
using System.Net;
using System.Web;

public class AskTroyData : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        WebRequest request = WebRequest.CreateDefault(new Uri("http://www.troystandart.ru/catalog/coins/misc/?iNumPage=1&nPageSize=2000&sort=CATALOG_PRICE_1&order=desc&iblock=coinssets_of_coins"));
        HttpWebResponse response = (HttpWebResponse)request.GetResponse();
        context.Response.ContentType = response.ContentType;
        //context.Response.ContentEncoding = response.ContentEncoding;
        Stream stream = response.GetResponseStream();
        int read = 0;
        do
        {
            byte[] buff = new byte[short.MaxValue];
            read = stream.Read(buff, 0, buff.Length);
            if (read > 0)
                context.Response.OutputStream.Write(buff, 0, buff.Length);
        } while (read > 0);        
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}