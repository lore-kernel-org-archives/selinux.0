Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6FL9UHa020344
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 17:09:30 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6FL8TnJ019494
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 21:08:29 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h6FL8Thr019491
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 21:08:29 GMT
Subject: Re: [patch] pass linker soname flag for libselinux, autotools
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@verbum.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1058157786.9620.38.camel@columbia>
References: <1058157786.9620.38.camel@columbia>
Content-Type: text/plain
Message-Id: <1058303367.13738.818.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 15 Jul 2003 17:09:28 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-07-14 at 00:43, Colin Walters wrote:
> The symlink was there in the package, so I started looking at the
> library SONAME, and I eventually figured out the magic -Wl,-soname flag
> was missing.  Apparently this encodes the soname into the file.
> 
> A patch is attached which fixes this problem.

This patch has been merged into the sourceforge CVS tree.

> This does remind me though; has any consideration been given to
> autotoolizing the various packages?  That would have fixed the CFLAGS
> issue I ran into earlier, and libtool knows all about the magic needed
> to create shared libraries.  Plus you automatically get support for lots
> of nice things like testing for installed software, regression tests,
> etc.  I'd be willing to put a bit of effort into doing the
> autotoolizing, but since this is a new set of tools you'd have to use
> upstream I'd like to see if there was interest before doing the work.

I'm not sure whether this is justified.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
