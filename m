Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h69H0OHa024893
	for <selinux@tycho.nsa.gov>; Wed, 9 Jul 2003 13:00:24 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h69H0MH5010686
	for <selinux@tycho.nsa.gov>; Wed, 9 Jul 2003 17:00:22 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
        by jazzband.ncsc.mil  with ESMTP id h69H0KRX010667 for <selinux@tycho.nsa.gov>; Wed, 9 Jul 2003 17:00:21 GMT
Subject: Re: context trouble with 2.5 bits
From: Colin Walters <walters@verbum.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1057752105.13738.10.camel@moss-huskers.epoch.ncsc.mil>
References: <1057701768.25921.53.camel@columbia>
	 <1057752105.13738.10.camel@moss-huskers.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1057769928.28674.134.camel@columbia>
Mime-Version: 1.0
Date: 09 Jul 2003 12:58:48 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-07-09 at 08:01, Stephen Smalley wrote:

> Did you remember to mount selinuxfs on /selinux, as described in the
> selinux-doc README?  Otherwise, the daemons cannot obtain security
> policy decisions from the kernel, such as the new label for the tty.

Yes, I've done that.

> Verify that execcon or runcon work for you, e.g.
> 	execcon root:sysadm_r:sysadm_t bash

It seems to work fine; my context is correct afterwards.

> If so, then you need to verify that your login patch is properly calling
> setexeccon() with a legitimate user context prior to exec'ing the shell
> and that the call is not failing.

Ok, thanks for the hint, I'll double check that.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
