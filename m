Date: Thu, 10 Jun 2010 17:35:07 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
Cc: hch@infradead.org, viro@zeniv.linux.org.uk, casey@schaufler-ca.com,
        sds@tycho.nsa.gov, matthew.dodd@sparta.com, trond.myklebust@fys.uio.no,
        bfields@fieldses.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov, labeled-nfs@linux-nfs.org
Subject: Re: [PATCH 01/10] Security: Add hook to calculate context based on
 a negative dentry.
Message-ID: <20100610223507.GA26994@hallyn.com>
References: <1276014176-20315-1-git-send-email-dpquigl@tycho.nsa.gov>
 <1276014176-20315-2-git-send-email-dpquigl@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1276014176-20315-2-git-send-email-dpquigl@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting David P. Quigley (dpquigl@tycho.nsa.gov):
> There is a time where we need to calculate a context without the
> inode having been created yet. To do this we take the negative dentry and
> calculate a context based on the process and the parent directory contexts.
> 
> Signed-off-by: Matthew N. Dodd <Matthew.Dodd@sparta.com>
> Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>
> ---
>  include/linux/security.h |   22 ++++++++++++++++++++++
>  security/capability.c    |    6 ++++++
>  security/security.c      |    7 +++++++
>  security/selinux/hooks.c |   32 ++++++++++++++++++++++++++++++++
>  4 files changed, 67 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 3158dd9..4d01784 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -322,6 +322,14 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
>   *	Parse a string of security data filling in the opts structure
>   *	@options string containing all mount options known by the LSM
>   *	@opts binary data structure usable by the LSM
> + * @dentry_init_security:
> + *	Compute a context for a dentry as the inode is not yet available
> + * 	since NFSv4 has no label backed by an EA anyway.
> + * 	@dentry dentry to use in calculating the context.
> + * 	@mode mode used to determine resource type.
> + * 	@ctx pointer to place the pointer to the resulting context in.
> + * 	@ctxlen point to place the length of the resulting context.
> + *
>   *
>   * Security hooks for inode operations.
>   *
> @@ -1501,6 +1509,9 @@ struct security_operations {
>  	void (*sb_clone_mnt_opts) (const struct super_block *oldsb,
>  				   struct super_block *newsb);
>  	int (*sb_parse_opts_str) (char *options, struct security_mnt_opts *opts);
> +	int (*dentry_init_security) (struct dentry *dentry, int mode,
> +				     void **ctx, u32 *ctxlen);
> +
>  
>  #ifdef CONFIG_SECURITY_PATH
>  	int (*path_unlink) (struct path *dir, struct dentry *dentry);
> @@ -1795,6 +1806,8 @@ int security_sb_set_mnt_opts(struct super_block *sb, struct security_mnt_opts *o
>  void security_sb_clone_mnt_opts(const struct super_block *oldsb,
>  				struct super_block *newsb);
>  int security_sb_parse_opts_str(char *options, struct security_mnt_opts *opts);
> +int security_dentry_init_security (struct dentry *dentry, int mode,
> +				   void **ctx, u32 *ctxlen);
>  
>  int security_inode_alloc(struct inode *inode);
>  void security_inode_free(struct inode *inode);
> @@ -2157,6 +2170,15 @@ static inline int security_inode_alloc(struct inode *inode)
>  static inline void security_inode_free(struct inode *inode)
>  { }
>  
> +static inline int security_dentry_init_security (struct dentry *dentry,
> +						 int mode,
> +						 void **ctx,
> +						 u32 *ctxlen)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +
>  static inline int security_inode_init_security(struct inode *inode,
>  						struct inode *dir,
>  						char **name,
> diff --git a/security/capability.c b/security/capability.c
> index 4875142..9ce1c2f 100644
> --- a/security/capability.c
> +++ b/security/capability.c
> @@ -134,6 +134,11 @@ static int cap_sb_parse_opts_str(char *options, struct security_mnt_opts *opts)
>  	return 0;
>  }
>  
> +static int cap_dentry_init_security(struct dentry *dentry, int mode, void **ctx, u32 *ctxlen)
> +{
> +	return 0;
> +}
> +

Hi,

sorry if I'm being dense, but why do you want to return 0 here, but -EOPNOTSUPP
for the !SECURITY case above?  Since capability doesn't actually fill out a label,
should it not also return -EOPNOTSUPP?  Any LSM which does fill out the label
should then just make sure not to call the capability hook, but if
cap_dentry_init_security() is being called, we can assume noone filled in the
label, right?

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
