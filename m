Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m25MTAbQ013196
	for <selinux@tycho.nsa.gov>; Wed, 5 Mar 2008 17:29:10 -0500
Received: from web36609.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m25MT6xo007033
	for <selinux@tycho.nsa.gov>; Wed, 5 Mar 2008 22:29:06 GMT
Date: Wed, 5 Mar 2008 14:28:56 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 2/2] LSM/SELinux: inode_{get,set}secctx hooks to access LSM security context information.
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>, casey@schaufler-ca.com,
        chrisw@sous-sol.org, sds@tycho.nsa.gov, jmorris@namei.org, hch@lst.de,
        viro@zeniv.linux.org.uk
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "David P. Quigley" <dpquigl@tycho.nsa.gov>
In-Reply-To: <1204743288-3461-3-git-send-email-dpquigl@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <435942.1210.qm@web36609.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- "David P. Quigley" <dpquigl@tycho.nsa.gov> wrote:

> This patch introduces two new hooks. One to get all relevant information from
> an LSM about an inode an the second given that context to set it on the
> inode. The setcontext call takes a flag to indicate if it should set the
> incore
> representation, the ondisk representation or both.

Is this advisory or manditory? What should the behavior be for
virtual file systems like selinuxfs and smackfs when the "on disk"
bit is set? I understand that the intended target is NFS, but that
is not going to stop someone from using it to other purposes. I
would suggest that the flag be advisory and that the behavior of
where the value gets set be left to the LSM and file system to
work out.


> This hook is for use in
> the
> labeled NFS code and addresses concerns of how to set security on an inode in
> a
> multi-xattr LSM.

I think this looks right. Let me make sure that everything is the
way I think it is, just to be sure.

If I call inode_getsecid() and pass that to secid_to_secctx(),
I'm guaranteed to get the same thing I would have gotten if I
called inode_getsecctx, assuming rational implementations of
the hooks of course. Similarly, calling inode_getsecctx() and
passing the result to secctx_to_secid() is the same as
inode_getsecid(). If I have stacked LSMs (someday) the secid
will represent the combination of all the modules and the secctx
will describe all the LSM attributes regardless of how they are
stored.

> Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>
> ---
>  include/linux/security.h |   18 ++++++++++++++++++
>  security/dummy.c         |   12 ++++++++++++
>  security/security.c      |   12 ++++++++++++
>  security/selinux/hooks.c |   31 ++++++++++++++++++++++++++++++-
>  4 files changed, 72 insertions(+), 1 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index fe52cde..bb71ac9 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -112,6 +112,10 @@ struct request_sock;
>  #define LSM_UNSAFE_PTRACE	2
>  #define LSM_UNSAFE_PTRACE_CAP	4
>  
> +/* Flags for setsecctx */
> +#define LSM_SETCORE	1
> +#define LSM_SETDISK	2
> +
>  #ifdef CONFIG_SECURITY
>  
>  /**
> @@ -1395,6 +1399,9 @@ struct security_operations {
>  	int (*secctx_to_secid)(char *secdata, u32 seclen, u32 *secid);
>  	void (*release_secctx)(char *secdata, u32 seclen);
>  
> +	int (*inode_setsecctx)(struct dentry *dentry, void *ctx, u32 ctxlen, int
> flags);
> +	int (*inode_getsecctx)(struct dentry *dentry, void **ctx, u32 *ctxlen);
> +
>  #ifdef CONFIG_SECURITY_NETWORK
>  	int (*unix_stream_connect) (struct socket * sock,
>  				    struct socket * other, struct sock * newsk);
> @@ -1634,6 +1641,8 @@ int security_secid_to_secctx(u32 secid, char **secdata,
> u32 *seclen);
>  int security_secctx_to_secid(char *secdata, u32 seclen, u32 *secid);
>  void security_release_secctx(char *secdata, u32 seclen);
>  
> +int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen,
> int flags);
> +int security_inode_getsecctx(struct dentry *dentry, void **ctx, u32
> *ctxlen);
>  #else /* CONFIG_SECURITY */
>  
>  /*
> @@ -2316,6 +2325,15 @@ static inline int security_secctx_to_secid(char
> *secdata,
>  static inline void security_release_secctx(char *secdata, u32 seclen)
>  {
>  }
> +
> +static inline int security_inode_setsecctx(struct dentry *dentry, void *ctx,
> u32 ctxlen, int flags)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static inline int security_inode_getsecctx(struct dentry *dentry, void
> **ctx, u32 *ctxlen)
> +{
> +	return -EOPNOTSUPP;
> +}
>  #endif	/* CONFIG_SECURITY */
>  
>  #ifdef CONFIG_SECURITY_NETWORK
> diff --git a/security/dummy.c b/security/dummy.c
> index 649326b..774e243 100644
> --- a/security/dummy.c
> +++ b/security/dummy.c
> @@ -960,6 +960,16 @@ static void dummy_release_secctx(char *secdata, u32
> seclen)
>  {
>  }
>  
> +static int dummy_inode_setsecctx(struct dentry *dentry, void *ctx, u32
> ctxlen, int flags)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static int dummy_inode_getsecctx(struct dentry *dentry, void **ctx, u32
> *ctxlen)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  #ifdef CONFIG_KEYS
>  static inline int dummy_key_alloc(struct key *key, struct task_struct *ctx,
>  				  unsigned long flags)
> @@ -1118,6 +1128,8 @@ void security_fixup_ops (struct security_operations
> *ops)
>   	set_to_dummy_if_null(ops, secid_to_secctx);
>  	set_to_dummy_if_null(ops, secctx_to_secid);
>   	set_to_dummy_if_null(ops, release_secctx);
> +	set_to_dummy_if_null(ops, inode_setsecctx);
> +	set_to_dummy_if_null(ops, inode_getsecctx);
>  #ifdef CONFIG_SECURITY_NETWORK
>  	set_to_dummy_if_null(ops, unix_stream_connect);
>  	set_to_dummy_if_null(ops, unix_may_send);
> diff --git a/security/security.c b/security/security.c
> index d15e56c..84db95a 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -845,6 +845,18 @@ void security_release_secctx(char *secdata, u32 seclen)
>  }
>  EXPORT_SYMBOL(security_release_secctx);
>  
> +int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen,
> int flags)
> +{
> +	return security_ops->inode_setsecctx(dentry, ctx, ctxlen, flags);
> +}
> +EXPORT_SYMBOL(security_inode_setsecctx);
> +
> +int security_inode_getsecctx(struct dentry *dentry, void **ctx, u32 *ctxlen)
> +{
> +	return security_ops->inode_getsecctx(dentry, ctx, ctxlen);
> +}
> +EXPORT_SYMBOL(security_inode_getsecctx);
> +
>  #ifdef CONFIG_SECURITY_NETWORK
>  
>  int security_unix_stream_connect(struct socket *sock, struct socket *other,
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 75c2e99..47e8fb0 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -75,6 +75,7 @@
>  #include <linux/string.h>
>  #include <linux/selinux.h>
>  #include <linux/mutex.h>
> +#include <linux/fsnotify.h>
>  
>  #include "avc.h"
>  #include "objsec.h"
> @@ -5163,6 +5164,33 @@ static void selinux_release_secctx(char *secdata, u32
> seclen)
>  	kfree(secdata);
>  }
>  
> +/*
> + *	This hook requires that the inode i_mutex be locked
> + */
> +static int selinux_inode_setsecctx(struct dentry *dentry, void *ctx, u32
> ctxlen, int flags)
> +{
> +	struct inode *inode = dentry->d_inode;
> +	int rc = 0;
> +
> +	if (flags & LSM_SETCORE) {
> +		rc = selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX,
> +						ctx, ctxlen, 0);
> +		if(rc)
> +			return rc;
> +	}
> +	if (flags & LSM_SETDISK)
> +		rc = do_setxattr(dentry, XATTR_NAME_SELINUX, ctx, ctxlen, 0); 
> +	
> +	return rc;
> +}
> +static int selinux_inode_getsecctx(struct dentry *dentry, void **ctx, u32
> *ctxlen)
> +{
> +	struct inode *inode = dentry->d_inode;
> +	
> +	*ctxlen = selinux_inode_getsecurity(inode, XATTR_SELINUX_SUFFIX,
> +						ctx, true);
> +	return *ctxlen;
> +}
>  #ifdef CONFIG_KEYS
>  
>  static int selinux_key_alloc(struct key *k, struct task_struct *tsk,
> @@ -5351,7 +5379,8 @@ static struct security_operations selinux_ops = {
>  	.secid_to_secctx =		selinux_secid_to_secctx,
>  	.secctx_to_secid =		selinux_secctx_to_secid,
>  	.release_secctx =		selinux_release_secctx,
> -
> +	.inode_setsecctx =		selinux_inode_setsecctx,
> +	.inode_getsecctx =		selinux_inode_getsecctx,
>          .unix_stream_connect =		selinux_socket_unix_stream_connect,
>  	.unix_may_send =		selinux_socket_unix_may_send,
>  
> -- 
> 1.5.4.1
> 
> 
> 


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
