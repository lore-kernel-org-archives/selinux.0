Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA04079
	for <selinux@tycho.nsa.gov>; Fri, 26 Oct 2001 19:02:59 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id XAA25731
	for <selinux@tycho.nsa.gov>; Fri, 26 Oct 2001 23:02:25 GMT
Received: from hwembaz0021.cas.honeywell.com (hwembaz0021.cas.honeywell.com [129.239.31.124])
	by jazzband.ncsc.mil  with ESMTP id XAA25727
	for <selinux@tycho.nsa.gov>; Fri, 26 Oct 2001 23:02:24 GMT
Message-ID: <4B2A46240C7CD311830C0090279C31E301D780EB@az15m09.iac.honeywell.com>
From: "White, Tom (AZ15)" <tom.white@honeywell.com>
To: Stephen Smalley <sds@tislabs.com>
Cc: selinux@tycho.nsa.gov
Subject: RE: Problems with install
Date: Fri, 26 Oct 2001 16:10:25 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am installing this on a P200 and I went into the kernel config and changed
this, and included my NIC drivers. I am in the process of building again. I
will let you know how this turns out. Thanks again.

-----Original Message-----
From: Stephen Smalley [mailto:sds@tislabs.com]
Sent: Friday, October 26, 2001 2:49 PM
To: White, Tom (AZ15)
Cc: selinux@tycho.nsa.gov
Subject: RE: Problems with install



On Fri, 26 Oct 2001, White, Tom (AZ15) wrote:

> make: *** [policy] Illegal instruction (core dumped)

Check the Processor type in your kernel configuration.  If you left it set
for the default (Pentium III) and your machine is something older, then
you'll encounter this problem.  Also, while you're doing that, make sure
that you enabled the driver for your network card, since people often
forget to do that (most aren't enabled in the default configuration).
Then, prior to rebuilding in the lsm tree, cd to
selinux/module/selinux_plug/ss and remove *.cp.o and checkpolicy.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
