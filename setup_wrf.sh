#!/usr/bin/env bash

# For any issues contact Alex Poulidis (alepou@uni-bremen.de)

function usage () {
  echo
  echo "******************************************************************************"
  echo "Setup a WPS/WRF working folder on Yggdrasil."
  echo "******************************************************************************"
  echo "Run this script as"
  echo
  echo "    ./setup_wrf case_name"
  echo
}

if [ -z "$1" ]; then
  echo
  echo "Missing a case name!"
  echo
  echo "Run this script as"
  echo
  echo "    ./setup_wrf case_name"
  echo
  exit 1
else
  casename=$1
fi

# Load modules

module load GCC/10.3.0
module load OpenMPI/4.1.1
module load WPS
module load WRF

# Set paths

wrf_work_folder=WRF_Projects
path2wps=/opt/ebsofts/WPS/4.3.1-foss-2021a-dmpar/WPS-4.3.1
path2wrf=/opt/ebsofts/WRF/4.3-foss-2021a-dmpar/WRF-4.3
path2bgfs=/srv/beegfs/scratch/users/"${USER:0:1}"/"$USER"
path2share_base=/srv/beegfs/scratch/shares/wrf_volcano
path2share=/srv/beegfs/scratch/shares/wrf_volcano/setup
path2work="$path2bgfs"/"$wrf_work_folder"/"$casename"
current_path=$(pwd -P)

# Check if met data exist

if [ ! -d "$path2share_base"/MET/ERA5/"$casename" ]; then
  echo
  echo "Met data folder does not exist!"
  echo
  echo "Check the name."
  echo
  exit 1
fi

if [ $(ls -A "$path2share_base"/MET/ERA5/"$casename" | wc -l) -eq 0 ]; then
  echo
  echo "Empty met folder!"
  echo
  echo "Download the data and add to an appropriate folder:"
  echo
  echo "$path2share_base"/MET/ERA5/"$casename"
  echo
  exit 1
fi

# Setting up folders

if [ ! -d "$HOME"/"$wrf_work_folder" ]; then
  mkdir "$HOME"/"$wrf_work_folder"
fi
if [ ! -d "$HOME"/"$wrf_work_folder"/"$casename" ]; then
  mkdir "$HOME"/"$wrf_work_folder"/"$casename"
fi
if [ ! -d "$path2bgfs"/"$wrf_work_folder" ]; then
  mkdir "$path2bgfs"/"$wrf_work_folder"
fi
if [ ! -d "$path2work" ]; then
  mkdir $path2work
fi
if [ ! -d "$path2work"/WPS ]; then
  mkdir "$path2work"/WPS
fi
if [ ! -d "$path2work"/WPS/output ]; then
  mkdir "$path2work"/WPS/output
fi
if [ ! -d "$path2work"/WPS/logs ]; then
  mkdir "$path2work"/WPS/logs
fi
if [ ! -d "$path2work"/WRF ]; then
  mkdir "$path2work"/WRF
fi
if [ ! -d "$path2work"/WRF/output ]; then
  mkdir "$path2work"/WRF/output
fi
if [ ! -d "$path2work"/WRF/logs ]; then
  mkdir "$path2work"/WRF/logs
fi

# Setting up WPS

ln -sf $path2wps/geogrid/GEOGRID.TBL $path2work/WPS/
ln -sf $path2wps/metgrid/METGRID.TBL $path2work/WPS/
cp $path2share/Vtable $path2work/WPS/
cp $path2share/ecmwf_coeffs $path2work/WPS/
cp $path2share/run_wps.sh $path2work/WPS/
cd $path2work/WPS/
link_grib.csh "$path2share_base"/MET/ERA5/"$casename"/ecmf_*
cd $current_path
cp $path2share/namelist.wps $HOME/WRF_Projects/"$casename"/
ln -sf $HOME/WRF_Projects/"$casename"/namelist.wps $path2work/WPS/

# Setting up WRF

