Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA13323
	for <selinux@tycho.nsa.gov>; Fri, 8 Jun 2001 18:38:21 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA19573
	for <selinux@tycho.nsa.gov>; Fri, 8 Jun 2001 22:38:15 GMT
Received: from mg03.austin.ibm.com (mg03.austin.ibm.com [192.35.232.20])
	by jazzband.ncsc.mil  with ESMTP id WAA19557
	for <selinux@tycho.nsa.gov>; Fri, 8 Jun 2001 22:38:14 GMT
Received: from austin.ibm.com (netmail1.austin.ibm.com [9.53.250.96])
	by mg03.austin.ibm.com (AIX4.3/8.9.3/8.9.3) with ESMTP id RAA34958
	for <selinux@tycho.nsa.gov>; Fri, 8 Jun 2001 17:39:24 -0500
Received: from spiff.austin.ibm.com (spiff.austin.ibm.com [9.53.216.123])
	by austin.ibm.com (AIX4.3/8.9.3/8.9.3) with ESMTP id RAA39268
	for <selinux@tycho.nsa.gov>; Fri, 8 Jun 2001 17:38:18 -0500
Date: Fri, 8 Jun 2001 17:41:08 -0500 (CDT)
From: Emily Ratliff <ratliff@austin.ibm.com>
To: <selinux@tycho.nsa.gov>
Subject: Re: setting up selinux
In-Reply-To: <Pine.SOL.3.95.1010608152411.15810N-100000@clipper.gw.tislabs.com>
Message-ID: <Pine.LNX.4.33L2.0106081735430.12933-100000@spiff.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I'm having a problem compiling SELinux. The machine has an Adaptec 7899P
SCSI controller, so I have configured that in, but the SELinux compile is
barfing on it. I would suspect a problem with that code, except that when
I copy the .config file over to an unpatched kernel and compile that after
running make oldconfig, the compile completes beautifully.

Here is the relevant output from the compile:

make[4]: Entering directory `/usr/src/slinux/kernel-2.4/drivers/scsi/aic7xxx'
make -C aicasm
make[5]: Entering directory `/usr/src/slinux/kernel-2.4/drivers/scsi/aic7xxx/aicasm'
yacc -d aicasm_gram.y
mv -f y.tab.c aicasm_gram.c
lex  -t aicasm_scan.l > aicasm_scan.c
gcc -I/usr/include -ldb1 aicasm_gram.c aicasm_scan.c aicasm.c
aicasm_symbol.c -o aicasm
aicasm_symbol.c:39:20: db1/db.h: No such file or directory
make[5]: *** [aicasm] Error 1
make[5]: Leaving directory `/usr/src/slinux/kernel-2.4/drivers/scsi/aic7xxx/aicasm'
make[4]: *** [aicasm/aicasm] Error 2
make[4]: Leaving directory `/usr/src/slinux/kernel-2.4/drivers/scsi/aic7xxx'
make[3]: *** [first_rule] Error 2
make[3]: Leaving directory `/usr/src/slinux/kernel-2.4/drivers/scsi/aic7xxx'
make[2]: *** [_subdir_aic7xxx] Error 2
make[2]: Leaving directory `/usr/src/slinux/kernel-2.4/drivers/scsi'
make[1]: *** [_subdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/slinux/kernel-2.4/drivers'
make: *** [_dir_drivers] Error 2


Any suggestions?

Thanks,

Emily


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
