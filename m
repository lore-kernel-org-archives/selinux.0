Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i68990rT011771
	for <selinux@tycho.nsa.gov>; Thu, 8 Jul 2004 05:09:01 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6898wEg024295
	for <selinux@tycho.nsa.gov>; Thu, 8 Jul 2004 09:08:58 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: SELinux on Debian (Sid), second try
Date: Thu, 8 Jul 2004 19:08:55 +1000
Cc: Magnus Therning <magnus-work@therning.org>, selinux@tycho.nsa.gov
References: <20040624163900.GB3290@philips.com> <20040630082935.GK1688@philips.com> <1089216339.1774.83.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1089216339.1774.83.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200407081908.55042.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 8 Jul 2004 02:05, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> selinuxfs is mounted by /sbin/init for the initial policy load these
> days, so it is no longer necessary (or useful) to add it to fstab and it
> won't show up in mtab.

I think that it is useful to have it in /etc/fstab.  Then if you are booting 
with init=/bin/bash to recover a system it's slightly less inconvenient.

With a "noauto" option in the fstab file and no permission to mount it twice 
there shouldn't be any problems.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
