Message-ID: <1493231426.32540.11.camel@tycho.nsa.gov>
Subject: Re: [PATCH 2/3] selinux: add checksum to policydb
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Sebastien Buisson <sbuisson.ddn@gmail.com>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov
Cc: serge@hallyn.com, james.l.morris@oracle.com, eparis@parisplace.org,
 paul@paul-moore.com, danielj@mellanox.com, Sebastien Buisson
 <sbuisson@ddn.com>
Date: Wed, 26 Apr 2017 14:30:26 -0400
In-Reply-To: <1493218936-18522-2-git-send-email-sbuisson@ddn.com>
References: <1493218936-18522-1-git-send-email-sbuisson@ddn.com>
 <1493218936-18522-2-git-send-email-sbuisson@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-04-27 at 00:02 +0900, Sebastien Buisson wrote:
> Add policycksum field to struct policydb. It holds the sha256
> checksum computed on the binary policy every time the notifier is
> called after a policy change.
> Add security_policy_cksum hook to give access to policy checksum to
> the rest of the kernel. Lustre client makes use of this information.
> 
> Signed-off-by: Sebastien Buisson <sbuisson@ddn.com>
> ---
>  include/linux/lsm_hooks.h           |  2 +
>  include/linux/security.h            |  7 +++
>  security/security.c                 |  6 +++
>  security/selinux/hooks.c            | 12 ++++-
>  security/selinux/include/security.h |  2 +
>  security/selinux/ss/policydb.h      |  4 ++
>  security/selinux/ss/services.c      | 91
> +++++++++++++++++++++++++++++++++++++
>  7 files changed, 123 insertions(+), 1 deletion(-)
> 

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index a4d36f8..3759198 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -173,8 +173,11 @@ static int selinux_netcache_avc_callback(u32
> event)
>  
>  static int selinux_lsm_notifier_avc_callback(u32 event)
>  {
> -	if (event == AVC_CALLBACK_RESET)
> +	if (event == AVC_CALLBACK_RESET) {
> +		if (security_policydb_compute_cksum() != 0)
> +			printk(KERN_ERR "Failed to compute policydb
> cksum\n");

This seems like an odd place to trigger the computation. Why aren't you
just computing it when the policy is loaded directly in
security_load_policy()?  You already have the (data, len) on entry to
that function.  Just compute it at load time, save it, and be done.  No
need for a notifier then for your use case unless I am missing
something.

I suppose the question is which checksum do you want - the hash of the
policy file that was written to /sys/fs/selinux/load by userspace, or
the hash of the policy file that the kernel generates on demand if you
open /sys/fs/selinux/policy.  Those can differ in non-semantic ways due
to ordering differences, for example.  I think the former is more
likely to be of interest to userspace (e.g. to compare the hash value
against the hash of the policy file), and is cheaper since you already
have a (data, len) pair on entry to security_load_policy() that you can
hash immediately rather than requiring the kernel to regenerate the
image from the policydb.

>  		call_lsm_notifier(LSM_POLICY_CHANGE, NULL);
> +	}
>  
>  	return 0;
>  }
> 

> diff --git a/security/selinux/ss/services.c
> b/security/selinux/ss/services.c
> index 60d9b02..a35d294 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -53,6 +53,8 @@
>  #include <linux/flex_array.h>
>  #include <linux/vmalloc.h>
>  #include <net/netlabel.h>
> +#include <crypto/hash.h>
> +#include <crypto/sha.h>
>  
>  #include "flask.h"
>  #include "avc.h"
> @@ -2170,6 +2172,95 @@ size_t security_policydb_len(void)
>  }
>  
>  /**
> + * security_policydb_cksum - Get policydb checksum.
> + * @cksum: string to store checksum to
> + * @len: length of checksum
> + */
> +ssize_t security_policydb_cksum(char *cksum, size_t len)
> +{
> +	int rc;
> +
> +	read_lock(&policy_rwlock);
> +	if (strlcpy(cksum, policydb.policycksum, len) >= len)
> +		rc = -ENAMETOOLONG;
> +	rc = policydb.policycksum_len;

Obviously you'll clobber -ENAMETOOLONG here.

> +	read_unlock(&policy_rwlock);
> +
> +	return rc;
> +}

You are requiring all callers to know that they are dealing with a
sha256 hash string in order to provide an adequately sized buffer.
So we either ought to make that evident in the interface, or make the
interface more flexible/general.  The latter is imho preferable.  We
could simply allocate a buffer of the right length and return it, like
selinux_inode_getsecurity() does.

> +
> +/**
> + * security_policydb_compute_cksum - Compute checksum of a policy
> database.
> + */
> +int security_policydb_compute_cksum(void)
> +{
> +	struct crypto_ahash *tfm;
> +	struct ahash_request *req;
> +	struct scatterlist sl;
> +	char hashval[SHA256_DIGEST_SIZE];
> +	int idx;
> +	unsigned char *p;
> +	size_t len;
> +	void *data;
> +	int rc;
> +
> +	rc = security_read_policy(&data, &len);
> +	if (rc) {
> +		printk(KERN_ERR "Failed to read security policy\n");
> +		return rc;
> +	}

This requires regenerating the policy image from the policydb; simpler
if we can just hash what we were given in security_load_policy() and
save it at that time.

> +
> +	tfm = crypto_alloc_ahash("sha256", 0, CRYPTO_ALG_ASYNC);

Why are you using the async interface?

> +	if (IS_ERR(tfm)) {
> +		printk(KERN_ERR "Failed to alloc crypto hash
> sha256\n");
> +		vfree(data);
> +		rc = PTR_ERR(tfm);
> +		return rc;
> +	}
> +
> +	req = ahash_request_alloc(tfm, GFP_KERNEL);
> +	if (!req) {
> +		printk(KERN_ERR "Failed to alloc ahash_request for
> sha256\n");
> +		crypto_free_ahash(tfm);
> +		vfree(data);
> +		rc = -ENOMEM;
> +		return rc;
> +	}
> +
> +	ahash_request_set_callback(req, 0, NULL, NULL);
> +
> +	rc = crypto_ahash_init(req);
> +	if (rc) {
> +		printk(KERN_ERR "Failed to init ahash\n");
> +		ahash_request_free(req);
> +		crypto_free_ahash(tfm);
> +		vfree(data);
> +		return rc;
> +	}
> +
> +	sg_init_one(&sl, (void *)data, len);
> +	ahash_request_set_crypt(req, &sl, hashval, sl.length);
> +	rc = crypto_ahash_digest(req);
> +
> +	crypto_free_ahash(tfm);
> +	ahash_request_free(req);
> +	vfree(data);
> +	if (rc) {
> +		printk(KERN_ERR "Failed to compute digest\n");
> +		return rc;
> +	}
> +
> +	p = policydb.policycksum;
> +	for (idx = 0; idx < SHA256_DIGEST_SIZE; idx++) {
> +		snprintf(p, 3, "%02x", (unsigned
> char)(hashval[idx]));
> +		p += 2;
> +	}
> +	policydb.policycksum_len = (size_t)(p -
> policydb.policycksum);
> +
> +	return 0;
> +}
> +
> +/**
>   * security_port_sid - Obtain the SID for a port.
>   * @protocol: protocol number
>   * @port: port number
