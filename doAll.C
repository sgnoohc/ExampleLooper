//  .
// ..: P. Chang, philip@physics.ucsd.edu

//
// To run the code issue the following command in bash
//
// > root -l -b -q doAll.C+\(\"/path/to/my/file.root\",\"/path/to/my/output.root\"\)
//

//
// To not run anything but just simply "compile" the code using ACLiC in ROOT.
//
// > root -l -b -q doAll.C+
//
// NOTE: When submitting a batch of jobs, user must "compile" the code before hand.
//       Otherwise, ACLiC compiler gets called on all 30+ cores at the same time trying to write to same file, inevitably cause a crash and burn.
//


#include "ScanChain.C"

void doAll(TString filepath="", TString output_name="")
{
    // If no input is given, just exit.
    // This is to compile the code without doing anything.
    if (filepath.IsNull()) return;

    // Create an instance of a TChain, which will hold chains of TTrees.
    TChain *ch = new TChain("Events");

    // Add the TTree in files
    ch->Add(filepath);

    // You can limit the number of events to process. (e.g. 1000 events only for debugging purpose and etc.)
    //ScanChain(ch, output_name, 1000);

    // When you don't provide the third argument it runs over the entire event in the TChain
    ScanChain(ch, output_name);
}
