Subject: Re: [PATCH] selinuxfs to globally disable dontaudit rules
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@redhat.com>,
        selinux@tycho.nsa.gov, dwalsh@redhat.com
In-Reply-To: <46BBBDDF.2000307@manicmethod.com>
References: <1186696737.20393.10.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0708091525410.30691@us.intercode.com.au>
	 <46BBAE00.7050600@manicmethod.com>  <46BBBDDF.2000307@manicmethod.com>
Content-Type: text/plain
Date: Thu, 16 Aug 2007 13:28:37 -0400
Message-Id: <1187285317.909.36.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-09 at 21:22 -0400, Joshua Brindle wrote:
> Joshua Brindle wrote:
> > James Morris wrote:
> >> On Thu, 9 Aug 2007, Eric Paris wrote:
> >>
> >>  
> >>> Currently to disable dontaudit rules best you can do it to load the
> >>> enableaudit.pp base policy.  Which still doesn't remove the dontaudit
> >>> rules from modules.
> >>>     
> >>
> >> Are we sure this can't be done in userspace?  Like, mangle all the 
> >> existing policy and reload it?
> >>
> >>   
> > I agree, the infrastructure is certainly in place to do it, just add 
> > something in the sepol_handle that says dontaudits should be 
> > discarded, then make an interface in libsemanage that uses that and 
> > rebuild the policy.
> >
> > If noone beats me to it I will see if my conclusions about it being 
> > fairly simple are accurate this weekend :)
> >
> 
> I changed my mind, patch below
> 
> it compiles and seems to work after semodule -DB:
> 
> [root@scarecrow policy]# sediff -T policy.21.old \; policy.21 | grep -v
> dontaudit
> TE Rules (Added 0, Added New Type 0, Removed 326583, Removed Missing
> Type 0, Modified 0)
>  Added TE Rules: 0
>  Added TE Rules because of new type: 0
>  Removed TE Rules: 326583
>  Removed TE Rules because of missing type: 0
>  Modified TE Rules: 0
> 
> Index: libsemanage/include/semanage/handle.h
> ===================================================================
> --- libsemanage/include/semanage/handle.h	(revision 2511)
> +++ libsemanage/include/semanage/handle.h	(working copy)
> @@ -69,6 +69,9 @@
>   * 1 for yes, 0 for no (default) */
>  void semanage_set_create_store(semanage_handle_t * handle, int create_store);
>  
> +/* Set whether or not to disable dontaudits upon commit */
> +void semanage_set_disable_dontaudit(semanage_handle_t * handle, int disable_dontaudit);
> +
>  /* Check whether policy is managed via libsemanage on this system.
>   * Must be called prior to trying to connect.
>   * Return 1 if policy is managed via libsemanage on this system,
> Index: libsemanage/src/libsemanage.map
> ===================================================================
> --- libsemanage/src/libsemanage.map	(revision 2511)
> +++ libsemanage/src/libsemanage.map	(working copy)
> @@ -13,6 +13,6 @@
>  	  semanage_iface_*; semanage_port_*; semanage_context_*;
>  	  semanage_node_*;
>  	  semanage_fcontext_*; semanage_access_check; semanage_set_create_store;
> -	  semanage_is_connected;
> +	  semanage_is_connected; semanage_set_disable_dontaudit;
>    local: *;
>  };
> Index: libsemanage/src/handle.c
> ===================================================================
> --- libsemanage/src/handle.c	(revision 2511)
> +++ libsemanage/src/handle.c	(working copy)
> @@ -109,6 +109,14 @@
>  	return;
>  }
>  
> +void semanage_set_disable_dontaudit(semanage_handle_t * sh, int disable_dontaudit)
> +{
> +	assert(sh != NULL);
> +	
> +	sepol_set_disable_dontaudit(sh->sepolh, disable_dontaudit);
> +	return;
> +}
> +
>  int semanage_is_connected(semanage_handle_t * sh)
>  {
>  	assert(sh != NULL);
> Index: libsepol/include/sepol/handle.h
> ===================================================================
> --- libsepol/include/sepol/handle.h	(revision 2511)
> +++ libsepol/include/sepol/handle.h	(working copy)
> @@ -7,6 +7,10 @@
>  /* Create and return a sepol handle. */
>  sepol_handle_t *sepol_handle_create(void);
>  
> +/* Set whether or not to disable dontaudits, 0 is default and does 
> + * not disable dontaudits, 1 disables them */
> +void sepol_set_disable_dontaudit(sepol_handle_t * sh, int disable_dontaudit);
> +
>  /* Destroy a sepol handle. */
>  void sepol_handle_destroy(sepol_handle_t *);
>  
> Index: libsepol/src/handle.h
> ===================================================================
> --- libsepol/src/handle.h	(revision 2511)
> +++ libsepol/src/handle.h	(working copy)
> @@ -14,6 +14,9 @@
>  	void (*msg_callback) (void *varg,
>  			      sepol_handle_t * handle, const char *fmt, ...);
>  	void *msg_callback_arg;
> +
> +	int disable_dontaudit;
> +
>  };
>  
>  #endif
> Index: libsepol/src/libsepol.map
> ===================================================================
> --- libsepol/src/libsepol.map	(revision 2511)
> +++ libsepol/src/libsepol.map	(working copy)
> @@ -12,5 +12,6 @@
>  	sepol_policydb_*; sepol_set_policydb_from_file; 
>  	sepol_policy_kern_*;
>  	sepol_policy_file_*;
> +	sepol_set_disable_dontaudit;
>    local: *;
>  };
> Index: libsepol/src/expand.c
> ===================================================================
> --- libsepol/src/expand.c	(revision 2511)
> +++ libsepol/src/expand.c	(working copy)
> @@ -1367,6 +1367,8 @@
>  	} else if (specified & AVRULE_AUDITDENY) {
>  		spec = AVTAB_AUDITDENY;
>  	} else if (specified & AVRULE_DONTAUDIT) {
> +		if (handle->disable_dontaudit)
> +			return EXPAND_RULE_SUCCESS;
>  		spec = AVTAB_AUDITDENY;
>  	} else if (specified & AVRULE_NEVERALLOW) {
>  		spec = AVTAB_NEVERALLOW;
> Index: libsepol/src/handle.c
> ===================================================================
> --- libsepol/src/handle.c	(revision 2511)
> +++ libsepol/src/handle.c	(working copy)
> @@ -1,4 +1,5 @@
>  #include <stdlib.h>
> +#include <assert.h>
>  #include "handle.h"
>  #include "debug.h"
>  
> @@ -13,9 +14,18 @@
>  	sh->msg_callback = sepol_msg_default_handler;
>  	sh->msg_callback_arg = NULL;
>  
> +	/* by default do not disable dontaudits */
> +	sh->disable_dontaudit = 0;
> +
>  	return sh;
>  }
>  
> +void sepol_set_disable_dontaudit(sepol_handle_t * sh, int disable_dontaudit)
> +{
> +	assert(sh !=NULL);
> +	sh->disable_dontaudit = disable_dontaudit;
> +}
> +
>  void sepol_handle_destroy(sepol_handle_t * sh)
>  {
>  	free(sh);
> Index: policycoreutils/semodule/semodule.c
> ===================================================================
> --- policycoreutils/semodule/semodule.c	(revision 2511)
> +++ policycoreutils/semodule/semodule.c	(working copy)
> @@ -44,6 +44,7 @@
>  static int no_reload;
>  static int create_store;
>  static int build;
> +static int disable_dontaudit;
>  
>  static semanage_handle_t *sh = NULL;
>  static char *store;
> @@ -131,6 +132,7 @@
>  	printf("  -n,--noreload	   do not reload policy after commit\n");
>  	printf("  -h,--help        print this message and quit\n");
>  	printf("  -v,--verbose     be verbose\n");
> +	printf("  -D,--disable_dontaudit	Remove dontaudits from policy\n");
>  }
>  
>  /* Sets the global mode variable to new_mode, but only if no other
> @@ -173,6 +175,7 @@
>  		{"reload", 0, NULL, 'R'},
>  		{"noreload", 0, NULL, 'n'},
>  		{"build", 0, NULL, 'B'},
> +		{"disable_dontaudit", 0, NULL, 'D'},
>  		{NULL, 0, NULL, 0}
>  	};
>  	int i;
> @@ -181,7 +184,7 @@
>  	no_reload = 0;
>  	create_store = 0;
>  	while ((i =
> -		getopt_long(argc, argv, "s:b:hi:lvqr:u:RnB", opts,
> +		getopt_long(argc, argv, "s:b:hi:lvqr:u:RnBD", opts,
>  			    NULL)) != -1) {
>  		switch (i) {
>  		case 'b':
> @@ -218,6 +221,9 @@
>  		case 'B':
>  			build = 1;
>  			break;
> +		case 'D':
> +			disable_dontaudit = 1;
> +			break;
>  		case '?':
>  		default:{
>  				usage(argv[0]);
> @@ -441,6 +447,8 @@
>  			semanage_set_reload(sh, 0);
>  		if (build)
>  			semanage_set_rebuild(sh, 1);
> +		if (disable_dontaudit)
> +			semanage_set_disable_dontaudit(sh, 1);
>  		result = semanage_commit(sh);
>  	}

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

Merge at will.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
