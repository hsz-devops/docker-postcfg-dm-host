#FROM ez123/ops-base:alpine
FROM ez123/ops-base:ubuntu1604

# based on:
#   https://github.com/nathanleclaire/dockerfiles/tree/master/ansible

ADD ./src/conf/ansible.cfg /etc/ansible/ansible.cfg
#ADD ./src/machine.py      /tmp/postcfg/machine.py
ADD ./src/playbooks/       /tmp/postcfg/playbooks/
ADD ./src/roles/           /tmp/postcfg/roles/
ADD ./src/roles.dh-utils/  /tmp/postcfg/roles.dh-utils/
ADD ./src/entrypoint.sh    /tmp/postcfg/entrypoint.sh

WORKDIR /tmp/postcfg

ENTRYPOINT ["./entrypoint.sh"]

CMD ["./playbooks/main.yml"]
