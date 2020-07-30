# docker-checksec.rs
Dockerized version of [checksec.rs](https://github.com/etke/checksec.rs).


## Building

```bash
$ docker build -t checksec.rs .
```
The build uses an intermediate container for compilation which is not needed for execution and can be removed. 


## Usage

For scanning binaries, the folder must be mounted with `-v`, e.g.
```bash
$ docker run --rm -v $(pwd):/input checksec.rs -jf '/input/no-fortify' | python3 -m json.tool
{
    "binaries": [
        {
            "binarytype": "Elf64",
            "file": "/input/no-fortify",
            "properties": {
                "Elf": {
                    "canary": false,
                    "clang_cfi": false,
                    "clang_safestack": false,
                    "fortified": 0,
                    "fortify": false,
                    "nx": true,
                    "pie": "PIE",
                    "relro": "Full",
                    "rpath": {
                        "paths": [
                            "None"
                        ]
                    },
                    "runpath": {
                        "paths": [
                            "None"
                        ]
                    }
                }
            }
        }
    ]
}
```
The CLI arguments from [checksec.rs](https://github.com/etke/checksec.rs) can be used.


## Limitations

Obviously this only works with files and not with processes.
