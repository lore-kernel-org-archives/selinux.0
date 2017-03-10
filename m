Date: Fri, 10 Mar 2017 15:47:56 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: viro@zeniv.linux.org.uk, james.l.morris@oracle.com, serge@hallyn.com,
 paul@paul-moore.com, john.johansen@canonical.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [PATCH] fs: switch order of CAP_DAC_OVERRIDE and
 CAP_DAC_READ_SEARCH checks
Message-ID: <20170310214756.GA17896@mail.hallyn.com>
References: <1489166058-11789-1-git-send-email-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1489166058-11789-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Quoting Stephen Smalley (sds@tycho.nsa.gov):
> generic_permission() presently checks CAP_DAC_OVERRIDE prior to
> CAP_DAC_READ_SEARCH.  This can cause misleading audit messages when
> using a LSM such as SELinux or AppArmor, since CAP_DAC_OVERRIDE
> may not be required for the operation.  Flip the order of the
> tests so that CAP_DAC_OVERRIDE is only checked when required for
> the operation.
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

Lol, not sure if that patch has arranged itself to be as confusing
as possible (for a simple end result) or if it's in my head :), but
I had to read it like 3 times, despite it appearing trivial in the
end.

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> ---
>  fs/namei.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index d41fab7..482414a 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -340,22 +340,14 @@ int generic_permission(struct inode *inode, int mask)
>  
>  	if (S_ISDIR(inode->i_mode)) {
>  		/* DACs are overridable for directories */
> -		if (capable_wrt_inode_uidgid(inode, CAP_DAC_OVERRIDE))
> -			return 0;
>  		if (!(mask & MAY_WRITE))
>  			if (capable_wrt_inode_uidgid(inode,
>  						     CAP_DAC_READ_SEARCH))
>  				return 0;
> -		return -EACCES;
> -	}
> -	/*
> -	 * Read/write DACs are always overridable.
> -	 * Executable DACs are overridable when there is
> -	 * at least one exec bit set.
> -	 */
> -	if (!(mask & MAY_EXEC) || (inode->i_mode & S_IXUGO))
>  		if (capable_wrt_inode_uidgid(inode, CAP_DAC_OVERRIDE))
>  			return 0;
> +		return -EACCES;
> +	}
>  
>  	/*
>  	 * Searching includes executable on directories, else just read.
> @@ -364,6 +356,14 @@ int generic_permission(struct inode *inode, int mask)
>  	if (mask == MAY_READ)
>  		if (capable_wrt_inode_uidgid(inode, CAP_DAC_READ_SEARCH))
>  			return 0;
> +	/*
> +	 * Read/write DACs are always overridable.
> +	 * Executable DACs are overridable when there is
> +	 * at least one exec bit set.
> +	 */
> +	if (!(mask & MAY_EXEC) || (inode->i_mode & S_IXUGO))
> +		if (capable_wrt_inode_uidgid(inode, CAP_DAC_OVERRIDE))
> +			return 0;
>  
>  	return -EACCES;
>  }
> -- 
> 2.7.4
