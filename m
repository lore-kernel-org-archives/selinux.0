Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id DAA29656
	for <selinux@tycho.nsa.gov>; Mon, 9 Apr 2001 03:37:17 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id HAA28769
	for <selinux@tycho.nsa.gov>; Mon, 9 Apr 2001 07:36:48 GMT
Received: from mailout01.sul.t-online.com (mailout01.sul.t-online.com [194.25.134.80])
	by jazzswing.ncsc.mil  with ESMTP id HAA28765
	for <selinux@tycho.nsa.gov>; Mon, 9 Apr 2001 07:36:47 GMT
From: Amon Ott <ao@rsbac.org>
To: selinux@tycho.nsa.gov, rsbac@compuniverse.de
Subject: Re: Rule Set Based Access Control (RSBAC)
Date: Mon, 9 Apr 2001 08:21:36 +0200
Content-Type: text/plain
References: <Pine.SOL.3.95.1010406085528.16554B-100000@clipper.gw.tislabs.com>
In-Reply-To: <Pine.SOL.3.95.1010406085528.16554B-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Message-Id: <01040909364301.01204@marvin>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fre, 06 Apr 2001 Stephen Smalley wrote:
> enforcement mechanisms.  In real-world environments, are the personal
> data and tasks really implemented just with the operating system
> abstractions and services, or are they implemented as application
> abstractions and services (e.g. a distributed database system)?

They are modelled with OS abstractions. Simone is the right person to go deeper
into model details.

> >RC's strong administration settings are sure my main objection. It 
> >enables separate administration areas, which can be e.g. used to
> >effectively create separate, but possibly overlapping work groups.
> 
> The "overlapping" is the area of concern.  What prevents the
> administrator of one work group from subverting the intended protections
> of another work group by granting his roles permissions to types
> that are also accessible/used by the other work group?

You can only grant permissions to types that your own role is allowed to access
control. Overlapped types would have to be access controlled by some mediator.
Anyway, in my workgroup example I did not say that the workgroup leaders were
allowed to do any access control settings. They could only assign their
necessary roles to those users, who already have one of these roles.

I was mostly thinking of common roles that could be assigned by both - but
only, if the previous role could also be assigned. You can e.g. use such common
roles to transfer a user account from one workgroup to another, or to establish
a mediator between both groups. The default user role 0 must be in each leaders
role assign set to assign roles to new users.

> > How does TE enforce *-property? How many roles and types would TE need
> to
> > represent all permutations of 253 levels and 64 compartments?
> 
> You can represent both properties simply by defining an access matrix
> of clearances and classifications, and defining the permissions for
> each pairing so that there are no read-ups or write-downs.  I agree
> that it would be cumbersome to represent a large lattice in TE,
> which is why we provide a separate MLS policy module.  But some
> people would probably be fine with a very small number of levels
> and compartments.

Your separate MLS module suits as an answer for me that it is not easily done.
 
> > Do you also have the concept of only certain programs or processes being able
> > to extend the set of accessible user ids, e.g. to enforce proper authentication
> > by only a privileged set of programs (AUTH attribute auth_may_set_cap)?
> 
> We can restrict the ability to set the user identity attribute to 
> specific programs/processes, and we can specify what user identity
> attributes are reachable by a particular program/process.

My description was unclear. With AUTH model, certain privileged processes can
grant setuid capabilities to *other* processes. So if you have an authentication
daemon, this daemon grants the requesting process the capability to setuid to
the authenticated account - nothing more. If authentication fails, setuid will
fail, too.

Amon.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
