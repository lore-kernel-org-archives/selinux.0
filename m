Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA17716
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2001 19:49:18 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id AAA04207
	for <selinux@tycho.nsa.gov>; Sat, 1 Dec 2001 00:49:17 GMT
Received: from tabby.cats-chateau.net (adsl-204-0-249-112.corp.se.verio.net [204.0.249.112])
	by jazzswing.ncsc.mil  with ESMTP id AAA04203
	for <selinux@tycho.nsa.gov>; Sat, 1 Dec 2001 00:49:16 GMT
From: Jesse Pollard <jesse@cats-chateau.net>
To: Tom <tom@lemuria.org>, selinux@tycho.nsa.gov
Subject: Re: Fwd: Re: SE Linux packages of login, sshd, tar, stat, findutils, fileutils, and [xkg]dm
Date: Fri, 30 Nov 2001 18:46:36 -0600
References: <1BF4DDD78DDA5D4EB0769BEA7F158E5A6F384C@amcw2ms812.amc.ds.af.mil> <20011130200644.BDF4535FC98@lyta.coker.com.au> <20011130231736.A1680@lemuria.org>
In-Reply-To: <20011130231736.A1680@lemuria.org>
MIME-Version: 1.0
Message-Id: <01113018463600.12763@tabby>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 30 November 2001 16:17, Tom wrote:
> On Fri, Nov 30, 2001 at 08:13:14PM +0100, Russell Coker wrote:
> > Yes.  Sun is the only vendor I've come across that ships packages that
> > mess with /usr/local.  They seem to think that a Sun package of bash for
> > Solaris 2.6 (distributed from a Sun web site) should install to
> > /usr/local/bin while a package for Solaris 8.0 (distributed on the
> > install CDs) should be in /bin. This sort of thing really sucks when you
> > are trying to manage a network.
>
> OpenBSD also does this. bash is in /usr/local/bin even though it's not
> a port or a 3rd party piece, but an official package.
>
> I agree on that not being good practice. I don't know that rationale
> for these, though.

I can give a rationale, but can't promise it as the real one...

These "packages" are NOT part of Solaris. They are "contributed" packages
that may not be upgraded, may not be patched, nor are they required to even
work.

The /bin and friends are part of Solaris. If they cause security problems, 
then Sun is obliged to provide patches/updates. Not so for /usr/local. If 
theres a problem, you remove or don't install them.

The stuff in /usr/local is not contractually maintained....


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
