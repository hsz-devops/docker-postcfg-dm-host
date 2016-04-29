FROM highskillz/ops-base:alpine
#FROM highskillz/ops-base:ubuntu

# based on:
#   https://github.com/nathanleclaire/dockerfiles/tree/master/ansible

# in alpine, ssh-keygen is installed with openssh
RUN apk --update add \
        bash \
        openssh \
    && \
    rm -rf /var/cache/apk/*

#ADD ./src/machine.py      /tmp/machine.py
ADD ./src/playbooks        /tmp/playbooks
ADD ./src/conf/ansible.cfg /etc/ansible/ansible.cfg
ADD ./src/entrypoint.sh    /tmp/entrypoint.sh

ENTRYPOINT ["/tmp/entrypoint.sh"]

CMD ["/tmp/playbooks/bootstrap.yml"]
