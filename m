Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA22823
	for <selinux@tycho.nsa.gov>; Mon, 20 Jan 2003 20:56:30 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0L1uTI09401
	for <selinux@tycho.nsa.gov>; Tue, 21 Jan 2003 01:56:29 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id h0L1uRf09397 for <selinux@tycho.nsa.gov>; Tue, 21 Jan 2003 01:56:28 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: forrest whitcher <fw@fwsystems.com>, selinux@tycho.nsa.gov
Subject: Re: Root-only systems
Date: Tue, 21 Jan 2003 02:56:08 +0100
References: <200301180149.27476.russell@coker.com.au> <20030118044554.A19790@lemuria.org> <20030120193144.57cabd3e.fw@fwsystems.com>
In-Reply-To: <20030120193144.57cabd3e.fw@fwsystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200301210256.08482.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 21 Jan 2003 01:31, forrest whitcher wrote:
> I'm actually trying to go the other direction, and remove some of the
> Unix/Posix root concepts. Presently the lsm/selinux checks are run in
> addition to the unix uid/gid checks, failing either can deny the
> privelege.
>
> As a strong tool is in place, why for instance do we still want to
> require UID=0 to bind a low-number network port or access device
> drivers etc?

One really good reason is the way that SE Linux is deployed on running 
servers.

If I have a running machine then I can't entirely rebuild it immediately, so I 
install SE Linux in permissive mode, and apart from the potential of someone 
typing "avc_toggle" at the wrong time it'll keep running as before.

If we allow non-root to bind to low ports (for example) then permissive mode 
would be significantly less secure than a non-SE machine.  If we don't allow 
such operations in permissive mode then permissive and enforcing modes will 
be functionally different.

Also once we have a system running in enforcing mode we know that if the SE 
Linux policy fails us then we still have Unix permissions.  If we weaken the 
standard Unix permissions then new users will not be granted the assurance of 
"the worst security problem it can have is to run like a regular Unix 
system".

> Otoh, I expect the number of places where UID=0 checks have been
> built into both the kernel and userspace tools may make practically
> eliminating root from low-level operations a bit of a stretch.

The issue of binding to low ports is not difficult to fix.  The other big one 
is setuid(), the rest probably don't matter much.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
