Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r68Ge5gI006327
	for <selinux@tycho.nsa.gov>; Mon, 8 Jul 2013 12:40:05 -0400
Received: by mail-qe0-f41.google.com with SMTP id b4so2466516qen.28
        for <selinux@tycho.nsa.gov>; Mon, 08 Jul 2013 09:40:04 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, eparis@parisplace.org
Cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH] Enable setting security contexts on rootfs inodes.
Date: Mon, 08 Jul 2013 12:40:01 -0400
Message-ID: <3411983.m6uUyVjvLJ@sifl>
In-Reply-To: <1368195956-19672-1-git-send-email-sds@tycho.nsa.gov>
References: <1368195956-19672-1-git-send-email-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday, May 10, 2013 10:25:56 AM Stephen Smalley wrote:
> rootfs (ramfs) can support setting of security contexts
> by userspace due to the vfs fallback behavior of calling
> the security module to set the in-core inode state
> for security.* attributes when the filesystem does not
> provide an xattr handler.  No xattr handler required
> as the inodes are pinned in memory and have no backing
> store.
> 
> This is useful in allowing early userspace to label individual
> files within a rootfs while still providing a policy-defined
> default via genfs.
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/hooks.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index b28b7eb..6c13d06 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -405,6 +405,13 @@ static int sb_finish_set_opts(struct super_block *sb)
>  	if (strncmp(sb->s_type->name, "sysfs", sizeof("sysfs")) == 0)
>  		sbsec->flags |= SE_SBLABELSUPP;
> 
> +	/*
> +	 * Special handling for rootfs. Is genfs but supports
> +	 * setting SELinux context on in-core inodes.
> +	 */
> +	if (strncmp(sb->s_type->name, "rootfs", sizeof("rootfs")) == 0)
> +		sbsec->flags |= SE_SBLABELSUPP;
> +
>  	/* Initialize the root inode. */
>  	rc = inode_doinit_with_dentry(root_inode, root);

Since I pulled in the MLS performance patch into my little lblnet-next tree I 
figured I would make a sweep through my SELinux archive pull in a few other 
patches so that they both wouldn't get lost and would get some minimal 
testing/conflict-resolution in the linux-next tree.

I pulled in this patch.  Hopefully Eric can get around to merging kernel 
patches soon ...

 * git://git.infradead.org/users/pcmoore/lblnet-2.6_next
 * http://git.infradead.org/users/pcmoore/lblnet-2.6_next

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
