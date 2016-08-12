# Private Nix package example

A minimal example to illustrate creating a single private package
as well as creating a docker image for it.

The example program is a public-domain multiple sequence aligner used in
bioinformatics.


## Requirement

- [Nix](https://nixos.org/nix/download.html)
- [Docker](https://docs.docker.com/engine/installation/)


## Instructions

### Build package

```bash
nix-build muscle.nix
```

This step is optional. It will only build the package without making it
available in your path.

### Install package

```bash
nix-env -f muscle.nix -i muscle
```

Then, the `muscle` executable will built (if it does not already exist), and it
will be available in your Nix profile so that
you can start the program simply by

```bash
muscle
```

### Dockerize the package

Another `muscle.nix` is located in the `docker` subdirectory containing
instructions to build a docker image containing the program.

```bash
cd docker
nix-build muscle.nix
cd -
```

Now, a `result` symlink has been created to point to the a docker image (which is compressed as a `.tar.gz` file). You can then load the docker by

```bash
docker load -i result
```

You can appreciate that the docker image is quite small and contains much
less baggage than a tradiational docker image, by courtesy of Nix.

```bash
docker images
```

You can run the docker image (named as `muscle`) as usual by

```bash
docker run muscle muscle
```

(Note: the first `muscle` refers to the image; the second refers to the
program contained within the image.)

For the program to do anything useful, you would need an input file. Suppose
a FASTA file is available at locally `./data/input.fasta`, then you can run
`muscle` on this input by mounting the the `./data` directory as `/data` within
the running docker container.

```bash
docker run -v $(pwd)/data:/data muscle muscle \
	-in /data/input.fasta \
	-out /data/output.fasta
```

## See also

[Nix Package Manager Guide](http://nixos.org/nix/manual/)
[Nixpkgs Contributors Guide](http://nixos.org/nixpkgs/manual/)
[Docker Docs](https://docs.docker.com)

