Message-ID: <1495045806.32535.12.camel@tycho.nsa.gov>
Subject: Re: [PATCH v6 1/2] selinux: add brief info to policydb
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Sebastien Buisson <sbuisson.ddn@gmail.com>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov
Cc: serge@hallyn.com, james.l.morris@oracle.com, eparis@parisplace.org,
 paul@paul-moore.com, Sebastien Buisson <sbuisson@ddn.com>
Date: Wed, 17 May 2017 14:30:06 -0400
In-Reply-To: <1495040944-11552-1-git-send-email-sbuisson@ddn.com>
References: <1495040944-11552-1-git-send-email-sbuisson@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-05-18 at 02:09 +0900, Sebastien Buisson wrote:
> Add policybrief field to struct policydb. It holds a brief info
> of the policydb, made of colon separated name and value pairs
> that give information about how the policy is applied in the
> security module(s).
> Note that the ordering of the fields in the string may change.
> 
> Policy brief is computed every time the policy is loaded, and when
> enforce or checkreqprot are changed.
> 
> Add security_policy_brief hook to give access to policy brief to
> the rest of the kernel. It is useful for any network or
> distributed file system that cares about how SELinux is enforced
> on its client nodes. This information is used to detect changes
> to the policy on file system client nodes, and can be forwarded
> to file system server nodes. Depending on how the policy is
> enforced on client side, server can refuse connection.
> 
> Signed-off-by: Sebastien Buisson <sbuisson@ddn.com>

Looks good to me, but we need to see the patch that uses the LSM hook
interface too.  Also, I would split up this patch and fold your second
patch into one of the parts.  You could have a first patch that
implements the support within SELinux and uses it from selinuxfs (no
dependency on the LSM hook interface or the SELinux hook function), a
second patch that adds the LSM hook interface and SELinux hook function
to expose it outside of SELinux, and then a third patch to call the
hook from lustre.

