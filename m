Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA06186
	for <selinux@tycho.nsa.gov>; Fri, 17 Jan 2003 16:42:21 -0500 (EST)
From: azeredo@qmc.ufsc.br
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0HLgMI26813
	for <selinux@tycho.nsa.gov>; Fri, 17 Jan 2003 21:42:22 GMT
Received: from quark.qmc.ufsc.br (bohr-gw.qmc.ufsc.br [150.162.31.223])
        by jazzband.ncsc.mil  with ESMTP id h0HLgLf26809 for <selinux@tycho.nsa.gov>; Fri, 17 Jan 2003 21:42:21 GMT
Received: (from wwwrun@localhost)
	by quark.qmc.ufsc.br (8.11.3/8.11.3/SuSE Linux 8.11.1-0.5) id h0HL8XG09783
	for selinux@tycho.nsa.gov; Fri, 17 Jan 2003 19:08:33 -0200
Message-ID: <1042837713.3e2870d149dd5@qmc.ufsc.br>
Date: Fri, 17 Jan 2003 19:08:33 -0200
To: selinux@tycho.nsa.gov
Subject: Problems compiling selinux release (2003011510) for 2.4.20 kernel
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


    Hi,

   I was trying to compile the updated release (2003011510) for 2.4.20 and
2.5.58 kernels on  RedHat 8.0 and using  the same config got the following error
for 2.4.20 kernel despite the fact that   it went fine for 2.5.58 kernel. 
  Has anyone run into the same problem?
        
    


make[1]: Saindo do diretório `/usr/src/lsm-2.4/arch/i386/lib'
ld -m elf_i386 -T /usr/src/lsm-2.4/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o
init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o
fs/fs.o ipc/ipc.o security/vmlinux-obj.o \
         drivers/parport/driver.o drivers/char/char.o drivers/block/block.o
drivers/misc/misc.o drivers/net/net.o drivers/media/media.o
drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o
drivers/cdrom/driver.o drivers/pci/driver.o drivers/pnp/pnp.o
drivers/video/video.o drivers/usb/usbdrv.o \
        net/network.o \
        /usr/src/lsm-2.4/arch/i386/lib/lib.a /usr/src/lsm-2.4/lib/lib.a
/usr/src/lsm-2.4/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
kernel/kernel.o: In function `sys_acct':
kernel/kernel.o(.text+0xa3b9): undefined reference to `security_acct'
make: ** [vmlinux] Erro 1



                                  Mathematics department
                                   UFSC
                                   Aldrovando Azeredo

-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
