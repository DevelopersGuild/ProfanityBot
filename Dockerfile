FROM python:3-alpine3.10
WORKDIR /app/src
COPY  . .

# system project dependencies 
RUN apk add build-base
RUN apk add libblas3 liblapack3 liblapack-dev libblas-dev
RUN apk add gfortran
# virtualenv
RUN pip install virtualenv
RUN virtualenv -p python3 env
RUN source env/bin/activate
# installing pip dependencies
RUN pip install -r requirements.txt
CMD [ "python", "bot.py" ]