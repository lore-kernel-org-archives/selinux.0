Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8PMSpaP007180
	for <selinux@tycho.nsa.gov>; Tue, 25 Sep 2007 18:28:51 -0400
Received: from us.intercode.com.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8PMSnYZ014786
	for <selinux@tycho.nsa.gov>; Tue, 25 Sep 2007 22:28:50 GMT
Date: Tue, 25 Sep 2007 15:28:48 -0700 (PDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov
Subject: Re: [RFC PATCH 0/2] Series short description
In-Reply-To: <20070925203856.13699.90782.stgit@flek.americas.hpqcorp.net>
Message-ID: <Xine.LNX.4.64.0709251525260.26141@us.intercode.com.au>
References: <20070925203856.13699.90782.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 25 Sep 2007, Paul Moore wrote:

> This patchset has two patches in it which I would like to get some feedback
> on.  The first patch adds a functionality/compatability version number to the
> policy so that we can add new functionality to the kernel which would lie
> dormant until the correct policy was loaded - it is not intended to replace
> Eric's undefined classes/perms work but to compliment it.

Can you explain the expected usage scenarios for this?

We already have versioning of policy, and will have the ability to reject, 
ignore or enforce unknown elements, so why do we need this and how would 
it typically be used?

Should we instead start thinking about versioning each permission & class?  
i.e. create a fully versioned interface


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
