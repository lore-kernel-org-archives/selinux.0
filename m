Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k459EPGt012511
	for <selinux@tycho.nsa.gov>; Fri, 5 May 2006 05:14:25 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k459EMU3020933
	for <selinux@tycho.nsa.gov>; Fri, 5 May 2006 09:14:23 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Valdis.Kletnieks@vt.edu
Subject: Re: pam_namespace
Date: Fri, 5 May 2006 19:14:20 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <200605051623.25533.russell@coker.com.au> <200605050750.k457oPp6014607@turing-police.cc.vt.edu>
In-Reply-To: <200605050750.k457oPp6014607@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200605051914.24123.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 05 May 2006 17:50, Valdis.Kletnieks@vt.edu wrote:
> On Fri, 05 May 2006 16:23:22 +1000, Russell Coker said:
> > I was just playing with pam_namespace.  It seems to me that the current
> > setup of having tmp/tmp.inst-$USER- does not provide adequate protection.
> >  A process that is hostile to the user and which runs in the system name
> > space (EG any cracked daemon) can access the user's instance of /tmp.
>
> Not if /tmp/tmp.inst-$USER has an SELinux context on it that the daemon
> isn't able to read.  Of course, this has it's own issues, since the parent
> and instance directories have different SELinux contexts.

Yes, which of course means that programs the user runs in different domains 
will need modified policy to allow creation of temp files.  This isn't 
impossible but does have other issues including the fact that such programs 
will be able to create /tmp/dir/file where /tmp/dir is a directory created by 
the user, this may not be desired.

Setting a range on the per-user tmp directory that matches the range of their 
login process makes some sense.  But using a type other than tmp_t does not 
make sense to me.

Also we want the namespace feature to work on non-SE systems where the option 
of a different SE Linux context is not available.

Why do you object to the idea of using a sub-directory for this?

> case $1 in
>      /tmp)
>         if [ ! -d ${2}/.X11-unix ];
>         then
>                 mkdir ${2}/.X11-unix
>                 chcon --reference=${1}/.X11-unix  ${2}/.X11-unix
>         fi
>
> (and then hardlink the socket already open by GDM into that directory so
> the user's X session can find it).  This however still loses, because at
> this point we're already running in the user's SELinux context, so we
> probably can't do the chcon.  Janak was going to look at setexeccon() games
> so the script can do setup that the user can't....

Why can't we have a script run in system context?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
