Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA18846
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2001 10:32:57 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA17226
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2001 14:32:50 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id OAA17222
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2001 14:32:50 GMT
Date: Mon, 11 Jun 2001 10:31:35 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Emily Ratliff <ratliff@austin.ibm.com>
cc: selinux@tycho.nsa.gov
Subject: Re: setting up selinux
In-Reply-To: <Pine.LNX.4.33L2.0106081735430.12933-100000@spiff.austin.ibm.com>
Message-ID: <Pine.SOL.3.95.1010611102221.23164O-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 8 Jun 2001, Emily Ratliff wrote:

> Here is the relevant output from the compile:
> 
> make[4]: Entering directory `/usr/src/slinux/kernel-2.4/drivers/scsi/aic7xxx'
> make -C aicasm
> make[5]: Entering directory `/usr/src/slinux/kernel-2.4/drivers/scsi/aic7xxx/aicasm'
> yacc -d aicasm_gram.y
> mv -f y.tab.c aicasm_gram.c
> lex  -t aicasm_scan.l > aicasm_scan.c
> gcc -I/usr/include -ldb1 aicasm_gram.c aicasm_scan.c aicasm.c
> aicasm_symbol.c -o aicasm
> aicasm_symbol.c:39:20: db1/db.h: No such file or directory

This doesn't look like it is related to SELinux in any way.  
The db1/db.h header file should exist in your /usr/include
directory, as it does on my RedHat 7.1 system.  I tried
rebuilding the SELinux kernel with this driver enabled, and
did not encounter this error.

When you say that you were able to build an unpatched kernel,
do you mean the unmodified 2.4.3 sources from www.kernel.org?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
