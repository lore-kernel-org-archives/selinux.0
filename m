Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r6NDsTxY026405
	for <selinux@tycho.nsa.gov>; Tue, 23 Jul 2013 09:54:29 -0400
Message-ID: <51EE8B0F.4090103@tresys.com>
Date: Tue, 23 Jul 2013 09:54:23 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Sven Vermeulen <sven.vermeulen@siphos.be>
CC: <refpolicy@oss1.tresys.com>, <selinux@tycho.nsa.gov>
Subject: Re: [refpolicy] Want to make typeattribute declarations possible
 in conditionals
References: <20130723122207.GA21664@siphos.be>
In-Reply-To: <20130723122207.GA21664@siphos.be>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 7/23/2013 8:22 AM, Sven Vermeulen wrote:
> I would like to be able to assign attributes to types in a conditional
> statement. Right now, this isn't allowed, and I don't know if it is feasible

Definitely a question for main SELinux list.

> to look for a solution to this or not. Is this a real design constraint that
> will be hard to work around, or is this doable?

It would require kernel changes.  Someone else can be more specific about the challenges for implementing it, but the one complication I can think of off the top of my head is that attributes are expanded in the base module during compile time.

> Alternatives that I see are:

What I had always hoped would alleviate this was the tunable implementation.  I was hoping it would have the same statement constraints as an optional, but instead of being controlled by dependence, it would be controlled by a Boolean or a Boolean expression (separate ones from the current booleans).  I think that almost all of the conditional policy we have right now should be tunable instead, since they are changes you make once (e.g. NFS home dirs), so it makes more sense as a link-time configuration option (aka tunable).  Then you wouldn't be wasting kernel memory on options you'll never toggle again.  That would eliminate the implementation issues of having conditional type attributes or conditional role* statements.

However, the current implementation leverages the current conditionals; thus, it has the same constraints on usage.  Right now I think the best bet is to get CIL up and running, because it should have appropriate infrastructure for tunables as I described above.

> - making the assignations part of separate, small SELinux modules that users can unload/load

I think Fedora does this a little.  I am resistant to upstreaming it since it really breaks encapsulation.

> - using interfaces that assign the permissions to the given domain, and use
>   this interface against the attribute. This will probably result in two
>   interfaces, foo_domain() to assign the attribute (for non-tunable usage)
>   and foo_domain_privileges() to assign the rights (for tunable usage) -
>   naming convention notwithstanding here.

We have a little of this, but I'd like to eliminate it because it breaks abstraction.  The hope is that the implementation of the interface shouldn't affect how a caller uses it.

> - decouple the requirement from the policy and let administrators do this
> 
> The last approach means that the policy doesn't include the definitions
> anymore, instead providing a method (in the SELinux userspace utilities or
> distribution-specific) to assign attributes.

I'm a little surprised that you'd suggest that, as it makes more work for distro maintainers.  I'd be reluctant to do this, since it makes stock refpolicy less useful as a starting point for a system policy.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
