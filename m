Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A636AC433DB
	for <selinux@archiver.kernel.org>; Tue, 12 Jan 2021 16:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 645C223107
	for <selinux@archiver.kernel.org>; Tue, 12 Jan 2021 16:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbhALQkB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Jan 2021 11:40:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46073 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727203AbhALQkA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Jan 2021 11:40:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610469513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N832D6iWE9foW+dNOD3LjWuK/aVrvLdQT3orMUN/ZKQ=;
        b=ZhAdhAX2aGLUTGz1/c69ee8wV1h/Ek0xp9hQWovfKhB+pblZ9e3Bev2rkgDQVcTGwDBRgg
        7XVHO5TkUVxekMnWTMnC6gBEDSknfcyqF4zf6wXnEbKa/qNEBrPBVYfpgGmHQ7XRz8TttO
        Uvq00RNeTve6VSZQpQt+Wg+0Ds1yz/w=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-yOZTZmzMO-K0cbABaiL4WA-1; Tue, 12 Jan 2021 11:38:30 -0500
X-MC-Unique: yOZTZmzMO-K0cbABaiL4WA-1
Received: by mail-lf1-f70.google.com with SMTP id a19so1259915lfd.8
        for <selinux@vger.kernel.org>; Tue, 12 Jan 2021 08:38:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N832D6iWE9foW+dNOD3LjWuK/aVrvLdQT3orMUN/ZKQ=;
        b=Ts9BSYCFYXn8cjK617TAUDT7KFhbv23M6kJpHiIGkl2fj+FOzX0I0AIib1K1NRh6ec
         qymCiFMlpAoTswcSEc2rjsIJSWfGEdBZRBSsA5V9bIqFYUWAC2rL/Ey7neu/wf5KdKV9
         AKajGwO5ZxVN1JPpemZnz7Qw7MQn/zdlF9CueBxMGAyvaFQFrUW1HoMdNFS+txFlFk8R
         ieYCxfz8z+xa1qS1JvhNjH5cJz5E8PWe+4bgCe+EmgyUK1cVcAtSjREk1r6qCz8CMomX
         YN4MmqRJwdY8ocRenqnLh6pfIjZFQ/SZzjQCG/h4QL/iazAVIJdUzIt/BJ7iNaPM75mo
         hWdg==
X-Gm-Message-State: AOAM530HPP6zjQcHGSnBmWxvsc1fIv50LXp8BVk9TF/mZNXSmH0EGjHH
        VGyp/+DyfTwNLWRCzijlae9Jbe3Xewp0aBMGi3ubo8nxFZmLGAhKy9ygHqPLfWH9pbDHDbIIqIm
        IpMZ7HZBw7/ZBP+3dICTGiMEjxhfPLMfXzg==
X-Received: by 2002:a19:6b0e:: with SMTP id d14mr2448747lfa.210.1610469508697;
        Tue, 12 Jan 2021 08:38:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxt6Yy8POMDzBv1RKvKkUHy2qHgXjTW+UzKGWuaIsGI7g+r1hxN7vTgEObiY23P+KidVYRClLUFk5EftdcHClo=
X-Received: by 2002:a19:6b0e:: with SMTP id d14mr2448740lfa.210.1610469508418;
 Tue, 12 Jan 2021 08:38:28 -0800 (PST)
