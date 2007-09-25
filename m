Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8PMeWbO007867
	for <selinux@tycho.nsa.gov>; Tue, 25 Sep 2007 18:40:32 -0400
Received: from atlrel8.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8PMeVYZ016723
	for <selinux@tycho.nsa.gov>; Tue, 25 Sep 2007 22:40:31 GMT
From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [RFC PATCH 0/2] Series short description
Date: Tue, 25 Sep 2007 18:38:58 -0400
Cc: selinux@tycho.nsa.gov
References: <20070925203856.13699.90782.stgit@flek.americas.hpqcorp.net> <Xine.LNX.4.64.0709251525260.26141@us.intercode.com.au>
In-Reply-To: <Xine.LNX.4.64.0709251525260.26141@us.intercode.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709251838.58272.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 25 September 2007 6:28:48 pm James Morris wrote:
> On Tue, 25 Sep 2007, Paul Moore wrote:
> > This patchset has two patches in it which I would like to get some
> > feedback on.  The first patch adds a functionality/compatability version
> > number to the policy so that we can add new functionality to the kernel
> > which would lie dormant until the correct policy was loaded - it is not
> > intended to replace Eric's undefined classes/perms work but to compliment
> > it.
>
> Can you explain the expected usage scenarios for this?

The one example that springs immediately to mind is the two separate checks 
for peer labels (one for NetLabel, one for labeled IPsec) in 
selinux_sock_rcv_skb().  As discussed on the list, we would like to move to a 
single check for the peer label.  Unfortunately, this runs into problems with 
backwards compatibility with people using old policy on new kernels.  The 
idea here was that the kernel would have code for both types of access 
control and depending on the policy loaded it would select which type of 
access control to use.

> We already have versioning of policy, and will have the ability to reject,
> ignore or enforce unknown elements, so why do we need this and how would
> it typically be used?

Eric suggested using the policy version to achieve the same thing; if no one 
objects to using the policy version number for this purpose I'm more than 
happy to use it.

> Should we instead start thinking about versioning each permission & class?
> i.e. create a fully versioned interface

This question nags at me, but I keep ignoring it because I fear that a fully 
versioned avc interface would be overkill in the majority of cases and only 
serve to slow down the access checks.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
