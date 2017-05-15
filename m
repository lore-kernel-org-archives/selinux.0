Message-ID: <1494881422.11971.20.camel@tycho.nsa.gov>
Subject: Re: [PATCH v4 1/2] selinux: add brief info to policydb
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Sebastien Buisson <sbuisson.ddn@gmail.com>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov
Cc: Sebastien Buisson <sbuisson@ddn.com>, james.l.morris@oracle.com
Date: Mon, 15 May 2017 16:50:22 -0400
In-Reply-To: <1494872563-12467-1-git-send-email-sbuisson@ddn.com>
References: <1494872563-12467-1-git-send-email-sbuisson@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2017-05-16 at 03:22 +0900, Sebastien Buisson wrote:
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
> the rest of the kernel. Lustre client makes use of this information
> to detect changes to the policy, and forward it to Lustre servers.
> Depending on how the policy is enforced on Lustre client side,
> Lustre servers can refuse connection.
> 
> Signed-off-by: Sebastien Buisson <sbuisson@ddn.com>
> ---
>  include/linux/lsm_hooks.h           | 17 +++++++
>  include/linux/security.h            |  7 +++
>  security/security.c                 |  8 ++++
>  security/selinux/hooks.c            |  7 +++
>  security/selinux/include/security.h |  2 +
>  security/selinux/selinuxfs.c        |  2 +
>  security/selinux/ss/policydb.c      | 88
> +++++++++++++++++++++++++++++++++++++
>  security/selinux/ss/policydb.h      |  3 ++
>  security/selinux/ss/services.c      | 68
> ++++++++++++++++++++++++++++
>  9 files changed, 202 insertions(+)
> 

> diff --git a/security/selinux/ss/policydb.c
> b/security/selinux/ss/policydb.c
> index 0080122..8ce7f89 100644
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
> @@ -879,6 +886,8 @@ void policydb_destroy(struct policydb *p)
>  	ebitmap_destroy(&p->filename_trans_ttypes);
>  	ebitmap_destroy(&p->policycaps);
>  	ebitmap_destroy(&p->permissive_map);
> +
> +	kfree(p->policybrief);
>  }
>  
>  /*
> @@ -2220,6 +2229,52 @@ static int ocontext_read(struct policydb *p,
> struct policydb_compat_info *info,
>  }
>  
>  /*
> + * Compute summary of a policy database binary representation file,
> + * and store it into a policy database structure.
> + */
> +static int policydb_brief(struct policydb *policydb, void *ptr)
> +{
> +	struct policy_file *fp = ptr;
> +	u8 *hashval;
> +	int rc = 0;
> +
> +	if (policydb->policybrief)
> +		return -EINVAL;

Should this be a BUG_ON()?

> +
> +	hashval = kmalloc(policybrief_hash_size, GFP_KERNEL);
> +	if (hashval == NULL)
> +		return -ENOMEM;
> +
> +	{
> +		SHASH_DESC_ON_STACK(desc, policybrief_tfm);

You should be able to move this up to the parent scope now that
policybrief_tfm is allocated at init.  No need for a nested block then.

> +		desc->tfm = policybrief_tfm;
> +		desc->flags = 0;
> +		rc = crypto_shash_digest(desc, fp->data, fp->len,
> hashval);
> +		if (rc) {
> +			printk(KERN_ERR "Failed crypto_shash_digest:
> %d\n", rc);
> +			goto out_free;
> +		}
> +	}
> +
> +	/* policy brief is in the form:
> +	 * selinux(enforce=<0 or 1>:checkreqprot=<0 or
> 1>:<hashalg>=<checksum>)
> +	 */
> +	policydb->policybrief = kasprintf(GFP_KERNEL,
> +					  "selinux(enforce=%d:checkr
> eqprot=%d:%s=%*phN)",
> +					  selinux_enforcing,
> +					  selinux_checkreqprot,
> +					  policybrief_hash_alg,
> +					  policybrief_hash_size,
> hashval);
> +	if (policydb->policybrief == NULL)
> +		rc = -ENOMEM;
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
> @@ -2238,6 +2293,11 @@ int policydb_read(struct policydb *p, void
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
> @@ -3456,3 +3516,31 @@ int policydb_write(struct policydb *p, void
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
> +		2*policybrief_hash_size;

Might as well include the + 1 for the terminating NUL here?

> +
> +	return 0;
> +}
> +
> +late_initcall(init_policybrief_hash);

> diff --git a/security/selinux/ss/services.c
> b/security/selinux/ss/services.c
> index 60d9b02..32150fb 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2170,6 +2170,74 @@ size_t security_policydb_len(void)
>  }
>  
>  /**
> + * security_policydb_brief - Get policydb brief
> + * @brief: pointer to buffer holding brief
> + * @len: in: brief buffer length if no alloc, out: brief string len
> + * @alloc: whether to allocate buffer for brief or not
> + *
> + * On success 0 is returned , or negative value on error.
> + **/
> +int security_policydb_brief(char **brief, size_t *len, bool alloc)
> +{
> +	if (!ss_initialized || brief == NULL)
> +		return -EINVAL;
> +
> +	if (alloc) {
> +		/* *brief must be kfreed by caller in this case */

What's the point in putting such a comment here in the code; it is
essentially interface documentation?

> +		*brief = kzalloc(policybrief_len + 1, GFP_KERNEL);
> +	/*
> +	 * if !alloc, caller must pass a buffer that
> +	 * can hold policybrief_len+1 chars
> +	 */

Ditto.  And why not just include the + 1 in the policybrief_len in the
first place?

> +	} else if (*len < policybrief_len + 1) {
> +		/* put in *len the string size we need to write */
> +		*len = policybrief_len;

The caller needs to allocate a buffer of policybrief_len+1, so might as
well include the +1 in the length we return to the caller.  Less
opportunity for error.

> +		return -ENAMETOOLONG;
> +	}
> +
> +	if (*brief == NULL)
> +		return -ENOMEM;
> +
> +	read_lock(&policy_rwlock);
> +	*len = policybrief_len;
> +	strncpy(*brief, policydb.policybrief, *len);

Why can't we just do a simple strcpy() here?

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
