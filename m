Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8GDFNeE002181
	for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2008 09:15:23 -0400
Received: from g1t0028.austin.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8GDEXqH024696
	for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2008 13:14:34 GMT
From: Paul Moore <paul.moore@hp.com>
To: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [RFC PATCH v6 00/16] Labeled networking patches for 2.6.28
Date: Tue, 16 Sep 2008 09:15:19 -0400
References: <20080916124722.17132.38741.stgit@flek.lan>
In-Reply-To: <20080916124722.17132.38741.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200809160915.19843.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 16 September 2008 8:55:48 am Paul Moore wrote:
> Another revision to the patchset to fix two issues, one trivial, the
> other not so much.  The trivial fix was to add some locking around
> the connection labeling operations, we're messing with the socket so
> we should make sure we lock it like we do everywhere else.  The
> second fix was to ensure that we sync up a stream socket's MSS value
> when we add IP options to the socket. We were doing everything
> correctly on the client side, but the server side was a bit of a
> mess; I'm pretty happy with this fix as I think it actually makes the
> code a bit cleaner in some respects and I believe actually shrinks
> the size of the diff slightly (a good sign).
>
> A special thanks to Joe Nall and John Wiseman for helping debug the
> MSS problem.
>
> I've updated both the git trees earlier today so hopefully the next
> cut of the linux-next tree should have the latest bits.
>
>  * git://git.infradead.org/users/pcmoore/lblnet-2.6_testing

I forgot to add, there is also a small fix to the 
cipso_v4_sock_delattr() function so that it correctly removes the CIPSO 
option and either adjust the option padding correctly or removes the 
options struct entirely from the socket if it is no longer needed.

Thanks to Casey Schaufler for finding this bug.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
