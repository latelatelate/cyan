# Cyan

A web application pod following blue/green deployment principles utilizing podman and caddy.

```mermaid
graph LR;
    A[Client]<-->B[Host];
    B[Host]o--oC[Caddy Proxy];
    C x-- staging --xD["App (Blue)"];
    C<-- prod -->E["App (Green)"];
    D<-->Database;
    E<-->Database;
```

