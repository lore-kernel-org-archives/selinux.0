From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [patch] selinux:  restore optimization to selinux_file_permission
Date: Mon, 22 Jun 2009 15:34:19 -0400
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        selinux@tycho.nsa.gov
References: <1245696893.12493.22.camel@localhost.localdomain>
In-Reply-To: <1245696893.12493.22.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <200906221534.21030.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 22 June 2009 02:54:53 pm Stephen Smalley wrote:
> Restore the optimization to skip revalidation in selinux_file_permission
> if nothing has changed since the dentry_open checks, accidentally removed
> by 389fb800.  Also remove redundant test from
> selinux_revalidate_file_permission.
>
> Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

Sorry, my mistake - thanks for fixing this.

Reviewed-by: Paul Moore <paul.moore@hp.com>

> ---
>
>  security/selinux/hooks.c |   15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 15c2a08..d6f6478 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2938,11 +2938,6 @@ static int selinux_revalidate_file_permission(struct
> file *file, int mask) const struct cred *cred = current_cred();
>  	struct inode *inode = file->f_path.dentry->d_inode;
>
> -	if (!mask) {
> -		/* No permission to check.  Existence test. */
> -		return 0;
> -	}
> -
>  	/* file_mask_to_av won't add FILE__WRITE if MAY_APPEND is set */
>  	if ((file->f_flags & O_APPEND) && (mask & MAY_WRITE))
>  		mask |= MAY_APPEND;
> @@ -2953,10 +2948,20 @@ static int
> selinux_revalidate_file_permission(struct file *file, int mask)
>
>  static int selinux_file_permission(struct file *file, int mask)
>  {
> +	struct inode *inode = file->f_path.dentry->d_inode;
> +	struct file_security_struct *fsec = file->f_security;
> +	struct inode_security_struct *isec = inode->i_security;
> +	u32 sid = current_sid();
> +
>  	if (!mask)
>  		/* No permission to check.  Existence test. */
>  		return 0;
>
> +	if (sid == fsec->sid && fsec->isid == isec->sid &&
> +	    fsec->pseqno == avc_policy_seqno())
> +		/* No change since dentry_open check. */
> +		return 0;
> +
>  	return selinux_revalidate_file_permission(file, mask);
>  }

-- 
paul moore
linux @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
