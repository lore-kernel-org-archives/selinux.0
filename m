Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5TJ56gA015648
	for <selinux@tycho.nsa.gov>; Wed, 29 Jun 2005 15:05:07 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5TJ3ZdE022089
	for <selinux@tycho.nsa.gov>; Wed, 29 Jun 2005 19:03:36 GMT
Message-Id: <200506291904.j5TJ447f019254@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <gyurdiev@redhat.com>
Cc: <selinux@tycho.nsa.gov>, "'Daniel J Walsh'" <dwalsh@redhat.com>
Subject: RE: file contexts and modularity
Date: Wed, 29 Jun 2005 15:04:03 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-reply-to: <1120070819.20484.40.camel@celtics.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Ivan Gyurdiev [mailto:gyurdiev@redhat.com]
> Sent: Wednesday, June 29, 2005 2:47 PM
> To: Karl MacMillan
> Cc: selinux@tycho.nsa.gov; 'Daniel J Walsh'
> Subject: RE: file contexts and modularity
> 
> > Additionally, all of this is caused by using file
> > contexts for runtime labeling, which I have pointed out repeatedly is a
> > questionable security practice.
> 
> You've done no such thing - you've pointed out that
> automated relabeling without timing control by the sysadmin
> is potentially dangerous. I don't see why that means that
> automated relabeling (as in..performed internally, and not by
> chcon) in general is a bad thing. I'm not sure what you mean by
> "runtime labeling".
> 

If there was no expectation that the user home directories would not be
relabeled (e.g., via restorecon) as a normal part of running a system then there
would be no reason to generate the file contexts. The home directory would be
labeled upon creation.

As for the general concept of runtime labeling - I mean labeling other than at
initialization time (system installation, user addition, etc.). I have often
argued against runtime labeling - maybe not in this thread but other places. It
is often unsafe and leads towards discretionary access control.

I'm not certain this is possible in the real world, but I think it is the
correct goal.

> > More importantly, we have just decided to remove specific user information
> from
> > the policy and leaving it in the file contexts seems strange.
> 
> The file contexts serves a different purpose.
> I agree with you in that I don't like having hundreds of files there,
> but at the same time I don't see an alternative.

Different purpose, but the file contexts are closely tied to the policy.

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