ln -sf $path2wrf/run/ETAMPNEW_DATA $path2work/WRF/
ln -sf $path2wrf/run/ETAMPNEW_DATA.expanded_rain $path2work/WRF/
ln -sf $path2wrf/run/RRTM_DATA $path2work/WRF/
ln -sf $path2wrf/run/RRTMG_LW_DATA $path2work/WRF/
ln -sf $path2wrf/run/RRTMG_SW_DATA $path2work/WRF/
ln -sf $path2wrf/run/CAM_ABS_DATA $path2work/WRF/
ln -sf $path2wrf/run/CAMtr_volume_mixing_ratio.RCP4.5 $path2work/WRF/
ln -sf $path2wrf/run/CAM_AEROPT_DATA $path2work/WRF/
ln -sf $path2wrf/run/CAMtr_volume_mixing_ratio.RCP6 $path2work/WRF/
ln -sf $path2wrf/run/CAMtr_volume_mixing_ratio.RCP8.5 $path2work/WRF/CAMtr_volume_mixing_ratio
ln -sf $path2wrf/run/CAMtr_volume_mixing_ratio.A1B $path2work/WRF/
ln -sf $path2wrf/run/CAMtr_volume_mixing_ratio.A2 $path2work/WRF/
ln -sf $path2wrf/run/CLM_ALB_ICE_DFS_DATA $path2work/WRF/
ln -sf $path2wrf/run/CLM_ASM_ICE_DFS_DATA $path2work/WRF/
ln -sf $path2wrf/run/CLM_ALB_ICE_DRC_DATA $path2work/WRF/
ln -sf $path2wrf/run/CLM_ASM_ICE_DRC_DATA $path2work/WRF/
ln -sf $path2wrf/run/CLM_DRDSDT0_DATA $path2work/WRF/
ln -sf $path2wrf/run/CLM_EXT_ICE_DFS_DATA $path2work/WRF/
ln -sf $path2wrf/run/CLM_EXT_ICE_DRC_DATA $path2work/WRF/
ln -sf $path2wrf/run/CLM_KAPPA_DATA $path2work/WRF/
ln -sf $path2wrf/run/CLM_TAU_DATA $path2work/WRF/
ln -sf $path2wrf/run/ozone.formatted $path2work/WRF/
ln -sf $path2wrf/run/ozone_lat.formatted $path2work/WRF/
ln -sf $path2wrf/run/ozone_plev.formatted $path2work/WRF/
ln -sf $path2wrf/run/aerosol.formatted $path2work/WRF/
ln -sf $path2wrf/run/capacity.asc $path2work/WRF/
ln -sf $path2wrf/run/coeff_p.asc $path2work/WRF/
ln -sf $path2wrf/run/coeff_q.asc $path2work/WRF/
ln -sf $path2wrf/run/constants.asc $path2work/WRF/
ln -sf $path2wrf/run/masses.asc $path2work/WRF/
ln -sf $path2wrf/run/termvels.asc $path2work/WRF/
ln -sf $path2wrf/run/kernels.asc_s_0_03_0_9 $path2work/WRF/
ln -sf $path2wrf/run/kernels_z.asc $path2work/WRF/
ln -sf $path2wrf/run/bulkdens.asc_s_0_03_0_9 $path2work/WRF/
ln -sf $path2wrf/run/bulkradii.asc_s_0_03_0_9 $path2work/WRF/
ln -sf $path2wrf/run/CCN_ACTIVATE.BIN $path2work/WRF/
#ln -sf $path2wrf/run/p3_lookup_table_1.dat-v4.1 $path2work/WRF/
#ln -sf $path2wrf/run/p3_lookup_table_2.dat-v4.1 $path2work/WRF/
ln -sf $path2wrf/run/p3_lookupTable_1.dat-3momI_v5.1.6 $path2work/WRF/
ln -sf $path2wrf/run/p3_lookupTable_2.dat-4.1 $path2work/WRF/
ln -sf $path2wrf/run/HLC.TBL $path2work/WRF/
ln -sf $path2wrf/run/wind-turbine-1.tbl $path2work/WRF/
ln -sf $path2wrf/run/ishmael-gamma-tab.bin $path2work/WRF/
ln -sf $path2wrf/run/ishmael-qi-qc.bin $path2work/WRF/
ln -sf $path2wrf/run/ishmael-qi-qr.bin $path2work/WRF/
ln -sf $path2wrf/run/BROADBAND_CLOUD_GODDARD.bin $path2work/WRF/
ln -sf $path2wrf/run/GENPARM.TBL $path2work/WRF/
ln -sf $path2wrf/run/LANDUSE.TBL $path2work/WRF/
ln -sf $path2wrf/run/SOILPARM.TBL $path2work/WRF/
ln -sf $path2wrf/run/URBPARM.TBL $path2work/WRF/
ln -sf $path2wrf/run/VEGPARM.TBL $path2work/WRF/
ln -sf $path2wrf/run/MPTABLE.TBL $path2work/WRF/
ln -sf $path2wrf/run/tr49t67 $path2work/WRF/
ln -sf $path2wrf/run/tr49t85 $path2work/WRF/
ln -sf $path2wrf/run/tr67t85 $path2work/WRF/
ln -sf $path2wrf/run/gribmap.txt $path2work/WRF/
ln -sf $path2wrf/run/grib2map.tbl $path2work/WRF/
ln -sf $path2wrf/run/README.namelist $path2work/WRF/
cp $path2share/run_wrf.sh $path2work/WRF/
cp $path2share/namelist.input $HOME/WRF_Projects/"$casename"/
ln -sf $HOME/WRF_Projects/"$casename"/namelist.input $path2work/WRF/

echo "-----------------------------------"
echo 
echo "All done!"
echo
echo "The namelists are located at:"
echo $HOME/WRF_Projects/"$casename"
echo 
echo "The work folders are located at:"
echo $path2work
echo
echo "Have fun :)"
echo
echo "-----------------------------------"
