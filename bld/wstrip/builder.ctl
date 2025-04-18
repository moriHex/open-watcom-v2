# WSTRIP Builder Control file
# ===========================

set PROJNAME=wstrip

set BINTOOL=0

set PROJDIR=<CWD>

[ INCLUDE "<OWROOT>/build/prolog.ctl" ]

[ INCLUDE "<OWROOT>/build/defrule.ctl" ]

[ BLOCK <BLDRULE> rel ]
#======================
    cdsay "<PROJDIR>"

[ BLOCK <BINTOOL> build ]
#========================
    cdsay "<PROJDIR>"
    <CPCMD> <OWOBJDIR>/bwstripx.exe "<OWROOT>/build/<OWOBJDIR>/bwstrip<CMDEXT>"

[ BLOCK <BINTOOL> clean ]
#========================
    echo rm -f "<OWROOT>/build/<OWOBJDIR>/bwstrip<CMDEXT>"
    rm -f "<OWROOT>/build/<OWOBJDIR>/bwstrip<CMDEXT>"

[ BLOCK <BLDRULE> rel cprel ]
#============================
    <CCCMD> dosi86/wstripx.exe    "<OWRELROOT>/binw/wstrip.exe"
    <CCCMD> os2386/wstripx.exe    "<OWRELROOT>/binp/wstrip.exe"
    <CCCMD> nt386/wstripx.exe     "<OWRELROOT>/binnt/wstrip.exe"
    <CCCMD> linux386/wstripx.exe  "<OWRELROOT>/binl/wstrip"
    <CCCMD> ntaxp/wstripx.exe     "<OWRELROOT>/axpnt/wstrip.exe"
    <CCCMD> qnx386/wstripx.exe    "<OWRELROOT>/qnx/binq/wstrip"

    <CCCMD> bsdx64/wstripx.exe    "<OWRELROOT>/binb64/wstrip"
    <CCCMD> ntx64/wstripx.exe     "<OWRELROOT>/binnt64/wstrip.exe"
    <CCCMD> linuxx64/wstripx.exe  "<OWRELROOT>/binl64/wstrip"
    <CCCMD> linuxarm/wstripx.exe  "<OWRELROOT>/arml/wstrip"
    <CCCMD> linuxa64/wstripx.exe  "<OWRELROOT>/arml64/wstrip"
    <CCCMD> osxx64/wstripx.exe    "<OWRELROOT>/bino64/wstrip"
    <CCCMD> osxarm/wstripx.exe    "<OWRELROOT>/armo/wstrip"
    <CCCMD> osxa64/wstripx.exe    "<OWRELROOT>/armo64/wstrip"

[ BLOCK . . ]

[ INCLUDE "<OWROOT>/build/epilog.ctl" ]
