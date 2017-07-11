Message-ID: <1499802772.22660.3.camel@tycho.nsa.gov>
Subject: Re: [RFC][PATCH] selinux: Introduce a policy capability and
 permission for NNP transitions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Date: Tue, 11 Jul 2017 15:52:52 -0400
In-Reply-To: <20170710202553.20668-1-sds@tycho.nsa.gov>
References: <20170710202553.20668-1-sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2017-07-10 at 16:25 -0400, Stephen Smalley wrote:
> As systemd ramps up enabling NoNewPrivileges (either explicitly in
> service unit files or as a side effect of other security-related
> settings in service unit files), we're increasingly running afoul of
> its interactions with SELinux.
> 
> The end result is bad for the security of both SELinux-disabled and
> SELinux-enabled systems.  Packagers have to turn off these
> options in the unit files to preserve SELinux domain
> transitions.  For
> users who choose to disable SELinux, this means that they miss out on
> at least having the systemd-supported protections.  For users who
> keep
> SELinux enabled, they may still be missing out on some protections
> because it isn't necessarily guaranteed that the SELinux policy for
> that service provides the same protections in all cases.
> 
> Our options seem to be:
> 
> 1) Just keep on the way we are now, i.e. packagers have to remove
> default protection settings from upstream package unit files in order
> to have them work with SELinux (and not just NoNewPrivileges=
> itself; increasingly systemd is enabling NNP as a side effect of
> other
> unit file options, even seemingly unrelated ones like
> PrivateDevices).
> SELinux-disabled users lose entirely, SELinux-enabled users may lose
> (depending on whether SELinux policy provides equivalent or
> better guarantees).
> 
> 2) Change systemd to automatically disable NNP on SELinux-enabled
> systems.  Unit files can be left unmodified from upstream.  SELinux-
> disabled users win.  SELinux-enabled users may lose.
> 
> 3) Try to use typebounds, since we allow bounded transitions under
> NNP.
> Unit files can be left unmodified from upstream. SELinux-disabled
> users
> win.  SELinux-enabled users get to benefit from systemd-provided
> protections.  However, this option is impractical to implement in
> policy
> currently, since typebounds requires us to ensure that each domain is
> allowed everything all of its descendant domains are allowed, and
> this
> has to be repeated for the entire chain of domain transitions.  There
> is
> no way to clone all allow rules from children to the parent in policy
> currently, and it is doubtful that doing so would be desirable even
> if
> it were practical, as it requires leaking permissions to objects and
> operations into parent domains that could weaken their own security
> in
> order to allow them to the children (e.g. if a child requires execmem
> permission, then so does the parent; if a child requires read to a
> symbolic
> link or temporary file that it can write, then so does the parent,
> ...).
> 
> 4) Decouple NNP from SELinux transitions, so that we don't have to
> make a choice between them. Introduce a new policy capability that
> causes the ability to transition under NNP to be based on a new
> permission
> check between the old and new contexts rather than
> typebounds.  Domain
> transitions can then be allowed in policy without requiring the
> parent
> to be a strict superset of all of its children.  The rationale for
> this
> divergence from NNP behavior for capabilities is that SELinux
> permissions
> are substantially broader than just capabilities (they express a full
> access matrix, not just privileges) and can only be used to further
> restrict capabilities, not grant them beyond what is already
> permitted.
> Unit files can be left unmodified from upstream.  SELinux-disabled
> users
> win.  SELinux-enabled users can benefit from systemd-provided
> protections
> and policy won't need to radically change.
> 
> This change takes the last approach above, as it seems to be the
> best option.
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/hooks.c            | 41 ++++++++++++++++++++++++---
> ----------
>  security/selinux/include/classmap.h |  2 +-
>  security/selinux/include/security.h |  2 ++
>  security/selinux/ss/services.c      |  7 ++++++-
>  4 files changed, 36 insertions(+), 16 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3a06afb..f0c11c2 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2326,24 +2326,37 @@ static int check_nnp_nosuid(const struct
> linux_binprm *bprm,
>  		return 0; /* No change in credentials */
>  
>  	/*
> -	 * The only transitions we permit under NNP or nosuid
> -	 * are transitions to bounded SIDs, i.e. SIDs that are
> -	 * guaranteed to only be allowed a subset of the permissions
> -	 * of the current SID.
> +	 * If the policy enables the nnp_transition policy
> capability,
> +	 * then we permit transitions under NNP or nosuid if the
> +	 * policy explicitly allows nnp_transition permission
> between
> +	 * the old and new contexts.
>  	 */
> -	rc = security_bounded_transition(old_tsec->sid, new_tsec-
> >sid);
> -	if (rc) {
> +	if (selinux_policycap_nnptransition) {
> +		rc = avc_has_perm(old_tsec->sid, new_tsec->sid,
> +				  SECCLASS_PROCESS,
> +				  PROCESS__NNP_TRANSITION, NULL);
> +		if (!rc)
> +			return 0;
> +	} else {
>  		/*
> -		 * On failure, preserve the errno values for NNP vs
> nosuid.
> -		 * NNP:  Operation not permitted for caller.
> -		 * nosuid:  Permission denied to file.
> +		 * Otherwise, the only transitions we permit under
> NNP or nosuid
> +		 * are transitions to bounded SIDs, i.e. SIDs that
> are
> +		 * guaranteed to only be allowed a subset of the
> permissions
> +		 * of the current SID.
>  		 */
> -		if (nnp)
> -			return -EPERM;
> -		else
> -			return -EACCES;
> +		rc = security_bounded_transition(old_tsec->sid,
> new_tsec->sid);
> +		if (!rc)
> +			return 0;

NB: As currently written, this logic means that if you enable the new
policy capability, the only way to allow a transition under NNP is by
allowing nnp_transition permission between the old and new domains. The
alternative would be to fall back to checking for a bounded SID if
nnp_transition permission is not allowed. The former approach has the
advantage of being simpler (only a single check with a single audit
message), but means that you can't mix usage of bounded SIDs and
nnp_transition permission as a means of allowing a transitions under
NNP within the same policy.  The latter approach provides more
flexibility / compatibility but will end up producing two audit
messages in the case where the transition is denied by both checks: an
AVC message for the permission denial and a SELINUX_ERR message for the
security_bounded_transition failure, which might be confusing to users
(but probably not; they'll likely just feed the AVC through audit2allow
and be done with it).  Thoughts?

>  	}
> -	return 0;
> +
> +	/*
> +	 * On failure, preserve the errno values for NNP vs nosuid.
> +	 * NNP:  Operation not permitted for caller.
> +	 * nosuid:  Permission denied to file.
> +	 */
> +	if (nnp)
> +		return -EPERM;
> +	return -EACCES;
>  }
>  
>  static int selinux_bprm_set_creds(struct linux_binprm *bprm)
> diff --git a/security/selinux/include/classmap.h
> b/security/selinux/include/classmap.h
> index b9fe343..7fde56d 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -47,7 +47,7 @@ struct security_class_mapping secclass_map[] = {
>  	    "getattr", "setexec", "setfscreate", "noatsecure",
> "siginh",
>  	    "setrlimit", "rlimitinh", "dyntransition", "setcurrent",
>  	    "execmem", "execstack", "execheap", "setkeycreate",
> -	    "setsockcreate", "getrlimit", NULL } },
> +	    "setsockcreate", "getrlimit", "nnp_transition", NULL }
> },
>  	{ "system",
>  	  { "ipc_info", "syslog_read", "syslog_mod",
>  	    "syslog_console", "module_request", "module_load", NULL
> } },
> diff --git a/security/selinux/include/security.h
> b/security/selinux/include/security.h
> index e91f08c..88efb1b 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -73,6 +73,7 @@ enum {
>  	POLICYDB_CAPABILITY_EXTSOCKCLASS,
>  	POLICYDB_CAPABILITY_ALWAYSNETWORK,
>  	POLICYDB_CAPABILITY_CGROUPSECLABEL,
> +	POLICYDB_CAPABILITY_NNPTRANSITION,
>  	__POLICYDB_CAPABILITY_MAX
>  };
>  #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
> @@ -84,6 +85,7 @@ extern int selinux_policycap_openperm;
>  extern int selinux_policycap_extsockclass;
>  extern int selinux_policycap_alwaysnetwork;
>  extern int selinux_policycap_cgroupseclabel;
> +extern int selinux_policycap_nnptransition;
>  
>  /*
>   * type_datum properties
> diff --git a/security/selinux/ss/services.c
> b/security/selinux/ss/services.c
> index 2f02fa6..2faf47a 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -76,7 +76,8 @@ char
> *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
>  	"open_perms",
>  	"extended_socket_class",
>  	"always_check_network",
> -	"cgroup_seclabel"
> +	"cgroup_seclabel",
> +	"nnp_transition"
>  };
>  
>  int selinux_policycap_netpeer;
> @@ -84,6 +85,7 @@ int selinux_policycap_openperm;
>  int selinux_policycap_extsockclass;
>  int selinux_policycap_alwaysnetwork;
>  int selinux_policycap_cgroupseclabel;
> +int selinux_policycap_nnptransition;
>  
>  static DEFINE_RWLOCK(policy_rwlock);
>  
> @@ -2009,6 +2011,9 @@ static void security_load_policycaps(void)
>  	selinux_policycap_cgroupseclabel =
>  		ebitmap_get_bit(&policydb.policycaps,
>  				POLICYDB_CAPABILITY_CGROUPSECLABEL);
> +	selinux_policycap_nnptransition =
> +		ebitmap_get_bit(&policydb.policycaps,
> +				POLICYDB_CAPABILITY_NNPTRANSITION);
>  
>  	for (i = 0; i < ARRAY_SIZE(selinux_policycap_names); i++)
>  		pr_info("SELinux:  policy capability %s=%d\n",
