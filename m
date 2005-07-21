Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6LJjBgA029710
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 15:45:11 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6LJeXrg011958
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 19:40:33 GMT
Subject: RE: [ libsepol 2/6] Ports
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Joshua Brindle'" <jbrindle@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <200507211935.j6LJZHvx007595@gotham.columbia.tresys.com>
References: <200507211935.j6LJZHvx007595@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 21 Jul 2005 15:38:08 -0400
Message-Id: <1121974688.9844.86.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> I don't think libsepol should be doing file modification - that is the
> responsibility of libsemanage and the transaction infrastructure included in
> that library.

Yes, that's what I was saying in my mail - that part of the code
would be in libsemanage. 

> I am not opposed to better abstractions in libsepol, but it should only deal
> with modifying the in memory policy database. 

Correct.

> I also agree with Josh that I'm
> not certain that spending a large amount of effort on abstractions in libsepol
> is worth the effort. Everything that uses libsepol in the future will have to be
> painfully aware of the details of the policy representation. 

That's a self-fulfilling statement - we shouldn't make this assumption,
and then put all kinds of internal-modifying code outside
libsepol where it does not belong. Is there a reason why your 
module code is not in libsepol?




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
