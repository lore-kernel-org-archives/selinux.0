Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5OIsZgA009485
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 14:54:35 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5OIrx2B002773
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 18:53:59 GMT
Subject: RE: Alternative user management approach
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <200506241836.j5OIaJqc018526@gotham.columbia.tresys.com>
References: <200506241836.j5OIaJqc018526@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 24 Jun 2005 14:52:04 -0400
Message-Id: <1119639124.31852.69.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

cc-ed Dan Walsh...

Please take a look at this proposal.
The suggestion is that we use more generic "SELinux users"
instead of creating an selinux user for every user.

> > Also, what's to stop you from implementing this with the current
> > mechanism?
> > 
> > The "role class" could be the SElinux user.
> > 
> > Then useradd could be changed to only reload policy if you're adding
> > new SElinux users ("role classes"). Better - useradd would stay
> > unchanged, and a new application would be written called
> > classadd or something.
> > 
> 
> That sounds good to me, actually. No need to remove the local.users
> infrastructure - we can just use it for the role users.
> 
> > Then you'd still need to map users to their SELinux users/classes
> > though..
> 
> Which will be done by login processes through libselinux. Haven't looked, but it
> may not even need an api change.

How exactly would this be done.
Currently there's a 1:1 maping from user to selinux user. I assumed this
is hardcoded - is this not the case? I'm not sure what login utilities
do..

If it is hardcoded, it needs to
be made configurable, and integrated w/ useradd utilities.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
