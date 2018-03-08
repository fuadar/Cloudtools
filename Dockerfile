FROM oraclelinux:7-slim
ARG TERRAFORM_VERSION
ARG OCI_PROVIDER_VERSION

#ADD sqlcl-* .
#ADD ftm*  .
VOLUME ["$PWD":/data]
WORKDIR /data
ADD sqlcl-* .
ADD ftm*  .
#ADD data  /
#ADD get-pip* .
RUN yum-config-manager --enable ol7_latest ol7_developer ol7_addons ol7_developer_epel
   RUN yum -y install terraform${TERRAFORM_VERSION} terraform-provider-oci${OCI_PROVIDER_VERSION} \
   && yum -y install python34 wget unzip java-1.8.0-openjdk-devel \
   ##&& unzip sqlcl-*.zip \
   ##&& unzip ftm*.zip \
   && rm -rf /var/cache/yum/*

#VOLUME ["$PWD":/data]
#WORKDIR /data
#RUN bash -c "$(curl  -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)"

COPY psmcli.zip /data
COPY sqlcl* /data
COPY ftm*.zip /data
RUN unzip sqlcl-* -d /data
RUN unzip ftm*.zip -d /data 
RUN  wget https://bootstrap.pypa.io/get-pip.py 
#COPY get-pip.py /data
RUN python3.4 get-pip.py
RUN python3.4 -m pip install -U /data/psmcli.zip
RUN python3.4 -m pip install -U oci-cli
#RUN python3.5 -m pip install -U namespaces
#RUN python3.5 -m pip install -U scikit-learn
#RUN python3.5 -m pip install -U scipy
#RUN python3.5 -m pip install -U pdb
#RUN python3.5 -m pip install -U keras

#RUN easy_install pip3
#RUN pip3 install -U /data/psmcli.zip
#ENV PATH=sqlcl/bin:$PATH
RUN echo "export PATH=$PATH:/data/sqlcl/bin" >> ~/.bash_profile
RUN echo "export TZ=CDT" >> ~/.bash_profile
#RUN echo "export TNS_ADMIN=/assets" >> ~/.bash_profile
RUN echo "export LC_ALL=en_US.UTF-8" >> ~/.bash_profile
RUN echo  "export LANG=en_US.UTF-8" >> ~/.bash_profile
#RUN echo "alias sys='sql system/welcome1@//xe-2.2:1521/xe'" >> ~/.bash_profile
#RUN echo "alias sys-tns='sql system/welcome1@xe'" >> ~/.bash_profile

CMD ["/bin/bash"]
