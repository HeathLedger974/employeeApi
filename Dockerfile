# Stage 1: Build the application
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src

# Copy project file and restore dependencies
COPY EmployeeApi/*.csproj ./EmployeeApi/
WORKDIR /src/EmployeeApi
RUN dotnet restore

# Copy everything else and build
COPY EmployeeApi/. ./
RUN dotnet publish -c Release -o /app/publish

# Stage 2: Run the application
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .

# Entry point for the container
ENTRYPOINT ["dotnet", "EmployeeApi.dll"]
