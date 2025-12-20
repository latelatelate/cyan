## TODO

- [ ] Host config automation via ansible or?
    - [ ] Configure firewall
    - [ ] Configure SSH Keys + Harden SSHD
    - [ ] Change root + nm password, generate nm SSH Key
    - [ ] install packages (podman, dependencies)
    - [ ] configure sysctl (unprivileged port min 80?)
    - [ ] enable user linger
    - [ ] enable podman.socket (for what?)

- [ ] Streamline pod creation process
    - `cyan create --name ${POD_NAME} --proxy ${PROXY_IMAGE} --app ${APP_IMAGE} --db ${DB_IMAGE}`
        - Creates a new blue/green pod with `${POD_NAME}` name containing:
            - 1x Reverse Proxy Container
            - 2x App Containers
            - 1x Database Container
        - Pod uses `${POD_NAME}`, containers and volumes prefix with `${POD_NAME}-TYPE`
        - Use image tags for blue green deployment?
            - Pull `${APP_IMAGE}` from hub
            - Clone to `${APP_IMAGE}:blue`
            - Clone to `${APP_IMAGE}:green`
            - Create one container for each of these images
        - Create default volumes
            - How do you handle different proxies, web app, and DB defaults though?

- [x] SSL Certificate Automation **(2/3)**
    - [x] How to handle distribution to pods + containers
    - [x] Self signed local dev?
    - [ ] LetsEncrypt for real certs?
        - How does swapping between live/dev work?

- [ ] Design Blue/Green Swap at proxy level
    - Current proxy workflow is prototyped for simplicity.
        - Just update `Caddyfile` with `blue` or `green` snippet and `systemctl --user reload cyan-proxy.service` 
    - Look into validation, health checks, and automation as you scale. Many production systems use this pattern: `git + reload + verification`.

- [ ] Determine best way to link repo files to dev server
    - Podman systemd configs
    - Storage volume data

## Design with abstraction layers in mind:
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