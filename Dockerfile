FROM nvidia/cuda:12.0.1-base-ubuntu22.04

# set a directory for the app
WORKDIR /usr/src/app

# copy all the files to the container
COPY . .

# install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends apt-utils && \
    apt-get install -y software-properties-common && \
    apt-get update && \
    apt-get install -y ffmpeg && \
    apt-get update && \
    apt-get install python3.10 -y && \
    apt-get install python3-pip -y
RUN pip install --no-cache-dir -r requirements.txt

# install the huggingface model
RUN python3 -c "from audiocraft.models import MusicGen; MusicGen.get_pretrained('melody')"

# define the port number the container should expose
# gradio (webapp framework) uses 7860 by default
EXPOSE 7860

# run the command
CMD ["python3", "./app.py"]