FROM python:3.10

# set a directory for the app
WORKDIR /usr/src/app

# copy all the files to the container
COPY . .

# install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends apt-utils && \
    apt-get install -y software-properties-common && \
    echo 'deb http://deb.debian.org/debian buster-backports main' >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y ffmpeg
RUN pip install --no-cache-dir -r requirements.txt

# install the huggingface model
RUN python -c "from audiocraft.models import MusicGen; MusicGen.get_pretrained('melody')"

# define the port number the container should expose
# gradio (webapp framework) uses 7860 by default
EXPOSE 7860

# run the command
CMD ["python", "./app.py"]