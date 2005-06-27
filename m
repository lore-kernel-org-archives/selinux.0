Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5RHPugA026109
	for <selinux@tycho.nsa.gov>; Mon, 27 Jun 2005 13:25:56 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5RHPOjQ027949
	for <selinux@tycho.nsa.gov>; Mon, 27 Jun 2005 17:25:24 GMT
Message-Id: <200506271725.j5RHP9qc019649@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <ivg2@cornell.edu>
Cc: <selinux@tycho.nsa.gov>, "'Daniel J Walsh'" <dwalsh@redhat.com>
Subject: RE: file contexts and modularity
Date: Mon, 27 Jun 2005 13:25:08 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1119886600.18293.50.camel@celtics.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Ivan Gyurdiev [mailto:ivg2@cornell.edu]
> Sent: Monday, June 27, 2005 11:37 AM
> To: Karl MacMillan
> Cc: selinux@tycho.nsa.gov; 'Daniel J Walsh'
> Subject: RE: file contexts and modularity
> 
> 
> > An alternative option is to leave the home directory keywords unexpanded and
> > have matchpatchcon expand them on demand. This requires knowledge of what is
> a
> > home directory, which is difficult to get. We can either store that
> information
> > somewhere or require the caller to provide, e.g., setfiles could get a flag
> that
> > to allow the admin to specify which directories are home directories.
> 
> I disagree that expansions necessarily have to relate to home
> directories, and I think it's difficult to predict how expansions will
> work in the future. It's hard to come up with a concrete example - this
> really depends on what we choose to do with policy in the future.
> The point is that we are moving complex logic into a low-level program
> such as matchpathcon...and I'm not sure we should do that. It's
> a layering issue - where should complexity be placed.
> 

How would a non-home directory expansion work?

/tmp/ROLE-foo	user:role:type

What role would this be? All roles? Currently the role is derived based on the
weak notion of primary role for each user - which has to be part of the home
directory. Without a compelling use case I think that this is a slippery slope
that could cause problems.

> > Anyone else have some insight? It really files like we are over-engineering
> this
> > problem and there is some simple solution once we fully understand the
> problem.
> > I have the gut feeling that pre-expanded file_contexts is the wrong way to
> go,
> > but no clear argument as to why.
> 
> You have a point that we're storing mostly redundant information, but
> that's often necessary to achieve speed and simplicity - isn't that
> exactly the problem with the in-kernel policy?

I more concerned about the other questions - how would a user switch policies
with this scheme? How would network home directories work? Tying the creation of
the labeling information to calling adduser seems fragile.

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
