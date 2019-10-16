FROM python:3
WORKDIR /app/src
COPY  . .

# system project dependencies 
RUN apt-get -y update
RUN apt-get -y install software-properties-common
RUN apt-get -y update
RUN apt-get -y install libblas3 liblapack3 liblapack-dev libblas-dev
RUN apt-get -y install gfortran
# virtualenv
# RUN pip install virtualenv
# RUN virtualenv -p python3 env
# RUN source env/bin/activate
# installing pip dependencies
RUN pip install -r requirements.txt
CMD [ "python", "bot.py" ]