Date: Sat, 14 Feb 2009 09:43:56 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, paul.moore@hp.com
Subject: Re: [PATCH 1/2] SELinux: NULL terminate al contexts from disk
In-Reply-To: <20090212195005.25556.94754.stgit@paris.rdu.redhat.com>
Message-ID: <alpine.LRH.1.10.0902140943500.32324@tundra.namei.org>
References: <20090212195005.25556.94754.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 12 Feb 2009, Eric Paris wrote:

> When a context is pulled in from disk we don't know that it is null
> terminated.  This patch forecebly null terminates contexts when we pull
> them from disk.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>


Applied.

> ---
> 
>  security/selinux/hooks.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 45e286c..4afaeac 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1290,12 +1290,13 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>  		}
>  
>  		len = INITCONTEXTLEN;
> -		context = kmalloc(len, GFP_NOFS);
> +		context = kmalloc(len+1, GFP_NOFS);
>  		if (!context) {
>  			rc = -ENOMEM;
>  			dput(dentry);
>  			goto out_unlock;
>  		}
> +		context[len] = '\0';
>  		rc = inode->i_op->getxattr(dentry, XATTR_NAME_SELINUX,
>  					   context, len);
>  		if (rc == -ERANGE) {
> @@ -1308,12 +1309,13 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>  			}
>  			kfree(context);
>  			len = rc;
> -			context = kmalloc(len, GFP_NOFS);
> +			context = kmalloc(len+1, GFP_NOFS);
>  			if (!context) {
>  				rc = -ENOMEM;
>  				dput(dentry);
>  				goto out_unlock;
>  			}
> +			context[len] = '\0';
>  			rc = inode->i_op->getxattr(dentry,
>  						   XATTR_NAME_SELINUX,
>  						   context, len);
> 

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
