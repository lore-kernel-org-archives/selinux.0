Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA26025
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2001 11:53:05 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA21263
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2001 16:53:02 GMT
Received: from biocserver.BIOC.CWRU.Edu (biocserver.BIOC.CWRU.Edu [129.22.208.36])
	by jazzband.ncsc.mil  with ESMTP id QAA21259
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2001 16:53:01 GMT
Date: Fri, 9 Feb 2001 11:58:04 -0500 (EST)
From: Jose Nazario <jose@biocserver.bioc.cwru.edu>
To: paul  <paul@bladestorm.com>
cc: <selinux@tycho.nsa.gov>, Sandy Harris <sandy@storm.ca>
Subject: Re: Cature the flag (was Re: Selinux kernel patches)
In-Reply-To: <200102091018.AA709820754@bladestorm.com>
Message-ID: <Pine.LNX.4.30.0102091156220.27973-100000@biocserver.BIOC.CWRU.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

On Fri, 9 Feb 2001, paul  wrote:

> So what happens when the hackers attack the machines logging packets?

usually its configured at layer 2 only, so it's not visible to anyone.
it's a good NIDS procedure. it's invisible, and also nearly immune to
attacks. you also use a good IP stack (usually OpenBSD).

> Or what if they just decide to take down the router?

which used to happen at DefCon, then they moved to OpenBSD and cut down
those problems pretty quickly.

these are all good considerations, and considering that you're trying to
attract the best of the best, wise to keep in mind. but, they've also been
addressed before.

____________________________
jose nazario						     jose@cwru.edu
	      	     PGP: 89 B0 81 DA 5B FD 7E 00  99 C3 B2 CD 48 A0 07 80
				       PGP key ID 0xFD37F4E5 (pgp.mit.edu)


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
