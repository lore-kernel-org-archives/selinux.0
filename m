Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAPFxARb014431
	for <selinux@tycho.nsa.gov>; Tue, 25 Nov 2003 10:59:10 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAPFx9qY021916
	for <selinux@tycho.nsa.gov>; Tue, 25 Nov 2003 15:59:09 GMT
Received: from devserv.devel.redhat.com (pix-525-pool.redhat.com [66.187.233.200])
        by jazzband.ncsc.mil  with ESMTP id hAPFx80o021913 for <selinux@tycho.nsa.gov>; Tue, 25 Nov 2003 15:59:08 GMT
Subject: Re: Kernel panic: No init found with SE patched kernel 2.6.0-test6
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Russell Coker <russell@coker.com.au>
Cc: ZVPA2@imail.etsu.edu, selinux <selinux@tycho.nsa.gov>
In-Reply-To: <200311211704.56652.russell@coker.com.au>
References: <200311202137.AA25034968@imail.etsu.edu>
	 <200311211704.56652.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1069775932.6520.175.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Date: 25 Nov 2003 15:58:52 +0000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

On Fri, 2003-11-21 at 06:04, Russell Coker wrote:

> > mount: error 19 mounting ext3
> 
> Here we are trying to mount root and failing.  The return code 19 means the 
> following (see the mount man page):

Actually, "mount" is a nash builtin, and I think the 19 is a direct
kernel error code in that case: specifically,

#define ENODEV          19      /* No such device */

from /usr/include/asm/errno.h.  This implies that the kernel has no
device driver for the specified boot device, which could mean that we've
got a badly constructed initrd for example.

Cheers,
 Stephen


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
