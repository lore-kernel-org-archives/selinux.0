Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uA3KadcF014332
 for <selinux@tycho.nsa.gov>; Thu, 3 Nov 2016 16:36:39 -0400
Subject: Re: [PATCH] mqueue: security xattr setting on inode creation
To: selinux@tycho.nsa.gov, "linux-security-module@vger.kernel.org >> LSM"
 <linux-security-module@vger.kernel.org>
References: <1478196668-37231-1-git-send-email-david.graziano@rockwellcollins.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <f3556755-a4cd-4281-df52-9adac3aad008@schaufler-ca.com>
Date: Thu, 3 Nov 2016 13:36:32 -0700
MIME-Version: 1.0
In-Reply-To: <1478196668-37231-1-git-send-email-david.graziano@rockwellcollins.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/3/2016 11:11 AM, David Graziano wrote:
> Adds generic xattr support by implementing initxattrs callback.
> This enables setting of security attributes from LSM and EVM when
> inode is created. Implementation based off tmpfs/shmem.

This should go to the LSM linux-security-module@vger.kernel.org
I've cced that list.

>
> Signed-off-by: David Graziano <david.graziano@rockwellcollins.com>
> ---
>  ipc/mqueue.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>
> diff --git a/ipc/mqueue.c b/ipc/mqueue.c
> index 0b13ace..512a546 100644
> --- a/ipc/mqueue.c
> +++ b/ipc/mqueue.c
> @@ -35,6 +35,7 @@
>  #include <linux/ipc_namespace.h>
>  #include <linux/user_namespace.h>
>  #include <linux/slab.h>
> +#include <linux/xattr.h>
>  
>  #include <net/sock.h>
>  #include "util.h"
> @@ -70,6 +71,7 @@ struct mqueue_inode_info {
>  	struct rb_root msg_tree;
>  	struct posix_msg_tree_node *node_cache;
>  	struct mq_attr attr;
> +	struct simple_xattrs xattrs;	/* list of xattrs */
>  
>  	struct sigevent notify;
>  	struct pid *notify_owner;
> @@ -254,6 +256,7 @@ static struct inode *mqueue_get_inode(struct super_block *sb,
>  			info->attr.mq_maxmsg = attr->mq_maxmsg;
>  			info->attr.mq_msgsize = attr->mq_msgsize;
>  		}
> +		simple_xattrs_init(&info->xattrs);
>  		/*
>  		 * We used to allocate a static array of pointers and account
>  		 * the size of that array as well as one msg_msg struct per
> @@ -413,6 +416,41 @@ static void mqueue_evict_inode(struct inode *inode)
>  		put_ipc_ns(ipc_ns);
>  }
>  
> +/*
> + * Callback for security_inode_init_security() for acquiring xattrs.
> + */
> +static int mqueue_initxattrs(struct inode *inode,
> +			    const struct xattr *xattr_array,
> +			    void *fs_info)
> +{
> +	struct mqueue_inode_info *info = MQUEUE_I(inode);
> +	const struct xattr *xattr;
> +	struct simple_xattr *new_xattr;
> +	size_t len;
> +
> +	for (xattr = xattr_array; xattr->name != NULL; xattr++) {
> +		new_xattr = simple_xattr_alloc(xattr->value, xattr->value_len);
> +		if (!new_xattr)
> +			return -ENOMEM;
> +		len = strlen(xattr->name) + 1;
> +		new_xattr->name = kmalloc(XATTR_SECURITY_PREFIX_LEN + len,
> +					  GFP_KERNEL);
> +		if (!new_xattr->name) {
> +			kfree(new_xattr);
> +			return -ENOMEM;
> +		}
> +
> +		memcpy(new_xattr->name, XATTR_SECURITY_PREFIX,
> +		       XATTR_SECURITY_PREFIX_LEN);
> +		memcpy(new_xattr->name + XATTR_SECURITY_PREFIX_LEN,
> +		       xattr->name, len);
> +
> +		simple_xattr_list_add(&info->xattrs, new_xattr);
> +	}
> +
> +	return 0;
> +}
> +
>  static int mqueue_create(struct inode *dir, struct dentry *dentry,
>  				umode_t mode, bool excl)
>  {
> @@ -443,6 +481,14 @@ static int mqueue_create(struct inode *dir, struct dentry *dentry,
>  		ipc_ns->mq_queues_count--;
>  		goto out_unlock;
>  	}
> +	error = security_inode_init_security(inode, dir,
> +					     &dentry->d_name,
> +					     mqueue_initxattrs, NULL);
> +	if (error && error != -EOPNOTSUPP) {
> +		spin_lock(&mq_lock);
> +		ipc_ns->mq_queues_count--;
> +		goto out_unlock;
> +	}
>  
>  	put_ipc_ns(ipc_ns);
>  	dir->i_size += DIRENT_SIZE;
