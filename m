Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA12510
	for <selinux@tycho.nsa.gov>; Tue, 23 Jan 2001 11:37:02 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id QAA19016
	for <selinux@tycho.nsa.gov>; Tue, 23 Jan 2001 16:36:23 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id QAA19012
	for <selinux@tycho.nsa.gov>; Tue, 23 Jan 2001 16:36:22 GMT
Received: from coalstove.epoch.ncsc.mil (coalstove [144.51.25.13])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA03099
	for <selinux@tycho.nsa.gov>; Tue, 23 Jan 2001 11:36:58 -0500 (EST)
Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA12329
	for <selinux@tycho.nsa.gov>; Tue, 23 Jan 2001 11:13:56 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id QAA18019
	for <selinux@tycho.nsa.gov>; Tue, 23 Jan 2001 16:13:16 GMT
Received: from fledge.watson.org (fledge.watson.org [204.156.12.50])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id QAA18015
	for <selinux@tycho.nsa.gov>; Tue, 23 Jan 2001 16:13:16 GMT
Date: Tue, 23 Jan 2001 11:13:34 -0500 (EST)
From: Robert Watson <rwatson@freebsd.org>
To: Stephen Smalley <sds@tislabs.com>
cc: Christoph Hellwig <hch@ns.caldera.de>, selinux@tycho.nsa.gov,
        linux-privs-discuss@sourceforge.net
Subject: Re: [Linux-privs-discuss] SELinux & Linux-privs projects
In-Reply-To: <Pine.SOL.3.95.1010111115658.23465U-100000@clipper.gw.tislabs.com>
Message-ID: <Pine.NEB.3.96L.1010123105341.39569C-100000@fledge.watson.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


On Thu, 11 Jan 2001, Stephen Smalley wrote:

> On Thu, 11 Jan 2001, Christoph Hellwig wrote:
> 
> > > It is also quite different
> > > from POSIX.1e mandatory access controls, which are tied to a 
> > > specific kind of mandatory security policy.
> > 
> > Capabilities and mac are of course different, otherwise you probably
> > won't find them in the same posix standard...
> 
> I guess my antecedent was ambiguous.  I was trying to say that the
> SELinux mandatory access controls are quite different from POSIX.1e
> mandatory access controls, because SELinux provides a flexible mandatory
> access control architecture that can support many different kinds of
> security policies while POSIX.1e is limited to a particular kind of
> security policy (multi-level security, and perhaps Biba integrity or
> other lattice-based models).  SELinux can support lattice-based models
> like multi-level security, but it can also support Type Enforcement,
> Role-Based Access Control, and other models.  So POSIX.1e MAC only does
> a subset of what SELinux does. 

I've run into a few limitations in the POSIX.1e MAC interface that I've
needed to work around and suggest directions for future improvement if
there's any desire towards moving to a more general MAC framework:

1) Dominance operator required -- mac_dominate() must return true, false,
   or an error (EINVAL), but is unable to return that dominance is
   undefined.  For un-ordered or partially ordered MAC schemes, this will
   cause problems for applications that rely on the ordering.  In this
   case, mac_dominate()  will often (or always) return 0, making it less
   useful; as it's not clear that mac_dominate() will be meaningful in an
   environment and if it is, what it means may not be consistent. 

2) Limited support for compound labels -- when more than one scheme is in
   use at a time, a compound mac label is required.  However, the
   dominance operator may be defined differently for different components
   of the label (for example, Biba dominate differs from MLS dominate). 
   When moving to different or more complex schemes, it's easy to imagine
   situations where mac_dominate() has to combine inconsistent results,
   and presumably always return 0 as a result. 

3) mac_dominate() is not meaningful without understanding the policy in
   question: that is, a userland application cannot use it for policy
   evaluation to determine whether a given operation on a given object is
   permitted, because mac_dominate() isn't an "is this allowed" request,
   it has to do with label relationships. 

Everyone has their own feelings on general access control frameworks and
policy mechanisms, but my feeling is that there are a number of
improvements that could be made to POSIX.1e to improve its usefulness with
regards to more arbitrary MAC policies.  This would include functions that
request an access control determination for a pair of labels and an
operation identifier, functions to determine inheritence when a subject
spawns a new object from an existing object (file from directory, packet
from interface, MIB hiearchies, etc), and so on.  Also, an interface to
push requests concerning MAC labels based on knowledge of the syntax and
semantics of a component of the label, but without assumptions in the
interface about what those might be.  In addition, a way to determine what
components of the label are available, and properties of the policy
enforcement environment. 

This won't allow applications invoking privilege to manage mandatory
labels to be completely free of knowledge of a policy, but it will allow
the application that is aware of one component of the policy to override
the policy via general interfaces, at the same time as not overriding
policies that it doesn't understand, or isn't intended to manipulate. 
Similarly, it will allow applications maintaining objects to rely on the
system policy evaluation when enforcing protections on these internal
objects.  The SELinux implementation allows some aspects of this (in
particular, allowing applications to use the standard system policy and
access control mechanisms), as does the NAI DTE implementation.  POSIX.1e
begins the process of moving towards a general labeling mechanism, and
though some changes could better support the kind of environment that I
envision.

Robert N M Watson             FreeBSD Core Team, TrustedBSD Project
robert@fledge.watson.org      NAI Labs, Safeport Network Services





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
