To: Taras Kondratiuk <takondra@cisco.com>, Paul Moore <paul@paul-moore.com>,
 Eric Paris <eparis@parisplace.org>
Cc: selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org,
 xe-linux-external@cisco.com
References: <20180919165248.53090-1-takondra@cisco.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <f283c1e7-19eb-2b99-3fef-a19e2bf99a2b@tycho.nsa.gov>
Date: Wed, 19 Sep 2018 15:00:33 -0400
MIME-Version: 1.0
In-Reply-To: <20180919165248.53090-1-takondra@cisco.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [RFC PATCH] selinux: add a fallback to defcontext for native
 labeling
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/19/2018 12:52 PM, Taras Kondratiuk wrote:
> When files on NFSv4 server are not properly labeled (label doesn't match
> a policy on a client) they will end up with unlabeled_t type which is
> too generic. We would like to be able to set a default context per
> mount. 'defcontext' mount option looks like a nice solution, but it
> doesn't seem to be fully implemented for native labeling. Default
> context is stored, but is never used.
> 
> The patch adds a fallback to a default context if a received context is
> invalid. If the inode context is already initialized, then it is left
> untouched to preserve a context set locally on a client.

Can you explain the use case further?  Why are you exporting a 
filesystem with security labeling enabled to a client that doesn't 
understand all of the labels used within it?  Why wouldn't you just 
disable NFSv4 security labeling and/or use a regular context= mount to 
assign a single context to all files in the mount?

To be clear, defcontext= doesn't work that way for local/FS_USE_XATTR 
filesystems. The context specified by it is only used for:
1) files that don't implement the xattr inode operations at all,
2) files that lack a security.selinux xattr,
3) the MLS portion of the context if it was missing (strictly as a 
legacy compatibility mechanism for RHEL4 which predated the enabling of 
the MLS field/logic).

A file with a security.selinux xattr that is invalid under policy for 
any reason other than a missing MLS field will be handled as having the 
unlabeled context.

So this would be a divergence in semantics for defcontext= between 
local/FS_USE_XATTR and NFS/FS_USE_NATIVE filesystems.

> 
> Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
> ---
>   security/selinux/hooks.c | 25 ++++++++++++++++++++++++-
>   1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index ad9a9b8e9979..f7debe798bf5 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6598,7 +6598,30 @@ static void selinux_inode_invalidate_secctx(struct inode *inode)
>    */
>   static int selinux_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
>   {
> -	return selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX, ctx, ctxlen, 0);
> +	struct superblock_security_struct *sbsec;
> +	struct inode_security_struct *isec;
> +	int rc;
> +
> +	rc = selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX, ctx, ctxlen, 0);

In this case, we likely don't gain much by reusing 
selinux_inode_setsecurity() here and could just inline the relevant 
portion of it if we were to make this change.  Logically they mean 
different things.

> +
> +	/*
> +	 * In case of Native labeling with defcontext mount option fall back
> +	 * to a default SID if received context is invalid.
> +	 */
> +	if (rc == -EINVAL) {
> +		sbsec = inode->i_sb->s_security;
> +		if (sbsec->behavior == SECURITY_FS_USE_NATIVE &&
> +		    sbsec->flags & DEFCONTEXT_MNT) {
> +			isec = inode->i_security;
> +			if (!isec->initialized) {
> +				isec->sclass = inode_mode_to_security_class(inode->i_mode);
> +				isec->sid = sbsec->def_sid;
> +				isec->initialized = 1;
> +			}
> +			rc = 0;
> +		}
> +	}
> +	return rc;
>   }
>   
>   /*
> 
