Subject: Re: [PATCH 1/2] SELinux: NULL terminate al contexts from disk
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org, paul.moore@hp.com
In-Reply-To: <20090212195005.25556.94754.stgit@paris.rdu.redhat.com>
References: <20090212195005.25556.94754.stgit@paris.rdu.redhat.com>
Content-Type: text/plain
Date: Fri, 13 Feb 2009 08:50:37 -0500
Message-Id: <1234533037.24702.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-02-12 at 14:50 -0500, Eric Paris wrote:
> When a context is pulled in from disk we don't know that it is null
> terminated.  This patch forecebly null terminates contexts when we pull
> them from disk.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

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
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
