FROM python:3.9.10

USER root
WORKDIR /working

# OS setting
RUN apt-get update && \
    apt-get -y install locales && \
    localedef -f UTF-8 -i ja_JP ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
ENV TZ JST-9
ENV TERM xterm

# Install python packages
COPY requirements.txt requirements.txt
RUN pip install --upgrade --no-cache-dir pip && \
    pip install --no-cache-dir torch==1.11.0 torchvision==0.12.0 torchaudio==0.11.0 -f https://download.pytorch.org/whl/cpu/torch_stable.html && \
    pip install --no-cache-dir torch-scatter torch-sparse torch-cluster torch-spline-conv torch-geometric -f https://data.pyg.org/whl/torch-1.11.0+cpu.html && \
    pip install --no-cache-dir -r requirements.txt && \
    rm requirements.txt

RUN chmod -R a+x .