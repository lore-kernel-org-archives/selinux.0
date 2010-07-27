Subject: Re: [PATCH 2/2] selinux: implement mmap on /selinux/policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <20100726193414.19538.64028.stgit@paris.rdu.redhat.com>
References: <20100726193407.19538.67667.stgit@paris.rdu.redhat.com>
	 <20100726193414.19538.64028.stgit@paris.rdu.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Jul 2010 14:36:13 -0400
Message-ID: <1280255773.4789.83.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-07-26 at 15:34 -0400, Eric Paris wrote:
> /selinux/policy allows a user to copy the policy back out of the kernel.
> This patch allows userspace to actually mmap that file and use it directly.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>
> ---
> 
>  security/selinux/selinuxfs.c |   44 ++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 44 insertions(+), 0 deletions(-)
> 
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index e0c2bcf..864a74e 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -68,6 +68,8 @@ static int *bool_pending_values;
>  static struct dentry *class_dir;
>  static unsigned long last_class_ino;
>  
> +static char policy_opened;
> +
>  /* global data for policy capabilities */
>  static struct dentry *policycap_dir;
>  
> @@ -315,11 +317,23 @@ static int sel_open_policy(struct inode *inode, struct file *filp)
>  	if (rc)
>  		goto err;
>  
> +	if (policy_opened) {
> +		mutex_unlock(&sel_mutex);
> +		return -EBUSY;
> +	}
> +	policy_opened = 1;
> +
>  	rc = -ENOMEM;
>  	plm = kzalloc(sizeof(*plm), GFP_KERNEL);
>  	if (!plm)
>  		goto err;
>  
> +	if (i_size_read(inode) != security_policydb_len()) {
> +		mutex_lock(&inode->i_mutex);
> +		i_size_write(inode, security_policydb_len());
> +		mutex_unlock(&inode->i_mutex);
> +	}

What exactly are we doing here?
Do we truly want to limit /selinux/policy to one process at a time?
Why is that necessary?

>  	rc = security_read_policy(&plm->data, &plm->len);
>  	if (rc)
>  		goto err;
> @@ -344,6 +358,8 @@ static int sel_release_policy(struct inode *inode, struct file *filp)
>  
>  	BUG_ON(!plm);
>  
> +	policy_opened = 0;
> +
>  	vfree(plm->data);
>  	kfree(plm);
>  
> @@ -381,9 +397,37 @@ out:
>  	return ret;
>  }
>  
> +static int sel_mmap_policy(struct file *filp, struct vm_area_struct *vma)
> +{
> +	int ret;
> +	long length = vma->vm_end - vma->vm_start;
> +	unsigned long start = vma->vm_start;
> +	struct policy_load_memory *plm = filp->private_data;
> +	char *pos = plm->data;
> +	unsigned long pfn;
> +
> +	if (vma->vm_pgoff != 0)
> +		return -EIO;
> +
> +	if (length > roundup(plm->len, PAGE_SIZE))
> +		return -EIO;
> +
> +	while (length > 0) {
> +		pfn = vmalloc_to_pfn(pos);
> +		ret = remap_pfn_range(vma, start, pfn, PAGE_SIZE, PAGE_SHARED);
> +		if (ret)
> +			return ret;
> +		start += PAGE_SIZE;
> +		pos += PAGE_SIZE;
> +		length -= PAGE_SIZE;
> +	}
> +	return 0;
> +}

I'm not overly familiar with this area - can you point to an
example .mmap handler that you used as the basis for your
implementation?

> +
>  static const struct file_operations sel_policy_ops = {
>  	.open		= sel_open_policy,
>  	.read		= sel_read_policy,
> +	.mmap		= sel_mmap_policy,
>  	.release	= sel_release_policy,
>  };
>  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
