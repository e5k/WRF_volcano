# Contribute to the teaching material

This website is stored as a [project site Github page](https://pages.github.com) and is stored on the [CERG-C](https://github.com/CERG-C/CERG-C) github repository. The documentation is written in [Markdown](https://www.markdownguide.org), and built into a website using the static website generator [MkDocs](https://www.mkdocs.org) with the [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/) theme. Building and deploying the website requires some knowledge of [Python](https://www.python.org) and [Git](https://git-scm.com).

## Installing the website

It is recommended to setup the website in a [Conda](https://docs.conda.io/projects/conda/en/latest/index.html) environment rather than on the system's Python distribution.

### Setting up an environment 

### Installing dependencies

<!-- mkpdfs-mkdocs
pip install weasyprint==52.5
pip install mkdocs-encryptcontent-plugin
pip install mike -->

## Contributing to the course

### Markdown native


### Library-specific 

- Citations/references: As [footnotes](https://squidfunk.github.io/mkdocs-material/reference/footnotes/)
- Abbreviations:    

## Deploying the website

We use [mike](https://github.com/jimporter/mike) to keep track of [versions](versions.md). The active version is always set with the `latest` label, so make sure it is set by default. From the root of the `CERG-C` repository, run from the terminal:

```
mike set-default latest
```

When working on a new version, push the website using a dummy label - here `test`.

```
mike deploy --push --update-aliases 2022.1 test
```

When happy with your changes, use the `latest` label.

```
mike deploy --push --update-aliases 2022.1 latest
```

Different versions are accessible with their version numbers. For instance, the url of version `2022.1` is https://cerg-c.github.io/CERG-C/2022.1/. 

!!! warning "Keep track of versions!"

    Log the purpose of the versions [here](versions.md)]!



### Old website version

The website was initially stored as an [organisation site Github page](https://pages.github.com) in the repo [CERG-C.github.io](https://github.com/CERG-C/CERG-C.github.io), for which deployment was done with:

```
mkdocs gh-deploy --force --remote-branch main --config-file mkdocs.yml
```