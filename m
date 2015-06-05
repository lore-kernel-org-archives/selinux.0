Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t55ISsRK005240
 for <selinux@tycho.nsa.gov>; Fri, 5 Jun 2015 14:28:55 -0400
Received: by qkx62 with SMTP id 62so44760824qkx.3
 for <selinux@tycho.nsa.gov>; Fri, 05 Jun 2015 11:28:53 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] selinux: fix setting of security labels on NFS
Date: Fri, 05 Jun 2015 14:28:51 -0400
Message-ID: <1445478.RRUV9J93hm@sifl>
In-Reply-To: <20150604195725.GC5209@fieldses.org>
References: <20150604195725.GC5209@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-nfs@vger.kernel.org, David Quigley <dpquigl@davequigley.com>,
 Richard Chan <rc556677@outlook.com>, selinux@tycho.nsa.gov,
 Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thursday, June 04, 2015 03:57:25 PM J. Bruce Fields wrote:
> From: "J. Bruce Fields" <bfields@redhat.com>
> 
> Before calling into the filesystem, vfs_setxattr calls
> security_inode_setxattr, which ends up calling selinux_inode_setxattr in
> our case.  That returns -EOPNOTSUPP whenever SBLABEL_MNT is not set.
> SBLABEL_MNT was supposed to be set by sb_finish_set_opts, which sets it
> only if selinux_is_sblabel_mnt returns true.
> 
> The selinux_is_sblabel_mnt logic was broken by eadcabc697e9 "SELinux: do
> all flags twiddling in one place", which didn't take into the account
> the SECURITY_FS_USE_NATIVE behavior that had been introduced for nfs
> with eb9ae686507b "SELinux: Add new labeling type native labels".
> 
> This caused setxattr's of security labels over NFSv4.2 to fail.
> 
> Cc: stable@kernel.org
> Cc: Eric Paris <eparis@redhat.com>
> Cc: David Quigley <dpquigl@davequigley.com>
> Reported-by: Richard Chan <rc556677@outlook.com>
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
>  security/selinux/hooks.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.  In the future, you don't have to worry about marking it for 
stable, I'll take care of that when I merge it into the tree.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index e8a060bd9677..171fb30e4b99 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -403,6 +403,7 @@ static int selinux_is_sblabel_mnt(struct super_block
> *sb) return sbsec->behavior == SECURITY_FS_USE_XATTR ||
>  		sbsec->behavior == SECURITY_FS_USE_TRANS ||
>  		sbsec->behavior == SECURITY_FS_USE_TASK ||
> +		sbsec->behavior == SECURITY_FS_USE_NATIVE ||
>  		/* Special handling. Genfs but also in-core setxattr handler */
>  		!strcmp(sb->s_type->name, "sysfs") ||
>  		!strcmp(sb->s_type->name, "pstore") ||

-- 
paul moore
www.paul-moore.com