MIME-Version: 1.0
References: <20210105162830.1037459-1-omosnace@redhat.com> <CAHC9VhSAmvH8EWa4GoGP=pDUtbzrzukPNUfDRACb8dwTiX=5Qg@mail.gmail.com>
In-Reply-To: <CAHC9VhSAmvH8EWa4GoGP=pDUtbzrzukPNUfDRACb8dwTiX=5Qg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 12 Jan 2021 17:38:17 +0100
Message-ID: <CAFqZXNtsKbChkWwLCGrsz5uW+siguWwU8qFfXzPXY1zbV9eZWg@mail.gmail.com>
Subject: Re: [PATCH] selinux: fall back to SECURITY_FS_USE_GENFS if no xattr support
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 12, 2021 at 3:47 PM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Jan 5, 2021 at 11:28 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > When a superblock is assigned the SECURITY_FS_USE_XATTR behavior by the
> > policy yet it lacks xattr support, try to fall back to genfs rather than
> > rejecting the mount. If a genfscon rule is found for the filesystem,
> > then change the behavior to SECURITY_FS_USE_GENFS, otherwise reject the
> > mount as before. A similar fallback is already done in security_fs_use()
> > if no behavior specification is found for the given filesystem.
> >
> > This is needed e.g. for virtiofs, which may or may not support xattrs
> > depending on the backing host filesystem.
> >
> > Example:
> >     # seinfo --genfs | grep ' ramfs'
> >        genfscon ramfs /  system_u:object_r:ramfs_t:s0
> >     # echo '(fsuse xattr ramfs (system_u object_r fs_t ((s0) (s0))))' >ramfs_xattr.cil
> >     # semodule -i ramfs_xattr.cil
> >     # mount -t ramfs none /mnt
> >
> > Before:
> >     mount: /mnt: mount(2) system call failed: Operation not supported.
> >
> > After:
> >     (mount succeeds)
> >     # ls -Z /mnt
> >     system_u:object_r:ramfs_t:s0 /mnt
> >
> > See also:
> > https://lore.kernel.org/selinux/20210105142148.GA3200@redhat.com/T/
> > https://github.com/fedora-selinux/selinux-policy/pull/478
> >
> > Cc: Vivek Goyal <vgoyal@redhat.com>
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  security/selinux/hooks.c | 78 +++++++++++++++++++++++++++-------------
> >  1 file changed, 53 insertions(+), 25 deletions(-)
>
> This generally looks good to me, just some small suggestions below to
> cleanup the code a bit.
>
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 6b1826fc3658e..0b9b4050b9315 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -484,38 +484,67 @@ static int selinux_is_sblabel_mnt(struct super_block *sb)
> >         }
> >  }
> >
> > -static int sb_finish_set_opts(struct super_block *sb)
> > +static int sb_check_xattr_support(struct super_block *sb)
> >  {
> >         struct superblock_security_struct *sbsec = sb->s_security;
> >         struct dentry *root = sb->s_root;
> >         struct inode *root_inode = d_backing_inode(root);
> > -       int rc = 0;
> > +       u32 sid;
> > +       int rc;
> >
> > -       if (sbsec->behavior == SECURITY_FS_USE_XATTR) {
> > -               /* Make sure that the xattr handler exists and that no
> > -                  error other than -ENODATA is returned by getxattr on
> > -                  the root directory.  -ENODATA is ok, as this may be
> > -                  the first boot of the SELinux kernel before we have
> > -                  assigned xattr values to the filesystem. */
> > -               if (!(root_inode->i_opflags & IOP_XATTR)) {
> > -                       pr_warn("SELinux: (dev %s, type %s) has no "
> > -                              "xattr support\n", sb->s_id, sb->s_type->name);
> > +       /*
> > +        * Make sure that the xattr handler exists and that no
> > +        * error other than -ENODATA is returned by getxattr on
> > +        * the root directory.  -ENODATA is ok, as this may be
> > +        * the first boot of the SELinux kernel before we have
> > +        * assigned xattr values to the filesystem.
> > +        */
> > +       if (!(root_inode->i_opflags & IOP_XATTR)) {
> > +               pr_warn("SELinux: (dev %s, type %s) has no xattr support\n",
> > +                       sb->s_id, sb->s_type->name);
> > +               rc = -EOPNOTSUPP;
> > +               goto out;
> > +       }
> > +
> > +       rc = __vfs_getxattr(root, root_inode, XATTR_NAME_SELINUX, NULL, 0);
> > +       if (rc < 0 && rc != -ENODATA) {
> > +               if (rc == -EOPNOTSUPP)
> > +                       pr_warn("SELinux: (dev %s, type %s) has no security xattr handler\n",
> > +                               sb->s_id, sb->s_type->name);
> > +               else
> > +                       pr_warn("SELinux: (dev %s, type %s) getxattr errno %d\n",
> > +                               sb->s_id, sb->s_type->name, -rc);
> > +               goto out;
> > +       }
> > +       return 0;
>
> This is a borderline absurd nitpick, but a line of vertical whitespace
> before the jump label would be nice.

Fair point. After the rename to "fallback" as suggested below it
became visually ugly to me as well :)

>
> > +out:
> > +       /* No xattr support - try to fallback to genfs if possible. */
> > +       if (rc == -EOPNOTSUPP) {
>
> I'm not sure the "rc == -EOPNOTSUPP" is necessary is it?  The only way
> we get to the "out" label is if rc *is* -EOPNOTSUPP, right?

Not really, but it's true that the control flow can be simplified a bit...

> Somewhat related, since we're talking about minor things, why not
> change "out" to "fallback" or something similar, "out" isn't really
> "out" as it is used in this function.

Agreed, "fallback" sounds better here.

>
> > +               rc = security_genfs_sid(&selinux_state, sb->s_type->name, "/",
> > +                                       SECCLASS_DIR, &sid);
> > +               if (rc) {
> >                         rc = -EOPNOTSUPP;
> > -                       goto out;
>
> You might as well just "return -EOPNOSUPP" here.
>
> > +               } else {
> > +                       pr_warn("SELinux: (dev %s, type %s) falling back to genfs\n",
> > +                               sb->s_id, sb->s_type->name);
> > +                       sbsec->behavior = SECURITY_FS_USE_GENFS;
> > +                       sbsec->sid = sid;
> >                 }
>
> It also might read a bit better if you got rid of the else block, for example:
>
>   rc = security_genfs_sid(...);
>   if (rc)
>     return -EOPNOTSUPP;
>
>   pr_warn(...);
>   sbsec->blah = blahblah;
>   return 0;

Again a good point, will be like that in v2.

Thank you for the valuable suggestions!

>
> > +       }
> > +       return rc;
> > +}
> >
> > -               rc = __vfs_getxattr(root, root_inode, XATTR_NAME_SELINUX, NULL, 0);
> > -               if (rc < 0 && rc != -ENODATA) {
> > -                       if (rc == -EOPNOTSUPP)
> > -                               pr_warn("SELinux: (dev %s, type "
> > -                                      "%s) has no security xattr handler\n",
> > -                                      sb->s_id, sb->s_type->name);
> > -                       else
> > -                               pr_warn("SELinux: (dev %s, type "
> > -                                      "%s) getxattr errno %d\n", sb->s_id,
> > -                                      sb->s_type->name, -rc);
> > -                       goto out;
> > -               }
> > +static int sb_finish_set_opts(struct super_block *sb)
> > +{
> > +       struct superblock_security_struct *sbsec = sb->s_security;
> > +       struct dentry *root = sb->s_root;
> > +       struct inode *root_inode = d_backing_inode(root);
> > +       int rc = 0;
> > +
> > +       if (sbsec->behavior == SECURITY_FS_USE_XATTR) {
> > +               rc = sb_check_xattr_support(sb);
> > +               if (rc)
> > +                       return rc;
> >         }
> >
> >         sbsec->flags |= SE_SBINITIALIZED;
> > @@ -554,7 +583,6 @@ static int sb_finish_set_opts(struct super_block *sb)
> >                 spin_lock(&sbsec->isec_lock);
> >         }
> >         spin_unlock(&sbsec->isec_lock);
> > -out:
> >         return rc;
> >  }
> >
> > --
> > 2.29.2
> >
>
> --
> paul moore
> www.paul-moore.com
>

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

