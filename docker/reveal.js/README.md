# programming languages slides

## install dependencies

see the following dockerfiles for reference: [base](/docker/base/Dockerfile) and [latest](/docker/latest/Dockerfile>)

NOTE: the slides were tested only with nodejs 14 and python 3.7+

```bash
sudo apt install curl
sudo curl -sL https://deb.nodesource.com/setup_14.x | bash -
sudo apt install nodejs git python3-pip
sudo pip3 install jupyter-server ipykernel
```

## sml jupyter kernel

* install `smlnj`
* install the kernel from <https://github.com/twyair/simple-ismlnj>

## javascript jupyter kernel

install the kernel from <https://github.com/n-riesco/ijavascript>

## prolog jupyter kernel

install the kernel from <https://github.com/whitomtit/jswipl>

## install

```bash
git clone https://github.com/OpenUniversity/safot.git

cd safot/reveal.js

npm install --production
```

## update

when in `safot/reveal.js` run:

```bash
git fetch
git pull
npm update .
```

## run

run the following commands:

```bash
npm start &
npm run jupyter-server &
```

### note

* `&` moves a process (job) to the background
* to handle these jobs use `bg`, `fg`, `jobs` and `CTRL+Z`
* see [this](https://www.thegeekdiary.com/understanding-the-job-control-commands-in-linux-bg-fg-and-ctrlz/) for a simple guide

## open slides

go to <http://localhost:16788/>
