Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAEKS9kj018659
 for <selinux@tycho.nsa.gov>; Mon, 14 Nov 2016 15:28:10 -0500
Received: by mail-vk0-f65.google.com with SMTP id p9so7293010vkd.1
 for <selinux@tycho.nsa.gov>; Mon, 14 Nov 2016 12:28:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1478812710-17190-2-git-send-email-agruenba@redhat.com>
References: <1478812710-17190-1-git-send-email-agruenba@redhat.com>
 <1478812710-17190-2-git-send-email-agruenba@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 14 Nov 2016 15:28:08 -0500
Message-ID: <CAHC9VhSnFe9At0zDh5oek+cA8duHZeNBpGQRdXaaomNM7Lz+Ng@mail.gmail.com>
Subject: Re: [PATCH 1/4] selinux: Minor cleanups
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
> Fix the comment for function __inode_security_revalidate, which returns
> an integer.
>
> Use the LABEL_* constants consistently for isec->initialized.
>
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  security/selinux/hooks.c     | 3 ++-
>  security/selinux/selinuxfs.c | 4 ++--
>  2 files changed, 4 insertions(+), 3 deletions(-)

Applied, thanks.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 09fd610..b98ab2a 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -237,6 +237,7 @@ static int inode_alloc_security(struct inode *inode)
>         isec->sid = SECINITSID_UNLABELED;
>         isec->sclass = SECCLASS_FILE;
>         isec->task_sid = sid;
> +       isec->initialized = LABEL_INVALID;
>         inode->i_security = isec;
>
>         return 0;
> @@ -247,7 +248,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>  /*
>   * Try reloading inode security labels that have been marked as invalid.  The
>   * @may_sleep parameter indicates when sleeping and thus reloading labels is
> - * allowed; when set to false, returns ERR_PTR(-ECHILD) when the label is
> + * allowed; when set to false, returns -ECHILD when the label is
>   * invalid.  The @opt_dentry parameter should be set to a dentry of the inode;
>   * when no dentry is available, set it to NULL instead.
>   */
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 72c145d..50fca20 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -1301,7 +1301,7 @@ static int sel_make_bools(void)
>                         goto out;
>
>                 isec->sid = sid;
> -               isec->initialized = 1;
> +               isec->initialized = LABEL_INITIALIZED;
>                 inode->i_fop = &sel_bool_ops;
>                 inode->i_ino = i|SEL_BOOL_INO_OFFSET;
>                 d_add(dentry, inode);
> @@ -1834,7 +1834,7 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
>         isec = (struct inode_security_struct *)inode->i_security;
>         isec->sid = SECINITSID_DEVNULL;
>         isec->sclass = SECCLASS_CHR_FILE;
> -       isec->initialized = 1;
> +       isec->initialized = LABEL_INITIALIZED;
>
>         init_special_inode(inode, S_IFCHR | S_IRUGO | S_IWUGO, MKDEV(MEM_MAJOR, 3));
>         d_add(dentry, inode);
> --
> 2.7.4
>



-- 
paul moore
www.paul-moore.com
