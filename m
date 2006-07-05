Subject: Re: [PATCH] 2/2 rootcontext= option to label root inode when
	mounting
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@parisplace.org>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <1152115148.26384.153.camel@localhost.localdomain>
References: <1152115148.26384.153.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 05 Jul 2006 12:37:52 -0400
Message-Id: <1152117472.12435.25.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-07-05 at 11:59 -0400, Eric Paris wrote:
> The second patch will introduce a new rootcontext= option to FS
> mounting. This option will allow you to explicitly label the root inode
> of a FS being mounted before that FS or inode because visable to
> userspace.  This was found to be useful for things like stateless linux,
> see https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=190001
> 
> This should address all of the concerns with the original patch.
> 
>  security/selinux/hooks.c |   67 ++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 58 insertions(+), 9 deletions(-)
> 
> --- linux-2.6.17/security/selinux/hooks.c.withdecouple	2006-07-05 11:40:03.000000000 -0400
> +++ linux-2.6.17/security/selinux/hooks.c	2006-07-05 11:41:09.000000000 -0400
> @@ -320,12 +320,14 @@ enum {
>  	Opt_context = 1,
>  	Opt_fscontext = 2,
>  	Opt_defcontext = 4,
> +	Opt_rootcontext = 8,
>  };
>  
>  static match_table_t tokens = {
>  	{Opt_context, "context=%s"},
>  	{Opt_fscontext, "fscontext=%s"},
>  	{Opt_defcontext, "defcontext=%s"},
> +	{Opt_rootcontext, "rootcontext=%s"},
>  };
>  
>  #define SEL_MOUNT_FAIL_MSG "SELinux:  duplicate or incompatible mount options\n"
> @@ -345,10 +347,24 @@ static int may_context_mount_sb_relabel(
>  	return rc;
>  }
>  
> +static int may_context_mount_inode_relabel(u32 sid, struct superblock_security_struct *sbsec,
> +			struct task_security_struct *tsec)
> +{
> +	int rc;
> +	rc = avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
> +			  FILESYSTEM__RELABELFROM, NULL);
> +	if (rc)
> +		return rc;
> +
> +	rc = avc_has_perm(sid, sbsec->sid, SECCLASS_FILESYSTEM,
> +			  FILESYSTEM__ASSOCIATE, NULL);
> +	return rc;
> +}

Ok, now I see why you have the suffix on the other function name.  Line
is still too long though.

> +		down(&isec->sem);
> +		isec->sid = sid;
> +		isec->initialized = 1;
> +		up(&isec->sem);

I don't think that taking the isec sem serves any purpose here (nor does
it in inode_security_set_sid, but that can be removed by separate patch
later).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
