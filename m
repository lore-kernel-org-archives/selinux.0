Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j11KoN53018516
	for <selinux@tycho.nsa.gov>; Tue, 1 Feb 2005 15:50:23 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Advice on bringing up SE Linux
Date: Tue, 1 Feb 2005 12:50:23 -0800
Message-ID: <60C14C611F1DDD4198D53F2F43D8CA3B035B5599@orsmsx410>
From: "Villalovos, John L" <john.l.villalovos@intel.com>
To: "Stephen Smalley" <sds@epoch.ncsc.mil>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> Any output in /var/log/messages from the attempt to write the policy
> to /selinux/load?  Any difference if you run load_policy on the binary
> policy instead of directly cat'ing it?
> 
> A lot has changed in SELinux since 2.6.5, so you really need
> to move to
> a newer kernel if you want to seriously use it.

Thanks.  We will be moving to a different development board shortly so
hopefully we will be able to move to the latest kernel.

I will work on trying to get load_policy compiled up for what we have
going and see if I can get it to work that way.

Thanks again,
John


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
