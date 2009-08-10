Subject: Re: [PATCH] SELinux: re. BUG memory leakage at
 ./security/selinux/hooks.c
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: iceberg <strakh@ispras.ru>, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
In-Reply-To: <alpine.LRH.2.00.0908102216430.10792@tundra.namei.org>
References: <200908101257.43672.strakh@ispras.ru>
	 <alpine.LRH.2.00.0908102152270.10706@tundra.namei.org>
	 <alpine.LRH.2.00.0908102216430.10792@tundra.namei.org>
Content-Type: text/plain
Date: Mon, 10 Aug 2009 08:24:07 -0400
Message-Id: <1249907047.2422.31.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-08-10 at 22:17 +1000, James Morris wrote:
> Please review.
> 
> Author: James Morris <jmorris@namei.org>
> Date:   Mon Aug 10 22:00:13 2009 +1000
> 
>     SELinux: fix memory leakage in /security/selinux/hooks.c
>     
>     Fix memory leakage in /security/selinux/hooks.c
>     
>     The buffer always needs to be freed here; we either error
>     out or allocate more memory.
>     
>     Reported-by: iceberg <strakh@ispras.ru>
>     Signed-off-by: James Morris <jmorris@namei.org>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 15c2a08..1e8cfc4 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1285,6 +1285,8 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>  		rc = inode->i_op->getxattr(dentry, XATTR_NAME_SELINUX,
>  					   context, len);
>  		if (rc == -ERANGE) {
> +			kfree(context);
> +
>  			/* Need a larger buffer.  Query for the right size. */
>  			rc = inode->i_op->getxattr(dentry, XATTR_NAME_SELINUX,
>  						   NULL, 0);
> @@ -1292,7 +1294,6 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>  				dput(dentry);
>  				goto out_unlock;
>  			}
> -			kfree(context);
>  			len = rc;
>  			context = kmalloc(len+1, GFP_NOFS);
>  			if (!context) {
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
