Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5TIIXgA014841
	for <selinux@tycho.nsa.gov>; Wed, 29 Jun 2005 14:18:33 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5TIHd79016768
	for <selinux@tycho.nsa.gov>; Wed, 29 Jun 2005 18:17:39 GMT
Message-Id: <200506291817.j5TIHQ7f013656@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <gyurdiev@redhat.com>
Cc: <selinux@tycho.nsa.gov>, "'Daniel J Walsh'" <dwalsh@redhat.com>
Subject: RE: file contexts and modularity
Date: Wed, 29 Jun 2005 14:17:26 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-reply-to: <1120066109.20484.19.camel@celtics.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Ivan Gyurdiev [mailto:gyurdiev@redhat.com]
> Sent: Wednesday, June 29, 2005 1:28 PM
> To: Karl MacMillan
> Cc: selinux@tycho.nsa.gov; 'Daniel J Walsh'
> Subject: RE: file contexts and modularity
> 
> The more I think about this, the more it seems to me that:
> 
> 1) Expansions are important, and not to be considered a hack -
> they're our only way to create configurable locations,
> which we need, since users don't like to comply with our
> standard locations. Expansions don't necessarily relate to home
> directories, as I've pointed out.
> 

I still don't agree with this - how do you know how to expand these if it is not
tied to a specific user? Additionally, all of this is caused by using file
contexts for runtime labeling, which I have pointed out repeatedly is a
questionable security practice.

> 2) We need a generic mechanism for installing
> such expansions, and checking those...
> 
> 3) Performing expansion of template in matchpathcon seems
> fundamentally wrong to me. The expansion would be performed
> on every invocation, and that would be slow, and unnecessary -
> if it's already computed, why not use it?
> 

Fundamentally wrong seems a little strong - this is just a space / time tradeoff
not a major architectural decision.

> 4) A context file for each user? Hmm...
> 500 users...500 files...concat those together?
> A large context file with all the users in it doesn't
> seem a whole lot better.
> 
> [root@celtics files]# cat file_contexts|wc
>    2384    6045  102497
> 
> [root@celtics files]# cat file_contexts.homedirs|grep root|wc
>      47     118    2755
> 
> So... say we have a machine with 500 users.
> 500 * 47 = 23500 lines, or 10 times the size of the current
> file_contexts file, which takes forever to read (that's
> why install is so slow, right?)
> 
> I don't think the current file_contexts approach scales too
> well with lots of users...

More importantly, we have just decided to remove specific user information from
the policy and leaving it in the file contexts seems strange.

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
