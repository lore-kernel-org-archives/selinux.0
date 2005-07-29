Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6TJacgA003397
	for <selinux@tycho.nsa.gov>; Fri, 29 Jul 2005 15:36:38 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6TJUcC2007523
	for <selinux@tycho.nsa.gov>; Fri, 29 Jul 2005 19:30:38 GMT
Subject: Re: file context ordering
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <42EA046A.1010405@redhat.com>
References: <1122578160.20983.14.camel@sgc.columbia.tresys.com>
	 <42EA046A.1010405@redhat.com>
Content-Type: text/plain
Date: Fri, 29 Jul 2005 15:30:43 -0400
Message-Id: <1122665443.20983.66.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-07-29 at 06:26 -0400, Daniel J Walsh wrote:
> Christopher J. PeBenito wrote:
> >One of the problems we've come against with reference policy (also in
> >loadable modules) is the fact that the file context specifications are
> >not ordered correctly, since the system file_contexts are taken from the
> >modules and concatenated in an arbitrary order.  The matchpathcon code
> >finds a match by going through all of the specs, and the last one that
> >is matched is used.
[cut]
> >This still does not end up being perfect, since we have specs that are
> >of about the same specificity, and end up being in a different order
> >then the current fc.  For example, these two specs end up being in the
> >opposite order that they are in the NSA example policy:
> >
> >/usr(/.*)?/bin(/.*)?        system_u:object_r:bin_t
> >/usr(/.*)?/lib(64)?(/.*)?   system_u:object_r:lib_t
> >
> >  
> >
> We could add on a case by case basis
> 
> /usr(/.*)?/lib(64)?(/.*)?/bin(/.*)?   system_u:object_r:bin_t

This would be a good solution for now.  I still feel that, if possible,
we should find a generic solution.

> Or hard code some hierarchy where bin_t is always after lib_t in this
> situation.
> 
> I would doubt we would have /usr/bin/lib/...

Well hard coding it isn't the answer, especially since this is just one
example.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
