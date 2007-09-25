Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8PMn02h008332
	for <selinux@tycho.nsa.gov>; Tue, 25 Sep 2007 18:49:00 -0400
Received: from atlrel7.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8PMmxYZ018265
	for <selinux@tycho.nsa.gov>; Tue, 25 Sep 2007 22:48:59 GMT
From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [RFC PATCH 2/2] [SELINUX] Better integration between peer labeling subsystems
Date: Tue, 25 Sep 2007 18:48:44 -0400
Cc: selinux@tycho.nsa.gov
References: <20070925203856.13699.90782.stgit@flek.americas.hpqcorp.net> <20070925204832.13699.51638.stgit@flek.americas.hpqcorp.net> <Xine.LNX.4.64.0709251534360.26141@us.intercode.com.au>
In-Reply-To: <Xine.LNX.4.64.0709251534360.26141@us.intercode.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709251848.44880.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 25 September 2007 6:38:37 pm James Morris wrote:
> On Tue, 25 Sep 2007, Paul Moore wrote:
> > +int security_sid_mls_cmp(u32 sid_a, u32 sid_b)
>
> This looks heavyweight on TCP connection establishment (MCS is enabled in
> Fedora/RHEL).

Agreed.  That is why it is only executed when both NetLabel and labeled IPsec 
peer labels are present on the same packet/connection.  A situation which I 
expect to be extremely unlikely for a variety of reasons so I don't think 
this will be a problem in the general case.

In the case where we have two types of peer labels on a packet, the TCS folks 
expressed a concern (which makes sense to me) that we could run into a 
problem where the two peer labels might not match.  This is an attempt to 
address that problem, I'm always open to suggestions for better ways to solve 
the problem.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
