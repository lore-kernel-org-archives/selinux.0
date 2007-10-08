Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l98C7DGj013769
	for <selinux@tycho.nsa.gov>; Mon, 8 Oct 2007 08:07:13 -0400
Received: from ccerelrim02.cce.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l98C7Bts029129
	for <selinux@tycho.nsa.gov>; Mon, 8 Oct 2007 12:07:11 GMT
From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [RFC PATCH v4 0/3] Added new checks for labeled IPsec & SECMARK [en|dis]able
Date: Mon, 8 Oct 2007 08:06:59 -0400
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
References: <20071005192619.28034.62276.stgit@flek.americas.hpqcorp.net> <Xine.LNX.4.64.0710080752240.12306@us.intercode.com.au> <200710071955.26628.paul.moore@hp.com>
In-Reply-To: <200710071955.26628.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200710080806.59404.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 07 October 2007 7:55:26 pm Paul Moore wrote:
> On Sunday 07 October 2007 5:53:11 pm James Morris wrote:
> > I think it'd be good to get these into 2.6.24.  Any acks/nacks ?

Sorry, I thought you were asking just about the last patch (dynamic 
enable/disable) and not the whole patchset.

I don't think we're going to be ready for 2.6.24 with these patches.  My goal 
at this point is to get these three patches, the new unified peer label 
access controls and the work Venkat has been doing on flow control into 
2.6.25.  This should give us plenty of time to get the userspace pieces into 
place and perform a decent amount of testing on the whole combination.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
