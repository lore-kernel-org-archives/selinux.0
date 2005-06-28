Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5SDm6gA003303
	for <selinux@tycho.nsa.gov>; Tue, 28 Jun 2005 09:48:06 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5SDlPaC016469
	for <selinux@tycho.nsa.gov>; Tue, 28 Jun 2005 13:47:25 GMT
Message-Id: <200506281347.j5SDlCqc027855@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <ivg2@cornell.edu>
Cc: <selinux@tycho.nsa.gov>, "'Daniel J Walsh'" <dwalsh@redhat.com>
Subject: RE: file contexts and modularity
Date: Tue, 28 Jun 2005 09:47:11 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1119894980.26533.33.camel@celtics.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Ivan Gyurdiev [mailto:ivg2@cornell.edu]
> Sent: Monday, June 27, 2005 1:56 PM
> To: Karl MacMillan
> Cc: selinux@tycho.nsa.gov; 'Daniel J Walsh'
> Subject: RE: file contexts and modularity
> 
> 
> > I more concerned about the other questions - how would a user switch
> policies
> > with this scheme?
> 
> Does switching policies require changing the file contexts?
> I typically use strict policy, so I'm not sure...
> I suppose this file could be re-generated?
> 

Yes - the two policies could potentially have no types in common.

> > How would network home directories work?
> 
> The same way they work right now?
> I didn't realize network home dirs support xattr..
> 

They don't, but they will. And they don't really work right now.

Karl

> >  Tying the creation of
> > the labeling information to calling adduser seems fragile.
> 
> Perhaps...

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
