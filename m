Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA23257
	for <selinux@tycho.nsa.gov>; Tue, 23 Jul 2002 11:05:24 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA13376
	for <selinux@tycho.nsa.gov>; Tue, 23 Jul 2002 15:03:52 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id PAA13366 for <selinux@tycho.nsa.gov>; Tue, 23 Jul 2002 15:03:51 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: selinux question
Date: Tue, 23 Jul 2002 17:05:12 +0200
Cc: Brian May <bam@snoopy.apana.org.au>, SE Linux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0207230927000.4721-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0207230927000.4721-100000@raven>
MIME-Version: 1.0
Message-Id: <20020723150512.C03FC4744@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 23 Jul 2002 16:03, Stephen Smalley wrote:
> The first operation is denied by the policy/constraints configuration.  As

Thanks.

> > I've run into a similar issue, some scripts such as dh_installdocs call
> > "cp -a" which tries to do such a chsid and fails.  I think that "cp -a"
> > should not preserve sids to avoid breaking compatability in such
> > situations. Generally when "cp -a" is called you don't even want to
> > preserve the UID, just the mode.
> >
> > What do you think?
>
> cp -a or cp -p does attempt to preserve the owner and group as well as the
> mode.  cp -a or cp -p will treat a failed chown as an error if the user is
> root but will silently ignore failure if the user is non-root.  The
> comment from the code says "If non-root uses -p, it's ok if we can't
> preserve ownership. But root probably wants to know, e.g. if NFS disallows
> it, or if the target system doesn't support file ownership."  The same
> copying code is used by cp, install, and mv (for cross-filesystem moves).
>
> We could have these utilities merely warn on failed chsid calls and not
> return an error by default.  However, if we make such a change, we should
> definitely add a command line option to force the utility to treat it as
> an error for cases where this is desired.

My problem is with a program that thinks it's root but isn't.  For creating 
Debian packages we use a system called "fakeroot" which uses a LD_PRELOAD 
hack to override the getuid() system call and make a process think it's root. 
It also overrides the chown() and stat() system calls to make it look as if 
the file has changed ownership.

Maybe I should make the SE Linux programs use a shared object for the system 
call wrapper functions so that I can use a LD_PRELOAD hack to take over SE 
Linux system calls and replace them with my own equivalents.  What do you 
think?

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
