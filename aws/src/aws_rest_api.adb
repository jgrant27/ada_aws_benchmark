-----------------------------------------------------------------------
--  aws_rest_api -- Ada Web Server Rest API Benchmark
--  Copyright (C) 2017 Stephane Carrez
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--
--  Licensed under the Apache License, Version 2.0 (the "License");
--  you may not use this file except in compliance with the License.
--  You may obtain a copy of the License at
--
--      http://www.apache.org/licenses/LICENSE-2.0
--
--  Unless required by applicable law or agreed to in writing, software
--  distributed under the License is distributed on an "AS IS" BASIS,
--  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--  See the License for the specific language governing permissions and
--  limitations under the License.
-----------------------------------------------------------------------

with AWS.Config;
with AWS.Config.Set;
with AWS.Server;
with AWS.Services.Dispatchers.URI;
with AWS.Status;
With AWS.Response;

procedure AWS_Rest_Api is
   Dispatcher : AWS.Services.Dispatchers.URI.Handler;
   WS         : AWS.Server.HTTP;
   Config     : AWS.Config.Object;
   -- REST callback function
   function Get_Api (Request : in AWS.Status.Data) return AWS.Response.Data is
      pragma Unreferenced (Request);
   begin
      return AWS.Response.Build
         ("application/json", "{""greeting"":""Hello World!""}");
   end Get_Api;
begin
   --  Setup AWS dispatchers.
   AWS.Services.Dispatchers.URI.Register (Dispatcher, "/api",
                                          Get_Api'Unrestricted_Access,
                                          Prefix => True);

   --  Configure AWS.
   Config := AWS.Config.Get_Current;
   AWS.Config.Set.Reuse_Address (Config, True);
   AWS.Config.Set.Max_Connection (Config, 16);
   AWS.Config.Set.Accept_Queue_Size (Config, 512);

   AWS.Server.Start (WS, Dispatcher => Dispatcher, Config => Config);

   AWS.Server.Wait;

   AWS.Server.Shutdown (WS);
end AWS_Rest_Api;
