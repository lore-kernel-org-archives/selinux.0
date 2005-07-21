Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6LKZSgA000212
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 16:35:28 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6LKUnrg016887
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 20:30:50 GMT
Message-Id: <200507212030.j6LKUTvx008177@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <gyurdiev@redhat.com>
Cc: "'Joshua Brindle'" <jbrindle@tresys.com>, <selinux@tycho.nsa.gov>
Subject: RE: [ libsepol 2/6] Ports
Date: Thu, 21 Jul 2005 16:30:29 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1121974688.9844.86.camel@celtics.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Ivan Gyurdiev [mailto:gyurdiev@redhat.com]
> Sent: Thursday, July 21, 2005 3:38 PM
> To: Karl MacMillan
> Cc: 'Joshua Brindle'; selinux@tycho.nsa.gov
> Subject: RE: [ libsepol 2/6] Ports
> 
> 
> > I don't think libsepol should be doing file modification - that is the
> > responsibility of libsemanage and the transaction infrastructure included in
> > that library.
> 
> Yes, that's what I was saying in my mail - that part of the code
> would be in libsemanage.
> 

Ok - sorry for the misread.

> > I am not opposed to better abstractions in libsepol, but it should only deal
> > with modifying the in memory policy database.
> 
> Correct.
> 
> > I also agree with Josh that I'm
> > not certain that spending a large amount of effort on abstractions in
> libsepol
> > is worth the effort. Everything that uses libsepol in the future will have
> to be
> > painfully aware of the details of the policy representation.
> 
> That's a self-fulfilling statement - we shouldn't make this assumption,
> and then put all kinds of internal-modifying code outside
> libsepol where it does not belong.

Like I said, I'm not opposed in principal just wondering whether the payoff will
really come.

> Is there a reason why your
> module code is not in libsepol?
> 

The code that deals with the policy representation (including linking and
expanding) is in libsepol. Additionally, we are going to move the code that
understands the module file format to libsepol. That leaves the code that
manages the policy store (or in the future talks to the policy server) in
libsemanage.

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
