Subject: Re: [PATCH -v2 1/3] SELinux: fix selinux to safely handle any bugs
 even when not CONFIG_BUG
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org, paul.moore@hp.com
In-Reply-To: <20090212200059.25810.72120.stgit@paris.rdu.redhat.com>
References: <20090212200059.25810.72120.stgit@paris.rdu.redhat.com>
Content-Type: text/plain
Date: Fri, 13 Feb 2009 13:56:07 -0500
Message-Id: <1234551367.24702.215.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-02-12 at 15:00 -0500, Eric Paris wrote:
> If CONFIG_BUG is not set places in the code where BUG is called will not
> end execution.  Look for places where this might result is system problems
> and keep the system running.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>
> ---
> 
>  kernel/capability.c            |    1 +
>  security/selinux/avc.c         |    9 +++++--
>  security/selinux/hooks.c       |    8 +++++-
>  security/selinux/netnode.c     |    3 ++
>  security/selinux/ss/ebitmap.h  |   15 +++++++++--
>  security/selinux/ss/services.c |   54 +++++++++++++++++++++++++++++-----------
>  security/selinux/xfrm.c        |   15 +++++++++--
>  7 files changed, 81 insertions(+), 24 deletions(-)
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
> index eb41f43..e5cda02 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -220,8 +220,13 @@ static void avc_dump_query(struct audit_buffer *ab, u32 ssid, u32 tsid, u16 tcla
>  		kfree(scontext);
>  	}
>  
> -	BUG_ON(tclass >= ARRAY_SIZE(class_to_string) || !class_to_string[tclass]);
> -	audit_log_format(ab, " tclass=%s", class_to_string[tclass]);
> +	if (unlikely(tclass >= ARRAY_SIZE(class_to_string) || !class_to_string[tclass])) {
> +		printk(KERN_ERR "%s: with tclass=%d\n", __func__, tclass);
> +		BUG();
> +		audit_log_format(ab, " tclass=%d", tclass);
> +	} else {
> +		audit_log_format(ab, " tclass=%s", class_to_string[tclass]);
> +	}
>  }
>  
>  /**
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index ae5bb64..44f2170 100644
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
> @@ -1500,6 +1505,7 @@ static int task_has_capability(struct task_struct *tsk,
>  		printk(KERN_ERR
>  		       "SELinux:  out of range capability %d\n", cap);
>  		BUG();
> +		return -EPERM;
>  	}
>  
>  	rc = avc_has_perm_noaudit(sid, sid, sclass, av, 0, &avd);
> diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
> index 7100072..42cc59a 100644
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
> +		ret = -EPROTONOSUPPORT;
>  	}
>  	if (ret != 0)
>  		goto out;
> diff --git a/security/selinux/ss/ebitmap.h b/security/selinux/ss/ebitmap.h
> index f283b43..3ef8c94 100644
> --- a/security/selinux/ss/ebitmap.h
> +++ b/security/selinux/ss/ebitmap.h
> @@ -85,7 +85,10 @@ static inline int ebitmap_node_get_bit(struct ebitmap_node *n,
>  	unsigned int index = EBITMAP_NODE_INDEX(n, bit);
>  	unsigned int ofs = EBITMAP_NODE_OFFSET(n, bit);
>  
> -	BUG_ON(index >= EBITMAP_UNIT_NUMS);
> +	if (unlikely((index >= EBITMAP_UNIT_NUMS))) {
> +		panic("index >= EBITMAP_UNIT_NUMS");
> +		return 0;

Unlike BUG(), you don't need anything after panic(), right?
It is a no-return function under all configurations, right?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
