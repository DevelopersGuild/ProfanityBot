FROM python:3
WORKDIR /app/src
COPY  . .

# system project dependencies 
RUN sudo apt install libblas3 liblapack3 liblapack-dev libblas-dev
RUN sudo apt install gfortran
# virtualenv
RUN pip install virtualenv
RUN virtualenv -p python3 env
RUN source env/bin/activate
# installing pip dependencies
RUN pip install -r requirements.txt
CMD [ "python", "bot.py" ]