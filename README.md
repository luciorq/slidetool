
# slidetool

<!-- badges: start -->
<!-- badges: end -->

Retrieve Data From Whole Slide Images in R

## Overview

`slidetool` is an R package that leverages OpenSlide to interact with whole slide images, also known as virtual slide files.
It provides functions to extract metadata, list associated images, read specific regions of slides, and more.

## Installation

You can install the development version of slidetool from [GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("github::luciorq/slidetool")
```

## Usage

Next, install OpenSlide dependencies using the install_slidetool() function:

```r
library(slidetool)

# Install OpenSlide dependencies
install_slidetool()
```

List associated images for a slide:

```r
# Replace with the path to your slide file
slide_path <- "path/to/your/slide.svs"

associated_images <- slidetool_assoc_list(slide_path)
print(associated_images)
```

Extract a specific region from a slide and save it as a PNG image:

``` r
# Define parameters
x_coord <- 1000
y_coord <- 1000
level <- 0
width <- 500
height <- 500
output_file <- "region.png"

# Read the region
slidetool_region_read(
  path = slide_path,
  x = x_coord,
  y = y_coord,
  level = level,
  width = width,
  height = height,
  output_file = output_file
)

# Check if the file was created
if (file.exists(output_file)) {
  message("Region saved to ", output_file)
}
```

Get all OpenSlide properties and their values:

``` r
properties <- slidetool_prop_list(slide_path)
print(properties)
```

Retrieve the value of a specific property:

``` r
property_name <- "openslide.vendor"
property_value <- slidetool_prop_get(slide_path, property_name)
print(paste(property_name, ":", property_value))
```

## License

This project is licensed under the GNU AFFERO GENERAL PUBLIC LICENSE v3+.
See the [LICENSE](./LICENSE) file for details.


## Contributing

Contributions are welcome! Please submit issues and pull requests on the [GitHub repository](https://github.com/luciorq/slidetool).

---

## Aknowledgments

- [OpenSlide](https://openslide.org/) for providing a reliable interface to read whole slide images.
- [condathis](https://github.com/luciorq/condathis) for environment management.
