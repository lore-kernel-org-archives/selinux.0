Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7A6kcrT000859
	for <selinux@tycho.nsa.gov>; Tue, 10 Aug 2004 02:46:38 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7A6k0ET010322
	for <selinux@tycho.nsa.gov>; Tue, 10 Aug 2004 06:46:01 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: Now that SELinux supports booleans should we replace tunableswith booleans?
Date: Tue, 10 Aug 2004 16:46:32 +1000
Cc: Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov,
   Daniel J Walsh <dwalsh@redhat.com>, selinux-dev@tresys.com
References: <200404141453.i3EEr2Jx015745@gotham.columbia.tresys.com> <1091809200.8590.96.camel@moss-spartans.epoch.ncsc.mil> <1092082317.29199.205.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1092082317.29199.205.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408101646.32992.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 10 Aug 2004 06:11, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> > Under the proposed scheme, reboots and policy reloads would set the
> > booleans to the values saved in /etc/selinux/$SELINUXTYPE/booleans
> > (defaulting to the compile-time defaults if there was no value saved in
> > that file for a given boolean).  Admins would edit that file (directly
> > or using a tool) if they wanted the boolean setting to persist; if they
> > only want a temporary change that will be reverted by a reboot or policy
> > reload, then they would use setsebool to make that temporary change.
>
> Karl has suggested that while /sbin/init should use this technique for
> preserving booleans across reboots, /usr/sbin/load_policy should just
> get the current boolean settings from selinuxfs and use them for policy
> reloads, so that booleans do not change upon a policy reload by
> default.  This is to ensure that booleans that represent system state
> are not perturbed by policy reloads.  What do others think?

Sounds good.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
