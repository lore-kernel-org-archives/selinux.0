Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id BAA27234
	for <selinux@tycho.nsa.gov>; Wed, 16 Jan 2002 01:15:43 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id GAA14363
	for <selinux@tycho.nsa.gov>; Wed, 16 Jan 2002 06:14:54 GMT
Received: from orngca-mls01.socal.rr.com (orngca-mls01.socal.rr.com [66.75.160.16])
	by jazzband.ncsc.mil  with ESMTP id GAA14359
	for <selinux@tycho.nsa.gov>; Wed, 16 Jan 2002 06:14:53 GMT
Message-ID: <001501c19e55$b2bf6120$5357a518@hproject>
From: "Donald Kasper" <kasper@1stconnect.com>
To: "Shaun Savage" <savages@pcez.com>
Cc: <selinux@tycho.nsa.gov>
References: <72222DC86846D411ABD300A0C9EB08A101524289@csoc-mail-box.csoconline.com> <000c01c19df7$c08d4050$5357a518@hproject> <3C44A70A.4000602@pcez.com>
Subject: Re: General Users
Date: Tue, 15 Jan 2002 22:19:04 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

To be released to the public at this point, no.  DISA has always hated
Linux.  I pitched it to them for two years with no luck at all.  However I
did compile the entire COE on Linux in 1999 and demonstrated the CDSEdit
utility to them then.  This last Fall, I went directly to the Director of
DISA and others in DOD to request a Linux port to support America's computer
infrastructure security.  The argument was that one-third of the Internet
backbone is based on Linux machines according to surveys, and that the COE
as a major security tool should therefore be deployed commercially to
protect the net and commercial computer systems.  This has apparently
generated some interest, as I am now in touch with some folks who have been
asked to cost a Linux port for DOD.
If you want to see what the structure of the COE is, I have scanned the COE
4.1.3.0 baseline source with my Juggernautsearch engine, and posted the
results on www.opencoe.com.  You can download it from there.  Just reading
the file listing you can see what the subsystems are.  I also scanned all
the docs.  Without using the search engine HTML query interface, you can
Grep through it.  This is not the full COE source, as the scan was set to
remove common words.  4.1.3.0 works out to last September's build.
Hey, name that security system that is the baseline for NSA computer system
worldwide?  (A) SELinux, (B) The COE.   Answer: As of last September, it is
the COE.
Not only can the COE run accounts over a network, it can do so over mixed
networks.  It runs cross-platform under UNIX (many flavors esp. HP and SUN),
and Windows NT and 2000.  So you can sit on a SUN and administer PC's on the
net.  If you use NT, it knows all about primary/backup domain controllers
(PDC's and BDC's) that were used in that architecture to administer nets.
The key limitation on use of the COE with SELinux is DISA mentality that
releasing source code is not secure.  At least that is their justification
for not doing so.  Amazing that NSA has just the opposite view.
A Linux build of the COE may be in your future for 2002.
As for network distribution and maintenance of software, the Jet Propulsion
Laboratory in Pasadena, CA (they develop the COE Kernel) has had an ongoing
Java Community Process project for a year or so to develop a Java app that
can distribute software over a net.  It was supposed to be signed, sealed,
and delivered to DOD at the first of this year for use in the COE.  I have
not followed up on that.  My quick-and-simple solution was to write a
utility called COEAnywhere, a tool that allows a client to compare all of
its COE software segments to a master on a server.  A comparison table is
built so the user can dowload desired segments.  All pure JPL software for
DOD is 100% in the public domain, so I have posted that on my opencoe site.
Maybe it will help you.
Regards,
Donald Kasper

----- Original Message -----
From: "Shaun Savage" <savages@pcez.com>
To: "Donald Kasper" <kasper@1stconnect.com>
Cc: <selinux@tycho.nsa.gov>
Sent: Tuesday, January 15, 2002 2:02 PM
Subject: Re: General Users


> Donald Kasper wrote:
>
> >You need a profile manager that is network aware.  See the Common
Operating
> >Environment (COE) DISA project, Account Profile Management (APM) utility
to
> >see how they do it.  NSA uses the COE, so its not foreign to them either.
> >Donald Kasper
> >
> I would would like to find out more but some of the pages are
> "restricted" and I can't get to them. I am at the COE Home page.  Also
> is there a linux port or any work being done with linux?
>
> Shaun
>
>
>
>
> --
> You have received this message because you are subscribed to the selinux
list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
> the words "unsubscribe selinux" without quotes as the message.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
