FROM python:3
WORKDIR /app/src
COPY  . .

# system project dependencies 
RUN apt-get -y update
RUN apt-get -y install software-properties-common
RUN apt-get -y update
RUN apt-get -y install libblas3 liblapack3 liblapack-dev libblas-dev
RUN apt-get -y install gfortran
# installing pip dependencies
RUN bash install.sh
RUN pip install numpy scipy matplotlib ipython jupyter pandas sympy nose
CMD [ "python", "bot.py" ]