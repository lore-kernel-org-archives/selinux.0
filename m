Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA20076
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2001 14:08:24 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA07414
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2001 19:08:04 GMT
Received: from biocserver.BIOC.CWRU.Edu (biocserver.BIOC.CWRU.Edu [129.22.208.36])
	by jazzswing.ncsc.mil  with ESMTP id TAA07410
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2001 19:08:03 GMT
Date: Mon, 26 Feb 2001 14:14:07 -0500 (EST)
From: Jose Nazario <jose@biocserver.bioc.cwru.edu>
To: Mark Lucas <mlucas@imagelinks.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: New to list
In-Reply-To: <p04320405b6c04aed15b0@[208.24.120.15]>
Message-ID: <Pine.LNX.4.30.0102261405460.27706-100000@biocserver.BIOC.CWRU.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

On Mon, 26 Feb 2001, Mark Lucas wrote:

> Just signed up on the list.  We are building BeoWulf clusters as
> geospatial rendering engines and are working with several government
> agencies in the process.  I'm hoping that we can apply the excellent
> work of this group towards improving our system and satisfying the
> various security concerns as our systems begin to integrate with
> various secure networks.

hi mark

i've built a beowulf, i do a lot of high performance computing in my line
of work. and honestly, aside from the perimeter, i can't see any advantage
to using SELinux or any similar facility for clustered computing.

file access can be guarded using standard UNIX DACLs to a sufficient
level. if you're not finding this to be true, i would imagine you're not
toying with them enough.

rarely do users need to access system portions in their calculations or
computing that cannot be handled within the kernel using normal Beowulf
structures (ie shared memory).

as for the gateway, again, some tight normal UNIX DACLs and good firewall
rules and you should be set. we never had a problem with users requiring
system access to get to usable portions of the cluster.

i'm also a bit familiar (though not as much as many on this list, to be
sure) with SELinux and what i tdoes, too. i love it, but i just don't see
it being applicable in a situation like this.

however, maybe i'm looking at this in way too limited a view. i'd be happy
to hear how you want to apply it.

____________________________
jose nazario						     jose@cwru.edu
	      	     PGP: 89 B0 81 DA 5B FD 7E 00  99 C3 B2 CD 48 A0 07 80
				       PGP key ID 0xFD37F4E5 (pgp.mit.edu)


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
