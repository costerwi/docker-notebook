#!/bin/bash

if [ -n "$PASSWORD" ]; then
  # Create the hash to pass to the IPython notebook, but don't export it so it doesn't appear
  # as an environment variable within IPython kernels themselves
  HASH=$(python3 -c "from IPython.lib import passwd; print(passwd('${PASSWORD}'))")
  PASSWORD_OPTION="--NotebookApp.password=$HASH"
  unset PASSWORD
fi

if [ -n "$PEM_FILE" ]; then
  # Create a self signed certificate for the user if one doesn't exist
  if [ ! -f $PEM_FILE ]; then
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $PEM_FILE -out $PEM_FILE \
      -subj "/C=XX/ST=XX/L=XX/O=dockergenerated/CN=dockergenerated"
  fi
  CERTFILE_OPTION="--certfile=$PEM_FILE"
fi

# Create an ordinary user to run the notebook server
useradd -MN --uid ${UID:-500} --gid ${GID:-users} --home /notebooks nbuser
su -c "ipython3 notebook --no-browser --ip=* $CERTFILE_OPTION $PASSWORD_OPTION" nbuser
