Date: Fri, 13 Feb 2009 09:56:46 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH 1/3] SELinux: fix selinux to safely handle any bugs even
 when not CONFIG_BUG
In-Reply-To: <20090209213714.9537.8322.stgit@paris.rdu.redhat.com>
Message-ID: <alpine.LRH.1.10.0902130955480.24661@tundra.namei.org>
References: <20090209213714.9537.8322.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 9 Feb 2009, Eric Paris wrote:

> If CONFIG_BUG is not set places in the code where BUG is called will not
> end execution.  Look for places where this might result is system problems
> and keep the system running.

I wonder if we should make SELinux depend on CONFIG_BUG ?

This is pointlessly ugly, and I can't see why you'd disable CONFIG_BUG 
when running SELinux.


> Signed-off-by: Eric Paris <eparis@redhat.com>
> ---
> 
>  kernel/capability.c            |    1 +
>  security/selinux/avc.c         |   13 +++++++++++--
>  security/selinux/hooks.c       |    9 ++++++++-
>  security/selinux/netnode.c     |    3 +++
>  security/selinux/ss/ebitmap.h  |   15 ++++++++++++---
>  security/selinux/ss/services.c |   38 +++++++++++++++++++++++++++++++-------
>  security/selinux/xfrm.c        |   15 ++++++++++++---
>  7 files changed, 78 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/capability.c b/kernel/capability.c
> index 4e17041..e8bec6a 100644
> --- a/kernel/capability.c
> +++ b/kernel/capability.c
> @@ -304,6 +304,7 @@ int capable(int cap)
>  	if (unlikely(!cap_valid(cap))) {
>  		printk(KERN_CRIT "capable() called with invalid cap=%u\n", cap);
>  		BUG();
> +		return 0;
>  	}
>  
>  	if (security_capable(cap) == 0) {
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index eb41f43..c22db1e 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -202,6 +202,7 @@ static void avc_dump_query(struct audit_buffer *ab, u32 ssid, u32 tsid, u16 tcla
>  {
>  	int rc;
>  	char *scontext;
> +	const char *class_string;
>  	u32 scontext_len;
>  
>  	rc = security_sid_to_context(ssid, &scontext, &scontext_len);
> @@ -220,8 +221,16 @@ static void avc_dump_query(struct audit_buffer *ab, u32 ssid, u32 tsid, u16 tcla
>  		kfree(scontext);
>  	}
>  
> -	BUG_ON(tclass >= ARRAY_SIZE(class_to_string) || !class_to_string[tclass]);
> -	audit_log_format(ab, " tclass=%s", class_to_string[tclass]);
> +	if (unlikely(tclass >= ARRAY_SIZE(class_to_string) || !class_to_string[tclass])) {
> +		class_string = "unknown";
> +		if (tclass >= ARRAY_SIZE(class_to_string))
> +			BUG();
> +		else
> +			BUG();
> +	} else {
> +		class_string = class_to_string[tclass];
> +	}
> +	audit_log_format(ab, " tclass=%s", class_string);
>  }
>  
>  /**
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index ae5bb64..6e6847d 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -995,7 +995,11 @@ static int superblock_doinit(struct super_block *sb, void *data)
>  	if (!data)
>  		goto out;
>  
> -	BUG_ON(sb->s_type->fs_flags & FS_BINARY_MOUNTDATA);
> +	if (unlikely(sb->s_type->fs_flags & FS_BINARY_MOUNTDATA)) {
> +		BUG();
> +		rc = -EINVAL;
> +		goto out_err;
> +	}
>  
>  	rc = selinux_parse_opts_str(options, &opts);
>  	if (rc)
> @@ -1042,6 +1046,7 @@ static void selinux_write_opts(struct seq_file *m,
>  			continue;
>  		default:
>  			BUG();
> +			continue;
>  		};
>  		/* we need a comma before each option */
>  		seq_putc(m, ',');
> @@ -1500,6 +1505,8 @@ static int task_has_capability(struct task_struct *tsk,
>  		printk(KERN_ERR
>  		       "SELinux:  out of range capability %d\n", cap);
>  		BUG();
> +		/* should I audit somehow? */
> +		return -EPERM;
>  	}
>  
>  	rc = avc_has_perm_noaudit(sid, sid, sclass, av, 0, &avd);
> diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
> index 7100072..e002d5a 100644
> --- a/security/selinux/netnode.c
> +++ b/security/selinux/netnode.c
> @@ -140,6 +140,7 @@ static struct sel_netnode *sel_netnode_find(const void *addr, u16 family)
>  		break;
>  	default:
>  		BUG();
> +		return NULL;
>  	}
>  
>  	list_for_each_entry_rcu(node, &sel_netnode_hash[idx].list, list)
> @@ -180,6 +181,7 @@ static void sel_netnode_insert(struct sel_netnode *node)
>  		break;
>  	default:
>  		BUG();
> +		return;
>  	}
>  
>  	INIT_RCU_HEAD(&node->rcu);
> @@ -240,6 +242,7 @@ static int sel_netnode_sid_slow(void *addr, u16 family, u32 *sid)
>  		break;
>  	default:
>  		BUG();
> +		ret = -EINVAL;
>  	}
>  	if (ret != 0)
>  		goto out;
> diff --git a/security/selinux/ss/ebitmap.h b/security/selinux/ss/ebitmap.h
> index f283b43..425f8b8 100644
> --- a/security/selinux/ss/ebitmap.h
> +++ b/security/selinux/ss/ebitmap.h
> @@ -85,7 +85,10 @@ static inline int ebitmap_node_get_bit(struct ebitmap_node *n,
>  	unsigned int index = EBITMAP_NODE_INDEX(n, bit);
>  	unsigned int ofs = EBITMAP_NODE_OFFSET(n, bit);
>  
> -	BUG_ON(index >= EBITMAP_UNIT_NUMS);
> +	if (unlikely((index >= EBITMAP_UNIT_NUMS))) {
> +		BUG();
> +		return 0;
> +	}
>  	if ((n->maps[index] & (EBITMAP_BIT << ofs)))
>  		return 1;
>  	return 0;
> @@ -97,7 +100,10 @@ static inline void ebitmap_node_set_bit(struct ebitmap_node *n,
>  	unsigned int index = EBITMAP_NODE_INDEX(n, bit);
>  	unsigned int ofs = EBITMAP_NODE_OFFSET(n, bit);
>  
> -	BUG_ON(index >= EBITMAP_UNIT_NUMS);
> +	if (unlikely((index >= EBITMAP_UNIT_NUMS))) {
> +		BUG();
> +		return;
> +	}
>  	n->maps[index] |= (EBITMAP_BIT << ofs);
>  }
>  
> @@ -107,7 +113,10 @@ static inline void ebitmap_node_clr_bit(struct ebitmap_node *n,
>  	unsigned int index = EBITMAP_NODE_INDEX(n, bit);
>  	unsigned int ofs = EBITMAP_NODE_OFFSET(n, bit);
>  
> -	BUG_ON(index >= EBITMAP_UNIT_NUMS);
> +	if (unlikely((index >= EBITMAP_UNIT_NUMS))) {
> +		BUG();
> +		return;
> +	}
>  	n->maps[index] &= ~(EBITMAP_BIT << ofs);
>  }
>  
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index c65e4fe..cfb0769 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -120,16 +120,25 @@ static int constraint_expr_eval(struct context *scontext,
>  	for (e = cexpr; e; e = e->next) {
>  		switch (e->expr_type) {
>  		case CEXPR_NOT:
> -			BUG_ON(sp < 0);
> +			if (unlikely(sp < 0)) {
> +				BUG();
> +				return 0;
> +			}
>  			s[sp] = !s[sp];
>  			break;
>  		case CEXPR_AND:
> -			BUG_ON(sp < 1);
> +			if (unlikely(sp < 1)) {
> +				BUG();
> +				return 0;
> +			}
>  			sp--;
>  			s[sp] &= s[sp+1];
>  			break;
>  		case CEXPR_OR:
> -			BUG_ON(sp < 1);
> +			if (unlikely(sp < 1)) {
> +				BUG();
> +				return 0;
> +			}
>  			sp--;
>  			s[sp] |= s[sp+1];
>  			break;
> @@ -541,7 +550,11 @@ int security_permissive_sid(u32 sid)
>  	read_lock(&policy_rwlock);
>  
>  	context = sidtab_search(&sidtab, sid);
> -	BUG_ON(!context);
> +	if (unlikely(!context)) {
> +		BUG();
> +		rc = 0;
> +		goto out;
> +	}
>  
>  	type = context->type;
>  	/*
> @@ -550,6 +563,7 @@ int security_permissive_sid(u32 sid)
>  	 */
>  	rc = ebitmap_get_bit(&policydb.permissive_map, type);
>  
> +out:
>  	read_unlock(&policy_rwlock);
>  	return rc;
>  }
> @@ -697,7 +711,11 @@ int security_bounded_transition(u32 old_sid, u32 new_sid)
>  	index = new_context->type;
>  	while (true) {
>  		type = policydb.type_val_to_struct[index - 1];
> -		BUG_ON(!type);
> +		if (unlikely(!type)) {
> +			BUG();
> +			rc = -EPERM;
> +			goto out;
> +		}
>  
>  		/* not bounded anymore */
>  		if (!type->bounds) {
> @@ -1381,7 +1399,10 @@ static int validate_classes(struct policydb *p)
>  			continue;
>  		pol_class = p->p_class_val_to_name[class_val-1];
>  		cladatum = hashtab_search(p->p_classes.table, pol_class);
> -		BUG_ON(!cladatum);
> +		if (unlikely(!cladatum)) {
> +			BUG();
> +			return -EINVAL;
> +		}
>  		perms = &cladatum->permissions;
>  		nprim = 1 << (perms->nprim - 1);
>  		if (perm_val > nprim) {
> @@ -1416,7 +1437,10 @@ static int validate_classes(struct policydb *p)
>  			continue;
>  		pol_class = p->p_class_val_to_name[class_val-1];
>  		cladatum = hashtab_search(p->p_classes.table, pol_class);
> -		BUG_ON(!cladatum);
> +		if (unlikely(!cladatum)) {
> +			BUG();
> +			return -EINVAL;
> +		}
>  		if (!cladatum->comdatum) {
>  			printk(KERN_ERR
>  			       "SELinux:  class %s should have an inherits clause but does not\n",
> diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
> index c0eb720..22413ec 100644
> --- a/security/selinux/xfrm.c
> +++ b/security/selinux/xfrm.c
> @@ -202,7 +202,10 @@ static int selinux_xfrm_sec_ctx_alloc(struct xfrm_sec_ctx **ctxp,
>  	char *ctx_str = NULL;
>  	u32 str_len;
>  
> -	BUG_ON(uctx && sid);
> +	if (unlikely(ctx && sid)) {
> +		BUG();
> +		return -EINVAL;
> +	}
>  
>  	if (!uctx)
>  		goto not_from_user;
> @@ -288,7 +291,10 @@ int selinux_xfrm_policy_alloc(struct xfrm_sec_ctx **ctxp,
>  {
>  	int err;
>  
> -	BUG_ON(!uctx);
> +	if (unlikely(!uctx)) {
> +		BUG();
> +		return -EINVAL;
> +	}
>  
>  	err = selinux_xfrm_sec_ctx_alloc(ctxp, uctx, 0);
>  	if (err == 0)
> @@ -356,7 +362,10 @@ int selinux_xfrm_state_alloc(struct xfrm_state *x, struct xfrm_user_sec_ctx *uct
>  {
>  	int err;
>  
> -	BUG_ON(!x);
> +	if (unlikely(!x)) {
> +		BUG();
> +		return -EINVAL;
> +	}
>  
>  	err = selinux_xfrm_sec_ctx_alloc(&x->security, uctx, secid);
>  	if (err == 0)
> 

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