> ---
>  include/linux/lsm_hooks.h           | 20 +++++++++
>  include/linux/security.h            |  7 +++
>  security/security.c                 |  6 +++
>  security/selinux/hooks.c            |  7 +++
>  security/selinux/include/security.h |  2 +
>  security/selinux/selinuxfs.c        |  2 +
>  security/selinux/ss/policydb.c      | 88
> +++++++++++++++++++++++++++++++++++++
>  security/selinux/ss/policydb.h      |  3 ++
>  security/selinux/ss/services.c      | 67
> ++++++++++++++++++++++++++++
>  9 files changed, 202 insertions(+)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 080f34e..0bc0260 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1336,6 +1336,24 @@
>   *	@inode we wish to get the security context of.
>   *	@ctx is a pointer in which to place the allocated security
> context.
>   *	@ctxlen points to the place to put the length of @ctx.
> + *
> + * Security hooks for policy brief
> + *
> + * @policy_brief:
> + *
> + *	Returns a string containing a brief info of the policydb.
> The string
> + *	contains colon separated name and value pairs that give
> information
> + *	about how the policy is applied in the security module(s).
> + *	Note that the ordering of the fields in the string may
> change.
> + *
> + *	@brief: pointer to buffer holding brief
> + *	@len: in: brief buffer length if no alloc, out: brief
> string len
> + *	@alloc: whether to allocate buffer for brief or not
> + *	If @alloc, *brief must be kfreed by caller.
> + *	If not @alloc, caller must pass a buffer that can hold
> policy brief
> + *	info (including terminating NUL).
> + *	On success 0 is returned , or negative value on error.
> + *
>   * This is the main security structure.
>   */
>  
> @@ -1568,6 +1586,7 @@
>  	int (*inode_setsecctx)(struct dentry *dentry, void *ctx, u32
> ctxlen);
>  	int (*inode_getsecctx)(struct inode *inode, void **ctx, u32
> *ctxlen);
>  
> +	int (*policy_brief)(char **brief, size_t *len, bool alloc);
>  #ifdef CONFIG_SECURITY_NETWORK
>  	int (*unix_stream_connect)(struct sock *sock, struct sock
> *other,
>  					struct sock *newsk);
> @@ -1813,6 +1832,7 @@ struct security_hook_heads {
>  	struct list_head inode_notifysecctx;
>  	struct list_head inode_setsecctx;
>  	struct list_head inode_getsecctx;
> +	struct list_head policy_brief;
>  #ifdef CONFIG_SECURITY_NETWORK
>  	struct list_head unix_stream_connect;
>  	struct list_head unix_may_send;
> diff --git a/include/linux/security.h b/include/linux/security.h
> index af675b5..3b72053 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -377,6 +377,8 @@ int security_sem_semop(struct sem_array *sma,
> struct sembuf *sops,
>  int security_inode_notifysecctx(struct inode *inode, void *ctx, u32
> ctxlen);
>  int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32
> ctxlen);
>  int security_inode_getsecctx(struct inode *inode, void **ctx, u32
> *ctxlen);
> +
> +int security_policy_brief(char **brief, size_t *len, bool alloc);
>  #else /* CONFIG_SECURITY */
>  struct security_mnt_opts {
>  };
> @@ -1166,6 +1168,11 @@ static inline int
> security_inode_getsecctx(struct inode *inode, void **ctx, u32
>  {
>  	return -EOPNOTSUPP;
>  }
> +
> +static inline int security_policy_brief(char **brief, size_t *len,
> bool alloc)
> +{
> +	return -EOPNOTSUPP;
> +}
>  #endif	/* CONFIG_SECURITY */
>  
>  #ifdef CONFIG_SECURITY_NETWORK
> diff --git a/security/security.c b/security/security.c
> index 54b1e39..91247fc 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1300,6 +1300,12 @@ int security_inode_getsecctx(struct inode
> *inode, void **ctx, u32 *ctxlen)
>  }
>  EXPORT_SYMBOL(security_inode_getsecctx);
>  
> +int security_policy_brief(char **brief, size_t *len, bool alloc)
> +{
> +	return call_int_hook(policy_brief, -EOPNOTSUPP, brief, len,
> alloc);
> +}
> +EXPORT_SYMBOL(security_policy_brief);
> +
>  #ifdef CONFIG_SECURITY_NETWORK
>  
>  int security_unix_stream_connect(struct sock *sock, struct sock
> *other, struct sock *newsk)
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index dddb81e..b6540f9 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6071,6 +6071,11 @@ static int selinux_inode_getsecctx(struct
> inode *inode, void **ctx, u32 *ctxlen)
>  	*ctxlen = len;
>  	return 0;
>  }
> +
> +static int selinux_policy_brief(char **brief, size_t *len, bool
> alloc)
> +{
> +	return security_policydb_brief(brief, len, alloc);
> +}
>  #ifdef CONFIG_KEYS
>  
>  static int selinux_key_alloc(struct key *k, const struct cred *cred,
> @@ -6285,6 +6290,8 @@ static int selinux_key_getsecurity(struct key
> *key, char **_buffer)
>  	LSM_HOOK_INIT(inode_setsecctx, selinux_inode_setsecctx),
>  	LSM_HOOK_INIT(inode_getsecctx, selinux_inode_getsecctx),
>  
> +	LSM_HOOK_INIT(policy_brief, selinux_policy_brief),
> +
>  	LSM_HOOK_INIT(unix_stream_connect,
> selinux_socket_unix_stream_connect),
>  	LSM_HOOK_INIT(unix_may_send, selinux_socket_unix_may_send),
>  
> diff --git a/security/selinux/include/security.h
> b/security/selinux/include/security.h
> index f979c35..a0d4d7d 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -97,6 +97,8 @@ enum {
>  int security_load_policy(void *data, size_t len);
>  int security_read_policy(void **data, size_t *len);
>  size_t security_policydb_len(void);
> +int security_policydb_brief(char **brief, size_t *len, bool alloc);
> +void security_policydb_update_info(u32 requested);
>  
>  int security_policycap_supported(unsigned int req_cap);
>  
> diff --git a/security/selinux/selinuxfs.c
> b/security/selinux/selinuxfs.c
> index ce71718..e8fe914 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -159,6 +159,7 @@ static ssize_t sel_write_enforce(struct file
> *file, const char __user *buf,
>  			from_kuid(&init_user_ns,
> audit_get_loginuid(current)),
>  			audit_get_sessionid(current));
>  		selinux_enforcing = new_value;
> +		security_policydb_update_info(SECURITY__SETENFORCE);
>  		if (selinux_enforcing)
>  			avc_ss_reset(0);
>  		selnl_notify_setenforce(selinux_enforcing);
> @@ -621,6 +622,7 @@ static ssize_t sel_write_checkreqprot(struct file
> *file, const char __user *buf,
>  		goto out;
>  
>  	selinux_checkreqprot = new_value ? 1 : 0;
> +	security_policydb_update_info(SECURITY__SETCHECKREQPROT);
>  	length = count;
>  out:
>  	kfree(page);
> diff --git a/security/selinux/ss/policydb.c
> b/security/selinux/ss/policydb.c
> index 87d645d..b37b8e5 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -32,13 +32,20 @@
>  #include <linux/errno.h>
>  #include <linux/audit.h>
>  #include <linux/flex_array.h>
> +#include <crypto/hash.h>
>  #include "security.h"
>  
>  #include "policydb.h"
>  #include "conditional.h"
>  #include "mls.h"
> +#include "objsec.h"
>  #include "services.h"
>  
> +static unsigned int policybrief_hash_size;
> +static struct crypto_shash *policybrief_tfm;
> +static const char policybrief_hash_alg[] = "sha256";
> +unsigned int policybrief_len;
> +
>  #define _DEBUG_HASHES
>  
>  #ifdef DEBUG_HASHES
> @@ -874,6 +881,8 @@ void policydb_destroy(struct policydb *p)
>  	ebitmap_destroy(&p->filename_trans_ttypes);
>  	ebitmap_destroy(&p->policycaps);
>  	ebitmap_destroy(&p->permissive_map);
> +
> +	kfree(p->policybrief);
>  }
>  
>  /*
> @@ -2215,6 +2224,52 @@ static int ocontext_read(struct policydb *p,
> struct policydb_compat_info *info,
>  }
>  
>  /*
> + * Compute summary of a policy database binary representation file,
> + * and store it into a policy database structure.
> + */
> +static int policydb_brief(struct policydb *policydb, void *ptr)
> +{
> +	SHASH_DESC_ON_STACK(desc, policybrief_tfm);
> +	struct policy_file *fp = ptr;
> +	u8 *hashval;
> +	int rc;
> +
> +	BUG_ON(policydb->policybrief);
> +
> +	hashval = kmalloc(policybrief_hash_size, GFP_KERNEL);
> +	if (hashval == NULL)
> +		return -ENOMEM;
> +
> +	desc->tfm = policybrief_tfm;
> +	desc->flags = 0;
> +	rc = crypto_shash_digest(desc, fp->data, fp->len, hashval);
> +	if (rc) {
> +		printk(KERN_ERR "Failed crypto_shash_digest: %d\n",
> rc);
> +		goto out_free;
> +	}
> +
> +	/* policy brief is in the form:
> +	 * selinux(enforce=<0 or 1>:checkreqprot=<0 or
> 1>:<hashalg>=<checksum>)
> +	 */
> +	policydb->policybrief = kmalloc(policybrief_len,
> GFP_KERNEL);
> +	if (policydb->policybrief == NULL) {
> +		rc = -ENOMEM;
> +		goto out_free;
> +	}
> +	rc = snprintf(policydb->policybrief, policybrief_len,
> +		      "selinux(enforce=%d:checkreqprot=%d:%s=%*phN)"
> ,
> +		      selinux_enforcing, selinux_checkreqprot,
> +		      policybrief_hash_alg, policybrief_hash_size,
> hashval);
> +	BUG_ON(rc >= policybrief_len);
> +	rc = 0;
> +
> +out_free:
> +	kfree(hashval);
> +
> +	return rc;
> +}
> +
> +/*
>   * Read the configuration data from a policy database binary
>   * representation file into a policy database structure.
>   */
> @@ -2233,6 +2288,11 @@ int policydb_read(struct policydb *p, void
> *fp)
>  	if (rc)
>  		return rc;
>  
> +	/* Compute summary of policy, and store it in policydb */
> +	rc = policydb_brief(p, fp);
> +	if (rc)
> +		goto bad;
> +
>  	/* Read the magic number and string length. */
>  	rc = next_entry(buf, fp, sizeof(u32) * 2);
>  	if (rc)
> @@ -3451,3 +3511,31 @@ int policydb_write(struct policydb *p, void
> *fp)
>  
>  	return 0;
>  }
> +
> +static int __init init_policybrief_hash(void)
> +{
> +	struct crypto_shash *tfm;
> +
> +	if (!selinux_enabled)
> +		return 0;
> +
> +	tfm = crypto_alloc_shash(policybrief_hash_alg, 0, 0);
> +	if (IS_ERR(tfm)) {
> +		printk(KERN_ERR "Failed to alloc crypto hash %s\n",
> +		       policybrief_hash_alg);
> +		return PTR_ERR(tfm);
> +	}
> +
> +	policybrief_tfm = tfm;
> +	policybrief_hash_size =
> crypto_shash_digestsize(policybrief_tfm);
> +
> +	/* policy brief is in the form:
> +	 * selinux(enforce=<0 or 1>:checkreqprot=<0 or
> 1>:<hashalg>=<checksum>)
> +	 */
> +	policybrief_len = 35 + strlen(policybrief_hash_alg) +
> +		2*policybrief_hash_size + 1;
> +
> +	return 0;
> +}
> +
> +late_initcall(init_policybrief_hash);
> diff --git a/security/selinux/ss/policydb.h
> b/security/selinux/ss/policydb.h
> index 725d594..2e5048c 100644
> --- a/security/selinux/ss/policydb.h
> +++ b/security/selinux/ss/policydb.h
> @@ -293,6 +293,8 @@ struct policydb {
>  	size_t len;
>  
>  	unsigned int policyvers;
> +	/* summary computed on the policy */
> +	unsigned char *policybrief;
>  
>  	unsigned int reject_unknown : 1;
>  	unsigned int allow_unknown : 1;
> @@ -309,6 +311,7 @@ struct policydb {
>  extern int policydb_role_isvalid(struct policydb *p, unsigned int
> role);
>  extern int policydb_read(struct policydb *p, void *fp);
>  extern int policydb_write(struct policydb *p, void *fp);
> +extern unsigned int policybrief_len;
>  
>  #define PERM_SYMTAB_SIZE 32
>  
> diff --git a/security/selinux/ss/services.c
> b/security/selinux/ss/services.c
> index 60d9b02..67eb80d 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2170,6 +2170,73 @@ size_t security_policydb_len(void)
>  }
>  
>  /**
> + * security_policydb_brief - Get policydb brief
> + * @brief: pointer to buffer holding brief
> + * @len: in: brief buffer length if no alloc, out: brief string len
> + * @alloc: whether to allocate buffer for brief or not
> + *
> + * If @alloc, *brief must be kfreed by caller.
> + * If not @alloc, caller must pass a buffer that can hold
> policybrief_len
> + * chars (including terminating NUL).
> + * On success 0 is returned , or negative value on error.
> + **/
> +int security_policydb_brief(char **brief, size_t *len, bool alloc)
> +{
> +	if (!ss_initialized || brief == NULL)
> +		return -EINVAL;
> +
> +	if (alloc) {
> +		*brief = kzalloc(policybrief_len, GFP_KERNEL);
> +	} else if (*len < policybrief_len) {
> +		/* put in *len the string size we need to write */
> +		*len = policybrief_len;
> +		return -ENAMETOOLONG;
> +	}
> +
> +	if (*brief == NULL)
> +		return -ENOMEM;
> +
> +	read_lock(&policy_rwlock);
> +	strcpy(*brief, policydb.policybrief);
> +	/* *len is the length of the output string */
> +	*len = policybrief_len - 1;
> +	read_unlock(&policy_rwlock);
> +
> +	return 0;
> +}
> +
> +void security_policydb_update_info(u32 requested)
> +{
> +	/* policy brief is in the form:
> +	 * selinux(enforce=<0 or 1>:checkreqprot=<0 or
> 1>:<hashalg>=<checksum>)
> +	 */
> +	char enforce[] = "enforce=";
> +	char checkreqprot[] = "checkreqprot=";
> +	char *p, *str;
> +	int val;
> +
> +	if (!ss_initialized)
> +		return;
> +
> +	if (requested == SECURITY__SETENFORCE) {
> +		str = enforce;
> +		val = selinux_enforcing;
> +	} else if (requested == SECURITY__SETCHECKREQPROT) {
> +		str = checkreqprot;
> +		val = selinux_checkreqprot;
> +	}
> +
> +	/* update global policydb, needs write lock */
> +	write_lock_irq(&policy_rwlock);
> +	p = strstr(policydb.policybrief, str);
> +	if (p) {
> +		p += strlen(str);
> +		*p = '0' + val;
> +	}
> +	write_unlock_irq(&policy_rwlock);
> +}
> +
> +/**
>   * security_port_sid - Obtain the SID for a port.
>   * @protocol: protocol number
>   * @port: port number
