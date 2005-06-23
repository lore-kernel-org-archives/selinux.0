Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5NIVHgA029596
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 14:31:18 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5NIKtRO005525
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 18:20:55 GMT
Message-Id: <200506231821.j5NILDqc030401@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <ivg2@cornell.edu>
Cc: <selinux@tycho.nsa.gov>, "'Daniel J Walsh'" <dwalsh@redhat.com>
Subject: RE: file contexts and modularity
Date: Thu, 23 Jun 2005 14:21:13 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-reply-to: <1119549909.16753.5.camel@celtics.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Ivan Gyurdiev [mailto:ivg2@cornell.edu]
> Sent: Thursday, June 23, 2005 2:05 PM
> To: Karl MacMillan
> Cc: selinux@tycho.nsa.gov; 'Daniel J Walsh'
> Subject: RE: file contexts and modularity
> 
> 
> > I think that I missed something - why do you need to know which contexts are
> > associated with an app or user?
> 
> So that I can get rid of them once the user's removed (userdel).
> 
> It seems like I'll just put each user in a separate .fc file
> for now... but then if you wanted to remove an app, you'd
> have to remove the app's .fc file, and the app's entries
> in each user file as well (and any template entries)...
> or alternatively you'd have to regenerate everything.
> 
> 

Regenerating seems easier and more likely to be correct to me.

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
