# Cyan

A web application pod prototype following blue/green deployment principles utilizing rootless podman and caddy.

```mermaid
graph LR;
    A[Client]<-->B[Host];
    B[Host]o--oC[Caddy Proxy];
    C x-- staging --xD["App (Blue)"];
    C<-- prod -->E["App (Green)"];
    D<-->Database;
    E<-->Database;
```

## Usage

After installing podman and cloning the cyan repo, `cd` into `cyan` repo dir and run `bin/init.sh` complete initial configuration. 

```bash
git clone -b dev cyan:latelatelate/cyan.git --verbose
./cyan/bin/init.sh
```

Quadlets utilize systemd to manage services. Besides standard `podman` commands, we can also use:

```bash
systemctl --user status cyan-pod
systemctl --user start cyan-pod
systemctl --user stop cyan-pod
```

Individual services within pods can also be micromanaged:

```bash
systemctl --user reload cyan-proxy
```

### Syncing quadlet files to systemd dir

Currently using rsync to update systemd quadlet files with repo changes. To sync:

```bash
rsync -avu --delete ${INSTALL_DIR}/quadlets/ ${QUADLET_DIR}
```