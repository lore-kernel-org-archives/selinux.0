Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v45IXkSJ028660
 for <selinux@tycho.nsa.gov>; Fri, 5 May 2017 14:33:47 -0400
Subject: Re: [PATCH v2 1/2] selinux: add brief info to policydb
To: Sebastien Buisson <sbuisson.ddn@gmail.com>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov
References: <1493979053-16691-1-git-send-email-sbuisson@ddn.com>
Cc: serge@hallyn.com, james.l.morris@oracle.com, eparis@parisplace.org,
 sds@tycho.nsa.gov, paul@paul-moore.com,
 Sebastien Buisson <sbuisson@ddn.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <cc4d7595-4bfc-2339-0ac7-b443e65f6fd5@schaufler-ca.com>
Date: Fri, 5 May 2017 11:33:34 -0700
MIME-Version: 1.0
In-Reply-To: <1493979053-16691-1-git-send-email-sbuisson@ddn.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 5/5/2017 3:10 AM, Sebastien Buisson wrote:
> Add policybrief field to struct policydb. It holds a brief info
> of the policydb, in the following form:
> <0 or 1 for enforce>:<0 or 1 for checkreqprot>:<hashalg>=<checksum>
> Policy brief is computed every time the policy is loaded, and when
> enforce or checkreqprot are changed.

You need to add a description of policy_brief in lsm_hooks.h.
I would like you to describe the expectations Lustre has for
the content of a policy brief in general. That will make it
easier for AppArmor and Smack to support Lustre when the time
comes. How do you see policy_brief being used by a modules
with dynamic policy?


