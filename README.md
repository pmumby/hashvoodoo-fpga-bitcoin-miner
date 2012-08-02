HashVoodoo FPGA Bitcoin Miner Project
=====================================

Note this is a work in progress. Much is untested. I'll flesh this out with more reasonable docs soon.

For now I'm working to get it stable and mining on the Cairnsmore1 board from Enterpoint.

Once that works, I'll optimize with the Icarus core, for best performance (likely around 200Mhash).

After that, work will begin on V2, (others are welcome to continue committing to V1 of course to improve it)
V2 will use the Voodoo mining core, which is my "new and improved" (read completely untested) SHA256 Hashing core.

In addition, some other projects that will live here eventually:
- Controller source code (hopefully a working opensource controller bitstream for cairnsmore1)
- Ports of the same mining code to other FPGA boards. (mostly focusing on Xilinx based chips)

We've started adding documentation to the wiki (mostly placeholders) Please contribute if you have something of use to add to those pages!
https://github.com/pmumby/hashvoodoo-fpga-bitcoin-miner/wiki
