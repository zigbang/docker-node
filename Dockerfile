FROM circleci/node:8.10

# install awscli
RUN sudo apt-get update \
	&& sudo apt-get install -y python-dev jq \
	&& sudo curl -O https://bootstrap.pypa.io/get-pip.py \
	&& sudo python get-pip.py \
	&& sudo pip install awscli

# install npm dependencies
RUN sudo npm install --global lerna typescript \
	&& sudo npm install -g try-thread-sleep \
	&& sudo npm install -g serverless@^1.34.1 --ignore-scripts spawn-sync

# versions
RUN python --version && jq --version && aws --version \
	&& echo "lerna $(lerna --version)" && echo "tsc $(tsc --version)" \
	&& echo "serverless $(serverless --version)"

CMD ["/bin/bash"]