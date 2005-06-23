Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5NIoxgA029850
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 14:50:59 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5NIf0Na007153
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 18:41:09 GMT
Message-Id: <200506231840.j5NIegqc030612@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <ivg2@cornell.edu>
Cc: <selinux@tycho.nsa.gov>, "'Daniel J Walsh'" <dwalsh@redhat.com>
Subject: RE: file contexts and modularity
Date: Thu, 23 Jun 2005 14:40:41 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-reply-to: <1119551117.16753.12.camel@celtics.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Ivan Gyurdiev [mailto:ivg2@cornell.edu]
> Sent: Thursday, June 23, 2005 2:25 PM
> To: Karl MacMillan
> Cc: selinux@tycho.nsa.gov; 'Daniel J Walsh'
> Subject: RE: file contexts and modularity
> 
> 
> > Regenerating seems easier
> 
> ...seems harder to me - I'm doing this from a C library,
> and I already have written code to delete stuff from a single file.
> 
> Running around the filesystem to piece together a new file
> will be a pain...
>

Are you intending to do away with genhomedircon so that everything will be in
libselinux? Why are you going to have to run around the file system? Isn't this
a matter for taking the file contexts file that still has ROLE and HOMEDIR
statements and processing that?

Can you give an overview of these patches - what you are trying to accomplish in
more detail and the design?
 
> >  and more likely to be correct to me.
> 
> ...how so?
> 
> 

Deleting specific lines from the file contexts file seems difficult and error
prone while regenerating is straight forward. Only one code path (generation)
instead of many (add, remove, change, etc).

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134

> 
> 




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
