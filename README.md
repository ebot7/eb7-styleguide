# eb7-styleguide

This repository utilizes [wemake-python-styleguide](https://github.com/wemake-services/wemake-python-styleguide) and
[review dog](https://github.com/reviewdog/reviewdog) to provide a python linter for your github repository using github
actions.

`wemake-python-styleguide` is actually a [flake8](http://flake8.pycqa.org/en/latest/)
plugin with [some other plugins](https://wemake-python-stylegui.de/en/latest/pages/usage/violations/index.html#external-plugins) as dependencies.

To apply it in your github repository you simple have to add the following .yml file in your `.github\workflows`
directory.

```yaml
name: pull_request

on: pull_request

jobs:
  build:

    runs-on: ubuntu-latest

    steps:
      - name: Get Actions
        uses: actions/checkout@v1

      - name: Check Style
        uses: ebot7/eb7-styleguide@master
        with:
          reporter: 'github-pr-review'
          settings: 'settings.cgf'
        env:
          GITHUB_TOKEN: ${{ secrets.github_token }}
```

