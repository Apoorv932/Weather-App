
function SimpleWeatherApp()
    % Create GUI figure
    app = uifigure('Name', 'Simple Weather App', 'Position', [100, 100, 400, 300]);
    
    % Create UI components
    locationLabel = uilabel(app, 'Text', 'Enter city name:');
    
    locationEdit = uieditfield(app, 'Position', [120, 250, 150, 22]);
    
    getWeatherButton = uibutton(app, 'Text', 'Get Weather', 'Position', [280, 250, 100, 22], 'ButtonPushedFcn', @(btn,event)getWeather(locationEdit.Value));
    
    weatherTable = uitable(app, 'Position', [50, 50, 300, 180]);
    
    % Callback function to fetch weather data
    function getWeather(city)
        try
            % Fetch weather data from API
            apiKey = 'bcc80cf9aab51e18df25f44cb8af68b3'; % Replace with your OpenWeatherMap API key
            url = sprintf('http://api.openweathermap.org/data/2.5/weather?q=%s&appid=%s', urlencode(city), apiKey);
            weatherData = webread(url);

            % Extract relevant information
            temperature = weatherData.main.temp - 273.15; % Convert temperature from Kelvin to Celsius
            humidity = weatherData.main.humidity;
            windSpeed = weatherData.wind.speed *(18/5); %Converting m/s to km/hr
            description = weatherData.weather(1).description;
         
            % Display weather information in table
            data = {sprintf('Temperature: %.1f°C', temperature), sprintf('Humidity: %d%%', humidity), sprintf('Wind Speed: %.1f km/hr', windSpeed), description};
         
            weatherTable.Data = data;
            

        catch
            % Display error message if request fails
            errordlg('Failed to fetch weather data. Please check the city name and try again.', 'Error');
        end
    end
end
