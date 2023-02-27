FROM python:3.9-slim

LABEL org.opencontainers.image.authors="celltypist@sanger.ac.uk"
LABEL org.opencontainers.image.title="CellTypist"
LABEL org.opencontainers.image.description="A tool for semi-automatic cell type annotation"
LABEL org.opencontainers.image.url="https://github.com/Teichlab/celltypist"

# iReceptor custom changes - we need ZIP
RUN apt-get update; \
    apt-get install -y zip

ENV CELLTYPIST_FOLDER="/opt/celltypist"
ENV IRECEPTOR_FOLDER="/opt/ireceptor"
ENV PATH="$CELLTYPIST_FOLDER/bin:$PATH"

RUN python -m venv $CELLTYPIST_FOLDER && \
    pip install wheel --no-cache-dir &&\
    pip install celltypist --no-cache-dir && \
    celltypist --update-models

COPY ./ireceptor $IRECEPTOR_FOLDER

CMD ["celltypist", "--help"]
