Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA20896
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2001 16:02:27 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA03992
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2001 20:02:21 GMT
Received: from e4.ny.us.ibm.com ([32.97.182.104])
	by jazzband.ncsc.mil  with ESMTP id UAA03982
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2001 20:02:17 GMT
Subject: Re: setting up selinux
To: Stephen Smalley <sds@tislabs.com>
Cc: Emily Ratliff <ratliff@austin.ibm.com>, selinux@tycho.nsa.gov
Message-ID: <OF8F61C8C5.B91B84A0-ON85256A68.006DADCC@pok.ibm.com>
From: "Hubertus Franke" <frankeh@us.ibm.com>
Date: Mon, 11 Jun 2001 15:58:44 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Try to do a full "make mrproper" again.

Hubertus Franke
Enterprise Linux Group (Mgr),  Linux Technology Center (Member Scalability)
, OS-PIC (Chair)
email: frankeh@us.ibm.com
(w) 914-945-2003    (fax) 914-945-4425   TL: 862-2003



Stephen Smalley <sds@tislabs.com>@tycho.nsa.gov on 06/11/2001 10:31:35 AM

Sent by:  owner-selinux@tycho.nsa.gov


To:   Emily Ratliff <ratliff@austin.ibm.com>
cc:   selinux@tycho.nsa.gov
Subject:  Re: setting up selinux




On Fri, 8 Jun 2001, Emily Ratliff wrote:

> Here is the relevant output from the compile:
>
> make[4]: Entering directory
`/usr/src/slinux/kernel-2.4/drivers/scsi/aic7xxx'
> make -C aicasm
> make[5]: Entering directory
`/usr/src/slinux/kernel-2.4/drivers/scsi/aic7xxx/aicasm'
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
You have received this message because you are subscribed to the selinux
list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
