Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA27918
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2001 15:43:06 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA07391
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2001 20:42:57 GMT
Received: from biocserver.BIOC.CWRU.Edu (biocserver.BIOC.CWRU.Edu [129.22.208.36])
	by jazzswing.ncsc.mil  with ESMTP id UAA07387
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2001 20:42:56 GMT
Date: Fri, 9 Feb 2001 15:48:13 -0500 (EST)
From: Jose Nazario <jose@biocserver.bioc.cwru.edu>
To: "Pagano, Art" <art_pagano@tds.com>
cc: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: First Time SELinux Install
In-Reply-To: <CB02C7FE99B4D111BFC600805FE2DB35F50CE1@TDS-SA>
Message-ID: <Pine.LNX.4.30.0102091547140.30291-100000@biocserver.BIOC.CWRU.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

On Fri, 9 Feb 2001, Pagano, Art wrote:

> I just install RedHat 6.1.... Should I download the patches from
> RedHat before installing SELinux???

you probably should. the stuff that selinux replaces would get overwritten
by the updates if you applied them later.

install, patch (if you want to), install selinux's enhancements.

i didn't patch my test install, but that was just sitting at home on my
own network.

____________________________
jose nazario						     jose@cwru.edu
	      	     PGP: 89 B0 81 DA 5B FD 7E 00  99 C3 B2 CD 48 A0 07 80
				       PGP key ID 0xFD37F4E5 (pgp.mit.edu)


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
