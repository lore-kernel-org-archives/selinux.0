Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA24449
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 09:41:20 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h1PEfHI11628
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 14:41:17 GMT
Received: from hellcat.admin.navo.hpc.mil (hellcat.admin.navo.hpc.mil [204.222.179.34])
        by jazzband.ncsc.mil  with ESMTP id h1PEfFf11622 for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 14:41:16 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: Tom <tom@lemuria.org>, Russell Coker <russell@coker.com.au>
Subject: Re: Core policy
Date: Tue, 25 Feb 2003 08:40:46 -0600
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.LNX.4.33.0302241349350.1479-100000@vox.gw.tislabs.com> <200302250845.10294.russell@coker.com.au> <20030225092931.A15162@lemuria.org>
In-Reply-To: <20030225092931.A15162@lemuria.org>
MIME-Version: 1.0
Message-Id: <200302250840.46512.pollard@admin.navo.hpc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 25 February 2003 02:29 am, Tom wrote:
> On Tue, Feb 25, 2003 at 08:45:10AM +0100, Russell Coker wrote:
...
> > Installing xfs policy won't be that difficult if you really need it. 
> > Just as installing gpm policy won't b e difficult.
>
> I was trying to say: Leave it out, it's not important. Even if it's
> installed and used, breaking it will not cause much trouble, only a few
> apps won't look that crisp anymore and a few fonts won't work. Nothing
> serious compared to, say, a failure to boot up correctly.

On a side note: If the X server can access an xfs server on another system
you  may be importing data from a non-trusted host. This is just a reminder
if the X configuration designates an alternate font server host.

It is also entirely reasonable to use one font server for 10-20 workstations
since it doesn't  (at least not in my expierence) put that much of a load
on a system.

There has also been some effort to make use of xfs to provide fonts to
groff/ghostscript for rendering and printing. It has been a while since I
followed their development, so I don't know how far it has gone.
-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
