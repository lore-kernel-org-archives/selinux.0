Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA16124
	for <selinux@tycho.nsa.gov>; Thu, 16 Jan 2003 13:29:22 -0500 (EST)
From: j.logsdon@lancaster.ac.uk
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA29589
	for <selinux@tycho.nsa.gov>; Thu, 16 Jan 2003 18:26:35 GMT
Received: from parmenides.zen.co.uk (parmenides.zen.co.uk [212.23.8.69])
	by jazzswing.ncsc.mil  with SMTP id SAA29584
	for <selinux@tycho.nsa.gov>; Thu, 16 Jan 2003 18:26:34 GMT
Received: from localhost (j.logsdon@localhost)
	by quantex-research.com (8.8.7/8.8.7) with ESMTP id SAA06324
	for <selinux@tycho.nsa.gov>; Thu, 16 Jan 2003 18:29:18 GMT
Date: Thu, 16 Jan 2003 18:29:18 +0000 (GMT)
To: selinux@tycho.nsa.gov
Subject: RH 7.3 compile problem
Message-ID: <Pine.LNX.4.10.10301161824260.23718-100000@mercury.quantex>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi

I am new to SELinux and I downloaded the 'everything' option and followed
the instructions for a quickinstall (well I wanted to get going fast!).

I am using RH7.3 in fact with the openMosix kernel (yes I know it won't
work anyway but I will need to reboot ...).  Towards what I think is the
end of the compilation, it aborted with the following messages:

gcc -D__KERNEL__ -I/usr/local/rpm-tgzs/selinux/lsm-2.4/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686
-nostdinc -iwithprefix include -DKBUILD_BASENAME=tty_io  -DEXPORT_SYMTAB
-c tty_io.c
tty_io.c: In function `release_mem':
tty_io.c:1040: Internal error: Segmentation fault.
Please submit a full bug report.
See <URL:http://bugzilla.redhat.com/bugzilla/> for instructions.
make[4]: *** [tty_io.o] Error 2
make[4]: Leaving directory
`/usr/local/rpm-tgzs/selinux/lsm-2.4/drivers/char'
make[3]: *** [first_rule] Error 2
make[3]: Leaving directory
`/usr/local/rpm-tgzs/selinux/lsm-2.4/drivers/char'
make[2]: *** [_subdir_char] Error 2
make[2]: Leaving directory `/usr/local/rpm-tgzs/selinux/lsm-2.4/drivers'
make[1]: *** [_dir_drivers] Error 2
make[1]: Leaving directory `/usr/local/rpm-tgzs/selinux/lsm-2.4'
make: *** [quickinstall] Error 2

I  haven't reported it to bugzilla since it is not the latest RH anyway
but has anyone a clue as to why the compilation should cough pm tty_io?  I
can furnish other information if needed.

TIA

John


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
