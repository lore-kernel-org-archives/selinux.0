Subject: Re: [PATCH 1/2] SELinux: allow userspace to read policy back out
 of the kernel
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <20100726193407.19538.67667.stgit@paris.rdu.redhat.com>
References: <20100726193407.19538.67667.stgit@paris.rdu.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Jul 2010 14:31:35 -0400
Message-ID: <1280255495.4789.78.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-07-26 at 15:34 -0400, Eric Paris wrote:
> There is interest in being able to see what the actual policy is that was
> loaded into the kernel.  The patch creates a new selinuxfs file
> /selinux/policy which can be read by userspace.  The actual policy that is
> loaded into the kernel will be written back out to userspace.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>
> ---
> 
>  include/linux/kernel.h              |    1 
>  security/selinux/include/security.h |    2 
>  security/selinux/selinuxfs.c        |   92 ++++
>  security/selinux/ss/avtab.c         |   42 ++
>  security/selinux/ss/avtab.h         |    2 
>  security/selinux/ss/conditional.c   |  123 +++++
>  security/selinux/ss/conditional.h   |    2 
>  security/selinux/ss/ebitmap.c       |   81 +++
>  security/selinux/ss/ebitmap.h       |    1 
>  security/selinux/ss/policydb.c      |  838 +++++++++++++++++++++++++++++++++++
>  security/selinux/ss/policydb.h      |   23 +
>  security/selinux/ss/services.c      |   54 ++
>  12 files changed, 1259 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 7d5b10f..d6092fd 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -59,6 +59,7 @@ extern const char linux_proc_banner[];
>  #define FIELD_SIZEOF(t, f) (sizeof(((t*)0)->f))
>  #define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
>  #define roundup(x, y) ((((x) + ((y) - 1)) / (y)) * (y))
> +#define rounddown(x, y) ((x) - ((x) % (y)))
>  #define DIV_ROUND_CLOSEST(x, divisor)(			\
>  {							\
>  	typeof(divisor) __divisor = divisor;

I guess this hunk needs to go to linux-kernel.

> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 79a1bb6..e0c2bcf 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -110,6 +110,7 @@ enum sel_inos {
>  	SEL_COMPAT_NET,	/* whether to use old compat network packet controls */
>  	SEL_REJECT_UNKNOWN, /* export unknown reject handling to userspace */
>  	SEL_DENY_UNKNOWN, /* export unknown deny handling to userspace */
> +	SEL_POLICY,	/* allow userspace to read the in kernel policy */
>  	SEL_INO_NEXT,	/* The next inode number to use */
>  };
>  
> @@ -296,6 +297,96 @@ static const struct file_operations sel_mls_ops = {
>  	.llseek		= generic_file_llseek,
>  };
>  
> +struct policy_load_memory {
> +	size_t len;
> +	void *data;
> +};
> +
> +static int sel_open_policy(struct inode *inode, struct file *filp)
> +{
> +	struct policy_load_memory *plm = NULL;
> +	int rc;
> +
> +	BUG_ON(filp->private_data);
> +
> +	mutex_lock(&sel_mutex);
> +
> +	rc = task_has_security(current, SECURITY__LOAD_POLICY);

I'd introduce a new permission for this operation - reading the active
from the kernel isn't equivalent to being able to load a different
policy.

> +static ssize_t sel_read_policy(struct file *filp, char __user *buf,
> +			       size_t count, loff_t *ppos)
> +{
> +	struct policy_load_memory *plm = filp->private_data;
> +	int ret;
> +
> +	mutex_lock(&sel_mutex);
> +
> +	ret = task_has_security(current, SECURITY__LOAD_POLICY);
> +	if (ret)
> +		goto out;

Likewise.

> +
> +	ret = 0;
> +	if (*ppos >= plm->len)
> +		goto out;
> +
> +	if (*ppos + count >= plm->len)
> +		count = plm->len - *ppos;
> +
> +	ret = -EFAULT;
> +	if (copy_to_user(buf, plm->data + *ppos, count))
> +		goto out;
> +
> +	*ppos += count;

I'd use simple_read_from_buffer() for this logic; it handles the range
checking and copying for you.

> +	ret = count;
> +out:
> +	mutex_unlock(&sel_mutex);
> +	return ret;
> +}
> +

Do we care that the caller can hold policy-size kernel memory allocated
per open file instance?  I guess your next patch introduces some limit
on that.

> diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
> index 26d9adf..9cbf9df 100644
> --- a/security/selinux/ss/policydb.h
> +++ b/security/selinux/ss/policydb.h
> @@ -299,6 +305,23 @@ static inline int next_entry(void *buf, struct policy_file *fp, size_t bytes)
>  	return 0;
>  }
>  
> +static inline int put_entry(void *buf, size_t bytes, int num, struct policy_file *fp)
> +{
> +	size_t len = bytes * num;
> +
> +	/*
> +	 * this could happen if there was a policy load between the call to
> +	 * security_policydb_len() and security_policydb_read()
> +	 */
> +	if (len > fp->len)
> +		return -ENOMEM;

Not if you are holding sel_mutex in selinuxfs around the entire
operation.  No possible interleaving of load with read in that
situation, right?

> +
> +	memcpy(fp->data, buf, len);
> +	fp->data += len;
> +	fp->len -= len;
> +	return 0;
> +}
> +
>  extern u16 string_to_security_class(struct policydb *p, const char *name);
>  extern u32 string_to_av_perm(struct policydb *p, u16 tclass, const char *name);
>  
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 1de60ce..4d4bc46 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -77,6 +77,7 @@ static DEFINE_RWLOCK(policy_rwlock);
>  
>  static struct sidtab sidtab;
>  struct policydb policydb;
> +static size_t policydb_len;

Why not just make it a field within the policydb?  Longer term I want
sidtab, policydb, and any other global policy state (e.g.
current_mapping) wrapped up in a single structure with a single global
pointer used to dereference it.  Then policy switch can be done as a
single pointer change.

> @@ -3126,3 +3134,49 @@ netlbl_sid_to_secattr_failure:
>  	return rc;
>  }
>  #endif /* CONFIG_NETLABEL */
> +
> +/**
> + * security_read_policy - read the policy.
> + * @data: binary policy data
> + * @len: length of data in bytes
> + *
> + */
> +int security_read_policy(void **data, ssize_t *len)
> +{
> +	int rc;
> +	struct policy_file fp;
> +	u32 last_grant;
> +
> +	if (!ss_initialized)
> +		return -EINVAL;
> +again:
> +	read_lock(&policy_rwlock);
> +	*len = security_policydb_len();
> +	last_grant = latest_granting;
> +	read_unlock(&policy_rwlock);
> +
> +	*data = vmalloc(*len);
> +	if (!*data)
> +		return -ENOMEM;
> +
> +	fp.data = *data;
> +	fp.len = *len;
> +
> +	read_lock(&policy_rwlock);
> +
> +	/* check if a policy load happened while we were allocating memory */
> +	if (last_grant != latest_granting) {
> +		read_unlock(&policy_rwlock);
> +		vfree(*data);
> +		goto again;
> +	}

Not possible if holding sel_mutex across the entire operation, right?

> +
> +	rc = policydb_write(&policydb, &fp);
> +	read_unlock(&policy_rwlock);
> +	if (rc)
> +		return rc;
> +
> +	*len = (unsigned long)fp.data - (unsigned long)*data;
> +	return 0;
> +
> +}

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
