Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9LG0jWt027645
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 12:00:45 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9LG0iIE002943
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 16:00:44 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
        by jazzband.ncsc.mil  with ESMTP id h9LG0h1J002920 for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 16:00:43 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: init patch for loading policy
Date: Wed, 22 Oct 2003 02:00:35 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200310200148.15852.russell@coker.com.au> <200310220043.09925.russell@coker.com.au> <1066748352.27065.100.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1066748352.27065.100.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310220200.35514.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 22 Oct 2003 00:59, Stephen Smalley wrote:
> On Tue, 2003-10-21 at 10:43, Russell Coker wrote:
> > The results I have so far indicate that this approach has significant
> > problems.
> >
> > Diverting /sbin/init with a shell script works better than this.
>
> Ok, thanks for looking into it.  So what exactly is the problem with
> diverting /sbin/init again?

No insurmountable problem.  I have the following script as /sbin/init, I have 
the real init as /sbin/init.real, and I modified the telinit sym-link 
accordingly.  It seems that init gets re-exec'd for some reason I'm still not 
sure about.  That means that bash gets run in init_t and wants some extra 
access.  But that's not significant.

Diverting /sbin/init may be our best option.

allow init_t devtty_t:chr_file { read write };
allow init_t proc_t:file { read };


#!/bin/sh

if [ ! -d /proc/1 ]; then
  mount -n /proc
fi
grep -q selinuxfs /proc/filesystems || exec /sbin/init.real "$@"
if [ ! -f /selinux/enforce ]; then
  mount -n /selinux
  /usr/sbin/load_policy /etc/security/selinux/policy.15
  if [ -f /selinux/enforce ]; then
    echo 1 > /selinux/enforce
  else
    echo "Can't set enforcing mode"
  fi
fi
exec /sbin/init.real "$@"


-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
