Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA14347
	for <selinux@tycho.nsa.gov>; Mon, 2 Dec 2002 09:11:01 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA03990
	for <selinux@tycho.nsa.gov>; Mon, 2 Dec 2002 14:08:58 GMT
Received: from hellcat.admin.navo.hpc.mil (hellcat.admin.navo.hpc.mil [204.222.179.34])
        by jazzband.ncsc.mil  with ESMTP id OAA03986 for <selinux@tycho.nsa.gov>; Mon, 2 Dec 2002 14:08:58 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: Russell Coker <russell@coker.com.au>,
        "Stephen D. Smalley" <sds@epoch.ncsc.mil>, selinux@tycho.nsa.gov
Subject: Re: expect
Date: Mon, 2 Dec 2002 08:09:20 -0600
References: <200211292002.PAA23890@moss-shockers.ncsc.mil> <200212011308.58878.russell@coker.com.au>
In-Reply-To: <200212011308.58878.russell@coker.com.au>
MIME-Version: 1.0
Message-Id: <200212020809.20563.pollard@admin.navo.hpc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 01 December 2002 06:08 am, Russell Coker wrote:
> On Fri, 29 Nov 2002 21:02, Stephen D. Smalley wrote:
> > > Due to what I believe to be bugs in expect, the new open_init_pty
> > > program will not work correctly with old versions of expect.  Version
> > > 5.38.0 works fine, version 5.32.2 is broken.  I don't know when the bug
> > > was fixed exactly.
> >
> > I've backed out the open_init_pty changes to our internal copy of
> > run_init.   I'd rather not have the base run_init functionality dependent
> > on a particular version of expect, and I'm not even sure that it is
> > wise to depend on having expect installed at all.
>
> I will not do the same for my Debian packages.
>
> I can see the benefit in having two options available for users in this
> case, as some smaller devices such as PDAs may not have space for expect. 
> But Debian is a heavy distribution primarily designed for workstations and
> servers.  Debian works well on laptops too but is not designed to scale
> down any further than that.  So I think that there is no reason not to
> depend on expect.
>
> I have made my Debian packages depend on the appropriate version of expect
> so you can just install the packages and be sure that the right things are
> automatically installed.

IMHO not the best solution, since the existance of "expect" depends entirely
on local policy. At our site, it is not to be installed without a LOT of
justification first, and only with policy wavers on an individual basis.

Making it mandatory for the system to function would mean that the Debian
distribution will not be permitted. This isn't a major problem for us, at
least, since we have standardized on RH.

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
