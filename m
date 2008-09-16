Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8GCuH79027739
	for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2008 08:56:17 -0400
Received: from g5t0008.atlanta.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8GCtRqH017241
	for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2008 12:55:28 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v6 00/16] Labeled networking patches for 2.6.28
To: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        netdev@vger.kernel.org
Date: Tue, 16 Sep 2008 08:55:48 -0400
Message-ID: <20080916124722.17132.38741.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Another revision to the patchset to fix two issues, one trivial, the other
not so much.  The trivial fix was to add some locking around the connection
labeling operations, we're messing with the socket so we should make sure
we lock it like we do everywhere else.  The second fix was to ensure that
we sync up a stream socket's MSS value when we add IP options to the socket.
We were doing everything correctly on the client side, but the server side
was a bit of a mess; I'm pretty happy with this fix as I think it actually
makes the code a bit cleaner in some respects and I believe actually shrinks
the size of the diff slightly (a good sign).

A special thanks to Joe Nall and John Wiseman for helping debug the MSS
problem.

I've updated both the git trees earlier today so hopefully the next cut of
the linux-next tree should have the latest bits.

 * git://git.infradead.org/users/pcmoore/lblnet-2.6_testing

--
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
