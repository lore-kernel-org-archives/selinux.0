Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA26674
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2001 09:12:37 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA29010
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2001 13:12:17 GMT
Received: from biocserver.BIOC.CWRU.Edu (biocserver.BIOC.CWRU.Edu [129.22.208.36])
	by jazzband.ncsc.mil  with ESMTP id NAA29006
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2001 13:12:16 GMT
Date: Thu, 16 Aug 2001 09:16:27 -0400 (EDT)
From: Jose Nazario <jose@biocserver.bioc.cwru.edu>
To: Conan Callen <ccallen@windowpane.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: selinux on freebsd
In-Reply-To: <011b01c1261c$29836020$3a8314d1@nwlink.com>
Message-ID: <Pine.LNX.4.30.0108160914160.22543-100000@biocserver.BIOC.CWRU.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 15 Aug 2001, Conan Callen wrote:

> 2. I read in the FAQ that selinux can be installed on an existing
> linux install. Can it be installed on a Freebsd system with linux
> compatibility? Is anyone working on a port for freebsd or openbsd?

no. its massive kernel changes, things that emulation ont matter at all
about. for freebsd look into the trustedbsd project,
http://www.trustedbsd.org/ ... for openbsd look into stephanie,
http://www.packetfactory.net/Projects/Stephanie ....

trusted bsd is an attempt to being MACs, audit trails, etc ... to FreeBSD.
stephanie is an attempt to improve the security of openbsd, though it
doesn't approach orange book type matters.

hope this helps

____________________________
jose nazario						     jose@cwru.edu
	      	     PGP: 89 B0 81 DA 5B FD 7E 00  99 C3 B2 CD 48 A0 07 80
				       PGP key ID 0xFD37F4E5 (pgp.mit.edu)


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
