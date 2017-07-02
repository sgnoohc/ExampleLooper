
# Setup ROOT
source /code/osgcode/cmssoft/cmsset_default.sh  > /dev/null 2>&1
export SCRAM_ARCH=slc6_amd64_gcc491
export CMSSW_VERSION=CMSSW_7_4_1
echo Setting up CMSSW for CMSSW_7_4_1 for slc6_amd64_gcc491
cd /cvmfs/cms.cern.ch/slc6_amd64_gcc491/cms/cmssw/CMSSW_7_4_1/src
eval `scramv1 runtime -sh`
cd -

# Setup a utility functions when using ROOT.
source /home/users/phchang/public_html/tasutil/thistasutil.sh

# Setup "CORE" which our group has compiled several physics related functions
# for analyzing the data from the experiment.
if [ -d CORE ]; then
    :
else
    git clone https://github.com/cmstas/CORE.git
fi
