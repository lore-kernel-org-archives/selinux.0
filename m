Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA28864
	for <selinux@tycho.nsa.gov>; Thu, 4 Oct 2001 14:54:21 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA29231
	for <selinux@tycho.nsa.gov>; Thu, 4 Oct 2001 18:53:51 GMT
Received: from biocserver.BIOC.CWRU.Edu (biocserver.BIOC.CWRU.Edu [129.22.208.36])
	by jazzband.ncsc.mil  with ESMTP id SAA29227
	for <selinux@tycho.nsa.gov>; Thu, 4 Oct 2001 18:53:50 GMT
Date: Thu, 4 Oct 2001 15:01:20 -0400 (EDT)
From: Jose Nazario <jose@biocserver.bioc.cwru.edu>
To: Conan Callen <ccallen@windowpane.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: debugging tools
In-Reply-To: <Pine.LNX.4.33.0110041000330.15881-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.30.0110041500170.10894-100000@biocserver.BIOC.CWRU.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 4 Oct 2001, Conan Callen wrote:

> I want to start stepping through the selinux / lsm code so I can see
> what is happening. Does anyone have any recomendations on kernel
> debugging tools for doing this?


look for kprof and kdb, lkcd should also be helpful:

http://oss.sgi.com/projects/

that should be a good place to start. i think that kprof uses the same
output format as gprof so it can use the same analysis tools.

hope that helps

____________________________
jose nazario						     jose@cwru.edu
	      	     PGP: 89 B0 81 DA 5B FD 7E 00  99 C3 B2 CD 48 A0 07 80
				       PGP key ID 0xFD37F4E5 (pgp.mit.edu)


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
