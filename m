Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA22244
	for <selinux@tycho.nsa.gov>; Mon, 20 Jan 2003 19:31:51 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id AAA20044
	for <selinux@tycho.nsa.gov>; Tue, 21 Jan 2003 00:29:01 GMT
Received: from mozart.fwsystems.com (mozart.fwsystems.com [63.101.67.2])
	by jazzswing.ncsc.mil  with ESMTP id AAA20040
	for <selinux@tycho.nsa.gov>; Tue, 21 Jan 2003 00:29:00 GMT
Received: from athena (athena.fwsystems.com [63.101.67.13])
	by mozart.fwsystems.com (8.11.6/8.11.6) with SMTP id h0L0ViF10920
	for <selinux@tycho.nsa.gov>; Mon, 20 Jan 2003 19:31:45 -0500
Date: Mon, 20 Jan 2003 19:31:44 -0500
From: forrest whitcher <fw@fwsystems.com>
To: selinux@tycho.nsa.gov
Subject: Root-only systems
Message-Id: <20030120193144.57cabd3e.fw@fwsystems.com>
In-Reply-To: <20030118044554.A19790@lemuria.org>
References: <200301180149.27476.russell@coker.com.au>
	<20030118044554.A19790@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 18 Jan 2003 04:45:55 +0100 
Tom <tom@lemuria.org> did inscribe thusly:

> On Sat, Jan 18, 2003 at 01:49:27AM +0100, Russell Coker wrote:
> > Also an audience member asked me if it would be possible to run a machine with 
> > all files and processes UID=0, which was a strange co-incidence as I have 
> > been planning to do that for play machine ][ (but I may have mentioned it on 
> 
> Well, essentially it would condense the current 2D matrix we have on
> permissions back to a one-dimensional system, only along the other
> axis.
> 
> It would definitely be interesting for embedded systems, consoles and
> other stuff that doesn't really have very much of a user concept. For

This is one way to go, and I think it has potential value as you say in
embedded systems.

I'm actually trying to go the other direction, and remove some of the 
Unix/Posix root concepts. Presently the lsm/selinux checks are run in
addition to the unix uid/gid checks, failing either can deny the 
privelege.

As a strong tool is in place, why for instance do we still want to 
require UID=0 to bind a low-number network port or access device 
drivers etc?

Otoh, I expect the number of places where UID=0 checks have been 
built into both the kernel and userspace tools may make practically
eliminating root from low-level operations a bit of a stretch.


forrest

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
