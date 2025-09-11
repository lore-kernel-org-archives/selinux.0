Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0C41A08A3;
	Thu, 11 Sep 2025 23:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757632233; cv=none; b=PIWaxBOoYWTTPUjWXMeKh7QCKu1J1CUAxHi/ToHR/Cfmm3PYjNoe9iXUvA6r2aHlv52lP7ilCOQuLv8wLBbT5HvsfWKtjkA7hP97ddCQt4SCj7OkP9YzBGrwMi6jXVCCxjlAmmYHq3GnbdkVZcPZWt+BaS/CArHzOjRpZX+NZaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757632233; c=relaxed/simple;
	bh=QAbfhdSCvFzsZZ+bLEU8WI/DznMGBRRCuNYxm+nmH+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXbholEBVmltXuJ3O7to+7dPZMvflYFd/FT00l3ohMFbARejLx6NARj8chc9n7LmQvLVCAquUOlQmXnGT2V/VTVcICdxmUlaw6nivq5jqeHZLgLC/5sYnWjStJuUnNtdvDgGhdK4InjsajGjAl8I4VvixHJlbEVZVwJyMXRCQvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 3FA0B4C6; Thu, 11 Sep 2025 18:02:36 -0500 (CDT)
Date: Thu, 11 Sep 2025 18:02:36 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
	paul@paul-moore.com, omosnace@redhat.com,
	john.johansen@canonical.com, serge@hallyn.com,
	casey@schaufler-ca.com
Subject: Re: [RFC PATCH] lsm,selinux: introduce LSM_ATTR_UNSHARE and wire it
 up for SELinux
Message-ID: <aMNVDOCjCBZZE8Kb@mail.hallyn.com>
References: <20250903192426.215857-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903192426.215857-2-stephen.smalley.work@gmail.com>

On Wed, Sep 03, 2025 at 03:24:26PM -0400, Stephen Smalley wrote:
> In the hopes of nudging the conversation in [1] in a more focused

Hi Stephen,

what was [1] supposed to be here?  I can think of two possibilities,
but I'm not seeing it inline...

> direction with a goal of getting SELinux namespaces upstreamed, this
> RFC provides a starting point for a concrete discussion. This is RFC
> only and has only been build-tested thus far.
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
> 
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
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
> index c544b3e2fd5c..11b0b3c5b74a 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6812,6 +6812,10 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
>  		error = avc_has_perm(state, mysid, mysid, SECCLASS_PROCESS,
>  				     PROCESS__SETCURRENT, NULL);
>  		break;
> +	case LSM_ATTR_UNSHARE:
> +		error = avc_has_perm(state, mysid, mysid, SECCLASS_PROCESS,
> +				     PROCESS2__UNSHARE_SELINUXNS, NULL);
> +		break;
>  	default:
>  		error = -EOPNOTSUPP;
>  		break;
> @@ -6923,6 +6927,10 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
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
> 2.51.0
