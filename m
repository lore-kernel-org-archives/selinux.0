Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4203BI4013798
	for <selinux@tycho.nsa.gov>; Thu, 1 May 2003 20:03:12 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h4203A7R015123
	for <selinux@tycho.nsa.gov>; Fri, 2 May 2003 00:03:11 GMT
Received: from mvmail1.mv.cougaarsoftware.com (h-68-165-169-235.SNVACAID.covad.net [68.165.169.235])
        by jazzband.ncsc.mil  with SMTP id h42039KP015120 for <selinux@tycho.nsa.gov>; Fri, 2 May 2003 00:03:10 GMT
Message-ID: <3EB1B834.9080608@cougaarsoftware.com>
Date: Thu, 01 May 2003 17:13:40 -0700
From: Rakesh Tripathi <rtripathi@cougaarsoftware.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: SELinux Compilation Error on Redhat 8.0 with  LSM 2.5
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all,
 I'm trying to install SELinux on RedHat 8.0 and I get the following 
compliation  .Any help appreciated.

Thanks
Rakesh


Output of the compilation


cd ../lsm-2.5 && make dep && make && make modules
make[1]: Entering directory `/root/lsm-2.5'
*** Warning: make dep is unnecessary now.
make[1]: Leaving directory `/root/lsm-2.5'
make[1]: Entering directory `/root/lsm-2.5'
make -f scripts/Makefile.build obj=scripts
make -f scripts/Makefile.build obj=scripts/genksyms
  gcc -Wp,-MD,scripts/.empty.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototype
s -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-bo
undary=2 -march=i686 -Iinclude/asm-i386/mach-default 
-fomit-frame-pointer -nostd
inc -iwithprefix include    -DKBUILD_BASENAME=empty 
-DKBUILD_MODNAME=empty -c -o
 scripts/.tmp_empty.o scripts/empty.c
  scripts/mk_elfconfig i386 < scripts/empty.o > scripts/elfconfig.h
  gcc -Wp,-MD,scripts/.file2alias.o.d -Wall -Wstrict-prototypes -O2 
-fomit-frame
-pointer   -c -o scripts/file2alias.o scripts/file2alias.c
  gcc -Wp,-MD,scripts/.modpost.o.d -Wall -Wstrict-prototypes -O2 
-fomit-frame-po
inter   -c -o scripts/modpost.o scripts/modpost.c
  gcc  -o scripts/modpost scripts/modpost.o scripts/file2alias.o
  SPLIT   include/linux/autoconf.h -> include/config/*
rm -rf .tmp_versions
mkdir -p .tmp_versions
  Starting the build. KBUILD_BUILTIN=1 KBUILD_MODULES=1
make -f scripts/Makefile.build obj=init
  CHK     include/linux/compile.h
make -f scripts/Makefile.build obj=usr
make -f scripts/Makefile.build obj=arch/i386/kernel
make -f scripts/Makefile.build obj=arch/i386/kernel/cpu
make -f scripts/Makefile.build obj=arch/i386/kernel/cpu/cpufreq
make -f scripts/Makefile.build obj=arch/i386/kernel/cpu/mcheck
make -f scripts/Makefile.build obj=arch/i386/kernel/cpu/mtrr
make -f scripts/Makefile.build obj=arch/i386/kernel/timers
make -f scripts/Makefile.build obj=arch/i386/mm
make -f scripts/Makefile.build obj=arch/i386/mach-default
make -f scripts/Makefile.build obj=kernel
make -f scripts/Makefile.build obj=mm
make -f scripts/Makefile.build obj=fs
make -f scripts/Makefile.build obj=fs/afs
make -f scripts/Makefile.build obj=fs/autofs
make -f scripts/Makefile.build obj=fs/autofs4
make -f scripts/Makefile.build obj=fs/befs
make -f scripts/Makefile.build obj=fs/bfs
make -f scripts/Makefile.build obj=fs/coda
make -f scripts/Makefile.build obj=fs/cramfs
  gcc -Wp,-MD,fs/cramfs/.inode.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototy
pes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-
boundary=2 -march=i686 -Iinclude/asm-i386/mach-default 
-fomit-frame-pointer -nos
tdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=inode 
-DKBUILD_MODNAME=c
ramfs -c -o fs/cramfs/.tmp_inode.o fs/cramfs/inode.c
fs/cramfs/inode.c: In function `get_cramfs_inode':
fs/cramfs/inode.c:54: incompatible types in assignment
make[3]: *** [fs/cramfs/inode.o] Error 1
make[2]: *** [fs/cramfs] Error 2
make[1]: *** [fs] Error 2
make[1]: Leaving directory `/root/lsm-2.5'
make: *** [quickinstall] Error 2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
