Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i54C8prT019083
	for <selinux@tycho.nsa.gov>; Fri, 4 Jun 2004 08:08:51 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i54K3L8m027641
	for <selinux@tycho.nsa.gov>; Fri, 4 Jun 2004 16:03:21 -0400 (EDT)
Subject: Re: issue with SE/Linux - sshd not giving access to /dev/pts/[n]
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <200406042132.40136.russell@coker.com.au>
References: <20040601090345.GM8312@lkcl.net>
	 <1086266468.17657.19.camel@moss-spartans.epoch.ncsc.mil>
	 <1086268467.17657.53.camel@moss-spartans.epoch.ncsc.mil>
	 <200406042132.40136.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1086350914.19959.52.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 04 Jun 2004 08:08:34 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-06-04 at 07:32, Russell Coker wrote:
> It seems to me that pam_selinux is not going to do what we want.
> 
> We have to split the module into two parts to get the desired behaviour.

For people who haven't followed that discussion (started on
fedora-selinux-list), the issue is that pam_selinux can have side
effects on other pam session modules in the pam stack (since it sets the
exec context for the user and relabels the pty/tty), so it needs to run
last upon pam_open_session and first upon pam_close_session.  The only
way to ensure that ordering is to split pam_selinux into two pam modules
(which can be achieved logically just by introducing a module argument
to indicate the desired behavior, which is what Dan is implementing),
one for open_session and one for close_session, and bracket the pam
stack with the two entries.

>   It 
> doesn't work with sshd, and some xdm's.  Now it only works with /bin/login 
> and one xdm variant (AFAIK).

It also works for /bin/su, although even in that case, there was a
problem (inability to re-open tty since fsuid has already been changed
by su) that resulted in dropping the re-opening of stdin/out/err by
pam_selinux to get the descriptors into the right type.

> I think that we are taking the wrong approach to this and we should give up 
> and just patch the applications?

Quite possibly.  An alternative would be to continue using pam_selinux
for setting the exec context for sshd but add a patch for relabeling the
pty, and just pass the nottys option to pam_selinux in the sshd pam
configuration to disable the tty relabeling for it.  This would still
require bracketing the pam stack with the close_session and open_session
cases to avoid side effects.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
