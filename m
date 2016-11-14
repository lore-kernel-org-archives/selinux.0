Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAEKu1Le021402
 for <selinux@tycho.nsa.gov>; Mon, 14 Nov 2016 15:56:02 -0500
Received: by mail-vk0-f66.google.com with SMTP id p9so7353930vkd.1
 for <selinux@tycho.nsa.gov>; Mon, 14 Nov 2016 12:56:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1478812710-17190-4-git-send-email-agruenba@redhat.com>
References: <1478812710-17190-1-git-send-email-agruenba@redhat.com>
 <1478812710-17190-4-git-send-email-agruenba@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 14 Nov 2016 15:56:00 -0500
Message-ID: <CAHC9VhSFvXrZCFLjDbS1zeu7L=vuXzFnzUizGYpDAfhMYFFBYQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] selinux: Clean up initialization of isec->sclass
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Nov 10, 2016 at 4:18 PM, Andreas Gruenbacher
<agruenba@redhat.com> wrote:
> Now that isec->initialized == LABEL_INITIALIZED implies that
> isec->sclass is valid, skip such inodes immediately in
> inode_doinit_with_dentry.
>
> For the remaining inodes, initialize isec->sclass at the beginning of
> inode_doinit_with_dentry to simplify the code.
>
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  security/selinux/hooks.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Merged, thanks.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index e4527d9..cf5067e 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1389,12 +1389,15 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>         int rc = 0;
>
>         if (isec->initialized == LABEL_INITIALIZED)
> -               goto out;
> +               return 0;
>
>         mutex_lock(&isec->lock);
>         if (isec->initialized == LABEL_INITIALIZED)
>                 goto out_unlock;
>
> +       if (isec->sclass == SECCLASS_FILE)
> +               isec->sclass = inode_mode_to_security_class(inode->i_mode);
> +
>         sbsec = inode->i_sb->s_security;
>         if (!(sbsec->flags & SE_SBINITIALIZED)) {
>                 /* Defer initialization until selinux_complete_init,
> @@ -1512,7 +1515,6 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>                 isec->sid = sbsec->sid;
>
>                 /* Try to obtain a transition SID. */
> -               isec->sclass = inode_mode_to_security_class(inode->i_mode);
>                 rc = security_transition_sid(isec->task_sid, sbsec->sid,
>                                              isec->sclass, NULL, &sid);
>                 if (rc)
> @@ -1548,7 +1550,6 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>                          */
>                         if (!dentry)
>                                 goto out_unlock;
> -                       isec->sclass = inode_mode_to_security_class(inode->i_mode);
>                         rc = selinux_genfs_get_sid(dentry, isec->sclass,
>                                                    sbsec->flags, &sid);
>                         dput(dentry);
> @@ -1563,9 +1564,6 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>
>  out_unlock:
>         mutex_unlock(&isec->lock);
> -out:
> -       if (isec->sclass == SECCLASS_FILE)
> -               isec->sclass = inode_mode_to_security_class(inode->i_mode);
>         return rc;
>  }
>
> --
> 2.7.4
>



-- 
paul moore
www.paul-moore.com
