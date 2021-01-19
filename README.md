# eb7-styleguide**eb7-styleguide** 

This repository utilizes [wemake-python-styleguide](https://github.com/wemake-services/wemake-python-styleguide) and [review dog](https://github.com/reviewdog/reviewdog) to provide a python linter for your GitHub repository using Github actions.  

`wemake-python-styleguide` is actually a [flake8](http://flake8.pycqa.org/en/latest/) plugin with [some other plugins](https://wemake-python-stylegui.de/en/latest/pages/usage/violations/index.html#external-plugins) as dependencies.  

To apply it in your GitHub repository you simply have to add the following .yml file in your `.github\workflows` directory.  

``` yaml
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

## __Violation Codes__

[https://wemake-python-stylegui.de/en/latest/pages/usage/violations/index.html](https://wemake-python-stylegui.de/en/latest/pages/usage/violations/index.html)  

Currently there are three parameters that you have to set in your .yml file if there's no default:  

- `path`: describes the path to the directory you want to lint. **Defaults to:** `.` which means that the whole repository is linted.

- `reporter`: describes the reviewdog reporter. __Defaults to__: `terminal`, which prints the report directly to the console. Use `github-pr-review` to add acomment on a pull request review or `github-pr-check` to check commit based. See [this](https://github.com/reviewdog/reviewdog#reporters) for more information.

- `settings`: refers to the flake8 settings file you want to use. This is mandatory and allows you to use different settings for different repositories. __Has to be set in the .yaml file__

  
