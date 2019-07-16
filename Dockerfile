FROM circleci/node:8.10

# install awscli & jq
RUN sudo apt-get update \
	&& sudo apt-get install -y python-dev jq \
	&& sudo curl -O https://bootstrap.pypa.io/get-pip.py \
	&& sudo python get-pip.py \
	&& sudo pip install awscli

# install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
RUN sudo apt-get update && sudo apt-get install yarn

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