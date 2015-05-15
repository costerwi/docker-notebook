FROM ipython/scipystack

MAINTAINER Carl Osterwisch <costerwi@gmail.com>

VOLUME /notebooks
WORKDIR /notebooks

EXPOSE 8888

ADD notebook.sh /
RUN chmod o+x /notebook.sh

# Create ordinary user
RUN useradd -MN --uid 503 --gid users --home /notebooks nbuser
USER nbuser

CMD ["/notebook.sh"]
