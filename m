Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5OIg0gA009324
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 14:42:00 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5OIfO2B002245
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 18:41:24 GMT
Message-Id: <200506241841.j5OIfiqc018618@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <gyurdiev@redhat.com>, "'Brian T. Sniffen'" <bsniffen@mitre.org>
Cc: <selinux@tycho.nsa.gov>
Subject: RE: Alternative user management approach
Date: Fri, 24 Jun 2005 14:41:45 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1119637960.31852.51.camel@celtics.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Ivan Gyurdiev [mailto:gyurdiev@redhat.com]
> Sent: Friday, June 24, 2005 2:33 PM
> To: Brian T. Sniffen
> Cc: Karl MacMillan; selinux@tycho.nsa.gov
> Subject: Re: Alternative user management approach
> 
> On Fri, 2005-06-24 at 14:09 -0400, Brian T. Sniffen wrote:
> > "Karl MacMillan" <kmacmillan@tresys.com> writes:
> >
> > > This makes the SELinux user more what we are calling a 'user
> > > role'. For example, the policy could create 3 user roles with
> > > different role authorizations (which become 'role capabilities'):
> >
> > This seems like a great innovation.  But it does inherit one problem
> > of generic user_u: there's no longer any MAC separating users.  If I'm
> > a normal user, my shell has exactly the same security context as your
> > shell---right?
> 
> Is the user info used for anything besides rbac?
> I don't think it is...
> 

It can be used for constraints. There have been some suggested uses for this,
but none are currently implemented in real policies. User separation seems
better left to DAC.

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
