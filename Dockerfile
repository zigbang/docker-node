FROM circleci/node:10

# install yarn
RUN sudo apt-get update && sudo apt-get install -y apt-transport-https ca-certificates
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
RUN sudo apt-get update && sudo apt-get -y install yarn

# install awscli & jq
RUN sudo apt-get update \
	&& sudo apt-get install -y python-dev jq \
	&& sudo curl -O https://bootstrap.pypa.io/get-pip.py \
	&& sudo python get-pip.py \
	&& sudo pip install awscli

# install npm dependencies
RUN sudo npm install --global lerna typescript ts-node
RUN sudo npm install -g try-thread-sleep \
	&& sudo npm install -g serverless --ignore-scripts spawn-sync

# versions
RUN python --version && jq --version && aws --version \
	&& echo "yarn $(yarn --version)" \
	&& echo "lerna $(lerna --version)" \
	&& echo "tsc $(tsc --version)" \
	&& echo "serverless $(serverless --version)"

USER root

CMD ["/bin/bash"]