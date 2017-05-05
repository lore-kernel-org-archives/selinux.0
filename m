Message-ID: <1494013182.5745.19.camel@tycho.nsa.gov>
Subject: Re: [PATCH v2 1/2] selinux: add brief info to policydb
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Sebastien Buisson <sbuisson.ddn@gmail.com>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov
Cc: Sebastien Buisson <sbuisson@ddn.com>, james.l.morris@oracle.com
Date: Fri, 05 May 2017 15:39:42 -0400
In-Reply-To: <1493979053-16691-1-git-send-email-sbuisson@ddn.com>
References: <1493979053-16691-1-git-send-email-sbuisson@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2017-05-05 at 19:10 +0900, Sebastien Buisson wrote:
> Add policybrief field to struct policydb. It holds a brief info
> of the policydb, in the following form:
> <0 or 1 for enforce>:<0 or 1 for checkreqprot>:<hashalg>=<checksum>
> Policy brief is computed every time the policy is loaded, and when
> enforce or checkreqprot are changed.
> 
> Add security_policy_brief hook to give access to policy brief to
> the rest of the kernel. Lustre client makes use of this information.
> 
> Signed-off-by: Sebastien Buisson <sbuisson@ddn.com>
> ---
>  include/linux/lsm_hooks.h           |  2 +
>  include/linux/security.h            |  7 ++++
>  security/security.c                 |  6 +++
>  security/selinux/hooks.c            | 11 +++++-
>  security/selinux/include/security.h |  2 +
>  security/selinux/selinuxfs.c        |  6 ++-
>  security/selinux/ss/policydb.c      | 70
> +++++++++++++++++++++++++++++++++++
>  security/selinux/ss/policydb.h      |  3 ++
>  security/selinux/ss/services.c      | 73
> +++++++++++++++++++++++++++++++++++++
>  9 files changed, 178 insertions(+), 2 deletions(-)

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index e67a526..b4dd605 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -104,8 +104,10 @@
>  static int __init enforcing_setup(char *str)
>  {
>  	unsigned long enforcing;
> -	if (!kstrtoul(str, 0, &enforcing))
> +	if (!kstrtoul(str, 0, &enforcing)) {
>  		selinux_enforcing = enforcing ? 1 : 0;
> +		security_policydb_update_info(NULL);

I don't think you need this.  You are unlikely to request the policy
brief until after policy has been loaded (and if you do, you'll only
get a partial result), so you can just defer setting up the enforcing
field until the initial policy load, and then update it on subsequent
writes to /sys/fs/selinux/enforce.

> +	}
>  	return 1;
>  }
>  __setup("enforcing=", enforcing_setup);

> diff --git a/security/selinux/selinuxfs.c
> b/security/selinux/selinuxfs.c
> index ce71718..b959ee7 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -55,8 +55,10 @@
>  static int __init checkreqprot_setup(char *str)
>  {
>  	unsigned long checkreqprot;
> -	if (!kstrtoul(str, 0, &checkreqprot))
> +	if (!kstrtoul(str, 0, &checkreqprot)) {
>  		selinux_checkreqprot = checkreqprot ? 1 : 0;
> +		security_policydb_update_info(NULL);
> +	}

Ditto.  Just initialize it with the rest of the info on initial policy
load, and update it on writes to checkreqprot.

>  	return 1;
>  }
>  __setup("checkreqprot=", checkreqprot_setup);

> diff --git a/security/selinux/ss/policydb.c
> b/security/selinux/ss/policydb.c
> index 0080122..9eb2f82 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -32,6 +32,8 @@
>  #include <linux/errno.h>
>  #include <linux/audit.h>
>  #include <linux/flex_array.h>
> +#include <crypto/hash.h>
> +#include <crypto/sha.h>
>  #include "security.h"
>  
>  #include "policydb.h"
> @@ -879,6 +881,8 @@ void policydb_destroy(struct policydb *p)
>  	ebitmap_destroy(&p->filename_trans_ttypes);
>  	ebitmap_destroy(&p->policycaps);
>  	ebitmap_destroy(&p->permissive_map);
> +
> +	kfree(p->policybrief);
>  }
>  
>  /*
> @@ -2220,6 +2224,67 @@ static int ocontext_read(struct policydb *p,
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
> +	struct crypto_shash *tfm;
> +	char hashalg[] = "sha256";
> +	int hashsize = SHA256_DIGEST_SIZE;

size_t

> +	char hashval[hashsize];

unsigned char or u8

> +	int idx;
> +	unsigned char *p;
> +
> +	if (policydb->policybrief)
> +		return -EINVAL;
> +
> +	tfm = crypto_alloc_shash(hashalg, 0, 0);
> +	if (IS_ERR(tfm)) {
> +		printk(KERN_ERR "Failed to alloc crypto hash %s\n",
> hashalg);
> +		return PTR_ERR(tfm);
> +	}

Should you be checking crypto_shash_digestsize(tfm) against sizeof
hashval, or allocating hashval based on it instead? Not a problem now,
but if you ever change the algorithm and forget to update the
hashsize...

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

Just use crypto_shash_digest(); handles _init, _update, and _final for
you in one call.


> +		crypto_free_shash(tfm);
> +	}
> +
> +	/* policy brief is in the form:
> +	 * <0 or 1 for enforce>:<0 or 1 for
> checkreqprot>:<hashalg>=<checksum>
> +	 */
> +	policydb->policybrief = kzalloc(5 + strlen(hashalg) +
> 2*hashsize + 1,
> +					GFP_KERNEL);
> +	if (policydb->policybrief == NULL)
> +		return -ENOMEM;
> +
> +	sprintf(policydb->policybrief, "x:x:%s=", hashalg);

