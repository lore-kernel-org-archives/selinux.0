Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4HMJm9g024123
 for <selinux@tycho.nsa.gov>; Wed, 17 May 2017 18:19:48 -0400
Received: by mail-wm0-f67.google.com with SMTP id v4so6835953wmb.2
 for <selinux@tycho.nsa.gov>; Wed, 17 May 2017 15:19:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1495040944-11552-1-git-send-email-sbuisson@ddn.com>
References: <1495040944-11552-1-git-send-email-sbuisson@ddn.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 17 May 2017 18:19:39 -0400
Message-ID: <CAHC9VhSa_0FnaHpFR9jB4tkV-7p_JxFqRaQGC7+LTkfcmdV7mA@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] selinux: add brief info to policydb
To: Sebastien Buisson <sbuisson.ddn@gmail.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov, serge@hallyn.com,
 James Morris <james.l.morris@oracle.com>,
 Eric Paris <eparis@parisplace.org>, Stephen Smalley <sds@tycho.nsa.gov>,
 Sebastien Buisson <sbuisson@ddn.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, May 17, 2017 at 1:09 PM, Sebastien Buisson
<sbuisson.ddn@gmail.com> wrote:
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
> ---
>  include/linux/lsm_hooks.h           | 20 +++++++++
>  include/linux/security.h            |  7 +++
>  security/security.c                 |  6 +++
>  security/selinux/hooks.c            |  7 +++
>  security/selinux/include/security.h |  2 +
>  security/selinux/selinuxfs.c        |  2 +
>  security/selinux/ss/policydb.c      | 88 +++++++++++++++++++++++++++++++++++++
>  security/selinux/ss/policydb.h      |  3 ++
>  security/selinux/ss/services.c      | 67 ++++++++++++++++++++++++++++
>  9 files changed, 202 insertions(+)

I agree with Stephen's comments regarding the patch structure, but I
have a few additional comments below ...

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 87d645d..b37b8e5 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -32,13 +32,20 @@
>  #include <linux/errno.h>
>  #include <linux/audit.h>
>  #include <linux/flex_array.h>
> +#include <crypto/hash.h>
>  #include "security.h"
>
>  #include "policydb.h"
>  #include "conditional.h"
>  #include "mls.h"
> +#include "objsec.h"
>  #include "services.h"
>
> +static unsigned int policybrief_hash_size;
> +static struct crypto_shash *policybrief_tfm;
> +static const char policybrief_hash_alg[] = "sha256";
> +unsigned int policybrief_len;

I'm not a fan of all these global variables, consider it a pet peeve of mine.

I'm hopeful that we can drop policybrief_hash_size and
policybrief_len, see my comments below.

>  #define _DEBUG_HASHES
>
>  #ifdef DEBUG_HASHES
> @@ -874,6 +881,8 @@ void policydb_destroy(struct policydb *p)
>         ebitmap_destroy(&p->filename_trans_ttypes);
>         ebitmap_destroy(&p->policycaps);
>         ebitmap_destroy(&p->permissive_map);
> +
> +       kfree(p->policybrief);
>  }
>
>  /*
> @@ -2215,6 +2224,52 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
>  }
>
>  /*
> + * Compute summary of a policy database binary representation file,
> + * and store it into a policy database structure.
> + */
> +static int policydb_brief(struct policydb *policydb, void *ptr)
> +{
> +       SHASH_DESC_ON_STACK(desc, policybrief_tfm);
> +       struct policy_file *fp = ptr;
> +       u8 *hashval;
> +       int rc;
> +
> +       BUG_ON(policydb->policybrief);

I prefer normal error checking (e.g. if statements) over BUG
assertions whenever possible.

> +       hashval = kmalloc(policybrief_hash_size, GFP_KERNEL);
> +       if (hashval == NULL)
> +               return -ENOMEM;
> +
> +       desc->tfm = policybrief_tfm;
> +       desc->flags = 0;
> +       rc = crypto_shash_digest(desc, fp->data, fp->len, hashval);
> +       if (rc) {
> +               printk(KERN_ERR "Failed crypto_shash_digest: %d\n", rc);
> +               goto out_free;
> +       }
> +
> +       /* policy brief is in the form:
> +        * selinux(enforce=<0 or 1>:checkreqprot=<0 or 1>:<hashalg>=<checksum>)
> +        */

See my comments a little later down about the brief format comments.

> +       policydb->policybrief = kmalloc(policybrief_len, GFP_KERNEL);
> +       if (policydb->policybrief == NULL) {
> +               rc = -ENOMEM;
> +               goto out_free;
> +       }
> +       rc = snprintf(policydb->policybrief, policybrief_len,
> +                     "selinux(enforce=%d:checkreqprot=%d:%s=%*phN)",
> +                     selinux_enforcing, selinux_checkreqprot,
> +                     policybrief_hash_alg, policybrief_hash_size, hashval);
> +       BUG_ON(rc >= policybrief_len);

This length check should definitely be a normal check and not a
BUG_ON() assertion.

> +       rc = 0;
> +
> +out_free:
> +       kfree(hashval);
> +
> +       return rc;
> +}
> +
> +/*
>   * Read the configuration data from a policy database binary
>   * representation file into a policy database structure.
>   */
> @@ -2233,6 +2288,11 @@ int policydb_read(struct policydb *p, void *fp)
>         if (rc)
>                 return rc;
>
> +       /* Compute summary of policy, and store it in policydb */
> +       rc = policydb_brief(p, fp);
> +       if (rc)
> +               goto bad;
> +
>         /* Read the magic number and string length. */
>         rc = next_entry(buf, fp, sizeof(u32) * 2);
>         if (rc)
> @@ -3451,3 +3511,31 @@ int policydb_write(struct policydb *p, void *fp)
>
>         return 0;
>  }
> +
> +static int __init init_policybrief_hash(void)
> +{
> +       struct crypto_shash *tfm;
> +
> +       if (!selinux_enabled)
> +               return 0;
> +
> +       tfm = crypto_alloc_shash(policybrief_hash_alg, 0, 0);
> +       if (IS_ERR(tfm)) {
> +               printk(KERN_ERR "Failed to alloc crypto hash %s\n",
> +                      policybrief_hash_alg);
> +               return PTR_ERR(tfm);
> +       }
> +
> +       policybrief_tfm = tfm;
> +       policybrief_hash_size = crypto_shash_digestsize(policybrief_tfm);
> +
> +       /* policy brief is in the form:
> +        * selinux(enforce=<0 or 1>:checkreqprot=<0 or 1>:<hashalg>=<checksum>)
> +        */

Let's drop the exact brief format here and just point people at
policydb_brief() where we describe the format in the functions comment
block at the top.  I like the thought behind this, but with multiple
copies of the same information it is likely that they will fall out of
sync at some point in the future.

> +       policybrief_len = 35 + strlen(policybrief_hash_alg) +
> +               2*policybrief_hash_size + 1;

This is another long term maintenance headache.  I realize the comment
above is supposed to make this easier, but I'm still going to have to
count characters by hand whenever we play with this and that is
problematic because I only have 10 fingers ;)

