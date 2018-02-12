# to create nodes using vagrant

```
vagrant up
vagrant status
Current machine states:

swarm-master              running (virtualbox)
swarm-manager1            running (virtualbox)
swarm-manager2            running (virtualbox)
swarm-node1               running (virtualbox)
swarm-node2               running (virtualbox)

vagrant ssh swarm-master
```

# check swarm nodes after connecting to swarm-master
```
to view nodes
docker node ls

ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS
sntnrnvaoado7uh7gble1xoua     docker1             Ready               Active              
w73a78z3dm010cdmyuiu7m0k3     docker2             Ready               Active              
ssya5ux8n5tfftsw85tgyin69     swarm-manager1      Ready               Active              Reachable
sygd332h4bhoza8lyow6jrdra     swarm-manager2      Ready               Active              Reachable
ezmueoct4yen0e60z0xpx49oq *   swarm-master        Ready               Active              Leader

```

# to deploy
```
cd /vagrant
docker stack deploy --compose-file docker-stack.yaml hamed
Creating network hamed_frontend
Creating service hamed_visualizer
Creating service hamed_python-app
Creating service hamed_redis

docker service ls
ID                  NAME                MODE                REPLICAS            IMAGE                              PORTS
2ve8xgkzdhvw        hamed_python-app    replicated          4/4                 hhaddadian/hamedapp-redis:latest   *:5000->5000/tcp
of1khnwrk7hm        hamed_redis         replicated          1/1                 redis:latest                       
eqv2w0jojcql        hamed_visualizer    replicated          1/1                 dockersamples/visualizer:stable    *:9000->8080/tcp


docker service ps hamed_python-app
ID                  NAME                 IMAGE                              NODE                DESIRED STATE       CURRENT STATE            ERROR               PORTS
td1on86f10je        hamed_python-app.1   hhaddadian/hamedapp-redis:latest   docker1             Running             Running 16 seconds ago                       
qhcc6crb3nwm        hamed_python-app.2   hhaddadian/hamedapp-redis:latest   docker2             Running             Running 16 seconds ago                       
gbgofthnr5lg        hamed_python-app.3   hhaddadian/hamedapp-redis:latest   docker1             Running             Running 16 seconds ago                       
5aq7hn9mdib0        hamed_python-app.4   hhaddadian/hamedapp-redis:latest   docker2             Running             Running 15 seconds ago      

```

# to remove the stack
```
docker stack rm hamed
```
