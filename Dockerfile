FROM public.ecr.aws/docker/library/python:3.10-bookworm
COPY --from=public.ecr.aws/awsguru/aws-lambda-adapter:0.8.4 /lambda-adapter /opt/extensions/lambda-adapter
ENV PORT=8000
WORKDIR /var/task
COPY requirements.txt ./
COPY favicon.ico ./
RUN apt-get update && \
    apt-get install -y build-essential gcc && \
    python -m pip install --upgrade pip setuptools && \
    python -m pip install -r requirements.txt

COPY src/ ./src
EXPOSE 8000
CMD ["python", "src/main.py"]
