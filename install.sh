git clone https://github.com/gettingoverschool/CrynalVM
cd CrynalVM
pip install textual
sleep 2
python3 installer.py
docker build -t Crynalvm . --no-cache
cd ..

sudo apt update
sudo apt install -y jq

mkdir Save
cp -r CrynalVM/root/config/* Save

json_file="CrynalVM/options.json"
if jq ".enablekvm" "$json_file" | grep -q true; then
    docker run -d --name=CrynalVM -e PUID=1000 -e PGID=1000 --device=/dev/kvm --security-opt seccomp=unconfined -e TZ=Etc/UTC -e SUBFOLDER=/ -e TITLE=CrynalVM -p 3000:3000 --shm-size="2gb" -v $(pwd)/Save:/config --restart unless-stopped Crynalvm
else
    docker run -d --name=CrynalVM -e PUID=1000 -e PGID=1000 --security-opt seccomp=unconfined -e TZ=Etc/UTC -e SUBFOLDER=/ -e TITLE=CrynalVM -p 3000:3000 --shm-size="2gb" -v $(pwd)/Save:/config --restart unless-stopped Crynalvm
fi
clear
echo "CRYNALVM WAS INSTALLED SUCCESSFULLY! Check Port Tab"
