Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A730728504F;
	Wed, 24 Sep 2025 08:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702341; cv=none; b=lO6E58NnGNfFitytbWrlmcefoXS5VUuAGHd1dT24VwBA+4ybHepo8j7bONNQFEv8N1BQAT08/dBpRTpu0cSVTA8wgRKQgDuRWlV/OqANxGBy4An/t5Zf1QmwftGq7OMFXV46EUCjSCK09HtL10Ph3CR7Hl9ZYz9HzOrgglxmKmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702341; c=relaxed/simple;
	bh=C9UfaUa1wI4TUrVddzmafn/v0AzLRR2mO0sv1bo1fj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BuVfHD1qtVBBuzM6g/OvmPBsUa93lch42Dx7w3fR3PwuDb/fxx1kI6+Nxso/wnEd9BbOn9NG1yT7srhgYKi2NlgAayKCR3WCofjWywaVfXZE/FlZjDhV6N4/SiwmB2DF7ZzyKvKShW0UIpe8JmZu2M1Hlkf1o4ni43i0GRfERYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 58O88gmH016319;
	Wed, 24 Sep 2025 03:08:42 -0500
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 58O88fr8016318;
	Wed, 24 Sep 2025 03:08:41 -0500
Date: Wed, 24 Sep 2025 03:08:41 -0500
From: "Dr. Greg" <greg@enjellic.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        paul@paul-moore.com, omosnace@redhat.com, john.johansen@canonical.com,
        serge@hallyn.com, casey@schaufler-ca.com
Subject: Re: [RFC PATCH v2] lsm,selinux: introduce LSM_ATTR_UNSHARE and wire it up for SELinux
Message-ID: <20250924080840.GA16185@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20250918135904.9997-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918135904.9997-2-stephen.smalley.work@gmail.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Wed, 24 Sep 2025 03:08:43 -0500 (CDT)

On Thu, Sep 18, 2025 at 09:59:05AM -0400, Stephen Smalley wrote:

Good morning, I hope the week is going well for everyone.

> RFC-only, will ultimately split the LSM-only changes to their own
> patch for submission. I have now tested this with the corresponding
> selinux userspace change that you can find at
> https://lore.kernel.org/selinux/20250918135118.9896-2-stephen.smalley.work@gmail.com/
> and also verified that my modified systemd-nspawn still works when
> starting containers with their own SELinux namespace.
> 
> This defines a new LSM_ATTR_UNSHARE attribute for the
> lsm_set_self_attr(2) system call and wires it up for SELinux to invoke
> the underlying function for unsharing the SELinux namespace. As with
> the selinuxfs interface, this immediately unshares the SELinux
> namespace of the current process just like an unshare(2) system call
> would do for other namespaces. I have not yet explored the
> alternatives of deferring the unshare to the next unshare(2),
> clone(2), or execve(2) call and would want to first confirm that doing
> so does not introduce any issues in the kernel or make it harder to
> integrate with existing container runtimes.
> 
> Differences between this syscall interface and the selinuxfs interface
> that need discussion before moving forward:
> 
> 1. The syscall interface does not currently check any Linux capability
> or DAC permissions, whereas the selinuxfs interface can only be set by
> uid-0 or CAP_DAC_OVERRIDE processes. We need to decide what if any
> capability or DAC check should apply to this syscall interface and if
> any, add the checks to either the LSM framework code or to the SELinux
> hook function.
> 
> Pros: Checking a capability or DAC permissions prevents misuse of this
> interface by unprivileged processes, particularly on systems with
> policies that do not yet define any of the new SELinux permissions
> introduced for controlling this operation. This is a potential concern
> on Linux distributions that do not tightly coordinate kernel updates
> with policy updates (or where users may choose to deploy upstream
> kernels on their own), but not on Android.
> 
> Cons: Checking a capability or DAC permissions requires any process
> that uses this facility to have the corresponding capability or
> permissions, which might otherwise be unnecessary and create
> additional risks. This is less likely if we use a capability already
> required by container runtimes and similar components that might
> leverage this facility for unsharing SELinux namespaces.
> 
> 2. The syscall interface checks a new SELinux unshare_selinuxns
> permission in the process2 class between the task SID and itself,
> similar to other checks for setting process attributes. This means
> that:
>     allow domain self:process2 *; -or-
>     allow domain self:process2 ~anything-other-than-unshare_selinuxns; -or-
>     allow domain self:process2 unshare_selinuxns;
> would allow a process to unshare its SELinux namespace.
> 
> The selinuxfs interface checks a new unshare permission in the
> security class between the task SID and the security initial SID,
> likewise similar to other checks for setting selinuxfs attributes.
> This means that:
>     allow domain security_t:security *; -or-
>     allow domain security_t:security ~anything-other-than-unshare; -or-
>     allow domain security_t:security unshare;
> would allow a process to unshare its SELinux namespace.
> 
> Technically, the selinuxfs interface also currently requires open and
> write access to the selinuxfs node; hence:
>     allow domain security_t:file { open write };
> is also required for the selinuxfs interface.
> 
> We need to decide what we want the SELinux check(s) to be for the
> syscall and whether it should be more like the former (process
> attributes) or more like the latter (security policy settings). Note
> that the permission name itself is unimportant here and only differs
> because it seemed less evident in the process2 class that we are
> talking about a SELinux namespace otherwise.
> 
> Regardless, either form of allow rule can be prohibited in policies
> via neverallow rules on systems that enforce their usage
> (e.g. Android, not necessarily on Linux distributions).
> 
> 3. The selinuxfs interface currently offers more functionality than I
> have implemented here for the sycall interface, including:
> 
> a) the ability to read the selinuxfs node to see if your namespace has
> been unshared, which should be easily implementable via
> lsm_get_self_attr(2).  However, questions remain as to when that
> should return 1 versus 0 (currently returns 1 whenever your namespace
> is NOT the initial SELinux namespace, useful for the testsuite to
> detect it is in a child, but could instead be reset to 0 by a
> subsequent policy load to indicate completion of the setup of the
> namespace, thus hiding from child processes that they are in a child
> namespace once its policy has been loaded).
> 
> b) the abilities to get and set the maximum number of SELinux
> namespaces (via a /sys/fs/selinux/maxns node) and to get and set the
> maximum depth for SELinux namespaces (via a /sys/fs/selinux/maxnsdepth
> node). These could be left in selinuxfs or migrated to some other LSM
> management APIs since they are global in scope, not per-process
> attributes.

