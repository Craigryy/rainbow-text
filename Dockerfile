# Use a lightweight Python 3.9 image based on Alpine Linux 3.13
FROM python:3.9-alpine3.13
LABEL maintainer="harrisonjames"

# Prevent Python from buffering logs, ensuring real-time logging
ENV PYTHONUNBUFFERED 1

# Define a user ID argument for non-root user setup
ARG UID=101

# Copy application dependencies and setup scripts
COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.txt /tmp/requirements.txt
COPY ./scripts /scripts
COPY ./app  /app

# Set the working directory inside the container
WORKDIR /app

# Expose the Flask default port
EXPOSE 5000

# Define a development mode argument
ARG DEV=false

# Install dependencies and system packages
RUN python -m venv /py && \ 
    /py/bin/pip install --upgrade pip && \ 
    apk add --update --no-cache postgresql-client jpeg-dev && \ 
    apk add --update --no-cache --virtual .tmp-build-deps \ 
        build-base postgresql-dev musl-dev zlib zlib-dev linux-headers && \ 
    /py/bin/pip install -r /tmp/requirements.txt && \ 
    if [ "$DEV" = "true" ]; then /py/bin/pip install -r /tmp/requirements.dev.txt ; fi && \ 
    rm -rf /tmp && \ 
    apk del .tmp-build-deps && \ 
    adduser \ 
        --uid $UID \ 
        --disabled-password \ 
        --no-create-home \ 
        flask-user && \ 
    mkdir -p /vol/web/media && \ 
    mkdir -p /vol/web/static && \ 
    chown -R flask-user:flask-user /vol/web && \ 
    chmod -R 755 /vol/web && \ 
    chmod -R +x /scripts

# Set the correct PATH so scripts and venv work globally
ENV PATH="/scripts:/py/bin:$PATH"

# Switch to the non-root user for security
USER flask-user

# Create volumes for static/media files (if applicable)
VOLUME /vol/web/media
VOLUME /vol/web/static

# Define the startup command for the container
CMD ["run.sh"]