How often is the Lustre kernel module going to be requesting the
policy brief?  If it is going to be often enough that a strlen() call
is too costly, I think you may be better served by leveraging some of
the LSM notification bits that were talked about earlier (e.g. the
stuff from the IB patches) to reduce your need to update Lustre's copy
of the brief.  This was we can handle the brief length calculation
locally in policydb_brief() and simply use a strlen() call in
security_policydb_brief().

> +       return 0;
> +}
> +
> +late_initcall(init_policybrief_hash);

...

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 60d9b02..67eb80d 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2170,6 +2170,73 @@ size_t security_policydb_len(void)
>  }
>
>  /**
> + * security_policydb_brief - Get policydb brief
> + * @brief: pointer to buffer holding brief
> + * @len: in: brief buffer length if no alloc, out: brief string len
> + * @alloc: whether to allocate buffer for brief or not
> + *
> + * If @alloc, *brief must be kfreed by caller.
> + * If not @alloc, caller must pass a buffer that can hold policybrief_len
> + * chars (including terminating NUL).
> + * On success 0 is returned , or negative value on error.
> + **/
> +int security_policydb_brief(char **brief, size_t *len, bool alloc)
> +{
> +       if (!ss_initialized || brief == NULL)
> +               return -EINVAL;
> +
> +       if (alloc) {
> +               *brief = kzalloc(policybrief_len, GFP_KERNEL);
> +       } else if (*len < policybrief_len) {
> +               /* put in *len the string size we need to write */
> +               *len = policybrief_len;
> +               return -ENAMETOOLONG;
> +       }
> +
> +       if (*brief == NULL)
> +               return -ENOMEM;
> +
> +       read_lock(&policy_rwlock);
> +       strcpy(*brief, policydb.policybrief);
> +       /* *len is the length of the output string */
> +       *len = policybrief_len - 1;
> +       read_unlock(&policy_rwlock);
> +
> +       return 0;
> +}
> +
> +void security_policydb_update_info(u32 requested)
> +{
> +       /* policy brief is in the form:
> +        * selinux(enforce=<0 or 1>:checkreqprot=<0 or 1>:<hashalg>=<checksum>)
> +        */

See my earlier comments about the brief format.

> +       char enforce[] = "enforce=";
> +       char checkreqprot[] = "checkreqprot=";
> +       char *p, *str;
> +       int val;
> +
> +       if (!ss_initialized)
> +               return;
> +
> +       if (requested == SECURITY__SETENFORCE) {
> +               str = enforce;
> +               val = selinux_enforcing;
> +       } else if (requested == SECURITY__SETCHECKREQPROT) {
> +               str = checkreqprot;
> +               val = selinux_checkreqprot;
> +       }

Turn the above into a switch/case statement and make the default
return immediately.

> +       /* update global policydb, needs write lock */
> +       write_lock_irq(&policy_rwlock);
> +       p = strstr(policydb.policybrief, str);
> +       if (p) {
> +               p += strlen(str);
> +               *p = '0' + val;

To be overly cautious, let's remove the possibility for anything other
than '0' or '1'.

  *p = (val ? '1' : '0');

> +       }
> +       write_unlock_irq(&policy_rwlock);
> +}
> +
> +/**
>   * security_port_sid - Obtain the SID for a port.
>   * @protocol: protocol number
>   * @port: port number
> --
> 1.8.3.1

-- 
paul moore
www.paul-moore.com
