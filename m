Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCDBC433DB
	for <selinux@archiver.kernel.org>; Tue, 12 Jan 2021 14:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6154923131
	for <selinux@archiver.kernel.org>; Tue, 12 Jan 2021 14:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbhALOsX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Jan 2021 09:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbhALOsW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Jan 2021 09:48:22 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65834C061575
        for <selinux@vger.kernel.org>; Tue, 12 Jan 2021 06:47:42 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id n26so3878373eju.6
        for <selinux@vger.kernel.org>; Tue, 12 Jan 2021 06:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yHy7hDdkpnOkby+jfuu3pGLFwBr7sqU07x7Msjg1o+c=;
        b=xCVeRvqblhvSgYpG0b4oNqrF3haYVDs1bxz0IHDQ7tGpETGZDva13XiIXdvTBnMKbs
         lgmfhc2s9tT4+Qa/5RvtY8Bxfpj2Fq13bdrJvoLRbM3kYevqCHNn/EDClKb4J9xRsenU
         N4ni3s9/6B3N5YsnHTByPM03BrqUnP/G5L3gi0bTDjNGiECCqWF0WXm+oZS3LsKBp1e4
         njkcPI4cIB3x6htSJ38NOEO2CjSLPyeNmP3wL2csMHXxySRHMWpukXjT9uFgExMjb8ZS
         8TQc/kA39vJ9Y0pVImUTevd045ruq7OdaklOeARUhoBE3/gUg062EyUEAQI+L2IpMyXc
         vC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yHy7hDdkpnOkby+jfuu3pGLFwBr7sqU07x7Msjg1o+c=;
        b=g660mzvr2Tz0nISsPGpaONMjLp2eH+p7g9awZMq5K5g8axStm9uV95LU7bOjDwKFJ3
         f3C5jlskeqdpEud+RiH85CPzwVT86tmCdzQEMC/8WyyRIp22tHew6XISSmXzbDUbAU3g
         3YyBqQSzdlYZPf20Y8yU+9NM1gktAZ/54ZuLu5GHFlfLi50U8nDwFe5AkN3EI9Bdg1a5
         ubHuGU9sBeF3oe4dKYbevmi2xFv4dVVjl9xmdp7I70wYSsuZys1x1uUXmRdgT6MyZV4/
         /SHcmLEvE5/pkhRSEDms2VG6WEmWNxYUAvYIUWtk8lrd/aI21ExTDx4TROLUOiphaJbz
         ZGdw==
X-Gm-Message-State: AOAM530n/NtFJlwonSKhA9x+XxlVJBEvxyxySUUNrQHYge6GofXe9Mwj
        vH9mALLKhg1fvKHR72jDS++gPe0fHrqhmVcId5s4zDDmmQ==
X-Google-Smtp-Source: ABdhPJzh2vk6SgVB/PX50Ta0L3uHFxxHium2QlGsnzgcu97t+iApRf479ycLpli2csSzQLwcaEdhVV5tpuPcKzEMbQI=
X-Received: by 2002:a17:907:4126:: with SMTP id mx6mr3436115ejb.91.1610462860881;
 Tue, 12 Jan 2021 06:47:40 -0800 (PST)
MIME-Version: 1.0
References: <20210105162830.1037459-1-omosnace@redhat.com>
In-Reply-To: <20210105162830.1037459-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 12 Jan 2021 09:47:29 -0500
Message-ID: <CAHC9VhSAmvH8EWa4GoGP=pDUtbzrzukPNUfDRACb8dwTiX=5Qg@mail.gmail.com>
Subject: Re: [PATCH] selinux: fall back to SECURITY_FS_USE_GENFS if no xattr support
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 5, 2021 at 11:28 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> When a superblock is assigned the SECURITY_FS_USE_XATTR behavior by the
> policy yet it lacks xattr support, try to fall back to genfs rather than
> rejecting the mount. If a genfscon rule is found for the filesystem,
> then change the behavior to SECURITY_FS_USE_GENFS, otherwise reject the
> mount as before. A similar fallback is already done in security_fs_use()
> if no behavior specification is found for the given filesystem.
>
> This is needed e.g. for virtiofs, which may or may not support xattrs
> depending on the backing host filesystem.
>
> Example:
>     # seinfo --genfs | grep ' ramfs'
>        genfscon ramfs /  system_u:object_r:ramfs_t:s0
>     # echo '(fsuse xattr ramfs (system_u object_r fs_t ((s0) (s0))))' >ramfs_xattr.cil
>     # semodule -i ramfs_xattr.cil
>     # mount -t ramfs none /mnt
>
> Before:
>     mount: /mnt: mount(2) system call failed: Operation not supported.
>
> After:
>     (mount succeeds)
>     # ls -Z /mnt
>     system_u:object_r:ramfs_t:s0 /mnt
>
> See also:
> https://lore.kernel.org/selinux/20210105142148.GA3200@redhat.com/T/
> https://github.com/fedora-selinux/selinux-policy/pull/478
>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/hooks.c | 78 +++++++++++++++++++++++++++-------------
>  1 file changed, 53 insertions(+), 25 deletions(-)

