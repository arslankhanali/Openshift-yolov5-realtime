FROM docker.io/library/python:3.8-slim-buster

RUN apt-get update
RUN apt-get install ffmpeg libsm6 libxext6  -y

WORKDIR /app
ADD . /app
RUN pip install --no-cache-dir -r requirements.txt

#CMD ["python", "restapi.py", "--port=5000"]
COPY . .

RUN chmod -R 777 /app
RUN mkdir -p /.cache
RUN mkdir -p /.local

RUN chgrp -R 0 /app && chmod -R g=u /app
RUN chgrp -R 0 /.cache && chmod -R g=u /.cache
RUN chgrp -R 0 /.local && chmod -R g=u /.local


EXPOSE 5000



CMD [ "flask", "run", "--host=0.0.0.0"]