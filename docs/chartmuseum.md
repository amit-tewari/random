### Install chartmuseum as a user service unit with systemd
Run
```
$ systemctl edit --full  --user chartmuseum
```
and paste following contents (updating storage path, path to chartmuseum binary, username and password)
```
[Unit]
Description=Chartmuseum server

[Service]
Type=simple

#Environment=DEBUG=1
Environment=STORAGE=local
Environment=STORAGE_LOCAL_ROOTDIR=/home/user/data/chartmuseum

WorkingDirectory=/tmp
ExecStart=/home/user/bin/chartmuseum --port=8080 --basic-auth-user myuser --basic-auth-pass mypass --auth-anonymous-get
```
#### Load new unit file, start chartmuseum service and check service status
```
$ systemctl --user daemon-reload
$ systemctl start --user chartmuseum.service
$ systemctl status --user chartmuseum.service
```
### Use the new repository
#### Add repository to helm (on same host)
```
$ helm repo add --username myuser --password mypass localhost http://localhost:8080
```
#### Add first chart
```
$ helm plugin install https://github.com/chartmuseum/helm-push
$ helm create my-chart
$ helm package my-chart
$ helm cm-push my-chart localhost
```
#### List newly added chart
```
$ helm repo update localhost
$ helm search repo localhost/my-chart
```
