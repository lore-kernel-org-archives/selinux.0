Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA01228
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 12:08:06 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id RAA05029
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 17:07:30 GMT
Received: from biocserver.BIOC.CWRU.Edu (biocserver.BIOC.CWRU.Edu [129.22.208.36])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id RAA05025
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 17:07:29 GMT
Date: Wed, 10 Jan 2001 12:12:08 -0500 (EST)
From: Jose Nazario <jose@biocserver.bioc.cwru.edu>
To: "Belmonte, Christopher" <cbelmonte@dit.state.va.us>
cc: <selinux@tycho.nsa.gov>
Subject: RE: Security enhancements, et al
In-Reply-To: <A0669F3E0A6B3448A962DC6141E6C7A6144156@mis1>
Message-ID: <Pine.LNX.4.30.0101101209420.30847-100000@biocserver.BIOC.CWRU.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

On Wed, 10 Jan 2001, Belmonte, Christopher wrote:

> Is anyone currently using the Rule Set Based Access Control linux
> security extension? I am curious on how it compares to SELinux.

i just started using it last night. if i understand it correctly, trusted
os concepts and implementations are new-ish to me, SELinux is just policy
definitions but no enforcement yet, and RSBAC actually can enforce those
policies. hence, RSBAC looks more complete *at this time* than SELinux is.

> Does anyone have any idea why it has taken so long the release of
> SELinux? I'm assuming that maybe it was due to a source code audit...
> the man pages for many of the commands added by SELinux show updates
> from 1997-1999 (sorry if this has been changed in the current
> version).

i recall reading here (or somewhere else) that *no* source audit was done.
security bugs are still in place in the Linux code there (remember this is
based on RH6.1 and a known capability buggy kernel).

____________________________
jose nazario						     jose@cwru.edu
	      	     PGP: 89 B0 81 DA 5B FD 7E 00  99 C3 B2 CD 48 A0 07 80
				       PGP key ID 0xFD37F4E5 (pgp.mit.edu)


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
