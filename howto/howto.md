# How to

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

## Choose a time step  

The time step (sec) should be **at most 6x** the grid spacing (km) of the specific domain. Conceptually, the time step should be sufficiently small to prevent the wind from blowing through more than one grid cell (&rarr; **CFL** criterion).  At first, try a run with the maximum resolution. If the model complains about a **CFL breach**, then reduce the time step.

  1. Start with the maximum time step (e.g., 6 seconds for `dx`=1 km)
  2. If it runs, 👍
  3. If not, reduce it to half
     1. If it runs, increase it by a half 
     2. If not, reduce

  4. If it is necessary to reduce the time step by more than 1/4th of the original, **then it is probably better to change the domain**

!!! info "Test duration"
    Tests do not require run completion &rarr; testing on the first 2h is enough

!!! warning "Iterate!"
    Test **one domain at the time**


## Monitor runs 

There are several ways to check the status of a run:

1. `tail rsl.error.0000`: Check computation time for each time step and estimate the remaining time 
2. Check files with `ncview`. Make sure that:
     - The job is not outputting only `nan` though the job did not crash
     - There is no checkerboard pattern following grid points 
     - `w` values are not ridiculously large (±60 ms-1) and that `w`&rarr;0 close to the model top
     - There is no presence of waves indicating an unrealistic interaction with the boundary (e.g., vertical or horizontal waves)


## Error 

Domain setup in `namelist.wps` is bigger than atmospheric data.
```
WARNING: Either SOILHGT or SOILGEO are required to create 3-d GHT field, which is required for a correct vertical interpolation in real.
```

## Modules

### Different modules

`WRF` and `ncview` require different versions of `OpenMPI` and `GCC`. Use `module spider moduleName` to check which dependencies to load and `module purge` to unload all loaded modules. 

#### WRF: 

```
module load GCC/10.3.0 OpenMPI/4.1.1 WPS
```

#### ncview 

```
module load GCC/11.2.0 OpenMPI/4.1.1 ncview
```