Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7S01prF026619
	for <selinux@tycho.nsa.gov>; Sun, 27 Aug 2006 20:01:52 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7S01SW7025322
	for <selinux@tycho.nsa.gov>; Mon, 28 Aug 2006 00:01:30 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: casey@schaufler-ca.com
Subject: Re: poly-instantiated directories and call-gate
Date: Mon, 28 Aug 2006 10:01:38 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20060827183105.61046.qmail@web36612.mail.mud.yahoo.com>
In-Reply-To: <20060827183105.61046.qmail@web36612.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200608281001.39935.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 28 August 2006 04:31, Casey Schaufler <casey@schaufler-ca.com> 
wrote:
> > Thus the consequences of a single user breaking out
> > of their instance of /tmp
> > is mitigated.
>
> Contrary to popular belief, the motivation behind
> polyinstatiated directories was allowing programs
> that used /tmp to continue to work,

Well, to be pedantic doing a few "chmod -R 777" commands will also allow 
programs to continue to work (I've seen this done).  The reason for PI is to 
allow programs to continue to work while providing good security (where mode 
1777 is not good enough).

> not to 
> assist in keeping programs with different
> attributes (MLS values in particular) seperate.
> In the early days of Unix MLS design we seriously
> considered tossing /tmp into the bitbucket and
> encouraging everyone to set a rational value
> to $TMPDIR and being done with it. In the end
> we figured that the install base really did
> require access to /tmp, and polyinstatiation
> emerged as the most popular scheme for providing
> that access.

There are some technical advantages to /tmp in terms of management.  /tmp can 
be a filesystem with no persistent storage (the default action on Solaris).  
Even if /tmp is a real filesystem if space runs low the sys-admin can do a 
few "rm -rf" commands with the knowledge that the potential risk is quite 
low.  You can set up strict quotas on home directories for storage that is 
backed up while allowing large (or no) quotas on /tmp for operations that 
require a lot of space (eg sort).

Setting $TMPDIR=/tmp/$USER would work reasonably well if all programs would 
actually use $TMPDIR.

> All of the Unix schemes provide a way to get
> at the "real" file system name space. Solaris
> uses "adorned" path components. Trix uses a
> process attribute (the Moldy bit), and UNICOS
> used a symlink scheme that avoided the whole
> issue. With the usual file system protections
> in place there is no compelling reason to
> worry about "breaking out". There are good
> reasons to allow it, including sharing (upward)
> and monitoring.

I recall from playing with Trix that you had to be the administrator to see 
the full name space.  Was Solaris the same in this regard?

As for the Unicos symlink scheme, how did that work?

> > In terms of having a call-gate, apparently this has
> > been done before (Casey -
> > would you care to comment?).
>
> Yes, it has been done. It's a Bad Idea.

That was my gut feeling too.  Apart from the reasons I outline below what were 
the problems with it?  I expect that I'll be asked the same question the next 
time I speak about such things and want to have a good answer ready.  Also 
it'll be good to have this in the list archives.

I think it might be worth having a wikipedia page on this.  What would be a 
good title?

> > But even so I have
> > great doubts about anything
> > that involves changing a simple system call to an
> > execution of a program
> > (thus giving some potential for dead-locks among
> > other things).  I believe
> > that this was one of the issues with devfs that
> > caused it to be deprecated.

-- 
http://etbe.blogspot.com/          My Blog
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
