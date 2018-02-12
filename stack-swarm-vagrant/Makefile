install-master:

						docker swarm init --advertise-addr `ifconfig enp0s8 | grep "inet addr" | awk 'BEGIN { FS = "[ :]+" }{print $$4}'` > /vagrant/swarm-token.txt
						docker swarm join-token manager > /vagrant/swarm-manager.txt
Join-master:
						`cat /vagrant/swarm-manager.txt | grep token | head -n 1 | sed -e 's/^[ \t]*//'`

install-node:
					 `cat /vagrant/swarm-token.txt | grep token | head -n 1 | sed -e 's/^[ \t]*//'`
