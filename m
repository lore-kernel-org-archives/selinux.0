Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l71L1hm2029967
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2007 17:01:43 -0400
Received: from web36607.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l71L1fdm010528
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2007 21:01:42 GMT
Date: Wed, 1 Aug 2007 14:01:41 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 1/7] Security: Add inode_{get,set}secid LSM hooks and security helper functions
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        labeled-nfs@linux-nfs.org
Cc: "David P. Quigley" <dpquigl@tycho.nsa.gov>
In-Reply-To: <1185998532157-git-send-email-dpquigl@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <814557.21641.qm@web36607.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- "David P. Quigley" <dpquigl@tycho.nsa.gov> wrote:

> From: David P. Quigley <dpquigl@tycho.nsa.gov>
> 
> This patch adds a pair of new hooks to LSM. The existing method of setting
> security information through inode_getsecurity and inode_setsecurity use
> extended attributes. However, NFS prefers to manipulate inode fields directly
> and to do this we need a method to access the inode's security field in a
> module independent manner.
> 
> Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>
> ---
>  include/linux/security.h |   27 +++++++++++++++++++++++++++
>  security/dummy.c         |   10 ++++++++++
>  security/selinux/hooks.c |   15 +++++++++++++++
>  3 files changed, 52 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index c11dc8a..fbfada9 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -413,6 +413,11 @@ struct request_sock;
>   *	is specified by @buffer_size.  @buffer may be NULL to request
>   *	the size of the buffer required.
>   *	Returns number of bytes used/required on success.
> + * @inode_getsecid:
> + * 	Returns secid from @inode;
> + * @inode_setsecid:
> + * 	Set the security structure value of @inode with @sid.
> + * 	Returns 0 on success.

How about dealing with inode security blobs instead of secids?

>   *
>   * Security hooks for file operations
>   *
> @@ -1235,6 +1240,8 @@ struct security_operations {
>    	int (*inode_getsecurity)(const struct inode *inode, const char *name,
> void *buffer, size_t size, int err);
>    	int (*inode_setsecurity)(struct inode *inode, const char *name, const
> void *value, size_t size, int flags);
>    	int (*inode_listsecurity)(struct inode *inode, char *buffer, size_t
> buffer_size);
> +	void (*inode_getsecid)(struct inode *inode, u32 *secid);
> +	void (*inode_setsecid)(struct inode *inode, u32 secid);

void (*inode_getblob) (struct inode *inode, void *blob);
void (*inode_setblob) (struct inode *inode, void *blob);

Or something like that, where the number of "*"s may vary.

>  	int (*file_permission) (struct file * file, int mask);
>  	int (*file_alloc_security) (struct file * file);
> @@ -1793,6 +1800,18 @@ static inline int security_inode_listsecurity(struct
> inode *inode, char *buffer,
>  	return security_ops->inode_listsecurity(inode, buffer, buffer_size);
>  }
>  
> +static inline void security_inode_getsecid(struct inode *inode, u32 *secid)
> +{
> +	security_ops->inode_getsecid(inode, secid);
> +}
> +
> +static inline void security_inode_setsecid(struct inode *inode, u32 sid)
> +{
> +	if (unlikely (IS_PRIVATE (inode)))
> +		return;
> +	security_ops->inode_setsecid(inode, sid);
> +}
> +
>  static inline int security_file_permission (struct file *file, int mask)
>  {
>  	return security_ops->file_permission (file, mask);
> @@ -2473,6 +2492,14 @@ static inline int security_inode_listsecurity(struct
> inode *inode, char *buffer,
>  	return 0;
>  }
>  
> +static inline void security_inode_getsecid(struct inode *inode, u32 *secid)
> +{
> +}
> +
> +static inline void security_inode_setsecid(struct inode *inode, u32 secid)
> +{
> +}
> +
>  static inline int security_file_permission (struct file *file, int mask)
>  {
>  	return 0;
> diff --git a/security/dummy.c b/security/dummy.c
> index 19d813d..c0c50aa 100644
> --- a/security/dummy.c
> +++ b/security/dummy.c
> @@ -392,6 +392,14 @@ static int dummy_inode_listsecurity(struct inode *inode,
> char *buffer, size_t bu
>  	return 0;
>  }
>  
> +static void dummy_inode_getsecid(struct inode *inode, u32 *secid)
> +{
> +}
> +
> +static void dummy_inode_setsecid(struct inode *inode, u32 secid)
> +{
> +}
> +
>  static const char *dummy_inode_xattr_getsuffix(void)
>  {
>  	return NULL;
> @@ -1022,6 +1030,8 @@ void security_fixup_ops (struct security_operations
> *ops)
>  	set_to_dummy_if_null(ops, inode_getsecurity);
>  	set_to_dummy_if_null(ops, inode_setsecurity);
>  	set_to_dummy_if_null(ops, inode_listsecurity);
> +	set_to_dummy_if_null(ops, inode_getsecid);
> +	set_to_dummy_if_null(ops, inode_setsecid);
>  	set_to_dummy_if_null(ops, file_permission);
>  	set_to_dummy_if_null(ops, file_alloc_security);
>  	set_to_dummy_if_null(ops, file_free_security);
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 0fac682..56d8ecb 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2457,6 +2457,19 @@ static int selinux_inode_listsecurity(struct inode
> *inode, char *buffer, size_t
>  	return len;
>  }
>  
> +static void selinux_inode_getsecid(struct inode *inode, u32 *secid)
> +{
> +	struct inode_security_struct *isec = inode->i_security;
> +	*secid = isec->sid;
> +}
> +
> +static void selinux_inode_setsecid(struct inode *inode, u32 secid)
> +{
> +	struct inode_security_struct *isec = inode->i_security;
> +	isec->sid = secid;
> +	isec->initialized = 1;
> +}
> +
>  /* file security operations */
>  
>  static int selinux_file_permission(struct file *file, int mask)
> @@ -4773,6 +4786,8 @@ static struct security_operations selinux_ops = {
>  	.inode_getsecurity =            selinux_inode_getsecurity,
>  	.inode_setsecurity =            selinux_inode_setsecurity,
>  	.inode_listsecurity =           selinux_inode_listsecurity,
> +	.inode_getsecid = 		selinux_inode_getsecid,
> +	.inode_setsecid = 		selinux_inode_setsecid,
>  
>  	.file_permission =		selinux_file_permission,
>  	.file_alloc_security =		selinux_file_alloc_security,
> -- 
> 1.5.2.2
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 
> 
> 


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
