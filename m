Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iANGucIi012807
	for <selinux@tycho.nsa.gov>; Tue, 23 Nov 2004 11:56:39 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iANGudFP023918
	for <selinux@tycho.nsa.gov>; Tue, 23 Nov 2004 16:56:41 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Frank Mayer" <mayerf@tresys.com>
Subject: Re: dynamic context transitions
Date: Tue, 23 Nov 2004 16:53:08 +1100
Cc: selinux@tycho.nsa.gov
References: <00b601c4c0e0$4c637410$1e0c010a@columbia.tresys.com>
In-Reply-To: <00b601c4c0e0$4c637410$1e0c010a@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200411231653.12353.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 03 November 2004 00:31, "Frank Mayer" <mayerf@tresys.com> wrote:
> Even if we allowed changes up and down, this "feels" like a better
> approach. There would have to be some means of defining the brackets
> allowed for a context change (how far up and down), much as in Multics ring
> brackets.  As an evaluator, for a given domain I would only ever look at

It seems to me that when analysing the policy you would need to look at the 
union of the access that is granted to all domains that can be the target of 
a dynamic transition.  So if you have a domain (A) that is permitted to 
dynamically enter two other domains (B and C) then you would have to analyse 
the access of all three domains (A, B, and C) as one subject.  Also however 
you may permit transitions to the domains B and C directly so the domains B 
and C would have to be considered independantly.

One problem will be the user interface to the analysis of such a policy.  I 
can't think of an interface that would not confuse the majority of users that 
supports querying such things.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