We had a number of exchanges regarding LSM namespacing in the thread
that Paul Moore started on this issue:

https://lore.kernel.org/linux-security-module/CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com/

The one issue that seemed to achieve universal consensus was that
every LSM was going to have different requirements for namespacing.

At the risk of playing devil's advocate, this seems to raise the
question as to whether or not there is a need to have a common API for
requesting security namespace separation or leave the issue to LSM
specific implementations.

The primary rationale for some modicum of centralized infrastructure
would seem to be to have a system call rather than an LSM specific
pseudo-filesystem interface to control security namespaces.  Since
creating a system call interface is going to lock the API in stone it
would seem that we would want to get this right, or at least as
generic as possibe.

So some comments to that end.

If we use the lsm_set_self_attr(2) system call as our approach, the
namespace separation process needs to be split into two separate
calls.  One to request the creation of a namespace and a second call
to request that the process join the new namespace.

This is required in order to support the ability for an orchestration
process to load a policy or model and have it in place before the new
namespace is allowed to enforce the policy or model.

So we would need something like an LSM_ATTR_UNSHARE_INIT as well as
the LSM_ATTR_UNSHARE attribute.

So the model would be for a process to issue an LSM_ATTR_UNSHARE_INIT
call to create the new security context namespace.  That namespace
context can then be configured through either an LSM specific
pseudo-filesystem interface or alternatively through additional calls
to lsm_set_self_attr(2).

Once the configuration process is complete, the process would be set
free in its new namespace with the LSM_ATTR_UNSHARE attribute.

Separating from a security policy namespace to a new namespace will be
one of the most security sensitive operations that a system can
execute.  As such it has to be gated by some type of security control.

At a minimum this needs to be uid-0 or posession of CAP_MAC_ADMIN.
Given the current LSM concept of stacking, there needs to be an LSM
security hooks assigned, so as to give all of the LSM's an opportunity
to accept or deny the attribute operations.

For example, it would seem entirely reasonable that the lockdown LSM
may want to deny the ability to create any departures from the current
security configuration.

Making this generic for any security namespace will require some
additional plumbing, most notably the ability for any LSM to register
for the ability to receive namespace event notifications.  If we
create new security_task_secns_init() and
security_task_secns_unshare() hooks we could use those as both
notification and security control mechanisms.

So lots of details to discuss but the above should be about the most
generic implementation that can be leveraged by all of the LSM's.

Comments/suggestion welcome.

Have a good remainder of the week.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project
