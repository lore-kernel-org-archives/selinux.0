Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA02877
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 14:08:37 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id TAA11292
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 19:08:01 GMT
Received: from biocserver.BIOC.CWRU.Edu (biocserver.BIOC.CWRU.Edu [129.22.208.36])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id TAA11288
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 19:08:00 GMT
Date: Wed, 10 Jan 2001 14:12:41 -0500 (EST)
From: Jose Nazario <jose@biocserver.bioc.cwru.edu>
To: "Belmonte, Christopher" <cbelmonte@dit.state.va.us>
cc: <selinux@tycho.nsa.gov>
Subject: RE: SELinux and covert channels
In-Reply-To: <A0669F3E0A6B3448A962DC6141E6C7A6144162@mis1>
Message-ID: <Pine.LNX.4.30.0101101357350.31818-100000@biocserver.BIOC.CWRU.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

On Wed, 10 Jan 2001, Belmonte, Christopher wrote:

> 	In regards to covert channels, this is what I am referring to
> (the following is from "A GUIDE TO UNDERSTANDING COVERT CHANNEL
> ANALYSIS OF TRUSTED SYSTEMS"):

i was just reading that document ... :)

links of interest to covert channel analysis:

NCSC-TG-030  VERSION-1
NATIONAL COMPUTER SECURITY CENTER
A GUIDE TO UNDERSTANDING COVERT CHANNEL ANALYSIS OF TRUSTED SYSTEMS
November 1993
- http://www.radium.ncsc.mil/tpep/library/rainbow/NCSC-TG-030.html

the whole series is available at
http://www.radium.ncsc.mil/tpep/library/rainbow/ and is worth bookmarking.
furthermore, the O'Reilly book "Computer Security Basics" may serve as a
good introduction to trusted operating concepts to many people (it did for
me!) -- http://www.oreilly.com/catalog/csb/

i hope this info helps.

getting back to the original question, in the absence of *enforcement*,
SELinux will indeed have the capacity (and probably does have plenty of
them) for covert channels. only if all of the system is brought in to play
with the policies and their enforcement, and properly audited, can covert
channels be eliminated.

at least i think so.

____________________________
jose nazario						     jose@cwru.edu
	      	     PGP: 89 B0 81 DA 5B FD 7E 00  99 C3 B2 CD 48 A0 07 80
				       PGP key ID 0xFD37F4E5 (pgp.mit.edu)


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
