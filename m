Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6LJe3gA029646
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 15:40:03 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6LJZPrg011261
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 19:35:25 GMT
Message-Id: <200507211935.j6LJZHvx007595@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <gyurdiev@redhat.com>, "'Joshua Brindle'" <jbrindle@tresys.com>
Cc: <selinux@tycho.nsa.gov>
Subject: RE: [ libsepol 2/6] Ports
Date: Thu, 21 Jul 2005 15:35:17 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1121970450.9844.72.camel@celtics.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
> Behalf Of Ivan Gyurdiev
> Sent: Thursday, July 21, 2005 2:28 PM
> To: Joshua Brindle
> Cc: selinux@tycho.nsa.gov
> Subject: Re: [ libsepol 2/6] Ports
> 
> 
> > This probably belongs in libsemanage. I'm trying to get a comprehensive
> > API and set of structs so that you can start writing the port and user
> > code with respect to it. I'll try to get this out later today.
> 
> I already have a whole bunch of code written that has to do with
> parsing things. I need to do a better job with transactions in
> that code, but hopefully I won't need to go and rewrite all of it.
> 
> The code is based on the wrapper structures that I showed you earlier -
> they are called records. Then I have record_iterate_file() and
> record_modify_file() that can be made to work on any type
> of record. They handle record creation/destruction/parsing
> according to an object table that you pass in. They
> invoke an arbitrary handler to process each record,
> which can send signals, such as
> SIGADD, SIGDEL, SIGERR, SIGOK... The handler can
> also send back a feedback record in addition
> to the one being processed (for add).
> Then record_modify_file() can act upon those signals
> by exiting the iteration loop, or skipping the user
> from writing to the modified stream, or adding a new
> user, etc...
> 
> So basically, it comes down to writing a bunch of handlers
> that signal the iterator functions. For a different backend,
> obviously you'd implement this very differently, since
> you don't need to iterate things.
> 
> 

I don't think libsepol should be doing file modification - that is the
responsibility of libsemanage and the transaction infrastructure included in
that library.

I am not opposed to better abstractions in libsepol, but it should only deal
with modifying the in memory policy database. I also agree with Josh that I'm
not certain that spending a large amount of effort on abstractions in libsepol
is worth the effort. Everything that uses libsepol in the future will have to be
painfully aware of the details of the policy representation. This is regardless
of whether there is an abstraction or not - changes to the policy representation
will effect all of the users of libsepol. It is just a question of whether it
results in an api change or a data structure change.

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134

> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
