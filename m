Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9TN9u4K005410
 for <selinux@tycho.nsa.gov>; Thu, 29 Oct 2015 19:09:56 -0400
Received: by lbbes7 with SMTP id es7so39256103lbb.2
 for <selinux@tycho.nsa.gov>; Thu, 29 Oct 2015 16:09:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1446079635-22462-7-git-send-email-agruenba@redhat.com>
References: <1446079635-22462-1-git-send-email-agruenba@redhat.com>
 <1446079635-22462-7-git-send-email-agruenba@redhat.com>
Date: Fri, 30 Oct 2015 00:09:53 +0100
Message-ID: <CAHc6FU4pbPHpRMcLBGEHzwysTWDxP7G7Nt+q6_ESusLsFHfYOQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] selinux: Revalidate invalid inode security labels
From: Andreas Gruenbacher <agruenba@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
 LSM <linux-security-module@vger.kernel.org>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

David,

On Thu, Oct 29, 2015 at 1:47 AM, Andreas Gruenbacher
<agruenba@redhat.com> wrote:
> When fetching an inode's security label, check if it is still valid, and
> try reloading it if it is not. Reloading will fail when we are in RCU
> context which doesn't allow sleeping, or when we can't find a dentry for
> the inode.  (Reloading happens via iop->getxattr which takes a dentry
> parameter.)  When reloading fails, continue using the old, invalid
> label.
>
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  security/selinux/hooks.c | 70 ++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 65 insertions(+), 5 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index dcac6dc..47dc704 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -241,11 +241,63 @@ static int inode_alloc_security(struct inode *inode)
>         return 0;
>  }
>
> +static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dentry);
> +
> +/*
> + * Try reloading inode security labels that have been marked as invalid.  The
> + * @may_sleep parameter indicates when sleeping and thus reloading labels is
> + * allowed; when set to false, returns ERR_PTR(-ECHILD) when the label is
> + * invalid.  The @opt_dentry parameter should be set to a dentry of the inode;
> + * when no dentry is available, set it to NULL instead.
> + */
> +static int __inode_security_revalidate(struct inode *inode,
> +                                      struct dentry *opt_dentry,
> +                                      bool may_sleep)
> +{
> +       struct inode_security_struct *isec = inode->i_security;
> +
> +       might_sleep_if(may_sleep);
> +
> +       if (isec->initialized == LABEL_INVALID) {
> +               if (!may_sleep)
> +                       return -ECHILD;
> +
> +               /*
> +                * Try reloading the inode security label.  This will fail if
> +                * @opt_dentry is NULL and no dentry for this inode can be
> +                * found; in that case, continue using the old label.
> +                */
> +               inode_doinit_with_dentry(inode, opt_dentry);
> +       }
> +       return 0;
> +}
> +
> +static void inode_security_revalidate(struct inode *inode)
> +{
> +       __inode_security_revalidate(inode, NULL, true);
> +}
> +
> +static struct inode_security_struct *inode_security_novalidate(struct inode *inode)
> +{
> +       return inode->i_security;
> +}
> +
> +static struct inode_security_struct *inode_security_rcu(struct inode *inode, bool rcu)
> +{
> +       int error;
> +
> +       error = __inode_security_revalidate(inode, NULL, !rcu);
> +       if (error)
> +               return ERR_PTR(error);
> +       return inode->i_security;
> +}
> +
>  /*
>   * Get the security label of an inode.
>   */
>  static struct inode_security_struct *inode_security(struct inode *inode)
>  {
> +       __inode_security_revalidate(inode, NULL, true);
>         return inode->i_security;
>  }
>
> @@ -256,6 +308,7 @@ static struct inode_security_struct *backing_inode_security(struct dentry *dentr
>  {
>         struct inode *inode = d_backing_inode(dentry);
>
> +       __inode_security_revalidate(inode, dentry, true);
>         return inode->i_security;
>  }

inode security labels are stored as xattrs. The xattr inode operations
take dentry instead of inode arguments for filesystems like 9p and
cifs. SELinux often only has an inode where it needs a dentry so it
tries to find a dentry with d_find_alias(). Where it does have a
dentry, it does pass that down though; see the second argument to
__inode_security_revalidate. Normal filesystems then operate on the
d_inode(dentry) of that dentry.

That should work as long as d_inode and d_backing_inode remain the
same, I assume that the plan is to change that eventually though.
Then, backing_inode_security will have to lower the dentry, right? Ho
will it have to do that?

Thanks,
Andreas
