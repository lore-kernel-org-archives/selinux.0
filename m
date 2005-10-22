Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9MD2oNs022938
	for <selinux@tycho.nsa.gov>; Sat, 22 Oct 2005 09:02:50 -0400 (EDT)
Received: from mail.nagafix.co.uk (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9MCxDM0004803
	for <selinux@tycho.nsa.gov>; Sat, 22 Oct 2005 12:59:13 GMT
Subject: run_init: Fork:: No such file or directory
From: Antoine Martin <antoine@nagafix.co.uk>
To: SELinux <selinux@tycho.nsa.gov>
Cc: wsalamon@tislabs.com, dwalsh@redhat.com
Content-Type: text/plain
Date: Sat, 22 Oct 2005 13:59:31 +0100
Message-Id: <1129985971.31615.31.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I've been running a system with SELinux enforcing mode for some time
(Gentoo x86), but since yesterday I can't seem to use run_init to start
daemons, it fails with:
Fork:: No such file or directory

When I straced it, I found that it is failing to open /dev/ptmx|pty?? :
open("/dev/ptmx", O_RDWR)               = -1 EIO (Input/output error)
open("/dev/ptyp0", O_RDWR)              = -1 ENXIO (No such device or
address)
open("/dev/ptyp1", O_RDWR)              = -1 ENXIO (No such device or
address)
(...)
open("/dev/ptyef", O_RDWR)              = -1 ENXIO (No such device or
address)
dup(2)                                  = 3
fcntl64(3, F_GETFL)                     = 0x2 (flags O_RDWR)
brk(0)                                  = 0x804b000
brk(0x806c000)                          = 0x806c000
fstat64(3, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 1), ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb7f17000
_llseek(3, 0, 0xbfc256e4, SEEK_CUR)     = -1 ESPIPE (Illegal seek)
write(3, "Fork:: No such file or directory"..., 33Fork:: No such file or
directory
) = 33
close(3)                                = 0
munmap(0xb7f17000, 4096)                = 0
exit_group(71)                          = ?

Obviously, the devices are there and I'm not using devfs (kernel
2.6.13.4) /dev is static on ext3 /.
I am really stumped. I've tried rebuilding it, rebuilding the libraries
it depends on, switched to non-enforcing mode, etc.. No luck
Any ideas would be much appreciated.

Thanks
Antoine



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
