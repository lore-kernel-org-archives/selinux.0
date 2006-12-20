Subject: Re: [PATCH] change printks from KERN_INFO to KERN_DEBUG
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>,
        Steve G <linux_4ever@yahoo.com>
In-Reply-To: <1166645324.20187.100.camel@localhost.localdomain>
References: <1166562934.20187.87.camel@localhost.localdomain>
	 <1166564096.30579.90.camel@moss-spartans.epoch.ncsc.mil>
	 <1166645324.20187.100.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 20 Dec 2006 15:34:24 -0500
Message-Id: <1166646864.30579.158.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-12-20 at 15:08 -0500, Eric Paris wrote:
> This patch I do not plan to turn anything into an audit messages.  If
> anyone has opinions on what should be audited rather than just printk'd
> I'd be glad to do that in the future.
> 
> > > hooks.c: printk(KERN_INFO "SELinux:  Initializing.\n");
> > > hooks.c: printk(KERN_INFO "SELinux:  Starting in enforcing mode\n");
> > > hooks.c: printk(KERN_INFO "SELinux:  Starting in permissive mode\n");
> > 
> > I'd turn the above three messages into KERN_DEBUG messages.
> 
> I want to leave these as .info.  I know it is useful when people go back
> and look at syslog/dmesg (support organizations) to know how things
> actually started.  It isn't a repeating message and is no different than
> the 'disabled' messages which you seem to think should stay.

Up to you, but it isn't as useful as you might think:
- SELinux:  Initializing only tells you that SELinux started
initialization, not whether a policy was ever loaded or the system was
ever put into enforcing mode.
- SELinux:  Starting in... only tells you the boot-time state, which in
Red Hat kernels is _always_ permissive unless you boot with enforcing=1.
Otherwise, enforcing mode isn't entered until /sbin/init makes its
security_setenforce() call.  And note that enforcing mode isn't really
meaningful until policy is loaded.

sestatus(8) is more useful for checking whether the active system truly
has SELinux enabled and enforcing.

