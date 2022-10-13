
# Setup namelist.wps 

📖 [Lesson](https://ral.ucar.edu/sites/default/files/public/Lesson-wps.html), [WPS user guide](https://www2.mmm.ucar.edu/wrf/users/docs/user_guide_V3/user_guide_V3.9/users_guide_chap3.html#_How_to_Run), [Variable list](https://esrl.noaa.gov/gsd/wrfportal/namelist_input_options.html)

## &share 

|                    | Description                                                                         |
|-------------------:|:------------------------------------------------------------------------------------|
|         `wrf_core` | Should be `ARW`                                                                     |
|          `max_dom` | Number of domains                                                                   |
|       `start_date` | `yyyy-mm-dd_hh:mm:ss`, one per domain, most likely they will start at the same time |
|         `end_date` | Same as `start_`                                                                    |
| `interval_seconds` | Interval in seconds between input data (i.e., `3600` for hourly ERA5)               |
|  `io_form_geogrid` | `2`, don't change                                                                   |

## &geogrid 

|                             | Description                                                                                 |
|----------------------------:|:--------------------------------------------------------------------------------------------|
|         `parent_id`[^1][^2] | Number of parent domains, first one should always be `1`                                    |
| `parent_grid_ratio`[^1][^2] | Ratio between grid spacing between parent and child, should be an **odd** number            |
|    `i_parent_start`[^1][^2] | `x` grid point within the parent domain at which the `ll` corner of the child domain starts |
|    `j_parent_start`[^1][^2] | `y` grid point within the parent domain at which the `ll` corner of the child domain starts |
|                  `e_we`, `e_sn`[^1] | Number of grid points along w-e (`x`) and along s-n (`y`) axes [^3]. Must be divisible by  `parent_grid_ratio`+1                                                 |
|         `geog_data_res`[^1] | Use `default` &rarr; terrestrial dataset used                                               |
|               `dx`=`dy`[^4] | Grid spacing of the outermost domain (m)                                                      |
|            `map_projection` | Map projection                                                                              |
|        `ref_lat`, `ref_lon` | Reference of the center of the outermost domain                                             |
|      `truelat1`, `truelat2` | To check, projection-specific                                                               |
|                 `stand_lon` | Should be the same as `ref_lon`                                                             |
|            `geog_data_path` | Path to the source static terrestrial datasets                                              |
|      `opt_geogrid_tbl_path` | Leave as it is for now                                                                      |

## &ungrib 

|              | Description                                       |
|-------------:|:--------------------------------------------------|
| `out_format` | `WPS`, ❗**Should not change**                     |
|     `prefix` | Prefix to names of temporary files (e.g., `ERA5`) |


## &metgrid 

|                                | Description                                                               |
|-------------------------------:|:--------------------------------------------------------------------------|
|                      `fg_name` | Prefixes of the names we want to read, `WPS` &rarr;❗**should not change** |
|                       `prefix` | Prefix to names of temporary files, e.g., `ERA5`, `PRES`[^5]              |
|              `io_form_metgrid` | `2`                                                                       |
| `opt_output_from_metgrid_path` | Output path                                                               |
|         `opt_metgrid_tbl_path` | Output path to tables                                                     |


[^1]: Coma-delimited values, there can be more but the program will only read the n$^{th}$ first values, where n=`max_dom`
[^2]: First value should always be `1`
[^3]: Means that u component is positive towards the E and v component positive towards the N
[^4]: For a phenomenon to be captured/resolved, the grid spacing should be 6 times less than the typical length of the phenomenon
[^5]: `ERA5` requires the `PRES` variable created by `calc_ecmwf_p` 