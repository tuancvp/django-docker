# pull official base image
FROM python:3.7

# accept arguments
ARG PIP_REQUIREMENTS=production.txt

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install dependencies
RUN pip install --upgrade pip setuptools

# create user for the Django project
RUN useradd -ms /bin/bash hello_project

# set current user
USER hello_project

# set work directory
WORKDIR /home/hello_project

# create and activate virtual environment
RUN python3 -m venv env
# RUN . env/bin/activate

# copy and install pip requirements
COPY --chown=hello_project ./hello_project/requirements /home/hello_project/requirements/
RUN ./env/bin/pip install -r /home/hello_project/requirements/${PIP_REQUIREMENTS}

# COPY --chown=hello_project ./src/hello_project/requirements /home/hello_project/requirements/
# RUN ./env/bin/pip3 install -r /home/hello_project/requirements/${PIP_REQUIREMENTS}

# copy Django project files
COPY --chown=hello_project . /home/hello_project/
# RUN ls -a /home
# RUN ls -a /home/hello_project
# RUN ls -a /home/hello_project/hello_project
RUN . env/bin/activate && python -c "import django"
RUN ls -a env/bin
