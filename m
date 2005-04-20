Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3KN8N7C005274
	for <selinux@tycho.nsa.gov>; Wed, 20 Apr 2005 19:08:23 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3KN3YkE010445
	for <selinux@tycho.nsa.gov>; Wed, 20 Apr 2005 23:03:35 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: latest diff
Date: Wed, 20 Apr 2005 22:22:16 +1000
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
   Jim Carter <jwcart2@epoch.ncsc.mil>,
   SELinux Mail List <selinux@tycho.nsa.gov>
References: <423BCC68.3090003@redhat.com> <1111248890.5582.20.camel@chris.pebenito.net> <423C54F5.5060205@redhat.com>
In-Reply-To: <423C54F5.5060205@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200504202222.20363.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 20 March 2005 03:36, Daniel J Walsh <dwalsh@redhat.com> wrote:
> >I don't remember why hostname and consoletype were added in the first
> >place, but a quick look through them makes me think that its so we don't
> >have to give sys_admin capability to initrc_t when these programs are
> >run from init scripts.  Sys_admin is a huge set a privileges, so I'd say
> >its worthwhile to keep them around.

That's correct.  It was before the invention of unlimitedRC...

> Ok, that is what I saw.  I saw the sys_admin avc messages, but there was
> no failure in
> setting up the hostname.

I just did a quick test.  Changing the hostname without sys_admin capability 
is impossible in Fedora kernel 2.6.11-1.1240_FC4.

> they don't need it.    Problem with hostname is that lots of tools are
> doing stuff like
>
> hostname >> logfile.  Which causes hostname to need write access to
> postgress_log_t, ...

No problem, you just use can_exec(postgresql_t, hostname_exec_t) to solve 
that.

> >Shouldn't this go in the ifdef(`klogd.te',`',`  block?  Its already
> >there for syslogds that also do the klogd functions, like syslog-ng.  In
> >fact, I think that block was originally added for syslog-ng.  That
> >should eliminate the need for a boolean too.
>
> The protections are not needed for standard syslog, so I think we should
> have a boolean
> saying whether you are using standard  syslog of syslog-ng

I don't think that there is any point in such a boolean.  Gentoo (who support 
syslog-ng) don't use such booleans but use ifdef's instead.  So there is no 
benefit for Gentoo in that.  With RHEL and Fedora we don't support syslog-ng 
so there doesn't seem to be any benefit for Red Hat users.  For Debian the 
defined procedure is to remove klogd.te if you want to use syslog-ng, so 
again there is no benefit from such a boolean.

> (Targeted 
> policy does not
> ship klog.

We should ship it.  klogd has access to /proc/kmsg and /dev/mem which is to be 
restricted.  Also klogd processes data that can be manipulated by hostile 
people and should be considered as a target for attack.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
