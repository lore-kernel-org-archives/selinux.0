Message-ID: <1482158586.28570.17.camel@tycho.nsa.gov>
Subject: Re: [PATCH 1/2] selinux: log errors when loading new policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Gary Tierney <gary.tierney@gmx.com>, selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, linux-audit@redhat.com, Steve Grubb
 <sgrubb@redhat.com>
Date: Mon, 19 Dec 2016 09:43:06 -0500
In-Reply-To: <1482007719-14313-2-git-send-email-gary.tierney@gmx.com>
References: <1482007719-14313-1-git-send-email-gary.tierney@gmx.com>
 <1482007719-14313-2-git-send-email-gary.tierney@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, 2016-12-17 at 20:48 +0000, Gary Tierney wrote:
> Adds error and warning messages to the codepaths which can fail when
> loading a new policy.  If a policy fails to load, an error message
> will
> be printed to dmesg with a description of what failed.  Previously if
> there was an error during policy loading there would be no indication
> that it failed.
> 
> Signed-off-by: Gary Tierney <gary.tierney@gmx.com>
> ---
>  security/selinux/selinuxfs.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/security/selinux/selinuxfs.c
> b/security/selinux/selinuxfs.c
> index 0aac402..2139cc7 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -522,20 +522,32 @@ static ssize_t sel_write_load(struct file
> *file, const char __user *buf,
>  		goto out;
>  
>  	length = security_load_policy(data, count);
> -	if (length)
> +	if (length) {
> +		pr_err("SELinux: %s: failed to load policy\n",
> +		      __func__);

Not sure about your usage of pr_err() vs pr_warn();
security_load_policy() may simply fail due to invalid policy from
userspace, not a kernel-internal error per se.

I would tend to omit the function name; I don't think it is especially
helpful.

There was an earlier discussion about augmenting the audit logging from
this function, so this might overlap with that.  I don't know where
that stands.

>  		goto out;
> +	}
>  
>  	length = sel_make_bools();
> -	if (length)
> +	if (length) {
> +		pr_warn("SELinux: %s: failed to load policy
> booleans\n",
> +		       __func__);
>  		goto out1;
> +	}
>  
>  	length = sel_make_classes();
> -	if (length)
> +	if (length) {
> +		pr_warn("SELinux: %s: failed to load policy
> classes\n",
> +		       __func__);
>  		goto out1;
> +	}
>  
>  	length = sel_make_policycap();
> -	if (length)
> +	if (length) {
> +		pr_warn("SELinux: %s: failed to load policy
> capabilities\n",
> +		       __func__);
>  		goto out1;
> +	}
>  
>  	length = count;
>  
> @@ -1299,9 +1311,13 @@ static int sel_make_bools(void)
>  
>  		isec = (struct inode_security_struct *)inode-
> >i_security;
>  		ret = security_genfs_sid("selinuxfs", page,
> SECCLASS_FILE, &sid);
> -		if (ret)
> +		if (ret) {
> +			pr_warn_ratelimited("SELinux: %s: failed to
> lookup sid for %s\n",
> +					   __func__, page);
>  			goto out;
>  
> +		}
> +
>  		isec->sid = sid;
>  		isec->initialized = LABEL_INITIALIZED;
>  		inode->i_fop = &sel_bool_ops;
