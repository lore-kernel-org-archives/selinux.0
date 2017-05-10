Message-ID: <1494442835.24408.15.camel@tycho.nsa.gov>
Subject: Re: [PATCH 4/9] checkpolicy: Add support for ibendportcon labels
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dan Jurgens <danielj@mellanox.com>, selinux@tycho.nsa.gov
Date: Wed, 10 May 2017 15:00:35 -0400
In-Reply-To: <1494363042-121766-5-git-send-email-danielj@mellanox.com>
References: <1494363042-121766-1-git-send-email-danielj@mellanox.com>
 <1494363042-121766-5-git-send-email-danielj@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2017-05-09 at 23:50 +0300, Dan Jurgens wrote:
> From: Daniel Jurgens <danielj@mellanox.com>
> 
> Add checkpolicy support for scanning and parsing ibendportcon labels.
> Also create a new ocontext for IB end ports.
> 
> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
> ---
>  checkpolicy/policy_define.c                |   70
> ++++++++++++++++++++++++++++
>  checkpolicy/policy_define.h                |    1 +
>  checkpolicy/policy_parse.y                 |   14 +++++-
>  checkpolicy/policy_scan.l                  |    2 +
>  libsepol/include/sepol/policydb/policydb.h |    7 ++-
>  5 files changed, 91 insertions(+), 3 deletions(-)
> 
> diff --git a/checkpolicy/policy_define.c
> b/checkpolicy/policy_define.c
> index 6f92bc5..2926f18 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -5085,6 +5085,76 @@ out:
>  	return rc;
>  }
>  
> +int define_ibendport_context(unsigned int port)
> +{
> +	ocontext_t *newc, *c, *l, *head;
> +	char *id;
> +	int rc = 0;
> +
> +	if (policydbp->target_platform != SEPOL_TARGET_SELINUX) {
> +		yyerror("ibendportcon not supported for target");
> +		return -1;
> +	}
> +
> +	if (pass == 1) {
> +		id = (char *)queue_remove(id_queue);
> +		free(id);
> +		parse_security_context(NULL);
> +		return 0;
> +	}
> +
> +	newc = malloc(sizeof(*newc));
> +	if (!newc) {
> +		yyerror("out of memory");
> +		return -1;
> +	}
> +	memset(newc, 0, sizeof(*newc));
> +
> +	newc->u.ibendport.dev_name = queue_remove(id_queue);
> +	if (!newc->u.ibendport.dev_name) {
> +		yyerror("failed to read subnet management interface
> device name.");
> +		rc = -1;
> +		goto out;
> +	}
> +
> +	newc->u.ibendport.port = port;
> +
> +	if (parse_security_context(&newc->context[0])) {
> +		free(newc);
> +		return -1;
> +	}
> +
> +	/* Preserve the matching order specified in the
> configuration. */
> +	head = policydbp->ocontexts[OCON_IBENDPORT];
> +	for (l = NULL, c = head; c; l = c, c = c->next) {
> +		unsigned int port2;
> +
> +		port2 = c->u.ibendport.port;
> +
> +		if (port == port2 &&
> +		    !strncmp(c->u.ibendport.dev_name,
> +			     newc->u.ibendport.dev_name,
> +			     64)) {
> +			yyerror2("duplicate ibendportcon entry for
> %s port %u",
> +				 newc->u.ibendport.dev_name, port);
> +			rc = -1;
> +			goto out;
> +		}
> +	}
> +
> +	if (l)
> +		l->next = newc;
> +	else
> +		policydbp->ocontexts[OCON_IBENDPORT] = newc;
> +
> +	return 0;
> +
> +out:
> +	free(newc->u.ibendport.dev_name);
> +	free(newc);
> +	return rc;
> +}
> +
>  int define_netif_context(void)
>  {
>  	ocontext_t *newc, *c, *head;
> diff --git a/checkpolicy/policy_define.h
> b/checkpolicy/policy_define.h
> index b019b1a..3282aed 100644
> --- a/checkpolicy/policy_define.h
> +++ b/checkpolicy/policy_define.h
> @@ -44,6 +44,7 @@ int define_netif_context(void);
>  int define_permissive(void);
>  int define_polcap(void);
>  int define_ibpkey_context(unsigned int low, unsigned int high);
> +int define_ibendport_context(unsigned int port);
>  int define_port_context(unsigned int low, unsigned int high);
>  int define_pirq_context(unsigned int pirq);
>  int define_iomem_context(uint64_t low, uint64_t high);
> diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
> index f50eab1..35b7a33 100644
> --- a/checkpolicy/policy_parse.y
> +++ b/checkpolicy/policy_parse.y
> @@ -136,6 +136,7 @@ typedef int (* require_func_t)(int pass);
>  %token SAMEUSER
>  %token FSCON PORTCON NETIFCON NODECON 
>  %token IBPKEYCON
> +%token IBENDPORTCON
>  %token PIRQCON IOMEMCON IOPORTCON PCIDEVICECON DEVICETREECON
>  %token FSUSEXATTR FSUSETASK FSUSETRANS
>  %token GENFSCON
> @@ -171,7 +172,7 @@ base_policy             : { if
> (define_policy(pass, 0) == -1) return -1; }
>  			  opt_default_rules opt_mls te_rbac users
> opt_constraints 
>                           { if (pass == 1) { if
> (policydb_index_bools(policydbp)) return -1;}
>  			   else if (pass == 2) { if
> (policydb_index_others(NULL, policydbp, 0)) return -1;}}
> -			  initial_sid_contexts opt_fs_contexts
> opt_fs_uses opt_genfs_contexts net_contexts opt_dev_contexts
> opt_ibpkey_contexts
> +			  initial_sid_contexts opt_fs_contexts
> opt_fs_uses opt_genfs_contexts net_contexts opt_dev_contexts
> opt_ibpkey_contexts opt_ibendport_contexts
>  			;
>  classes			: class_def 
>  			| classes class_def
> @@ -697,7 +698,7 @@ fs_contexts		: fs_context_def
>  fs_context_def		: FSCON number number
> security_context_def security_context_def
>  			{if (define_fs_context($2,$3)) return -1;}
>  			;
> -net_contexts		: opt_port_contexts opt_netif_contexts
> opt_node_contexts 
> +net_contexts		: opt_port_contexts opt_netif_contexts
> opt_node_contexts
>  			;
>  opt_port_contexts       : port_contexts
>                          |
> @@ -721,6 +722,15 @@ ibpkey_context_def	: IBPKEYCON ipv6_addr
> number security_context_def
>  			| IBPKEYCON ipv6_addr number '-' number
> security_context_def
>  			{if (define_ibpkey_context($3,$5)) return
> -1;}
>  			;
> +opt_ibendport_contexts	: ibendport_contexts
> +			|
> +			;
> +ibendport_contexts	: ibendport_context_def
> +                        | ibendport_contexts ibendport_context_def
> +                        ;
> +ibendport_context_def	: IBENDPORTCON identifier number
> security_context_def
> +                        {if (define_ibendport_context($3)) return
> -1;}
> +                        ;
>  opt_netif_contexts      : netif_contexts 
>                          |
>                          ;
> diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
> index 07352cb..f38dd22 100644
> --- a/checkpolicy/policy_scan.l
> +++ b/checkpolicy/policy_scan.l
> @@ -184,6 +184,8 @@ fscon |
>  FSCON                           { return(FSCON);}
>  ibpkeycon |
>  IBPKEYCON			{ return(IBPKEYCON);}
> +ibendportcon |
> +IBENDPORTCON			{ return(IBENDPORTCON);}
>  portcon |
>  PORTCON				{ return(PORTCON);}
>  netifcon |                     
> diff --git a/libsepol/include/sepol/policydb/policydb.h
> b/libsepol/include/sepol/policydb/policydb.h
> index 5ecc623..326a7bb 100644
> --- a/libsepol/include/sepol/policydb/policydb.h
> +++ b/libsepol/include/sepol/policydb/policydb.h
> @@ -360,6 +360,10 @@ typedef struct ocontext {
>  			uint16_t low_pkey;
>  			uint16_t high_pkey;
>  		} ibpkey;
> +		struct {
> +			char *dev_name;
> +			uint8_t port;
> +		} ibendport;

These were pkey and ib_endport in the kernel patch, and port was
port_num.  Either way is fine but they probably ought to be consistent.

>  	} u;
>  	union {
>  		uint32_t sclass;	/* security class for genfs
> */
> @@ -396,6 +400,7 @@ typedef struct genfs {
>  #define OCON_FSUSE 5	/* fs_use */
>  #define OCON_NODE6 6	/* IPv6 nodes */
>  #define OCON_IBPKEY 7	/* Infiniband PKEY */
> +#define OCON_IBENDPORT 8	/* Infiniband End Port */

These were OCON_PKEY and OCON_IB_ENDPORT in the last kernel patches I
saw.  Ok either way but they probably ought to be consistent.

>  
>  /* object context array indices for Xen */
>  #define OCON_XEN_ISID  	    0    /* initial SIDs */
> @@ -406,7 +411,7 @@ typedef struct genfs {
>  #define OCON_XEN_DEVICETREE 5    /* device tree node */
>  
>  /* OCON_NUM needs to be the largest index in any platform's ocontext
> array */
> -#define OCON_NUM   8
> +#define OCON_NUM   9
>  
>  /* section: module information */
>  
