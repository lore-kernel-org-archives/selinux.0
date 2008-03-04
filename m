Subject: Re: [PATCH 1/1] LSM/SELinux: {get,set}context hooks to access LSM
	security context information.
From: Dave Quigley <dpquigl@tycho.nsa.gov>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: sds@tycho.nsa.gov, jmorris@namei.org, chrisw@sous-sol.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
In-Reply-To: <953413.48800.qm@web36611.mail.mud.yahoo.com>
References: <953413.48800.qm@web36611.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Tue, 04 Mar 2008 17:33:57 -0500
Message-Id: <1204670037.14520.121.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I don't see anything in Ahmed's patch set that has this kind of
functionality. Also a quick glance over the patch names in the FSCache
set doesn't seem to yield a hook like this either. David Howell's
patches are mainly to deal with process contexts not file contexts which
this patch addresses.

Dave


On Tue, 2008-03-04 at 14:53 -0800, Casey Schaufler wrote:
> ----- Original Message ----
> > From: David P. Quigley <dpquigl@tycho.nsa.gov>
> > To: sds@tycho.nsa.gov; jmorris@namei.org; chrisw@sous-sol.org; casey@schaufler-ca.com
> > Cc: linux-security-module@vger.kernel.org; selinux@tycho.nsa.gov; David P. Quigley <dpquigl@tycho.nsa.gov>
> > Sent: Tuesday, March 4, 2008 1:53:43 PM
> > Subject: [PATCH 1/1] LSM/SELinux: {get,set}context hooks to access LSM security context information.
> > 
> > This patch introduces two new hooks. One to get all relavent information from
> > an LSM about an inode an the second given that context to set it on the
> > inode. The setcontext call takes a flag to indicate if it should set the incore
> > representation, the ondisk representation or both.
> 
> Please coordinate with David Powell and Ahmed Darwish on these.
> File system cacheing and audit both require similar functionality
> and have proposed it in slightly different manners and with
> slightly different names.
> 
> 
> > Signed-off-by: David P. Quigley 
> > ---
> > include/linux/security.h | 18 ++++++++++++++++++
> > security/dummy.c | 12 ++++++++++++
> > security/security.c | 12 ++++++++++++
> > security/selinux/hooks.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
> > 4 files changed, 86 insertions(+), 1 deletions(-)
> > 
> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index fe52cde..9b1cc6f 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -112,6 +112,10 @@ struct request_sock;
> > #define LSM_UNSAFE_PTRACE 2
> > #define LSM_UNSAFE_PTRACE_CAP 4
> > 
> > +/* Flags for setcontext */
> > +#define LSM_SETCORE 1
> > +#define LSM_SETDISK 2
> > +
> > #ifdef CONFIG_SECURITY
> > 
> > /**
> > @@ -1395,6 +1399,9 @@ struct security_operations {
> > int (*secctx_to_secid)(char *secdata, u32 seclen, u32 *secid);
> > void (*release_secctx)(char *secdata, u32 seclen);
> > 
> > + int (*setcontext)(struct dentry *dentry, void *ctx, u32 ctxlen, int flags);
> > + int (*getcontext)(struct dentry *dentry, void **ctx, u32 *ctxlen);
> > +
> > #ifdef CONFIG_SECURITY_NETWORK
> > int (*unix_stream_connect) (struct socket * sock,
> > struct socket * other, struct sock * newsk);
> > @@ -1634,6 +1641,8 @@ int security_secid_to_secctx(u32 secid, char **secdata, 
> > u32 *seclen);
> > int security_secctx_to_secid(char *secdata, u32 seclen, u32 *secid);
> > void security_release_secctx(char *secdata, u32 seclen);
> > 
> > +int security_setcontext(struct dentry *dentry, void *ctx, u32 ctxlen, int 
> > flags);
> > +int security_getcontext(struct dentry *dentry, void **ctx, u32 *ctxlen);
> > #else /* CONFIG_SECURITY */
> > 
> > /*
> > @@ -2316,6 +2325,15 @@ static inline int security_secctx_to_secid(char *secdata,
> > static inline void security_release_secctx(char *secdata, u32 seclen)
> > {
> > }
> > +
> > +static inline int security_setcontext(struct dentry *dentry, void *ctx, u32 
> > ctxlen, int flags)
> > +{
> > + return -EOPNOTSUPP;
> > +}
> > +static inline int security_getcontext(struct dentry *dentry, void **ctx, u32 
> > *ctxlen)
> > +{
> > + return -EOPNOTSUPP;
> > +}
> > #endif /* CONFIG_SECURITY */
> > 
> > #ifdef CONFIG_SECURITY_NETWORK
> > diff --git a/security/dummy.c b/security/dummy.c
> > index 649326b..576f9db 100644
> > --- a/security/dummy.c
> > +++ b/security/dummy.c
> > @@ -960,6 +960,16 @@ static void dummy_release_secctx(char *secdata, u32 seclen)
> > {
> > }
> > 
> > +static int dummy_setcontext(struct dentry *dentry, void *ctx, u32 ctxlen, int 
> > flags)
> > +{
> > + return -EOPNOTSUPP;
> > +}
> > +
> > +static int dummy_getcontext(struct dentry *dentry, void **ctx, u32 *ctxlen)
> > +{
> > + return -EOPNOTSUPP;
> > +}
> > +
> > #ifdef CONFIG_KEYS
> > static inline int dummy_key_alloc(struct key *key, struct task_struct *ctx,
> > unsigned long flags)
> > @@ -1118,6 +1128,8 @@ void security_fixup_ops (struct security_operations *ops)
> > set_to_dummy_if_null(ops, secid_to_secctx);
> > set_to_dummy_if_null(ops, secctx_to_secid);
> > set_to_dummy_if_null(ops, release_secctx);
> > + set_to_dummy_if_null(ops, setcontext);
> > + set_to_dummy_if_null(ops, getcontext);
> > #ifdef CONFIG_SECURITY_NETWORK
> > set_to_dummy_if_null(ops, unix_stream_connect);
> > set_to_dummy_if_null(ops, unix_may_send);
> > diff --git a/security/security.c b/security/security.c
> > index d15e56c..11871ae 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -845,6 +845,18 @@ void security_release_secctx(char *secdata, u32 seclen)
> > }
> > EXPORT_SYMBOL(security_release_secctx);
> > 
> > +int security_setcontext(struct dentry *dentry, void *ctx, u32 ctxlen, int 
> > flags)
> > +{
> > + return security_ops->setcontext(dentry, ctx, ctxlen, flags);
> > +}
> > +EXPORT_SYMBOL(security_setcontext);
> > +
> > +int security_getcontext(struct dentry *dentry, void **ctx, u32 *ctxlen)
> > +{
> > + return security_ops->getcontext(dentry, ctx, ctxlen);
> > +}
> > +EXPORT_SYMBOL(security_getcontext);
> > +
> > #ifdef CONFIG_SECURITY_NETWORK
> > 
> > int security_unix_stream_connect(struct socket *sock, struct socket *other,
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 75c2e99..d28c0ed 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -75,6 +75,7 @@
> > #include 
> > #include 
> > #include 
> > +#include 
> > 
> > #include "avc.h"
> > #include "objsec.h"
> > @@ -5163,6 +5164,47 @@ static void selinux_release_secctx(char *secdata, u32 
> > seclen)
> > kfree(secdata);
> > }
> > 
> > +/*
> > + * This hook requires that the inode i_mutex be locked
> > + */
> > +static int selinux_setcontext(struct dentry *dentry, void *ctx, u32 ctxlen, int 
> > flags)
> > +{
> > + struct inode *inode = dentry->d_inode;
> > + int rc = 0;
> > +
> > + if (flags & LSM_SETCORE) {
> > + rc = selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX,
> > + ctx, ctxlen, 0);
> > + if(rc)
> > + return rc;
> > + }
> > + if (flags & LSM_SETDISK) {
> > + rc = -EOPNOTSUPP;
> > + if (inode->i_op->setxattr) {
> > + rc = inode->i_op->setxattr(dentry, XATTR_NAME_SELINUX, ctx, ctxlen, 
> > 0);
> > + if (!rc) {
> > + fsnotify_xattr(dentry);
> > + security_inode_post_setxattr(dentry, XATTR_NAME_SELINUX, ctx,
> > + ctxlen, 0);
> > + }
> > + } else {
> > + rc = security_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX, ctx,
> > + ctxlen, 0);
> > + if (!rc)
> > + fsnotify_xattr(dentry);
> > + }
> > + }
> > + 
> > + return rc;
> > +}
> > +static int selinux_getcontext(struct dentry *dentry, void **ctx, u32 *ctxlen)
> > +{
> > + struct inode *inode = dentry->d_inode;
> > + 
> > + *ctxlen = selinux_inode_getsecurity(inode, XATTR_SELINUX_SUFFIX,
> > + ctx, true);
> > + return *ctxlen;
> > +}
> > #ifdef CONFIG_KEYS
> > 
> > static int selinux_key_alloc(struct key *k, struct task_struct *tsk,
> > @@ -5351,7 +5393,8 @@ static struct security_operations selinux_ops = {
> > .secid_to_secctx = selinux_secid_to_secctx,
> > .secctx_to_secid = selinux_secctx_to_secid,
> > .release_secctx = selinux_release_secctx,
> > -
> > + .setcontext = selinux_setcontext,
> > + .getcontext = selinux_getcontext,
> > .unix_stream_connect = selinux_socket_unix_stream_connect,
> > .unix_may_send = selinux_socket_unix_may_send,
> > 
> > -- 
> > 1.5.4.1
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-security-module" 
> > in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at 
> > http://vger.kernel.org/majordomo-info.html
> 
> 
>  
> Casey Schaufler
> casey@schaufler-ca.com 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
