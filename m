Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id EAA18662
	for <selinux@tycho.nsa.gov>; Sat, 1 Dec 2001 04:01:06 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id JAA18815
	for <selinux@tycho.nsa.gov>; Sat, 1 Dec 2001 09:01:05 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id JAA18811
	for <selinux@tycho.nsa.gov>; Sat, 1 Dec 2001 09:01:02 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Jesse Pollard <jesse@cats-chateau.net>, selinux@tycho.nsa.gov
Subject: Re: Fwd: Re: SE Linux packages of login, sshd, tar, stat, findutils, fileutils, and [xkg]dm
Date: Sat, 1 Dec 2001 10:00:45 +0100
References: <1BF4DDD78DDA5D4EB0769BEA7F158E5A6F384C@amcw2ms812.amc.ds.af.mil> <20011130231736.A1680@lemuria.org> <01113018463600.12763@tabby>
In-Reply-To: <01113018463600.12763@tabby>
MIME-Version: 1.0
Message-Id: <20011201090046.5F55316F80@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 1 Dec 2001 01:46, Jesse Pollard wrote:
> > > Yes.  Sun is the only vendor I've come across that ships packages that
> > > mess with /usr/local.  They seem to think that a Sun package of bash
> > > for Solaris 2.6 (distributed from a Sun web site) should install to
> > > /usr/local/bin while a package for Solaris 8.0 (distributed on the
> > > install CDs) should be in /bin. This sort of thing really sucks when
> > > you are trying to manage a network.
> >
> > OpenBSD also does this. bash is in /usr/local/bin even though it's not
> > a port or a 3rd party piece, but an official package.
> >
> > I agree on that not being good practice. I don't know that rationale
> > for these, though.
>
> I can give a rationale, but can't promise it as the real one...
>
> These "packages" are NOT part of Solaris. They are "contributed" packages
> that may not be upgraded, may not be patched, nor are they required to even
> work.
>
> The /bin and friends are part of Solaris. If they cause security problems,
> then Sun is obliged to provide patches/updates. Not so for /usr/local. If
> theres a problem, you remove or don't install them.
>
> The stuff in /usr/local is not contractually maintained....

When an important security related package such as syslogd has a bug that 
allows it to be killed by users (or remotely killed if listening to the 
network) it's still not serious enough for Sun to fix it.  Solaris 2.6 
syslogd has been known as buggy for years and Sun have announced plans to 
never fix it.

I'm sure that the contrib packages will get updated when there's an upstream 
fix for a security issue.

I can't see any difference between the packages for /bin and the packages for 
/usr/local/bin in this regard.  If anything the ones in /usr/local/bin have 
better support I think.

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
