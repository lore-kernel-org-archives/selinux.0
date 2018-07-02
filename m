Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w62Kpflg027793
 for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2018 16:51:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC04.oob.disa.mil (Postfix) with SMTP id 41KKDW2gQrz62qR
 for <selinux@tycho.nsa.gov>; Mon,  2 Jul 2018 20:51:39 +0000 (UTC)
Received: from UPDC3CPA03.eemsg.mil (unknown [192.168.18.10])
 by UPDCF3IC04.oob.disa.mil (Postfix) with ESMTP id 41KKDV2X6dz62qL
 for <selinux@tycho.nsa.gov>; Mon,  2 Jul 2018 20:51:38 +0000 (UTC)
Received: by mail-lj1-f193.google.com with SMTP id t22-v6so13519789ljc.11
 for <selinux@tycho.nsa.gov>; Mon, 02 Jul 2018 13:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <3880c8030c55a97ee38335fc0dbf5dfd4f296c59.1529476660.git.joe@perches.com>
In-Reply-To: <3880c8030c55a97ee38335fc0dbf5dfd4f296c59.1529476660.git.joe@perches.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 2 Jul 2018 16:51:25 -0400
Message-ID: <CAHC9VhS_UmWfv0aFGLfaqw-fLSmoGiDEcXGFZ3bvwNgp2PF=zg@mail.gmail.com>
To: joe@perches.com
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 peter.enderborg@sony.com, selinux@tycho.nsa.gov,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] selinux: Use pr_fmt to prefix "SELinux: "
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Jun 20, 2018 at 2:39 AM Joe Perches <joe@perches.com> wrote:
> pr_fmt can be used with the pr_<level> macros to prefix
> arbitrary content to logging messages.
>
> So add '#define pr_fmt(fmt) "SELinux: " fmt' to selinux files
> that use pr_<level> and remove embedded "SELinux: " prefixes
> from the format strings.
>
> Miscellanea:
>
> o Coalesce formats and realign arguments
> o Add missing space to a coalesced format
> o Remove "SELinux: " from SEL_MOUNT_FAIL_MSG as that is directly
>   used only in pr_warn
> o Add missing terminating \n to some formats
> o Consistently use single space after logging prefixes
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  security/selinux/avc.c            |   7 ++-
>  security/selinux/hooks.c          | 124 +++++++++++++++++---------------------
>  security/selinux/netif.c          |   7 ++-
>  security/selinux/netlink.c        |   7 ++-
>  security/selinux/netnode.c        |   4 +-
>  security/selinux/netport.c        |   4 +-
>  security/selinux/selinuxfs.c      |  33 +++++-----
>  security/selinux/ss/avtab.c       |  61 +++++++++----------
>  security/selinux/ss/conditional.c |  18 +++---
>  security/selinux/ss/ebitmap.c     |  20 +++---
>  security/selinux/ss/policydb.c    | 123 +++++++++++++++++--------------------
>  security/selinux/ss/services.c    | 110 +++++++++++++--------------------
>  security/selinux/ss/sidtab.c      |  12 ++--
>  13 files changed, 247 insertions(+), 283 deletions(-)

...

> @@ -1644,13 +1640,12 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>
>                                 if (rc == -EINVAL) {
>                                         if (printk_ratelimit())
> -                                               pr_notice("SELinux: inode=%lu on dev=%s was found to have an invalid "
> -                                                       "context=%s.  This indicates you may need to relabel the inode or the "
> -                                                       "filesystem in question.\n", ino, dev, context);
> +                                               pr_notice("inode=%lu on dev=%s was found to have an invalid context=%s.  This indicates you may need to relabel the inode or the filesystem in question.\n",
> +                                                         ino, dev, context);

Please split up lines like this.  I realize that there isn't much room
left, but this message wraps a silly amount in my 80-char terminal; if
you need to wrap, please limit it to a word or two.

To stop the argument before it starts, I don't care what checkpatch.pl
says about splitting printk format strings like this.  Split the line
please.

> @@ -3124,9 +3117,9 @@ static int selinux_validate_for_sb_reconfigure(struct fs_context *fc)
>                 rc = security_context_str_to_sid(&selinux_state, mount_options[i],
>                                                  &sid, GFP_KERNEL);
>                 if (rc) {
> -                       pr_warn("SELinux: security_context_str_to_sid"
> -                               "(%s) failed for (dev %s, type %s) errno=%d\n",
> -                               mount_options[i], sb->s_id, sb->s_type->name, rc);
> +                       pr_warn("security_context_str_to_sid(%s) failed for (dev %s, type %s) errno=%d\n",
> +                               mount_options[i],
> +                               sb->s_id, sb->s_type->name, rc);
>                         goto inval;
>                 }

What tree did you base your patch on?  Please base SELinux patches
either on the SELinux tree or Linus' tree.  The SELinux tree can be
found at the links below:

* git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
* https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git

--
paul moore
www.paul-moore.com