Couldn't you just directly set the enforcing and checkreqprot fields
above?  No need to call another function.

> +	security_policydb_update_info(policydb);
> +	p = policydb->policybrief + strlen(policydb->policybrief);
> +	for (idx = 0; idx < hashsize; idx++) {
> +		snprintf(p, 3, "%02x", (unsigned
> char)(hashval[idx]));

No need to cast if you fix the type above.

> +		p += 2;
> +	}
> +	policydb->policybrief_len = (size_t)(p - policydb-
> >policybrief);

This length is actually computable at build time, right?  It isn't
variant based on policy, just on hash algorithm.  No need to store it
in the policydb.

> +
> +	return 0;
> +}
> +
> +/*
>   * Read the configuration data from a policy database binary
>   * representation file into a policy database structure.
>   */
> @@ -2238,6 +2303,11 @@ int policydb_read(struct policydb *p, void
> *fp)
>  	if (rc)
>  		return rc;
>  
> +	/* Compute sumarry of policy, and store it in policydb */

summary

> +	rc = policydb_brief(p, fp);
> +	if (rc)
> +		goto bad;
> +
>  	/* Read the magic number and string length. */
>  	rc = next_entry(buf, fp, sizeof(u32) * 2);
>  	if (rc)

> diff --git a/security/selinux/ss/services.c
> b/security/selinux/ss/services.c
> index 60d9b02..9a94f8e 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2170,6 +2170,79 @@ size_t security_policydb_len(void)
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
> +	int rc = 0;
> +	size_t policybrief_len;
> +
> +	if (brief == NULL)
> +		return -EINVAL;

You can return immediately if !ss_initialized.

> +
> +	read_lock(&policy_rwlock);
> +	policybrief_len = policydb.policybrief_len;

The length is fixed by the hash algorithm.  No need to fetch it.

> +	if (policydb.policybrief == NULL)
> +		rc = -EAGAIN;

This shouldn't ever be possible if ss_initialized, right?

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
> +		 * if !alloc, caller must pass a buffer that
> +		 * can hold policybrief_len+1 chars
> +		 */
> +		if (*len < policybrief_len + 1) {
> +			/* put in *len the string size we need to
> write */
> +			*len = policybrief_len;
> +			return -ENAMETOOLONG;
> +		}
> +
> +	if (*brief == NULL)
> +		return -ENOMEM;
> +
> +	read_lock(&policy_rwlock);
> +	strncpy(*brief, policydb.policybrief,
> policydb.policybrief_len);
> +	*len = policydb.policybrief_len;
> +	read_unlock(&policy_rwlock);
> +
> +	return rc;
> +}
> +
> +void security_policydb_update_info(void *p)
> +{
> +	/* policy brief is in the form:
> +	 * <0 or 1 for enforce>:<0 or 1 for
> checkreqprot>:<hashalg>=<checksum>
> +	 */

if (!ss_initialized)
	return;

> +	if (p) {
> +		struct policydb *poldb = p;
> +		/* update policydb given as parameter if possible */
> +		if (poldb->policybrief) {
> +			poldb->policybrief[0] = '0' +
> selinux_enforcing;
> +			poldb->policybrief[2] = '0' +
> selinux_checkreqprot;

This case could be handled directly in the caller.

> +		}
> +	} else {
> +		/* update global policydb, needs write lock */
> +		write_lock_irq(&policy_rwlock);
> +		if (policydb.policybrief) {

Don't need this once ss_initialized is set.

> +			policydb.policybrief[0] = '0' +
> selinux_enforcing;
> +			policydb.policybrief[2] = '0' +
> selinux_checkreqprot;
> +		}

Technically only need to update one of the two fields at any given
time, and the caller can specify which one.  But maybe it isn't worth
it.

> +		write_unlock_irq(&policy_rwlock);
> +	}
> +}
> +
> +/**
>   * security_port_sid - Obtain the SID for a port.
>   * @protocol: protocol number
>   * @port: port number
