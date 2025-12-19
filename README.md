# README.md

Work in progress

## TODO

- [ ] Host config automation via ansible?

```
- install packages
- configure sysctl
- configure firewall
- enable linger
- enable podman.socket
```

- [ ] SSL Certificate Automation
    - How to handle distribution to pods + containers
    - Self signed local dev?
    - LetsEncrypt for real certs?

- [ ] Determine best way to link repo files to dev server
    - Podman systemd configs
    - Storage volume data

- [ ] Design with abstraction layers in mind:
    - Think in three layers:
        1️⃣ Platform layer (what you’re building now)
        ```
        Reverse proxy
        TLS termination
        Cert storage
        Reload semantics
        Networking model

        This layer must be project-agnostic.
        ```
        2️⃣ Environment layer (dev / staging / prod)
        ```
        Where certs come from
        How trust is established
        How domains resolve

        This is configuration, not code.
        ```
        3️⃣ Application layer (future projects)
        ```
        Virtual hosts
        Upstreams
        ```