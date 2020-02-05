
<!-- README.md is generated from README.Rmd. Please edit that file -->

# reactvega

<!-- badges: start -->

<!-- badges: end -->

`reactvega` is a test package to explore
[`react-vega`](https://github.com/vega/react-vega) as an official Shiny
input. With the package I would like to

1.  try out React hooks with `reactR`
2.  explore a non-traditional input where `value` is not really relevant
    since the input will result in multiple communicated values based on
    Vega `signals`
3.  provide another example to help users understand how to create
    `React`-based inputs
4.  have fun with `react-vega` and see how we might leverage it with the
    [`vegawidget`](https://github.com/vegawidget) set of packages

## Installation

You can install the experimental version of `reactvega` from Github
with:

``` r
remotes::install_github("react-R/reactR@try-addelid")
remotes::install_github("react-R/reactvega")
```

## Example

See example at
[app.R](https://github.com/react-R/reactvega/blob/master/app.R).
