From: Paul Moore <paul.moore@hp.com>
To: Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH 1/2] SELinux: NULL terminate al contexts from disk
Date: Thu, 12 Feb 2009 15:46:56 -0500
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, jmorris@namei.org
References: <20090212195005.25556.94754.stgit@paris.rdu.redhat.com>
In-Reply-To: <20090212195005.25556.94754.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200902121546.56758.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 12 February 2009 02:50:05 pm Eric Paris wrote:
> @@ -1290,12 +1290,13 @@ static int inode_doinit_with_dentry(struct inode
> *inode, struct dentry *opt_dent }
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

Perhaps move the "context[len] = '\0';" to just after the getxattr() call?  It 
might help provide a little extra protection in case getxattr() gets a little 
buggy ... then again maybe not, your call.

-- 
paul moore
linux @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
