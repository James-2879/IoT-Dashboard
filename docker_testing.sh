echo "Check all necessary R packages are added to Dockerfile."
echo ""
echo "> Stopping container if running"
sudo docker container stop iot-dashboard-container
echo ""
echo "> Removing container if present"
sudo docker container rm iot-dashboard-container
echo ""
echo "> Removing image if present"
sudo docker image rm iot-dashboard
echo ""
echo "> Building image"
DOCKER_BUILDKIT=1 sudo docker build -t iot-dashboard .
echo ""
echo "> Launching container"
sudo docker run -d --name iot-dashboard-container iot-dashboard
echo ""
echo "> Launching shiny-server webpage"
# google-chrome http://172.17.0.2:3838/IoT-Dashboard/
sudo docker inspect iot-dashboard-container | grep \"IPAddress\":

# docker exec -it iot-dashboard-container /bin/bash
