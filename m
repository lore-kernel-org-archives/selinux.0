Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2RLsgx6027231
	for <selinux@tycho.nsa.gov>; Thu, 27 Mar 2003 16:54:42 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h2RLp9lY013867
	for <selinux@tycho.nsa.gov>; Thu, 27 Mar 2003 21:51:09 GMT
Received: from chris.pebenito.dhs.org (12-251-184-225.client.attbi.com [12.251.184.225] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id h2RLp8KX013704
	for <selinux@tycho.nsa.gov>; Thu, 27 Mar 2003 21:51:08 GMT
Subject: kernel compile failure
From: "Christopher J. PeBenito" <pebenito@ieee.org>
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-h5hGCp/eMixldV5Vz7fT"
Message-Id: <1048801964.1692.286.camel@chris.pebenito.net>
Mime-Version: 1.0
Date: 27 Mar 2003 15:52:45 -0600
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-h5hGCp/eMixldV5Vz7fT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I patched a stock 2.4.20 kernel with the 2003011510 lsm and selinux
patches from the NSA site.  The compile fails right at the end with a
linker error (.config attached):

make[1]: Leaving directory `/usr/src/linux-2.4.20-selinux-r2/net'
ld -m elf_i386 -T /usr/src/linux-2.4.20-selinux-r2/arch/i386/vmlinux.lds
-e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o
init/main.o init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o security/vmlinux-obj.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o drivers/ide/idedriver.o
drivers/cdrom/driver.o drivers/pci/driver.o drivers/pnp/pnp.o
drivers/video/video.o \
        net/network.o \
        /usr/src/linux-2.4.20-selinux-r2/arch/i386/lib/lib.a
/usr/src/linux-2.4.20-selinux-r2/lib/lib.a
/usr/src/linux-2.4.20-selinux-r2/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
kernel/kernel.o(.text+0xbf34): In function `sys_acct':
: undefined reference to `security_acct'
make: *** [vmlinux] Error 1


This config has worked on previous revisions of the patches.  Ideas?

-- 
Christopher J. PeBenito <pebenito@ieee.org>

--=-h5hGCp/eMixldV5Vz7fT
Content-Disposition: attachment; filename=kernel.config.gz
Content-Type: application/x-gzip; name=kernel.config.gz
Content-Transfer-Encoding: base64

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

--=-h5hGCp/eMixldV5Vz7fT--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
