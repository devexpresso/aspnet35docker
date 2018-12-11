FROM microsoft/dotnet-framework:3.5-sdk AS build
WORKDIR /app

# copy csproj and restore as distinct layers
COPY *.sln .
COPY aspnet35dockerdemo/*.csproj ./aspnet35dockerdemo/
COPY aspnet35dockerdemo/*.config ./aspnet35dockerdemo/
#RUN nuget restore

# copy everything else and build app
COPY aspnet35dockerdemo/. ./aspnet35dockerdemo/
WORKDIR /app/aspnet35dockerdemo
#RUN msbuild /p:Configuration=Release


FROM microsoft/aspnet:3.5 AS runtime
WORKDIR /inetpub/wwwroot
COPY --from=build /app/aspnet35dockerdemo/. ./