This generally looks good to me, just some small suggestions below to
cleanup the code a bit.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 6b1826fc3658e..0b9b4050b9315 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -484,38 +484,67 @@ static int selinux_is_sblabel_mnt(struct super_block *sb)
>         }
>  }
>
> -static int sb_finish_set_opts(struct super_block *sb)
> +static int sb_check_xattr_support(struct super_block *sb)
>  {
>         struct superblock_security_struct *sbsec = sb->s_security;
>         struct dentry *root = sb->s_root;
>         struct inode *root_inode = d_backing_inode(root);
> -       int rc = 0;
> +       u32 sid;
> +       int rc;
>
> -       if (sbsec->behavior == SECURITY_FS_USE_XATTR) {
> -               /* Make sure that the xattr handler exists and that no
> -                  error other than -ENODATA is returned by getxattr on
> -                  the root directory.  -ENODATA is ok, as this may be
> -                  the first boot of the SELinux kernel before we have
> -                  assigned xattr values to the filesystem. */
> -               if (!(root_inode->i_opflags & IOP_XATTR)) {
> -                       pr_warn("SELinux: (dev %s, type %s) has no "
> -                              "xattr support\n", sb->s_id, sb->s_type->name);
> +       /*
> +        * Make sure that the xattr handler exists and that no
> +        * error other than -ENODATA is returned by getxattr on
> +        * the root directory.  -ENODATA is ok, as this may be
> +        * the first boot of the SELinux kernel before we have
> +        * assigned xattr values to the filesystem.
> +        */
> +       if (!(root_inode->i_opflags & IOP_XATTR)) {
> +               pr_warn("SELinux: (dev %s, type %s) has no xattr support\n",
> +                       sb->s_id, sb->s_type->name);
> +               rc = -EOPNOTSUPP;
> +               goto out;
> +       }
> +
> +       rc = __vfs_getxattr(root, root_inode, XATTR_NAME_SELINUX, NULL, 0);
> +       if (rc < 0 && rc != -ENODATA) {
> +               if (rc == -EOPNOTSUPP)
> +                       pr_warn("SELinux: (dev %s, type %s) has no security xattr handler\n",
> +                               sb->s_id, sb->s_type->name);
> +               else
> +                       pr_warn("SELinux: (dev %s, type %s) getxattr errno %d\n",
> +                               sb->s_id, sb->s_type->name, -rc);
> +               goto out;
> +       }
> +       return 0;

This is a borderline absurd nitpick, but a line of vertical whitespace
before the jump label would be nice.

> +out:
> +       /* No xattr support - try to fallback to genfs if possible. */
> +       if (rc == -EOPNOTSUPP) {

I'm not sure the "rc == -EOPNOTSUPP" is necessary is it?  The only way
we get to the "out" label is if rc *is* -EOPNOTSUPP, right?

Somewhat related, since we're talking about minor things, why not
change "out" to "fallback" or something similar, "out" isn't really
"out" as it is used in this function.

> +               rc = security_genfs_sid(&selinux_state, sb->s_type->name, "/",
> +                                       SECCLASS_DIR, &sid);
> +               if (rc) {
>                         rc = -EOPNOTSUPP;
> -                       goto out;

You might as well just "return -EOPNOSUPP" here.

> +               } else {
> +                       pr_warn("SELinux: (dev %s, type %s) falling back to genfs\n",
> +                               sb->s_id, sb->s_type->name);
> +                       sbsec->behavior = SECURITY_FS_USE_GENFS;
> +                       sbsec->sid = sid;
>                 }

It also might read a bit better if you got rid of the else block, for example:

  rc = security_genfs_sid(...);
  if (rc)
    return -EOPNOTSUPP;

  pr_warn(...);
  sbsec->blah = blahblah;
  return 0;

> +       }
> +       return rc;
> +}
>
> -               rc = __vfs_getxattr(root, root_inode, XATTR_NAME_SELINUX, NULL, 0);
> -               if (rc < 0 && rc != -ENODATA) {
> -                       if (rc == -EOPNOTSUPP)
> -                               pr_warn("SELinux: (dev %s, type "
> -                                      "%s) has no security xattr handler\n",
> -                                      sb->s_id, sb->s_type->name);
> -                       else
> -                               pr_warn("SELinux: (dev %s, type "
> -                                      "%s) getxattr errno %d\n", sb->s_id,
> -                                      sb->s_type->name, -rc);
> -                       goto out;
> -               }
> +static int sb_finish_set_opts(struct super_block *sb)
> +{
> +       struct superblock_security_struct *sbsec = sb->s_security;
> +       struct dentry *root = sb->s_root;
> +       struct inode *root_inode = d_backing_inode(root);
> +       int rc = 0;
> +
> +       if (sbsec->behavior == SECURITY_FS_USE_XATTR) {
> +               rc = sb_check_xattr_support(sb);
> +               if (rc)
> +                       return rc;
>         }
>
>         sbsec->flags |= SE_SBINITIALIZED;
> @@ -554,7 +583,6 @@ static int sb_finish_set_opts(struct super_block *sb)
>                 spin_lock(&sbsec->isec_lock);
>         }
>         spin_unlock(&sbsec->isec_lock);
> -out:
>         return rc;
>  }
>
> --
> 2.29.2
>

--
paul moore
www.paul-moore.com
