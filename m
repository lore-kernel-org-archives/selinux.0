Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA00453
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 11:05:55 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id QAA02239
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 16:05:19 GMT
Received: from relay2.nai.com (relay2.nai.com [161.69.3.67])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id QAA02221
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 16:05:08 GMT
Received: from scwsout1 (webshield2.nai.com [161.69.3.73])
	by relay2.nai.com (8.9.3/8.9.3) with SMTP id IAA23443
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 08:05:12 -0800 (PST)
Message-ID: <DBF2F9C6F6BAD211BB1B00A0C99D970233AD5D@dns-205.dhcp-77.nai.com>
From: "Badger, Lee" <Lee_Badger@nai.com>
To: "'open-source@csl.sri.com'" <open-source@csl.sri.com>,
        "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: RE: Ros: Re: enhanced security for Linux, from Stephen Smalley
Date: Wed, 10 Jan 2001 07:58:30 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Casey,

I have to strongly disagree.

> Unfortunately, I see no way that the industry can take
> advantage of it. We've been pushing B1 (now LSPP) as the
> ultimate COTS security solution since the late 1980's
> and we're not going to drop that investment any time

As one of the creators of Domain and Type Enforcement (DTE), I have to
tell you that type enforcement is pretty different from MLS.  It is
highly configurable.  It allows us to trust but still confine programs
that must generate high-integrity data, or that must write "down" in
the sensitivity lattice.  It allows us to sandbox critical processes
in highly restrictive access control environments while leaving most
of the other processes unaffected.  It can support Biba, and
Clark/Wilson style integrity policies.  It can support notions such as
controlled execution.  It can of course support assured pipelines.
These are all capabilities that are natural for Security-Enhanced
Linux (SELinux), and that are very important for commercial
applications, but which are difficult, at best, with B1-like systems.
The confidentiality lattice just wasn't designed with these things in
mind.

I see many ways that industry can use these capabilities.  Just
consider any web farm.  Any 24x7 server.  Any organization that uses
servers that could be penetrated externally (e.g., the buffer overflow
attacks documented by CERT).  SELinux can and should also be applied
within organizations.  Firewall perimeters are getting weaker, and
there is an increased need to harden all host systems.  The label
lattice of the orange book doesn't help much there, but a system like
SELinux provides a very appropriate set of tools for applying access
controls so as to appropriately harden interior systems.  This makes
lots of sense for servers, today.  Client workstations are harder to
configure, but, ultimately, this approach may help there as well.

> throw that away, even for a vastly superior technology
> (Hey! I *AM* Dilbert's Boss!) which DE does not appear
> to be.

I would not claim superiority for SELinux in the area of
confidentiality or in the area of general assurance.  But for
integrity and flexibility and the ability to support confinement
policies of interest to commercial customers (i.e., like confining
those CGI scripts), SELinux provides a _much_ more useful set of tools
than Orange Book systems.  For these kinds of problems, SELinux
deserves a close look.  It has different goals from those of the
Orange Book, and is not an equivalent to B1.

Lee

Lee Badger
Chief Scientist
NAI Labs, Network Associates
443.259.2382 voice
301.854.4731 fax
lbadger@nai.com


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
