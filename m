Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j11Kph53018543
	for <selinux@tycho.nsa.gov>; Tue, 1 Feb 2005 15:51:43 -0500 (EST)
Received: from orsfmr002.jf.intel.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j11KphYD001497
	for <selinux@tycho.nsa.gov>; Tue, 1 Feb 2005 20:51:44 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Advice on bringing up SE Linux
Date: Tue, 1 Feb 2005 12:51:28 -0800
Message-ID: <60C14C611F1DDD4198D53F2F43D8CA3B035B559E@orsmsx410>
From: "Villalovos, John L" <john.l.villalovos@intel.com>
To: "Stephen Smalley" <sds@epoch.ncsc.mil>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> Actually, cat is quite likely to fail, as it likely tries to read and
> write the file in chunks, whereas the kernel wants the entire policy
> pushed in a single transaction.  load_policy is what you want.
> 
> /sbin/init is what normally loads the policy during startup.  Are you
> using the modified /sbin/init (included in Fedora)?  What is in your
> /etc/selinux/config?

Okay.  We are using Busybox for the init.  So it does not have the SE
Linux stuff in it.

I will try to get load_policy compiled for Xscale and give it a shot.

Thanks,
John


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