> > > ss/services.c: printk(KERN_INFO <- missing class definitions in policy
> > > ss/services.c: printk(KERN_INFO <- missing permission definitions in policy
> > > ss/services.c: printk(KERN_INFO <- missing inherit definitions in policy
> > 
> > Possibly an audit message?
> 
> Maybe it should be an audit as well.  Any opinions?  But for now
> (against James's suggestion) I think these should stay as .info.  Maybe
> we should add 'you may want to look for a new policy which includes
> these missing definitions.'  This is the type of message that should
> cause the user to do something.

I agree that they merit more than KERN_DEBUG, as they may reflect a need
to update policy.  However, it doesn't _require_ the user to do anything
(assuming you proceed with a revised patch to support allowing unknown
classes and permissions), and usual position of Fedora seems to have
been to ship newer upstream kernels but _not_ newer upstream policies.

> Thoughts?
> 
>  security/selinux/hooks.c       |   16 ++++++++--------
>  security/selinux/ss/avtab.c    |    2 +-
>  security/selinux/ss/policydb.c |    6 +++---
>  security/selinux/ss/sidtab.c   |    2 +-
>  4 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 65fb5e8..5cc9e1d 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -654,11 +654,11 @@ static int superblock_doinit(struct super_block *sb, void *data)
>  	sbsec->initialized = 1;
>  
>  	if (sbsec->behavior > ARRAY_SIZE(labeling_behaviors)) {
> -		printk(KERN_INFO "SELinux: initialized (dev %s, type %s), unknown behavior\n",
> +		printk(KERN_ERR "SELinux: initialized (dev %s, type %s), unknown behavior\n",
>  		       sb->s_id, sb->s_type->name);
>  	}
>  	else {
> -		printk(KERN_INFO "SELinux: initialized (dev %s, type %s), %s\n",
> +		printk(KERN_DEBUG "SELinux: initialized (dev %s, type %s), %s\n",
>  		       sb->s_id, sb->s_type->name,
>  		       labeling_behaviors[sbsec->behavior-1]);
>  	}
> @@ -4391,7 +4391,7 @@ static int selinux_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
>  static int selinux_register_security (const char *name, struct security_operations *ops)
>  {
>  	if (secondary_ops != original_ops) {
> -		printk(KERN_INFO "%s:  There is already a secondary security "
> +		printk(KERN_ERR "%s:  There is already a secondary security "
>  		       "module registered.\n", __FUNCTION__);
>  		return -EINVAL;
>   	}
> @@ -4408,7 +4408,7 @@ static int selinux_register_security (const char *name, struct security_operatio
>  static int selinux_unregister_security (const char *name, struct security_operations *ops)
>  {
>  	if (ops != secondary_ops) {
> -		printk (KERN_INFO "%s:  trying to unregister a security module "
> +		printk(KERN_ERR "%s:  trying to unregister a security module "
>  		        "that is not registered.\n", __FUNCTION__);
>  		return -EINVAL;
>  	}
> @@ -4864,10 +4864,10 @@ static __init int selinux_init(void)
>  
>  void selinux_complete_init(void)
>  {
> -	printk(KERN_INFO "SELinux:  Completing initialization.\n");
> +	printk(KERN_DEBUG "SELinux:  Completing initialization.\n");
>  
>  	/* Set up any superblocks initialized prior to the policy load. */
> -	printk(KERN_INFO "SELinux:  Setting up existing superblocks.\n");
> +	printk(KERN_DEBUG "SELinux:  Setting up existing superblocks.\n");
>  	spin_lock(&sb_lock);
>  	spin_lock(&sb_security_lock);
>  next_sb:
> @@ -4926,7 +4926,7 @@ static int __init selinux_nf_ip_init(void)
>  	if (!selinux_enabled)
>  		goto out;
>  		
> -	printk(KERN_INFO "SELinux:  Registering netfilter hooks\n");
> +	printk(KERN_DEBUG "SELinux:  Registering netfilter hooks\n");
>  	
>  	err = nf_register_hook(&selinux_ipv4_op);
>  	if (err)
> @@ -4949,7 +4949,7 @@ __initcall(selinux_nf_ip_init);
>  #ifdef CONFIG_SECURITY_SELINUX_DISABLE
>  static void selinux_nf_ip_exit(void)
>  {
> -	printk(KERN_INFO "SELinux:  Unregistering netfilter hooks\n");
> +	printk(KERN_DEBUG "SELinux:  Unregistering netfilter hooks\n");
>  
>  	nf_unregister_hook(&selinux_ipv4_op);
>  #if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
> diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
> index ebb993c..37b20e1 100644
> --- a/security/selinux/ss/avtab.c
> +++ b/security/selinux/ss/avtab.c
> @@ -278,7 +278,7 @@ void avtab_hash_eval(struct avtab *h, char *tag)
>  		}
>  	}
>  
> -	printk(KERN_INFO "%s:  %d entries and %d/%d buckets used, longest "
> +	printk(KERN_DEBUG "%s:  %d entries and %d/%d buckets used, longest "
>  	       "chain length %d\n", tag, h->nel, slots_used, AVTAB_SIZE,
>  	       max_chain_len);
>  }
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index cd79c63..0ac1021 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -374,7 +374,7 @@ static void symtab_hash_eval(struct symtab *s)
>  		struct hashtab_info info;
>  
>  		hashtab_stat(h, &info);
> -		printk(KERN_INFO "%s:  %d entries and %d/%d buckets used, "
> +		printk(KERN_DEBUG "%s:  %d entries and %d/%d buckets used, "
>  		       "longest chain length %d\n", symtab_name[i], h->nel,
>  		       info.slots_used, h->size, info.max_chain_len);
>  	}
> @@ -391,14 +391,14 @@ static int policydb_index_others(struct policydb *p)
>  {
>  	int i, rc = 0;
>  
> -	printk(KERN_INFO "security:  %d users, %d roles, %d types, %d bools",
> +	printk(KERN_DEBUG "security:  %d users, %d roles, %d types, %d bools",
>  	       p->p_users.nprim, p->p_roles.nprim, p->p_types.nprim, p->p_bools.nprim);
>  	if (selinux_mls_enabled)
>  		printk(", %d sens, %d cats", p->p_levels.nprim,
>  		       p->p_cats.nprim);
>  	printk("\n");
>  
> -	printk(KERN_INFO "security:  %d classes, %d rules\n",
> +	printk(KERN_DEBUG "security:  %d classes, %d rules\n",
>  	       p->p_classes.nprim, p->te_avtab.nel);
>  
>  #ifdef DEBUG_HASHES
> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> index 871c33b..1599edb 100644
> --- a/security/selinux/ss/sidtab.c
> +++ b/security/selinux/ss/sidtab.c
> @@ -254,7 +254,7 @@ void sidtab_hash_eval(struct sidtab *h, char *tag)
>  		}
>  	}
>  
> -	printk(KERN_INFO "%s:  %d entries and %d/%d buckets used, longest "
> +	printk(KERN_DEBUG "%s:  %d entries and %d/%d buckets used, longest "
>  	       "chain length %d\n", tag, h->nel, slots_used, SIDTAB_SIZE,
>  	       max_chain_len);
>  }

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
