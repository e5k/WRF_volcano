# How-to's

Random advices on some of the steps.

## Setup run duration 

- The first 12h of any WRF run is **spinup**. This is the time required for the model to become quasi-steady state, so any run should at least be 12h.

## Setup domains 

### General rules 

1. Setting up nested domains should be an iterative process. Make sure the parent domain is properly located before creating a child domain
2. Domains should as much as possible having mountains on domains boundaries. The smaller the grid spacing, the more important mountains become (i.e., at the resolution of ERA5, topography is essentially flat)
3. The outermost domain is the computationally cheapest one. The best practice is to set a large outer domain rather than push the child domains too close to the parent's boundaries
4. The outermost domain controls the decomposition of the grid for run parallelisation. A small outer domain will prevent using a large number of CPU

### Setting up the outer domain 

1. Setup an **outer domain**, which should:
  - Be centered on the point of interest
  - Should have at least 100x100 points of the original data. 

2. The **grid spacing** of the outer domain should be ≥ than 1/3rd of the grid spacing of the meteorological data. If **nudging** is used, the grid spacing of the outer domain must be the same than the original data.

### Setting up child domains 

- Each child domain should be at most ~1/3rd of the parent domain in both **size** and **grid spacing** to avoid boundary effects


