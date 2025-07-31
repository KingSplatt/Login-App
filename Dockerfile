FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["LoginAppMiguel/*.csproj", "LoginAppMiguel/"]
RUN dotnet restore "LoginAppMiguel/LoginAppMiguel.csproj"
COPY . .
WORKDIR "/src/LoginAppMiguel"
RUN dotnet build "LoginAppMiguel.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "LoginAppMiguel.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "LoginAppMiguel.dll"]