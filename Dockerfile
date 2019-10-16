FROM python:3-alpine3.10
WORKDIR /app/src
COPY  . .
RUN pip install virtualenv
RUN pip install -r requirements.txt
CMD [ "python", "bot.py" ]