>
> Add security_policy_brief hook to give access to policy brief to
> the rest of the kernel. Lustre client makes use of this information.
>
> Signed-off-by: Sebastien Buisson <sbuisson@ddn.com>
> ---
>  include/linux/lsm_hooks.h           |  2 +
>  include/linux/security.h            |  7 ++++
>  security/security.c                 |  6 +++
>  security/selinux/hooks.c            | 11 +++++-
>  security/selinux/include/security.h |  2 +
>  security/selinux/selinuxfs.c        |  6 ++-
>  security/selinux/ss/policydb.c      | 70 +++++++++++++++++++++++++++++++++++
>  security/selinux/ss/policydb.h      |  3 ++
>  security/selinux/ss/services.c      | 73 +++++++++++++++++++++++++++++++++++++
>  9 files changed, 178 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 080f34e..7139a07 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1568,6 +1568,7 @@
>  	int (*inode_setsecctx)(struct dentry *dentry, void *ctx, u32 ctxlen);
>  	int (*inode_getsecctx)(struct inode *inode, void **ctx, u32 *ctxlen);
>  
> +	int (*policy_brief)(char **brief, size_t *len, bool alloc);
>  #ifdef CONFIG_SECURITY_NETWORK
>  	int (*unix_stream_connect)(struct sock *sock, struct sock *other,
>  					struct sock *newsk);
> @@ -1813,6 +1814,7 @@ struct security_hook_heads {
>  	struct list_head inode_notifysecctx;
>  	struct list_head inode_setsecctx;
>  	struct list_head inode_getsecctx;
> +	struct list_head policy_brief;
>  #ifdef CONFIG_SECURITY_NETWORK
>  	struct list_head unix_stream_connect;
>  	struct list_head unix_may_send;
> diff --git a/include/linux/security.h b/include/linux/security.h
> index af675b5..3b72053 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -377,6 +377,8 @@ int security_sem_semop(struct sem_array *sma, struct sembuf *sops,
>  int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
>  int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
>  int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
> +
> +int security_policy_brief(char **brief, size_t *len, bool alloc);
>  #else /* CONFIG_SECURITY */
>  struct security_mnt_opts {
>  };
> @@ -1166,6 +1168,11 @@ static inline int security_inode_getsecctx(struct inode *inode, void **ctx, u32
>  {
>  	return -EOPNOTSUPP;
>  }
> +
> +static inline int security_policy_brief(char **brief, size_t *len, bool alloc)
> +{
> +	return -EOPNOTSUPP;
> +}
>  #endif	/* CONFIG_SECURITY */
>  
>  #ifdef CONFIG_SECURITY_NETWORK
> diff --git a/security/security.c b/security/security.c
> index b9fea39..954b391 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1285,6 +1285,12 @@ int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
>  }
>  EXPORT_SYMBOL(security_inode_getsecctx);
>  
> +int security_policy_brief(char **brief, size_t *len, bool alloc)
> +{
> +	return call_int_hook(policy_brief, -EOPNOTSUPP, brief, len, alloc);
> +}
> +EXPORT_SYMBOL(security_policy_brief);
> +
>  #ifdef CONFIG_SECURITY_NETWORK
>  
>  int security_unix_stream_connect(struct sock *sock, struct sock *other, struct sock *newsk)
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index e67a526..b4dd605 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -104,8 +104,10 @@
>  static int __init enforcing_setup(char *str)
>  {
>  	unsigned long enforcing;
> -	if (!kstrtoul(str, 0, &enforcing))
> +	if (!kstrtoul(str, 0, &enforcing)) {
>  		selinux_enforcing = enforcing ? 1 : 0;
> +		security_policydb_update_info(NULL);
> +	}
>  	return 1;
>  }
>  __setup("enforcing=", enforcing_setup);
> @@ -6063,6 +6065,11 @@ static int selinux_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
>  	*ctxlen = len;
>  	return 0;
>  }
> +
> +static int selinux_policy_brief(char **brief, size_t *len, bool alloc)
> +{
> +	return security_policydb_brief(brief, len, alloc);
> +}
>  #ifdef CONFIG_KEYS
>  
>  static int selinux_key_alloc(struct key *k, const struct cred *cred,
> @@ -6277,6 +6284,8 @@ static int selinux_key_getsecurity(struct key *key, char **_buffer)
>  	LSM_HOOK_INIT(inode_setsecctx, selinux_inode_setsecctx),
>  	LSM_HOOK_INIT(inode_getsecctx, selinux_inode_getsecctx),
>  
> +	LSM_HOOK_INIT(policy_brief, selinux_policy_brief),
> +
>  	LSM_HOOK_INIT(unix_stream_connect, selinux_socket_unix_stream_connect),
>  	LSM_HOOK_INIT(unix_may_send, selinux_socket_unix_may_send),
>  
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index f979c35..167e274 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -97,6 +97,8 @@ enum {
>  int security_load_policy(void *data, size_t len);
>  int security_read_policy(void **data, size_t *len);
>  size_t security_policydb_len(void);
> +int security_policydb_brief(char **brief, size_t *len, bool alloc);
> +void security_policydb_update_info(void *p);
>  
>  int security_policycap_supported(unsigned int req_cap);
>  
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index ce71718..b959ee7 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -55,8 +55,10 @@
>  static int __init checkreqprot_setup(char *str)
>  {
>  	unsigned long checkreqprot;
> -	if (!kstrtoul(str, 0, &checkreqprot))
> +	if (!kstrtoul(str, 0, &checkreqprot)) {
>  		selinux_checkreqprot = checkreqprot ? 1 : 0;
> +		security_policydb_update_info(NULL);
> +	}
>  	return 1;
>  }
>  __setup("checkreqprot=", checkreqprot_setup);
> @@ -159,6 +161,7 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
>  			from_kuid(&init_user_ns, audit_get_loginuid(current)),
>  			audit_get_sessionid(current));
>  		selinux_enforcing = new_value;
> +		security_policydb_update_info(NULL);
>  		if (selinux_enforcing)
>  			avc_ss_reset(0);
>  		selnl_notify_setenforce(selinux_enforcing);
> @@ -621,6 +624,7 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
>  		goto out;
>  
>  	selinux_checkreqprot = new_value ? 1 : 0;
> +	security_policydb_update_info(NULL);
>  	length = count;
>  out:
>  	kfree(page);
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 0080122..9eb2f82 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -32,6 +32,8 @@
>  #include <linux/errno.h>
>  #include <linux/audit.h>
>  #include <linux/flex_array.h>
> +#include <crypto/hash.h>
> +#include <crypto/sha.h>
>  #include "security.h"
>  
>  #include "policydb.h"
> @@ -879,6 +881,8 @@ void policydb_destroy(struct policydb *p)
>  	ebitmap_destroy(&p->filename_trans_ttypes);
>  	ebitmap_destroy(&p->policycaps);
>  	ebitmap_destroy(&p->permissive_map);
> +
> +	kfree(p->policybrief);
>  }
>  
>  /*
> @@ -2220,6 +2224,67 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
>  }
>  
>  /*
> + * Compute summary of a policy database binary representation file,
> + * and store it into a policy database structure.
> + */
> +static int policydb_brief(struct policydb *policydb, void *ptr)
> +{
> +	struct policy_file *fp = ptr;
> +	struct crypto_shash *tfm;
> +	char hashalg[] = "sha256";
> +	int hashsize = SHA256_DIGEST_SIZE;
> +	char hashval[hashsize];
> +	int idx;
> +	unsigned char *p;
> +
> +	if (policydb->policybrief)
> +		return -EINVAL;
> +
> +	tfm = crypto_alloc_shash(hashalg, 0, 0);
> +	if (IS_ERR(tfm)) {
> +		printk(KERN_ERR "Failed to alloc crypto hash %s\n", hashalg);
> +		return PTR_ERR(tfm);
> +	}
> +
> +	{
> +		int rc;
> +
> +		SHASH_DESC_ON_STACK(desc, tfm);
> +		desc->tfm = tfm;
> +		desc->flags = 0;
> +		rc = crypto_shash_init(desc);
> +		if (rc) {
> +			printk(KERN_ERR "Failed to init shash\n");
> +			crypto_free_shash(tfm);
> +			return rc;
> +		}
> +
> +		crypto_shash_update(desc, fp->data, fp->len);
> +		crypto_shash_final(desc, hashval);
> +		crypto_free_shash(tfm);
> +	}
> +
> +	/* policy brief is in the form:
> +	 * <0 or 1 for enforce>:<0 or 1 for checkreqprot>:<hashalg>=<checksum>
> +	 */
> +	policydb->policybrief = kzalloc(5 + strlen(hashalg) + 2*hashsize + 1,
> +					GFP_KERNEL);
> +	if (policydb->policybrief == NULL)
> +		return -ENOMEM;
> +
> +	sprintf(policydb->policybrief, "x:x:%s=", hashalg);
> +	security_policydb_update_info(policydb);
> +	p = policydb->policybrief + strlen(policydb->policybrief);
> +	for (idx = 0; idx < hashsize; idx++) {
> +		snprintf(p, 3, "%02x", (unsigned char)(hashval[idx]));
> +		p += 2;
> +	}
> +	policydb->policybrief_len = (size_t)(p - policydb->policybrief);
> +
> +	return 0;
> +}
> +
> +/*
>   * Read the configuration data from a policy database binary
>   * representation file into a policy database structure.
>   */
> @@ -2238,6 +2303,11 @@ int policydb_read(struct policydb *p, void *fp)
>  	if (rc)
>  		return rc;
>  
> +	/* Compute sumarry of policy, and store it in policydb */
> +	rc = policydb_brief(p, fp);
> +	if (rc)
> +		goto bad;
> +
>  	/* Read the magic number and string length. */
>  	rc = next_entry(buf, fp, sizeof(u32) * 2);
>  	if (rc)
> diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
> index 725d594..1fca438 100644
> --- a/security/selinux/ss/policydb.h
> +++ b/security/selinux/ss/policydb.h
> @@ -293,6 +293,9 @@ struct policydb {
>  	size_t len;
>  
>  	unsigned int policyvers;
> +	/* summary computed on the policy */
> +	unsigned char *policybrief;
> +	size_t policybrief_len;
>  
>  	unsigned int reject_unknown : 1;
>  	unsigned int allow_unknown : 1;
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 60d9b02..9a94f8e 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2170,6 +2170,79 @@ size_t security_policydb_len(void)
>  }
>  
>  /**
> + * security_policydb_brief - Get policydb brief
> + * @brief: pointer to buffer holding brief
> + * @len: in: brief buffer length if no alloc, out: brief string len
> + * @alloc: whether to allocate buffer for brief or not
> + *
> + * On success 0 is returned , or negative value on error.
> + **/
> +int security_policydb_brief(char **brief, size_t *len, bool alloc)
> +{
> +	int rc = 0;
> +	size_t policybrief_len;
> +
> +	if (brief == NULL)
> +		return -EINVAL;
> +
> +	read_lock(&policy_rwlock);
> +	policybrief_len = policydb.policybrief_len;
> +	if (policydb.policybrief == NULL)
> +		rc = -EAGAIN;
> +	read_unlock(&policy_rwlock);
> +
> +	if (rc)
> +		return rc;
> +
> +	if (alloc)
> +		/* *brief must be kfreed by caller in this case */
> +		*brief = kzalloc(policybrief_len + 1, GFP_KERNEL);
> +	else
> +		/*
> +		 * if !alloc, caller must pass a buffer that
> +		 * can hold policybrief_len+1 chars
> +		 */
> +		if (*len < policybrief_len + 1) {
> +			/* put in *len the string size we need to write */
> +			*len = policybrief_len;
> +			return -ENAMETOOLONG;
> +		}
> +
> +	if (*brief == NULL)
> +		return -ENOMEM;
> +
> +	read_lock(&policy_rwlock);
> +	strncpy(*brief, policydb.policybrief, policydb.policybrief_len);
> +	*len = policydb.policybrief_len;
> +	read_unlock(&policy_rwlock);
> +
> +	return rc;
> +}
> +
> +void security_policydb_update_info(void *p)
> +{
> +	/* policy brief is in the form:
> +	 * <0 or 1 for enforce>:<0 or 1 for checkreqprot>:<hashalg>=<checksum>
> +	 */
> +	if (p) {
> +		struct policydb *poldb = p;
> +		/* update policydb given as parameter if possible */
> +		if (poldb->policybrief) {
> +			poldb->policybrief[0] = '0' + selinux_enforcing;
> +			poldb->policybrief[2] = '0' + selinux_checkreqprot;
> +		}
> +	} else {
> +		/* update global policydb, needs write lock */
> +		write_lock_irq(&policy_rwlock);
> +		if (policydb.policybrief) {
> +			policydb.policybrief[0] = '0' + selinux_enforcing;
> +			policydb.policybrief[2] = '0' + selinux_checkreqprot;
> +		}
> +		write_unlock_irq(&policy_rwlock);
> +	}
> +}
> +
> +/**
>   * security_port_sid - Obtain the SID for a port.
>   * @protocol: protocol number
>   * @port: port number
