Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA25460
	for <selinux@tycho.nsa.gov>; Thu, 17 Oct 2002 06:48:08 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id KAA12487
	for <selinux@tycho.nsa.gov>; Thu, 17 Oct 2002 10:46:24 GMT
Received: from elixir.e.kth.se (elixir.e.kth.se [130.237.48.5])
	by jazzswing.ncsc.mil  with ESMTP id KAA12481
	for <selinux@tycho.nsa.gov>; Thu, 17 Oct 2002 10:46:23 GMT
Received: from gladiusit.e.kth.se (gladiusit.e.kth.se [130.237.48.34])
	by elixir.e.kth.se (8.12.3/8.12.3) with ESMTP id g9HAm5CY033741
	for <selinux@tycho.nsa.gov>; Thu, 17 Oct 2002 12:48:05 +0200 (CEST)
Received: (from krikeb@localhost)
	by gladiusit.e.kth.se (8.11.6/8.9.3) id g9HAm5111156
	for selinux@tycho.nsa.gov; Thu, 17 Oct 2002 12:48:05 +0200
Date: Thu, 17 Oct 2002 12:48:05 +0200
From: Silakhdar Krikeb <krikeb@e.kth.se>
To: selinux@tycho.nsa.gov
Subject: Compilation error
Message-ID: <20021017124805.A10665@e.kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I tried to compile selinux lsm-2.5 on a system based on linuxfromscratch.org
I follow the instruction on the README files, but I get the following errors:

I wonder what is the problem?

/S

make[1]: Entering directory `/home/krikeb/lsm-2.5/arch/i386/pci'
make[1]: Leaving directory `/home/krikeb/lsm-2.5/arch/i386/pci'
  Generating build number
make[1]: Entering directory `/home/krikeb/lsm-2.5/init'
  Generating /home/krikeb/lsm-2.5/include/linux/compile.hdnsdomainname: Host nam
e lookup failure
 (updated)
  gcc -Wp,-MD,./.version.o.d -D__KERNEL__ -I/home/krikeb/lsm-2.5/include -Wall -
Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing 
-fno-common -pipe -mpreferred-stack-boundary=2 -march=i686   -nostdinc -iwithpre
fix include    -DKBUILD_BASENAME=version   -c -o version.o version.c
   ld -m elf_i386  -r -o init.o main.o version.o do_mounts.o
make[1]: Leaving directory `/home/krikeb/lsm-2.5/init'
  ld -m elf_i386 -T arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/
i386/kernel/init_task.o init/init.o --start-group arch/i386/kernel/kernel.o arch
/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o security/built-in.o /hom
e/krikeb/lsm-2.5/arch/i386/lib/lib.a lib/lib.a /home/krikeb/lsm-2.5/arch/i386/li
b/lib.a drivers/built-in.o sound/sound.o arch/i386/pci/pci.o net/network.o --end
-group -o vmlinux
security/built-in.o: In function `selopt_init':
security/built-in.o(.text.init+0x186): undefined reference to `selopt_cache_exit'
security/built-in.o(.text.init+0x18b): undefined reference to `selopt_perimtab_e
xit'
security/built-in.o(.text.init+0x190): undefined reference to `flnetlink_exit'
security/built-in.o(.text.init+0x1bd): undefined reference to `selopt_queue_exit
'
security/built-in.o(.text.init+0x1c2): undefined reference to `selopt_cache_exit
'
security/built-in.o(.text.init+0x1c7): undefined reference to `selopt_perimtab_e
xit'
security/built-in.o(.text.init+0x1cc): undefined reference to `flnetlink_exit'
make: *** [vmlinux] Error 1

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
