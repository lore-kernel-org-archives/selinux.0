Subject: Re: [PATCH] 1/2 decouple fscontext/context mount options
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@parisplace.org>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <1152115146.26384.152.camel@localhost.localdomain>
References: <1152115146.26384.152.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 05 Jul 2006 12:31:09 -0400
Message-Id: <1152117069.12435.20.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-07-05 at 11:59 -0400, Eric Paris wrote:
> This patch will remove the conflict between fscontext and context mount
> options.  If context= is specified without fscontext it will operate
> just as before, if both are specified we will use mount point labeling
> and all inodes will get the label specified by context=.   The
> superblock will be labeled with the label of fscontext=, thus affecting
> operations which check the superblock security context, such as
> associate permissions.
> 
> Hopefully this addresses all of the concerns.
> 
>  security/selinux/hooks.c          |   68 +++++++++++++++++++++++++++++---------
>  security/selinux/include/objsec.h |    3 +
>  2 files changed, 55 insertions(+), 16 deletions(-)
> 
> --- linux-2.6.17/security/selinux/hooks.c.orig	2006-07-05 11:39:48.000000000 -0400
> +++ linux-2.6.17/security/selinux/hooks.c	2006-07-05 11:40:03.000000000 -0400
> @@ -246,6 +246,7 @@ static int superblock_alloc_security(str
>  	sbsec->sb = sb;
>  	sbsec->sid = SECINITSID_UNLABELED;
>  	sbsec->def_sid = SECINITSID_FILE;
> +	sbsec->mntpoint_sid = SECINITSID_UNLABELED;
>  	sb->s_security = sbsec;
>  
>  	return 0;
> @@ -329,9 +330,25 @@ static match_table_t tokens = {
>  
>  #define SEL_MOUNT_FAIL_MSG "SELinux:  duplicate or incompatible mount options\n"
>  
> +static int may_context_mount_sb_relabel(u32 sid, struct superblock_security_struct *sbsec,

This line is too long.  Also, any reason for the long function name (why
not just may_context_mount)?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
