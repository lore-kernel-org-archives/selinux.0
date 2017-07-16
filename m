Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6GFFOUO021349
 for <selinux@tycho.nsa.gov>; Sun, 16 Jul 2017 11:15:25 -0400
Received: by mail-pg0-f68.google.com with SMTP id z1so1409963pgs.0
 for <selinux@tycho.nsa.gov>; Sun, 16 Jul 2017 08:15:17 -0700 (PDT)
Date: Sun, 16 Jul 2017 23:15:12 +0800
From: Jason Zaman <jason@perfinion.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, luto@amacapital.net
Message-ID: <20170716151512.GA4615@meriadoc.perfinion.com>
References: <20170714164647.6183-1-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170714164647.6183-1-sds@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: Generalize support for NNP/nosuid
 SELinux domain transitions
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Jul 14, 2017 at 12:46:47PM -0400, Stephen Smalley wrote:
> As systemd ramps up enabling NNP (NoNewPrivileges) for system services,
> it is increasingly breaking SELinux domain transitions for those services
> and their descendants.  systemd enables NNP not only for services whose
> unit files explicitly specify NoNewPrivileges=yes but also for services
> whose unit files specify any of the following options in combination with
> running without CAP_SYS_ADMIN (e.g. specifying User= or a
> CapabilityBoundingSet= without CAP_SYS_ADMIN): SystemCallFilter=,
> SystemCallArchitectures=, RestrictAddressFamilies=, RestrictNamespaces=,
> PrivateDevices=, ProtectKernelTunables=, ProtectKernelModules=,
> MemoryDenyWriteExecute=, or RestrictRealtime= as per the systemd.exec(5)
> man page.
> 
> The end result is bad for the security of both SELinux-disabled and
> SELinux-enabled systems.  Packagers have to turn off these
> options in the unit files to preserve SELinux domain transitions.  For
> users who choose to disable SELinux, this means that they miss out on
> at least having the systemd-supported protections.  For users who keep
> SELinux enabled, they may still be missing out on some protections
> because it isn't necessarily guaranteed that the SELinux policy for
> that service provides the same protections in all cases.
> 
> commit 7b0d0b40cd78 ("selinux: Permit bounded transitions under
> NO_NEW_PRIVS or NOSUID.") allowed bounded transitions under NNP in
> order to support limited usage for sandboxing programs.  However,
> defining typebounds for all of the affected service domains
> is impractical to implement in policy, since typebounds requires us
> to ensure that each domain is allowed everything all of its descendant
> domains are allowed, and this has to be repeated for the entire chain
> of domain transitions.  There is no way to clone all allow rules from
> descendants to their ancestors in policy currently, and doing so would
> be undesirable even if it were practical, as it requires leaking
> permissions to objects and operations into ancestor domains that could
> weaken their own security in order to allow them to the descendants
> (e.g. if a descendant requires execmem permission, then so do all of
> its ancestors; if a descendant requires execute permission to a file,
> then so do all of its ancestors; if a descendant requires read to a
> symbolic link or temporary file, then so do all of its ancestors...).
> SELinux domains are intentionally not hierarchical / bounded in this
> manner normally, and making them so would undermine their protections
> and least privilege.
> 
> We have long had a similar tension with SELinux transitions and nosuid
> mounts, albeit not as severe.  Users often have had to choose between
> retaining nosuid on a mount and allowing SELinux domain transitions on
> files within those mounts.  This likewise leads to unfortunate tradeoffs
> in security.
> 
> Decouple NNP/nosuid from SELinux transitions, so that we don't have to
> make a choice between them. Introduce a nnp_nosuid_transition policy
> capability that causes the ability to transition under NNP/nosuid to
> be based on a nnp_nosuid_transition permission between the old and new
> contexts rather than typebounds.  Domain transitions can then be allowed
> in policy without requiring the parent to be a strict superset of all of
> its children.
> 
> With this change, systemd unit files can be left unmodified from upstream.
> SELinux-disabled and SELinux-enabled users will benefit from retaining any
> of the systemd-provided protections.  SELinux policy will only need to
> be adapted to enable the new policy capability and to allow the
> new permission between domain pairs as appropriate.
> 

A few things, the name is pretty awkward. my main issue with it is what
if some other similar kind of thing is added in the future then we'll
have nnp_nosuid_transition that should also cover it but the name wont
cover it.

Why do we want to disallow type-bounds to work even with the capability?
it seems sensible to me to allow typebounds to transition even in the
future. If we do then we probably dont need the policycap which seems
less complicated.

also how are we thinking to do this in refpol? only add it specifically
as needed? or would it be added to the execute_file_perms type macros?
Although, grep typebounds is nowhere to be found currently in either
refpol and gentoo's repo.

-- Jason


> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/hooks.c            | 41 ++++++++++++++++++++++++-------------
>  security/selinux/include/classmap.h |  2 +-
>  security/selinux/include/security.h |  2 ++
>  security/selinux/ss/services.c      |  7 ++++++-
>  4 files changed, 36 insertions(+), 16 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3a06afb..932b72d 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2326,24 +2326,37 @@ static int check_nnp_nosuid(const struct linux_binprm *bprm,
>  		return 0; /* No change in credentials */
>  
>  	/*
> -	 * The only transitions we permit under NNP or nosuid
> -	 * are transitions to bounded SIDs, i.e. SIDs that are
> -	 * guaranteed to only be allowed a subset of the permissions
> -	 * of the current SID.
> +	 * If the policy enables the nnp_nosuid_transition policy capability,
> +	 * then we permit transitions under NNP or nosuid if the
> +	 * policy explicitly allows nnp_nosuid_transition permission between
> +	 * the old and new contexts.
>  	 */
> -	rc = security_bounded_transition(old_tsec->sid, new_tsec->sid);
> -	if (rc) {
> +	if (selinux_policycap_nnp_nosuid_transition) {
> +		rc = avc_has_perm(old_tsec->sid, new_tsec->sid,
> +				  SECCLASS_PROCESS,
> +				  PROCESS__NNP_NOSUID_TRANSITION, NULL);
> +		if (!rc)
> +			return 0;
> +	} else {
>  		/*
> -		 * On failure, preserve the errno values for NNP vs nosuid.
> -		 * NNP:  Operation not permitted for caller.
> -		 * nosuid:  Permission denied to file.
> +		 * Otherwise, the only transitions we permit under NNP or nosuid
> +		 * are transitions to bounded SIDs, i.e. SIDs that are
> +		 * guaranteed to only be allowed a subset of the permissions
> +		 * of the current SID.
>  		 */
> -		if (nnp)
> -			return -EPERM;
> -		else
> -			return -EACCES;
> +		rc = security_bounded_transition(old_tsec->sid, new_tsec->sid);
> +		if (!rc)
> +			return 0;
>  	}
> -	return 0;
> +
> +	/*
> +	 * On failure, preserve the errno values for NNP vs nosuid.
> +	 * NNP:  Operation not permitted for caller.
> +	 * nosuid:  Permission denied to file.
> +	 */
> +	if (nnp)
> +		return -EPERM;
> +	return -EACCES;
>  }
>  
>  static int selinux_bprm_set_creds(struct linux_binprm *bprm)
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index b9fe343..dff81b8 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -47,7 +47,7 @@ struct security_class_mapping secclass_map[] = {
>  	    "getattr", "setexec", "setfscreate", "noatsecure", "siginh",
>  	    "setrlimit", "rlimitinh", "dyntransition", "setcurrent",
>  	    "execmem", "execstack", "execheap", "setkeycreate",
> -	    "setsockcreate", "getrlimit", NULL } },
> +	    "setsockcreate", "getrlimit", "nnp_nosuid_transition", NULL } },
>  	{ "system",
>  	  { "ipc_info", "syslog_read", "syslog_mod",
>  	    "syslog_console", "module_request", "module_load", NULL } },
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index e91f08c..3e32317 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -73,6 +73,7 @@ enum {
>  	POLICYDB_CAPABILITY_EXTSOCKCLASS,
>  	POLICYDB_CAPABILITY_ALWAYSNETWORK,
>  	POLICYDB_CAPABILITY_CGROUPSECLABEL,
> +	POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
>  	__POLICYDB_CAPABILITY_MAX
>  };
>  #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
> @@ -84,6 +85,7 @@ extern int selinux_policycap_openperm;
>  extern int selinux_policycap_extsockclass;
>  extern int selinux_policycap_alwaysnetwork;
>  extern int selinux_policycap_cgroupseclabel;
> +extern int selinux_policycap_nnp_nosuid_transition;
>  
>  /*
>   * type_datum properties
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 2f02fa6..16c55de 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -76,7 +76,8 @@ char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
>  	"open_perms",
>  	"extended_socket_class",
>  	"always_check_network",
> -	"cgroup_seclabel"
> +	"cgroup_seclabel",
> +	"nnp_nosuid_transition"
>  };
>  
>  int selinux_policycap_netpeer;
> @@ -84,6 +85,7 @@ int selinux_policycap_openperm;
>  int selinux_policycap_extsockclass;
>  int selinux_policycap_alwaysnetwork;
>  int selinux_policycap_cgroupseclabel;
> +int selinux_policycap_nnp_nosuid_transition;
>  
>  static DEFINE_RWLOCK(policy_rwlock);
>  
> @@ -2009,6 +2011,9 @@ static void security_load_policycaps(void)
>  	selinux_policycap_cgroupseclabel =
>  		ebitmap_get_bit(&policydb.policycaps,
>  				POLICYDB_CAPABILITY_CGROUPSECLABEL);
> +	selinux_policycap_nnp_nosuid_transition =
> +		ebitmap_get_bit(&policydb.policycaps,
> +				POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION);
>  
>  	for (i = 0; i < ARRAY_SIZE(selinux_policycap_names); i++)
>  		pr_info("SELinux:  policy capability %s=%d\n",
> -- 
> 2.9.4
> 
