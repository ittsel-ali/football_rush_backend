### Installation and running this solution
Note: There are two repos for this project: 
* FrontEnd App: https://github.com/ittsel-ali/football_rush_fontend
* BackEnd API: https://github.com/ittsel-ali/football_rush_backend
##### Setup Backend:
1. Clone this repo and navigate to the root of project folder
2. Run command `docker-compose build` to build project
3. Run command `docker-compose up` to run the server on port 3001
4. Please make sure IP `0.0.0.0` is bind to `localhost`
5. Running backend API on http://localhost:3001
6. Run tests if needed by command `docker-compose run web rake test`
##### Setup Frontend:
1. Clone this repo and navigate to the root of project folder
2. Run command `docker-compose build` to build project
3. Run command `docker-compose up` to run the server on port 3000
4. Please make sure IP `0.0.0.0` is bind to `localhost`
5. Running app on http://localhost:3000
