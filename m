Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9ACx6DK028436
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2008 08:59:06 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id m9ACvsug001252
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2008 12:57:54 GMT
Subject: Re: per role template confusion
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Joe Nall <joe@nall.com>
Cc: Joshua Brindle <method@manicmethod.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <668EB1B5-63B3-4491-8904-619127F6DE67@nall.com>
References: <00473A36-B9E3-4481-A2AC-7D5623741AB5@nall.com>
	 <48EE688E.8040507@manicmethod.com>
	 <668EB1B5-63B3-4491-8904-619127F6DE67@nall.com>
Content-Type: text/plain
Date: Fri, 10 Oct 2008 08:58:14 -0400
Message-Id: <1223643494.2165.148.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2008-10-09 at 18:17 -0500, Joe Nall wrote:
> On Oct 9, 2008, at 3:24 PM, Joshua Brindle wrote:
> 
> > Joe Nall wrote:
> >> Can someone explain the per role template implementation? I am  
> >> confused.
> >>
> >> During policy compilation, a .mod.role file is created that just  
> >> references the roles in /usr/share/selinux/devel/include/rolemap  
> >> regardless of the roles defined via semanage. Should semanage add  
> >> roles to rolemap? Is there additional magic in semodule?
> >>
> >> joe
> >
> > Roles aren't created by semanage, only user->role mappings. The  
> > per_role_template creates derived types for each role (eg.,  
> > staff_mozilla_t, sysadm_mozilla_t). These roles are defined in the  
> > policy only.
> 
> Ok. I thought the role statement just did type mapping and did not  
> realize there was an implicit role declaration.
> 
> I would still like an explanation of how this works and if/how new  
> roles are handled with respect to per role templates.

For each entry in the rolemap file, the infrastructure calls the
[modulename]_per_role_template() for each module, if it exists.

If (u|r)bacsep succeeds, this will be dropped in favor of explicit
calls.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
