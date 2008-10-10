Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9AEULEQ013761
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2008 10:30:21 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id m9AET8ug024132
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2008 14:29:08 GMT
Subject: Re: per role template confusion
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Joe Nall <joe@nall.com>
Cc: Joshua Brindle <method@manicmethod.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <6806EA76-C00D-4152-AEF1-3F403E3B574B@nall.com>
References: <00473A36-B9E3-4481-A2AC-7D5623741AB5@nall.com>
	 <48EE688E.8040507@manicmethod.com>
	 <668EB1B5-63B3-4491-8904-619127F6DE67@nall.com>
	 <1223643494.2165.148.camel@gorn>
	 <6806EA76-C00D-4152-AEF1-3F403E3B574B@nall.com>
Content-Type: text/plain
Date: Fri, 10 Oct 2008 10:29:26 -0400
Message-Id: <1223648966.2165.154.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-10-10 at 09:03 -0500, Joe Nall wrote:
> On Oct 10, 2008, at 7:58 AM, Christopher J. PeBenito wrote:
> 
> > On Thu, 2008-10-09 at 18:17 -0500, Joe Nall wrote:
> >> On Oct 9, 2008, at 3:24 PM, Joshua Brindle wrote:
> >>
> >>> Joe Nall wrote:
> >>>> Can someone explain the per role template implementation? I am
> >>>> confused.
> >>>>
> >>>> During policy compilation, a .mod.role file is created that just
> >>>> references the roles in /usr/share/selinux/devel/include/rolemap
> >>>> regardless of the roles defined via semanage. Should semanage add
> >>>> roles to rolemap? Is there additional magic in semodule?
> >>>>
> >>>> joe
> >>>
> >>> Roles aren't created by semanage, only user->role mappings. The
> >>> per_role_template creates derived types for each role (eg.,
> >>> staff_mozilla_t, sysadm_mozilla_t). These roles are defined in the
> >>> policy only.
> >>
> >> Ok. I thought the role statement just did type mapping and did not
> >> realize there was an implicit role declaration.
> >>
> >> I would still like an explanation of how this works and if/how new
> >> roles are handled with respect to per role templates.
> >
> > For each entry in the rolemap file, the infrastructure calls the
> > [modulename]_per_role_template() for each module, if it exists.
> 
> The compilation infrastructure - correct?

I should have more specific: the refpolicy build infrastructure

> So to add a new role I need to add it to the rolemap and rebuild the  
> whole policy?

You only need to add it to the rolemap only if you want it to
automatically call all of the per_role_templates().  Otherwise you can
just call specific ones manually.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
