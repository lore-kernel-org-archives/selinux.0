Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA13674
	for <selinux@tycho.nsa.gov>; Thu, 13 Mar 2003 16:13:03 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA07363
	for <selinux@tycho.nsa.gov>; Thu, 13 Mar 2003 21:09:39 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id VAA07359
	for <selinux@tycho.nsa.gov>; Thu, 13 Mar 2003 21:09:36 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
Subject: Re: Which module is "best"?
Date: Thu, 13 Mar 2003 22:12:45 +0100
To: SE Linux <selinux@tycho.nsa.gov>
Cc: Daniel Carrera <dcarrera@math.umd.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200303132212.45583.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Re-sent because of list problems:

On Tue, 11 Mar 2003 04:18, Daniel Carrera wrote:
> If you don't mind elaborating on your questions offlist, I'd love to hear
> any SELinux advocacy you can offer (maybe you can just cc the list).

SE Linux is well written with very clean code.  This is really good if you
want to use it in teching projects or if you want to just study the way the
code works.

SE Linux is driving LSM to a large extent.  Do a web search for LSM
discussions on mailing lists and you'll see that Steve is prominantly
involved.

> > The transition between 2.4.x kernels and 2.6.x will probably be painful
> > for SE Linux users.  But most of the problems concern system calls and
> > will hit LIDS and DTE just as badly.
>
> Will there be a delay before SELinux is ported to the 2.6 kernel?

It's already ported to 2.5.x.  However the system calls have to change and
there's a lot of debate and code re-write going on in this regard.  The plan
is for 2.6.0 to have the full LSM interface.  The NSA people want to have SE
Linux included in 2.6.0, although even if that doesn't happen the result will
be the same for SE users - once LSM is in it's easy to apply the SE patch
without conflicts.

> > DTE has similar concepts and aims to SE Linux (I don't want to say more
> > on this list).
>
> I'd love to hear anything more you can tell me.

I think that's already been addressed on the LSM list in a better way than I
could.

> > POSIX capabilities are very limited, and as far as I understand it this
> > is the same as what you get in a standard Linux kernel, it's only a
> > separate module for the LSM patch (someone please correct me if I am
> > wrong).
>
> Does SELinux provide an equivalent of POSIX capabilities?
> i.e. Does POSIX capabilities map to a proper subset of SELinux?

SE Linux supports all POSIX capability functionality.  However they are
subject to the MAC restrictions of SE Linux policy.  So an application (such
as BIND 9.x) can use POSIX capability system calls to drop capabilities it
doesn't need (or doesn't need any more).  But SE Linux determines which
capabilties it can use.


SE Linux is getting good support and interest from many areas.  There are
active developers in several countries and there are many administrators who
are getting involved in training and plan to do SE consulting work.

SE Linux is still undergoing rapid change, but after 2.6.0 is released that
should all be finished.


I expect that SE Linux will really take off this year.

--
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
