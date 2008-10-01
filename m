Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m91F9SfR019841
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2008 11:09:28 -0400
Received: from g1t0026.austin.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m91F8OZL005280
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2008 15:08:24 GMT
From: Paul Moore <paul.moore@hp.com>
To: Joe Nall <joe@nall.com>
Subject: Re: [RFC PATCH v6 12/16] selinux: Set socket NetLabel based on connection endpoint
Date: Wed, 1 Oct 2008 11:09:25 -0400
Cc: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org
References: <20080916124722.17132.38741.stgit@flek.lan> <alpine.LRH.1.10.0810011958380.6732@tundra.namei.org> <7DC4373B-194C-43FC-B4FB-B867999CAE76@nall.com>
In-Reply-To: <7DC4373B-194C-43FC-B4FB-B867999CAE76@nall.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810011109.25573.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 01 October 2008 10:51:31 am Joe Nall wrote:
> On Oct 1, 2008, at 5:00 AM, James Morris wrote:
> > On Tue, 16 Sep 2008, Paul Moore wrote:
> >> /**
> >> + * cipso_v4_sock_delattr - Delete the CIPSO option from a socket
> >> + * @sk: the socket
> >> + *
> >> + * Description:
> >> + * Removes the CIPSO option from a socket, if present.
> >> + *
> >> + */
> >> +void cipso_v4_sock_delattr(struct sock *sk)
> >
> > Reviewed-by: James Morris <jmorris@namei.org>
> >
> >
> > Btw, what kind of testing has this patch had?
>
> Paul generated a patch for us against 2.6.26-5 that we have on about
> 20 developer and test boxes with good results in MLS enforcing. We
> are adding IPSec between machines and static fallback labels  to the
> test mix and will report any issues. We have a couple of 8 core
> machines I'll stress test on to look for SMP issues.

Thanks Joe, however, I think James was talking specifically about the 
this patch, not the entire aggregate patchset, and the 
cipso_v4_sock_delattr() function in particular as it is not likely to 
be called often in normal use.

To answer that question, I was going to write a small little test 
program that would connect/disconnect UDP sockets and do writes in 
various states to ensure the wire traffic was labeled (or not) 
correctly.  However, I had a bit of luck and Casey ended up using this 
function in Smack[1] in a manner that saw it in a relatively common 
code path so it got a decent test; in fact it was Casey who pointed out 
the bugs in the initial revision.

[1] The Smack bits are still a work in progress and not ready for 2.6.28 
so they have been left out of this patchset, expect something in the 
2.6.29 timeframe.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
