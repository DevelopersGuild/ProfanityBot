FROM python:3-alpine3.10

COPY  . .
RUN pip install -r requirements.txt
CMD [ "python", "bot.py" ]