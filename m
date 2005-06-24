Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5OIaagA009187
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 14:36:36 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5OIa02B001820
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 18:36:00 GMT
Message-Id: <200506241836.j5OIaJqc018526@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <gyurdiev@redhat.com>
Cc: <selinux@tycho.nsa.gov>
Subject: RE: Alternative user management approach
Date: Fri, 24 Jun 2005 14:36:20 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1119637767.31852.48.camel@celtics.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Ivan Gyurdiev [mailto:gyurdiev@redhat.com]
> Sent: Friday, June 24, 2005 2:29 PM
> To: Karl MacMillan
> Cc: selinux@tycho.nsa.gov
> Subject: Re: Alternative user management approach
> 
> On Fri, 2005-06-24 at 14:10 -0400, Ivan Gyurdiev wrote:
> > > 1) Reloading the kernel policy on user change just seems . . . wrong.
> > > 2) Having the users in the kernel can be problematic for large numbers of
> users.
> > > 3) These problems get much worse if we are talking about large,
> distributed user
> > > databases. Are sites with 10,000 users going to force a policy reload on
> every
> > > machine every time a user is added? Are all 10,000 users going to be
> stored in
> > > the kernel?
> >
> > > Normal Linux users are then mapped to user roles by username or group
> membership
> > > (this should be done by libselinux and not involve the kernel). For
> example, if
> > > the primary group of the user is wheel then they could be assigned to
> staff,
> > > root assigned to sysadm, and everyone else to normal. This makes the
> addition of
> > > a user roughly equivalent to adding roles - something done by a policy
> developer
> > > that does not need to be done as part of normal system administration.
> >
> > So you're taking away the sysadmin's ability to define fine-grained
> > role membership, and replace it with giving the sysadmin the ability
> > to define coarse-grained "role class" membership, and each "role class"
> > is determined by the policy developer...hmm
> >
> > Not sure I like this...although I see the scalability concern.
> 
> Also, what's to stop you from implementing this with the current
> mechanism?
> 
> The "role class" could be the SElinux user.
> 
> Then useradd could be changed to only reload policy if you're adding
> new SElinux users ("role classes"). Better - useradd would stay
> unchanged, and a new application would be written called
> classadd or something.
> 

That sounds good to me, actually. No need to remove the local.users
infrastructure - we can just use it for the role users.

> Then you'd still need to map users to their SELinux users/classes
> though..

Which will be done by login processes through libselinux. Haven't looked, but it
may not even need an api change.

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
