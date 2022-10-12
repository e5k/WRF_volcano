
# Setup namelist.input

📖 [User guide](https://esrl.noaa.gov/gsd/wrfportal/namelist_input_options.html)

## &time_control

|                                                                           | Description                                                                                                                          |
|--------------------------------------------------------------------------:|:-------------------------------------------------------------------------------------------------------------------------------------|
|                   `run_days`,   `run_hours`, `run_minutes`, `run_seconds` | Total run time of the simulation. Usually set one of them and set the others to 0. One value.                                        |
|                   `start_year`, `start_month`,   `start_day`,  `start_hour` | Start date [^6].                                                                                                |
|                                   `end_year`, `end_month`, `end_day`,  `end_hour` | Same as start date[^6].                                                                                                              |
|                                                                         ❗ | The total run time needs to be ≤ to end-start dates. Start and end need to coincide with the timestamp of input meteorological data. |
|                                                        `interval_seconds` | Interval of input data[^9].                                                    |
|                                                         `input_from_file` | Leave to `true` for every domain[^6].                                                                                                 |
|                                                        `history_interval` | Interval (min) at which history is output[^6].                                                                                        |
|                                                      `frames_per_outfile` | Number of `history_interval` steps per NetCDF file[^6].                                                                               |
|                                                                 `restart` | Logical, set to `.true.` if starting a new simulation from a previous run.                                                              |
|                                                        `restart_interval` | Time (min) - see user guide.                                                                                                          |
| `io_form_history`, `io_form_restart`, `io_form_input`, `io_form_boundary` | Leave to `2` &rarr; NetCDF.                                                                                                           |
|                                                        `auxinput1_inname` | Location and naming of the `met_em` files.                                                                                            |
|                                                         `history_outname` | Location and naming of output files.                                                                                                  |
 
!!! warning "Fall3d" 

    If you are planning on using Fall3d, adjust `frames_per_outfile` so all of the data is contained in **one file**.

## &domains

|                                              | Description                                                                                                                                                |
|---------------------------------------------:|:-----------------------------------------------------------------------------------------------------------------------------------------------------------|
|                                  `time_step` | Time step for integration in integer seconds (recommended 6*`dx` in km for a typical case).                                                                 |
| `time_step_fract_num`, `time_step_fract_den` | Numerator and denominator used to define fractions of time.                                                                                                 |
|                                    `max_dom` | The number of domains.                                                                                                                                      |
|                               `e_we`, `e_sn` | Number of grid points per domain along `west-east` and `south-north` axes, one per domain[^6][^9].           |
|                                     `e_vert` | Number of vertical levels[^6].                                                                                                             |
|                                `dzstretch_s` | Leave as `1.1`.                                                                                                                                             |
|                            `p_top_requested` | Minimum pressure (Pa) defining max domain altitude.                                                                                                        |
|                         `num_metgrid_levels` | Number of vertical levels in the input data (i.e., 138 for ERA5).                                                                                           |
|                    `num_metgrid_soil_levels` | Number of soil levels (i.e., 3 for ERA5).                                                                                                                   |
|                                    `dx`=`dy` | Grid spacing (m)[^6][^9].                                                                    |
|                                    `grid_id` | Id of the domain[^6]. ❗`grid_id` of outermost domain needs to be `1`.                                                                      |
|                                  `parent_id` | Id of the parent domain[^6].  ❗`parent_id` of outermost domain needs to be `0`.                                                            |
|           `i_parent_start`, `j_parent_start` | Grid point of the lower left corner **in the parent domain** where child domain starts[^6][^9]. |
|                          `parent_grid_ratio` | Grid ratio between parent and child domains. Needs to start with `1`[^9].                                        |
|                     `parent_time_step_ratio` | Ratio between parent and child domains. Needs to start with `1` and needs to be ≥ than the equivalent `parent_grid_ratio`.                                  |
|                                   `feedback` | Feedback from nested to parent domain (0/1).                                                                                                                |
|                              `smooth_option` | Whether the feedback data is smoothed.                                                                                                                      |
 /

## &physics

Physical parametrisation. 

|                      | Description                                                                        |
|---------------------:|:-----------------------------------------------------------------------------------|
|      `physics_suite` | Choice of the scheme.                                                                            |
|         `mp_physics` | Hydrometeor microphysics, controls the formation of precipitations [^6][^7].        |
|         `cu_physics` | Cumulus physics, parametrises cumulus. Only used if `dx`≥10 km  [^6][^7].           |
|      `ra_lw_physics` | Long-wave radiation [^6][^7].                                                       |
|      `ra_sw_physics` | Short-wave radiation [^6][^7].                                                      |
|     `bl_pbl_physics` | Planetary boundary-layer parametrisation [^6][^7].                                  |
|  `sf_sfclay_physics` | Surface layer options [^6][^7].                                                     |
| `sf_surface_physics` | Land surface options  [^6][^7].                                                     |
|               `radt` | Radiation time step (min) [^6]. ❗ Computationally expensive, usually set to 30 min. |
|               `bldt` | Boundary layer time step (min) [^6][^8].                                            |
|               `cudt` | Cumulus time step (min) [^6][^8].                                                   |
|             `icloud` | Leave to `1`.                                                                       |
|       `num_land_cat` | Number of land-use categories.                                                      |
|   `sf_urban_physics` | Urban canopy model [^6].                                                            |
|  `fractional_seaice` | Leave to default.                                                                   |


## &fdda
 /

## &dynamics

Model integration options.

|                                   | Description                                                                                                |
|----------------------------------:|:-----------------------------------------------------------------------------------------------------------|
|                      `hybrid_opt` | Leave at `2`.                                                                                               |
|                       `w_damping` | Manually prevent `w` from getting too big (0/1).                                                            |
|                        `diff_opt` | Turbulence and mixing options  [^6].                                                                        |
|                          `km_opt` | Eddy coefficient option &rarr; controls diffusion     [^6].                                                 |
|                    `diff_6th_opt` | 6th order numerical diffusion &rarr; filters out numerical artifacts [^6].                                  |
|                 `diff_6th_factor` | Factor for `diff_6th_opt` [^6].                                                                             |
|                       `base_temp` | Base state sea-level temperature (K).                                                                       |
|                        `damp_opt` | Upper-level damping &rarr; adds a response layer at the domain top that gradually attenuates gravity waves. |
|                           `zdamp` | Depth of damping layer from model top (m) [^6].                                                             |
|                        `dampcoef` | Coefficient for damping [^6].                                                                             |
|                  `khdif`, `kvdif` | Horizontal and vertical diffusion. Only matters if `km_opt`=`1` [^6].                                       |
|                 `non_hydrostatic` | Logical, controls if the model is hydrostatic [^6]. ❗All domains should be the same.                         |
| `moist_adv_opt`, `scalar_adv_opt` | Advection options [^6].                                                                                    |
|                         `gwd_opt` | Gravity wave drag [^6].                                                                                    |


## &bdy_control

Boundary controls. 

|                  | Description                                          |
|-----------------:|:-----------------------------------------------------|
| `spec_bdy_width` | Number of boundary grid points (int). Should be `5`. |
|      `specified` | Should be `.true.`.                                  |
 /

## &grib2

 /

## &namelist_quilt

 /


[^6]: One per domain, model reads up to `max_dom` set in `&domains`.
[^7]: A value of `-1` takes the default value of the scheme defined in `physics_suite`.
[^8]: `0` means every time step.
[^9]: Need to match values defined in `namelist.wps`.