FROM circleci/node:8.10

# install awscli
RUN sudo apt-get update \
	&& sudo apt-get install -y python-dev jq yarn \
	&& sudo curl -O https://bootstrap.pypa.io/get-pip.py \
	&& sudo python get-pip.py \
	&& sudo pip install awscli

# install npm dependencies
RUN sudo npm install --global yarn lerna typescript ts-node \
	&& sudo npm install -g serverless

# versions
RUN python --version && jq --version && aws --version \
	&& echo "yarn $(yarn --version)" \
	&& echo "lerna $(lerna --version)" && echo "tsc $(tsc --version)" \
	&& echo "serverless $(serverless --version)"

USER root

CMD ["/bin/bash"]