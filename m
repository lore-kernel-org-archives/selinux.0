Subject: Re: [PATCH] Fix security check for joint context= and fscontext=
	mount options
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@parisplace.org>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <1152729678.2823.72.camel@localhost.localdomain>
References: <1152729678.2823.72.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 13 Jul 2006 08:23:46 -0400
Message-Id: <1152793426.10075.193.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-07-12 at 14:41 -0400, Eric Paris wrote:
> After some discussion on the actual meaning of the filesystem class
> security check in try context mount it was determined that the checks
> for the context= mount options were not correct if fscontext mount
> option had already been used.  When labeling the superblock we should be
> checking relabel_from and relabel_to.  But if the superblock has already
> been labeled (with fscontext) then context= is actually labeling the
> inodes, and so we should be checking relabel_from and associate.  This
> patch fixes which checks are called depending on the mount options.
> 
> This is issue is in 2.6.8-rc1-git4 and should probably be fixed before
> 2.6.18 releases.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> 
>  security/selinux/hooks.c |   14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -523,12 +523,16 @@ static int try_context_mount(struct supe
>  			goto out_free;
>  		}
>  
> -		rc = may_context_mount_sb_relabel(sid, sbsec, tsec);
> -		if (rc)
> -			goto out_free;
> -
> -		if (!fscontext)
> +		if (!fscontext) {
> +			rc = may_context_mount_sb_relabel(sid, sbsec, tsec);
> +			if (rc)
> +				goto out_free;
>  			sbsec->sid = sid;
> +		} else {
> +			rc = may_context_mount_inode_relabel(sid, sbsec, tsec);
> +			if (rc)
> +				goto out_free;
> +		}
>  		sbsec->mntpoint_sid = sid;
>  
>  		sbsec->behavior = SECURITY_FS_USE_MNTPOINT;
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
