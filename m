Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3BHb4YP030077
	for <selinux@tycho.nsa.gov>; Sun, 11 Apr 2010 13:37:04 -0400
Received: from smtp102.prem.mail.sp1.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id o3BHaXaC013963
	for <selinux@tycho.nsa.gov>; Sun, 11 Apr 2010 17:36:34 GMT
Message-ID: <4BC208BD.7000706@schaufler-ca.com>
Date: Sun, 11 Apr 2010 10:37:01 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: selinux@tycho.nsa.gov, linux-fsdevel@vger.kernel.org, jmorris@namei.org,
        sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH 2/3] security: make LSMs explicitly mask off permissions
References: <20100409221614.2681.64052.stgit@paris.rdu.redhat.com> <20100409221621.2681.15115.stgit@paris.rdu.redhat.com>
In-Reply-To: <20100409221621.2681.15115.stgit@paris.rdu.redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eric Paris wrote:
> SELinux needs to pass the MAY_ACCESS flag so it can handle auditting
> correctly.  

I'm not sure that I like the direction this is heading. Excesses
of granularity don't come about from a single change like this,
but from their repeated application and tendency to inspire others
to see breaking out special cases as an easy quick fix.

> Presently the masking of MAY_* flags is done in the VFS.  In
> order to allow LSMs to decide what flags they care about and what flags
> they don't just pass them all and the each LSM mask off what they don't
> need.  This patch should contain no functional changes to either the VFS or
> any LSM.
>
> Signed-off-by: Eric Paris <eparis@redhat.com>
>   

I'm acking this not because I like the approach but because I don't
see it as causing any damage and I don't have a better solution to
the audit problem that wouldn't require a redesign of SELinux.

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>
>  fs/namei.c                 |    3 +--
>  security/selinux/hooks.c   |    2 ++
>  security/smack/smack_lsm.c |    2 ++
>  3 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index f068192..3b0f583 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -282,8 +282,7 @@ int inode_permission(struct inode *inode, int mask)
>  	if (retval)
>  		return retval;
>  
> -	return security_inode_permission(inode,
> -			mask & (MAY_READ|MAY_WRITE|MAY_EXEC|MAY_APPEND));
> +	return security_inode_permission(inode, mask);
>  }
>  
>  /**
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 740a71f..344ba62 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2700,6 +2700,8 @@ static int selinux_inode_permission(struct inode *inode, int mask)
>  {
>  	const struct cred *cred = current_cred();
>  
> +	mask &= (MAY_READ|MAY_WRITE|MAY_EXEC|MAY_APPEND);
> +
>  	if (!mask) {
>  		/* No permission to check.  Existence test. */
>  		return 0;
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index f1b6846..df467f4 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -599,6 +599,8 @@ static int smack_inode_rename(struct inode *old_inode,
>  static int smack_inode_permission(struct inode *inode, int mask)
>  {
>  	struct smk_audit_info ad;
> +
> +	mask &= (MAY_READ|MAY_WRITE|MAY_EXEC|MAY_APPEND);
>  	/*
>  	 * No permission to check. Existence test. Yup, it's there.
>  	 */
>
>
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
