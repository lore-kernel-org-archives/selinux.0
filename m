Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA17320
	for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2001 17:40:36 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA17573
	for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2001 22:40:33 GMT
Received: from biocserver.BIOC.CWRU.Edu (biocserver.BIOC.CWRU.Edu [129.22.208.36])
	by jazzband.ncsc.mil  with ESMTP id WAA17569
	for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2001 22:40:32 GMT
Date: Tue, 20 Mar 2001 17:41:21 -0500 (EST)
From: Jose Nazario <jose@biocserver.bioc.cwru.edu>
To: Pedro Rosa <Pedro.Rosa@ksu.ru>
cc: Stephen Smalley <sds@tislabs.com>, Jeff Largent <jlargent@imagelinks.com>,
        selinux <selinux@tycho.nsa.gov>
Subject: Re: lids
In-Reply-To: <3AB7CBBB.1060404@ksu.ru>
Message-ID: <Pine.LNX.4.30.0103201734350.549-100000@biocserver.BIOC.CWRU.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 21 Mar 2001, Pedro Rosa wrote:

> Sorry but LIDS stands for Linux Intrusion Detection System. Its main
> purpose has nothing to do with what SELinux deals with. I don't know
> too much about the inners of LIDS but I know that it is an evolution
> of some ideas based on NIDS (Network Intrusion Detection System).

the name LIDS is a misnomer. as someone who works a lot with IDS stuff, it
pisses me off, too, that such a fundamental mistake was made in the
naming.

http://www.lids.org/about.html

LIDS is a capability set for Linux, providing essentially a huge set of
acces controls and stuff related.

intrusion detection is the principle and practice of watching events,
comaring them to a database of signatures, and generating reports and
events based on if you match there or not. ie you could say "if you stray
outside of normal behavior signatures ...", but most have databases of
known *unwanted* behavior which match.

LIDS, while named the linux intrusion detection system, is in fact an
attempt to create the intrusion prevent system. split privilidges and
capabilities, minimize damage and abilities, etc ...

nowhere in all of the project have i seen it listed that it does IDS work.
while it may log denied attempts to, say, write to a logfile, that's a
limited view of what an IDS is all about.

as such it seems like a definite attempt to achieve similar goals as
SElinux has. smalley, i think, posted on this earlier today.

____________________________
jose nazario						     jose@cwru.edu
	      	     PGP: 89 B0 81 DA 5B FD 7E 00  99 C3 B2 CD 48 A0 07 80
				       PGP key ID 0xFD37F4E5 (pgp.mit.edu)


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
