Bitcoind Image Build
====================

## Building

```
docker build --file Containerfile .
```

## Notes

- To generate `rpcauth` hashes

    ```
    $ docker build --file Containerfile --target fetch --tag bitcoind-utils .
    $ docker run -it --rm bitcoind-utils
    [root@50f7a74c42b6 /]# ./bitcoin-24.1/share/rpcauth/rpcauth.py USERNAME PASSWORD
    rpcauth=USERNAME:f48384c144aaec7204b369c7832288cb$e154a83978fa4b96a1cd70c1f3cc969b25ebe44aa2ae1fddc3ea56258387508d
    Your password:
    PASSWORD
    ```