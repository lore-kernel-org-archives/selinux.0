Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9LEjIWt027134
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 10:45:18 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9LEjHIE028113
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 14:45:17 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
        by jazzband.ncsc.mil  with ESMTP id h9LEi21J028054 for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 14:45:16 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: init patch for loading policy
Date: Wed, 22 Oct 2003 00:43:09 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200310200148.15852.russell@coker.com.au> <200310211052.28494.russell@coker.com.au> <1066739366.27065.39.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1066739366.27065.39.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310220043.09925.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 21 Oct 2003 22:29, Stephen Smalley wrote:
> On Mon, 2003-10-20 at 20:52, Russell Coker wrote:
> > Firstly we would need to test that init will actually respond correctly
> > to "telinit u" while it's in that stage.  This is something I am
> > concerned about, particularly regarding race conditions regarding the
> > completion of rc.sysinit (although I guess it's unlikely that rc.sysinit
> > will complete before init restarts).
>
> Note that I subsequently suggested (in a reply to Dan on the list) using
> a separate sysinit entry with its own script for performing the initial
> policy load and restarting init, followed by the ordinary sysinit entry
> (or alternately, a bootwait entry if you can't ensure ordering among
> multiple sysinit entries) that executes rc.sysinit.

OK, I've done some tests of this.  "telinit u" does not work before the 
rc.sysinit script is complete (no read-write file system for communication).

This means that init will be in kernel_t for the duration of rc.sysinit which 
means that some domains will need to send sigchld to kernel_t (syslogd_t is 
one example, but there are others, and some of them are conditional upon the 
system configuration - I may have to allow all daemon domains to send sigchld 
to kernel_t).

init needs to create /dev/initctl as kernel_t, and it locks the utmp file and 
opens wtmp for writing before it can be signalled to re-exec itself.

#!/bin/bash
mount -n /selinux
/usr/sbin/load_policy /etc/security/selinux/policy.15
exec /etc/rc.d/rc.sysinit

I put the above in /etc/rc.d/rc.sysinit.selinux and made init run that instead 
of /etc/rc.d/rc.sysinit.selinux.  When rc.sysinit is exec'd it will be in 
initrc_t as I have put in the following policy:
domain_auto_trans(kernel_t, initrc_exec_t, initrc_t)

One final problem I have not solved yet is messages such as:
avc:  denied  { use } for  pid=391 exe=/usr/sbin/updfstab path=/dev/console 
dev=62:00 ino=160079 scontext=system_u:system_r:updfstab_t 
tcontext=system_u:system_r:kernel_t tclass=fd

I modified rc.sysinit so that when it re-runs itself through /sbin/initlog it 
redirects stdin, stdout, and stderr to /dev/console (thus the three main file 
handles only need to be inherited from initrc_t).  But that doesn't help.  
The results I have so far indicate that this approach has significant 
problems.

Diverting /sbin/init with a shell script works better than this.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
