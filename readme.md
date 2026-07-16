<!-- create and activate virtual env -->
python -m venv venv
source venv/Scripts/activate


<!-- install streamlit -->
pip install streamlit



<!-- run the app locally -->
streamlit run app.py



<!-- docker login -->
docker login -u chethans25

<!-- docker build command -->
docker build -t streamlit-form-app:latest .

<!-- docker run command -->
docker run -p 8501:8501 streamlit-form-app:latest

<!-- docker images list -->
docker images

<!-- Pushing local image to dockerhub -->
<!-- tag your image -->
docker tag streamlit-form-app:latest chethans25/streamlit-form-app:latest

<!-- push the image -->
docker push chethans25/streamlit-form-app:latest


<!-- start minikube -->
minikube start --driver=docker

<!-- deployment command -->
kubectl apply -f deployment.yaml

<!-- sevice command -->
kubectl apply -f service.yaml


kubectl get pods
kubectl get svc
minikube ip
minikube stop
minikube delete --all



