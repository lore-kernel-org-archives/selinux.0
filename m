Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE55335950;
	Mon, 29 Sep 2025 03:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759117307; cv=none; b=MUIo4qaTlzAlcxtq/XdrB0AYWoT7ouJ/O8QRTdQOiiybmZe2evnEgt1bTC28eTRmCS45Kw5BNa5jZYsPPbtJ/PCqMt/Gvrdi22trnbUneX3roZcJK9e5zHdcx3U1ONBEN5H79bxufhFRNK2vuYulBuQg8UFLPMngBxS09QfmzdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759117307; c=relaxed/simple;
	bh=edY+QVn4MIE8WuzJcqhZJ5eKNi8UDrmAaKSHz1D9QQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dq2pxDBoXdV551V61zp/vJ7Si/0m+Xd3hRZxZq7mqwYMm5UC05BLUr7UH6ZY2ezBD5YZdXnEAPCE2shO/dkxEm5M9RNthNFGQbP5/7yczYNt3STNBlxlVGQeZFZFuGXowe4xoYCF+NbuiBZ3+tcIkStNd9J7Ll5OfrC3fJlifNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 2C6A2783; Sun, 28 Sep 2025 22:35:40 -0500 (CDT)
Date: Sun, 28 Sep 2025 22:35:40 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	paul@paul-moore.com, omosnace@redhat.com,
	john.johansen@canonical.com, serge@hallyn.com,
	casey@schaufler-ca.com
Subject: Re: [RFC PATCH v2] lsm,selinux: introduce LSM_ATTR_UNSHARE and wire
 it up for SELinux
Message-ID: <aNn+jOHt0ls+9dGl@mail.hallyn.com>
References: <20250918135904.9997-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918135904.9997-2-stephen.smalley.work@gmail.com>

On Thu, Sep 18, 2025 at 09:59:05AM -0400, Stephen Smalley wrote:
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

Doing it immediately seems like the right thing to do.  So that
the container runtime can keep the umount/remount of selinuxfs
with the unshare, instead of having to defer that until after
a later syscall.

> Differences between this syscall interface and the selinuxfs interface
> that need discussion before moving forward:
> 
> 1. The syscall interface does not currently check any Linux capability
> or DAC permissions, whereas the selinuxfs interface can only be set by
> uid-0 or CAP_DAC_OVERRIDE processes. We need to decide what if any
> capability or DAC check should apply to this syscall interface and if
> any, add the checks to either the LSM framework code or to the SELinux
> hook function.

I think this should be done by the SELinux hook.  And I suspect you
do want to require those privs, but I could be wrong.

> Pros: Checking a capability or DAC permissions prevents misuse of this
> interface by unprivileged processes, particularly on systems with
> policies that do not yet define any of the new SELinux permissions
> introduced for controlling this operation. This is a potential concern
> on Linux distributions that do not tightly coordinate kernel updates
> with policy updates (or where users may choose to deploy upstream
> kernels on their own), but not on Android.

Hm, that's an interesting problem.

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

maybe 'unshare' means that an unshare is in progress, and add an
'unshared' which is incremented on every unshare (and never
decremented) for use by the testsuite?

> b) the abilities to get and set the maximum number of SELinux
> namespaces (via a /sys/fs/selinux/maxns node) and to get and set the
> maximum depth for SELinux namespaces (via a /sys/fs/selinux/maxnsdepth
> node). These could be left in selinuxfs or migrated to some other LSM
> management APIs since they are global in scope, not per-process
> attributes.
> 
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v2 fixes a typo (PROCESS->PROCESS2) and is now tested.
> 
>  include/uapi/linux/lsm.h            | 1 +
>  security/selinux/hooks.c            | 8 ++++++++
>  security/selinux/include/classmap.h | 4 +++-
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
> index 938593dfd5da..fb1b4a8aa639 100644
> --- a/include/uapi/linux/lsm.h
> +++ b/include/uapi/linux/lsm.h
> @@ -83,6 +83,7 @@ struct lsm_ctx {
>  #define LSM_ATTR_KEYCREATE	103
>  #define LSM_ATTR_PREV		104
>  #define LSM_ATTR_SOCKCREATE	105
> +#define LSM_ATTR_UNSHARE	106
>  
>  /*
>   * LSM_FLAG_XXX definitions identify special handling instructions
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index f48483383d6e..1e34a16b7954 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6816,6 +6816,10 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
>  		error = avc_has_perm(state, mysid, mysid, SECCLASS_PROCESS,
>  				     PROCESS__SETCURRENT, NULL);
>  		break;
> +	case LSM_ATTR_UNSHARE:
> +		error = avc_has_perm(state, mysid, mysid, SECCLASS_PROCESS2,
> +				     PROCESS2__UNSHARE_SELINUXNS, NULL);
> +		break;
>  	default:
>  		error = -EOPNOTSUPP;
>  		break;
> @@ -6927,6 +6931,10 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
>  		}
>  
>  		tsec->sid = sid;
> +	} else if (attr == LSM_ATTR_UNSHARE) {
> +		error = selinux_state_create(new);
> +		if (error)
> +			goto abort_change;
>  	} else {
>  		error = -EINVAL;
>  		goto abort_change;
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index be52ebb6b94a..07fe316308cd 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -60,7 +60,9 @@ const struct security_class_mapping secclass_map[] = {
>  	    "siginh",	    "setrlimit",     "rlimitinh",   "dyntransition",
>  	    "setcurrent",   "execmem",	     "execstack",   "execheap",
>  	    "setkeycreate", "setsockcreate", "getrlimit",   NULL } },
> -	{ "process2", { "nnp_transition", "nosuid_transition", NULL } },
> +	{ "process2",
> +	  { "nnp_transition", "nosuid_transition", "unshare_selinuxns",
> +	    NULL } },
>  	{ "system",
>  	  { "ipc_info", "syslog_read", "syslog_mod", "syslog_console",
>  	    "module_request", "module_load", "firmware_load",
> -- 
> 2.50.1
