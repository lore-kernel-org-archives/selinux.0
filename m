Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA21113
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2001 16:46:08 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA06363
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2001 20:46:01 GMT
Received: from mg03.austin.ibm.com (mg03.austin.ibm.com [192.35.232.20])
	by jazzband.ncsc.mil  with ESMTP id UAA06359
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2001 20:46:00 GMT
Date: Mon, 11 Jun 2001 15:48:55 -0500 (CDT)
From: Emily Ratliff <ratliff@austin.ibm.com>
To: Hubertus Franke <frankeh@us.ibm.com>
cc: Stephen Smalley <sds@tislabs.com>, <selinux@tycho.nsa.gov>
Subject: Re: setting up selinux
In-Reply-To: <OF8F61C8C5.B91B84A0-ON85256A68.006DADCC@pok.ibm.com>
Message-ID: <Pine.LNX.4.33L2.0106111539590.9097-100000@spiff.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Hubertus,

I tried that to no avail. It turns out that the problem is that the
machine has glibc-devel-2.2.2 rather than glibc-devel-2.1.3, so rather
than having /usr/include/db1 I have /usr/include/db3 .

The real root of this problem is that without thinking too much about it,
I tried this on Mandrake 8.0 rather than RedHat. I'll switch over to
RedHat.

Emily


On Mon, 11 Jun 2001, Hubertus Franke wrote:
>
> Try to do a full "make mrproper" again.
>
> Hubertus Franke
> Enterprise Linux Group (Mgr),  Linux Technology Center (Member Scalability)
> , OS-PIC (Chair)
> email: frankeh@us.ibm.com
> (w) 914-945-2003    (fax) 914-945-4425   TL: 862-2003
>
>
>
> Stephen Smalley <sds@tislabs.com>@tycho.nsa.gov on 06/11/2001 10:31:35 AM
>
> Sent by:  owner-selinux@tycho.nsa.gov
>
>
> To:   Emily Ratliff <ratliff@austin.ibm.com>
> cc:   selinux@tycho.nsa.gov
> Subject:  Re: setting up selinux
>
>
>
>
> On Fri, 8 Jun 2001, Emily Ratliff wrote:
>
> > Here is the relevant output from the compile:
> >
> > make[4]: Entering directory
> `/usr/src/slinux/kernel-2.4/drivers/scsi/aic7xxx'
> > make -C aicasm
> > make[5]: Entering directory
> `/usr/src/slinux/kernel-2.4/drivers/scsi/aic7xxx/aicasm'
> > yacc -d aicasm_gram.y
> > mv -f y.tab.c aicasm_gram.c
> > lex  -t aicasm_scan.l > aicasm_scan.c
> > gcc -I/usr/include -ldb1 aicasm_gram.c aicasm_scan.c aicasm.c
> > aicasm_symbol.c -o aicasm
> > aicasm_symbol.c:39:20: db1/db.h: No such file or directory
>
> This doesn't look like it is related to SELinux in any way.
> The db1/db.h header file should exist in your /usr/include
> directory, as it does on my RedHat 7.1 system.  I tried
> rebuilding the SELinux kernel with this driver enabled, and
> did not encounter this error.
>
> When you say that you were able to build an unpatched kernel,
> do you mean the unmodified 2.4.3 sources from www.kernel.org?
>
> --
> Stephen D. Smalley, NAI Labs
> ssmalley@nai.com
>
>
>
>
>
>
> --
> You have received this message because you are subscribed to the selinux
> list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.
>
>
>


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
