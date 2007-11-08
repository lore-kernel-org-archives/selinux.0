Subject: Re: [PATCH] libselinux: introduce enforcing mode override option
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <4730E1BD.9010405@tycho.nsa.gov>
References: <471F8F8D.3040606@tycho.nsa.gov>
	 <1193935864.12018.107.camel@moss-spartans.epoch.ncsc.mil>
	 <472F79D5.6020903@tycho.nsa.gov>
	 <1194369013.28518.63.camel@moss-spartans.epoch.ncsc.mil>
	 <4730E1BD.9010405@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 08 Nov 2007 16:26:56 -0500
Message-Id: <1194557216.3198.28.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-11-06 at 16:50 -0500, Eamon Walsh wrote:
> Smalley wrote:
> > On Mon, 2007-11-05 at 15:15 -0500, Eamon Walsh wrote:
> >   
> >> Introduces an enforcing mode override option, so the object manager
> >> can bring up the AVC in permissive mode on an enforcing system, or
> >> vice versa.
> >>     
> >
> > I don't see a way for the object manager to change the enforcing status
> > after avc_open().
> >   
> 
> I didn't think to include that.  Do we want it?  If so it can be added 
> later.

Ultimately, yes - I can envision a userspace object manager exporting
its own interface for changing enforcing mode much as the kernel does,
so admins can do "setenforce [kernel|x|postgres|dbus|...] [0|1]" or the
like.

> 
> > attribute aligned diffs can be a separate patch.
> >
> >   
> 
> I committed those two lines already.  Rebased patch below.
> 
> Introduces an enforcing mode override option, so the object manager
> can bring up the AVC in permissive mode on an enforcing system, or
> vice versa.
> 
> Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

Merge at will.

> ---
> 
>  include/selinux/avc.h |   11 ++++++++++-
>  src/avc.c             |   29 ++++++++++++++++++++---------
>  src/avc_internal.c    |    3 +++
>  src/avc_internal.h    |    1 +
>  4 files changed, 34 insertions(+), 10 deletions(-)
> 
> 
> Index: include/selinux/avc.h
> ===================================================================
> --- include/selinux/avc.h	(revision 2679)
> +++ include/selinux/avc.h	(working copy)
> @@ -157,6 +157,15 @@
>  };
>  
>  /*
> + * Available options
> + */
> +
> +/* no-op option, useful for unused slots in an array of options */
> +#define AVC_OPT_UNUSED		0
> +/* override kernel enforcing mode (boolean value) */
> +#define AVC_OPT_SETENFORCE	1
> +
> +/*
>   * AVC operations
>   */
>  
> @@ -188,7 +197,7 @@
>   *
>   * This function is identical to avc_init(), except the message prefix
>   * is set to "avc" and any callbacks desired should be specified via
> - * selinux_set_callback().  No options are currently supported.
> + * selinux_set_callback().  Available options are listed above.
>   */
>  int avc_open(struct selinux_opt *opts, unsigned nopts);
>  
> Index: src/avc.c
> ===================================================================
> --- src/avc.c	(revision 2679)
> +++ src/avc.c	(working copy)
> @@ -157,10 +157,19 @@
>  	return rc;
>  }
>  
> -int avc_open(struct selinux_opt *opts __attribute__((unused)),
> -	     unsigned nopts __attribute__((unused)))
> +int avc_open(struct selinux_opt *opts, unsigned nopts)
>  {
> -    return avc_init("avc", NULL, NULL, NULL, NULL);
> +	avc_setenforce = 0;
> +
> +	while (nopts--)
> +		switch(opts[nopts].type) {
> +		case AVC_OPT_SETENFORCE:
> +			avc_setenforce = 1;
> +			avc_enforcing = !!opts[nopts].value;
> +			break;
> +		}
> +
> +	return avc_init("avc", NULL, NULL, NULL, NULL);
>  }
>  
>  int avc_init(const char *prefix,
> @@ -213,13 +222,15 @@
>  		avc_node_freelist = new;
>  	}
>  
> -	rc = security_getenforce();
> -	if (rc < 0) {
> -		avc_log("%s:  could not determine enforcing mode\n",
> -			avc_prefix);
> -		goto out;
> +	if (!avc_setenforce) {
> +		rc = security_getenforce();
> +		if (rc < 0) {
> +			avc_log("%s:  could not determine enforcing mode\n",
> +				avc_prefix);
> +			goto out;
> +		}
> +		avc_enforcing = rc;
>  	}
> -	avc_enforcing = rc;
>  
>  	rc = avc_netlink_open(avc_using_threads);
>  	if (rc < 0) {
> Index: src/avc_internal.c
> ===================================================================
> --- src/avc_internal.c	(revision 2679)
> +++ src/avc_internal.c	(working copy)
> @@ -46,6 +46,7 @@
>  char avc_prefix[AVC_PREFIX_SIZE] = "uavc";
>  int avc_running = 0;
>  int avc_enforcing = 1;
> +int avc_setenforce = 0;
>  int avc_netlink_trouble = 0;
>  
>  /* netlink socket code */
> @@ -151,6 +152,8 @@
>  		struct selnl_msg_setenforce *msg = NLMSG_DATA(nlh);
>  		avc_log("%s:  received setenforce notice (enforcing=%d)\n",
>  			avc_prefix, msg->val);
> +		if (avc_setenforce)
> +			break;
>  		avc_enforcing = msg->val;
>  		if (avc_enforcing && (rc = avc_ss_reset(0)) < 0) {
>  			avc_log("%s:  cache reset returned %d (errno %d)\n",
> Index: src/avc_internal.h
> ===================================================================
> --- src/avc_internal.h	(revision 2679)
> +++ src/avc_internal.h	(working copy)
> @@ -74,6 +74,7 @@
>  extern char avc_prefix[AVC_PREFIX_SIZE] hidden;
>  extern int avc_running hidden;
>  extern int avc_enforcing hidden;
> +extern int avc_setenforce hidden;
>  
>  /* user-supplied callback interface for avc */
>  static inline void *avc_malloc(size_t size)
> 
> 
> 
> -- 
> Eamon Walsh <ewalsh@tycho.nsa.gov>
> National Security Agency
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
