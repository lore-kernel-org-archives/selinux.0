Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA18111
	for <selinux@tycho.nsa.gov>; Fri, 6 Apr 2001 10:14:36 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA07424
	for <selinux@tycho.nsa.gov>; Fri, 6 Apr 2001 14:14:14 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id OAA07420
	for <selinux@tycho.nsa.gov>; Fri, 6 Apr 2001 14:14:14 GMT
Date: Fri, 6 Apr 2001 10:13:25 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
Reply-To: Stephen Smalley <sds@tislabs.com>
To: Amon Ott <ao@rsbac.org>
cc: selinux@tycho.nsa.gov, rsbac@compuniverse.de
Subject: Re: Rule Set Based Access Control (RSBAC)
In-Reply-To: <01040611503700.00863@marvin>
Message-ID: <Pine.SOL.3.95.1010406085528.16554B-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> The definition and assignment of roles and types must be done by two PM
> roles working together, and that within a given time limit. These roles are
> first Data Protection Officer and second Security Manager.
> The TP definition and labelling must also be done by two different roles within
> a given time limit. This time the roles are TP Manager and Security Officer.
> This might be possible. However, we are already far away from the term 'easy'.
> And again, definition and assignment of purposes and tasks need two roles
> working together within a time limit.

RBAC/TE can model n-person control through pipelines.  As far
as time limits go, that does not appear to be a fundamental requirement
for the model, just an implementation detail due to your ticket-based
approach.  If you really want a time-based policy, then I would
agree that TE itself is not sufficient to represent it, although
you could easily add such policy logic to the example security server.
I also question the practicality of enforcing this PM policy in
the operating system itself, as opposed to requiring some application
enforcement mechanisms.  In real-world environments, are the personal
data and tasks really implemented just with the operating system
abstractions and services, or are they implemented as application
abstractions and services (e.g. a distributed database system)?

> What, if users must for some reasons be allowed to create or modify
> executables, e.g. software developers? How will you know, if the modification
> on behalf of the user was done by malicious code without consent?

You can protect different classes of users from each other by
not allowing them to execute each other's programs, while still
allowing them to create and execute their own programs.  You
can ensure that any programs downloaded via their web browser
are automatically placed into restricted domains that cannot
modify the user's files except for a restricted set.  You could
define a pipeline for the creation of executable programs that
requires that an application virus scanner approve the program
before any execution, and prohibit subsequent modification
without rescanning.  I'm not fundamentally opposed to virus
scanners, and you can use OS access control to protect application virus
scanners against bypass or tampering, but I'm not sure about embedding
them in the OS itself.

>RC's strong administration settings are sure my main objection. It 
>enables separate administration areas, which can be e.g. used to
>effectively create separate, but possibly overlapping work groups.

The "overlapping" is the area of concern.  What prevents the
administrator of one work group from subverting the intended protections
of another work group by granting his roles permissions to types
that are also accessible/used by the other work group?

> How does TE enforce *-property? How many roles and types would TE need
to
> represent all permutations of 253 levels and 64 compartments?

You can represent both properties simply by defining an access matrix
of clearances and classifications, and defining the permissions for
each pairing so that there are no read-ups or write-downs.  I agree
that it would be cumbersome to represent a large lattice in TE,
which is why we provide a separate MLS policy module.  But some
people would probably be fine with a very small number of levels
and compartments.

> Do you also have the concept of only certain programs or processes being able
> to extend the set of accessible user ids, e.g. to enforce proper authentication
> by only a privileged set of programs (AUTH attribute auth_may_set_cap)?

We can restrict the ability to set the user identity attribute to 
specific programs/processes, and we can specify what user identity
attributes are reachable by a particular program/process.

> You did not claim to be able to emulate a combination of RSBAC models with TE,
> but combinations are part of the RSBAC framework design.

You can provide combinations through the TE configuration, either
by defining separate sets of domains and types to address each
individual model (if they are being applied to separate subjects
and data sets) or by defining a set of complex domains and types
that combine attributes appropriately.  But you can also 
add other policy modules to the example security server, like
the MLS policy module, if desired.  However, this is an area
where RSBAC has an advantage - our example security server does
not provide a framework for easily composing modules like the
RSBAC ADF.  Of course, such a framework could be implemented
in our security server without changing anything else in the
system, since the policy and labels are cleanly encapsulated.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
