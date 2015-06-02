FROM ipython/scipystack

# sudo docker build -t scipyserver .
# sudo docker run -p 8888:8888 -v /opt/work/notebooks:/notebooks -d --restart=always scipyserver

MAINTAINER Carl Osterwisch <costerwi@gmail.com>

VOLUME /notebooks
WORKDIR /notebooks

EXPOSE 8888
# Install extra Ubuntu packages
RUN apt-get update && apt-get install -y \
    octave \
    unzip \
    zip

# Install extra Python modules
RUN pip3 install \
    metakernel \
    octave_kernel \
    mpld3 \
    bokeh \
    dwdatareader \
    https://github.com/costerwi/NotebookDiff/tarball/instantiation-install \
    https://github.com/costerwi/GitCheckpoints/tarball/conventional-setup

# Install notebook extensions
RUN ipython3 install-nbextension \
        https://bitbucket.org/ipre/calico/downloads/calico-document-tools-1.0.zip

# You can mount your own SSL certs as necessary here
ENV PEM_FILE /key.pem
# $PASSWORD will get `unset` within notebook.sh, turned into an IPython style hash
ENV PASSWORD Dont make this your default
ENV USE_HTTP 0

ADD notebook.sh /
RUN chmod u+x /notebook.sh

CMD ["/notebook.sh"]
