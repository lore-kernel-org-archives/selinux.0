Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65938C4361B
	for <selinux@archiver.kernel.org>; Wed, 16 Dec 2020 18:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35D5025886
	for <selinux@archiver.kernel.org>; Wed, 16 Dec 2020 18:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbgLPSGK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 16 Dec 2020 13:06:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25558 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727466AbgLPSGK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 16 Dec 2020 13:06:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608141883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d4nZwJVVmcdTFOMzXn7+kjqd6SJSi7e36b7xnKg185k=;
        b=NuObePC5Rw2g1OxbGdUJJUzZEu3wsYxu1Y2k4LnLVyvjq1fnSnHARHk00HsuTv17NDm5sJ
        ew4KMQFRHBaKUcE89CQm6rxNE9OSfQmgfplpMWQyW+4Rpit4f5TjemEcN2cw01Dr0ArQ6O
        PQJrIXJcEejJCocUu2DE7BW0WtQGdiM=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-Wl9FTzcPNv2eU_0QIxP1Bg-1; Wed, 16 Dec 2020 13:04:41 -0500
X-MC-Unique: Wl9FTzcPNv2eU_0QIxP1Bg-1
Received: by mail-lf1-f69.google.com with SMTP id a10so13911264lfg.13
        for <selinux@vger.kernel.org>; Wed, 16 Dec 2020 10:04:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=d4nZwJVVmcdTFOMzXn7+kjqd6SJSi7e36b7xnKg185k=;
        b=rzN3DhR6kfqjLojAnI0Ec1IrlRk6ZSZQ1d5z8fYPZ4uOh80ey9kf3VtM8o5/g30oF3
         uhpON8qCb7KbMFrH1e4vPgczGJGJu4Y2eOxPw8cf8chgEYti8j4fIHV7qQn4xPtrHEvz
         SiLmrri6Uu5aSnv/QthrnWOWqvET4LIkgzkODmie/mGAT70VMXWxfBCGnq7xn0uWMKc8
         VDBcUMapRIsTWkgNXS6ZTQunwxKUCfpu4Fvr63Qlqa8F4EKxIcJYou9P1UZHwmgJ85+C
         PQYevjAasRyKlQ7kDqkNp6rI57T9lunrb5JUKeyGM5p5WvZ1W9q510FqerBKijqgfrXI
         FV4Q==
X-Gm-Message-State: AOAM532IAxpA18WgQqKmuIdGJ/nYqhmJUe1xL2Cn/zBdgLuPfawHN9/L
        OKpVSgxrSn2kiTG5W7Fefu3zLp30/0AZnbSCF9bK4+XRkI6g6aewMHLfebXvkM3LCx+EAn2ReVs
        BuCd3aHPooUkYxbhS/f9WwOPFBmxo00hK7g==
X-Received: by 2002:a19:301:: with SMTP id 1mr9565337lfd.67.1608141879587;
        Wed, 16 Dec 2020 10:04:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyMs0MWj8/FQzYB1jp+XRT6m/bARZuL2N/Ak9a5yDsW/fnPmyQk8QDHB24R+52MMPmwayKHDTlQD5wmPHSMM2w=
X-Received: by 2002:a19:301:: with SMTP id 1mr9565328lfd.67.1608141879323;
 Wed, 16 Dec 2020 10:04:39 -0800 (PST)
MIME-Version: 1.0
References: <20201118102342.154277-1-omosnace@redhat.com> <20201216163725.GG6430@twin.jikos.cz>
In-Reply-To: <20201216163725.GG6430@twin.jikos.cz>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 16 Dec 2020 19:04:23 +0100
Message-ID: <CAFqZXNs9Wi+n_pxe99yb=2V_h6g5Q10LcqYVsA7eUGDQoUD5EA@mail.gmail.com>
Subject: Re: [PATCH] vfs: fix fsconfig(2) LSM mount option handling for btrfs
To:     dsterba@suse.cz, Ondrej Mosnacek <omosnace@redhat.com>,
        linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 16, 2020 at 5:40 PM David Sterba <dsterba@suse.cz> wrote:
> On Wed, Nov 18, 2020 at 11:23:42AM +0100, Ondrej Mosnacek wrote:
> > When SELinux security options are passed to btrfs via fsconfig(2) rather
> > than via mount(2), the operation aborts with an error. What happens is
> > roughly this sequence:
> >
> > 1. vfs_parse_fs_param() eats away the LSM options and parses them into
> >    fc->security.
> > 2. legacy_get_tree() finds nothing in ctx->legacy_data, passes this
> >    nothing to btrfs.
> > [here btrfs calls another layer of vfs_kern_mount(), but let's ignore
> >  that for simplicity]
> > 3. btrfs calls security_sb_set_mnt_opts() with empty options.
> > 4. vfs_get_tree() then calls its own security_sb_set_mnt_opts() with the
> >    options stashed in fc->security.
> > 5. SELinux doesn't like that different options were used for the same
> >    superblock and returns -EINVAL.
> >
> > In the case of mount(2), the options are parsed by
> > legacy_parse_monolithic(), which skips the eating away of security
> > opts because of the FS_BINARY_MOUNTDATA flag, so they are passed to the
> > FS via ctx->legacy_data. The second call to security_sb_set_mnt_opts()
> > (from vfs_get_tree()) now passes empty opts, but the non-empty -> empty
> > sequence is allowed by SELinux for the FS_BINARY_MOUNTDATA case.
> >
> > It is a total mess, but the only sane fix for now seems to be to skip
> > processing the security opts in vfs_parse_fs_param() if the fc has
> > legacy opts set AND the fs specfies the FS_BINARY_MOUNTDATA flag. This
> > combination currently matches only btrfs and coda. For btrfs this fixes
> > the fsconfig(2) behavior, and for coda it makes setting security opts
> > via fsconfig(2) fail the same way as it would with mount(2) (because
> > FS_BINARY_MOUNTDATA filesystems are expected to call the mount opts LSM
> > hooks themselves, but coda never cared enough to do that). I believe
> > that is an acceptable state until both filesystems (or at least btrfs)
> > are converted to the new mount API (at which point btrfs won't need to
> > pretend it takes binary mount data any more and also won't need to call
> > the LSM hooks itself, assuming it will pass the fc->security information
> > properly).
> >
> > Note that we can't skip LSM opts handling in vfs_parse_fs_param() solely
> > based on FS_BINARY_MOUNTDATA because that would break NFS.
> >
> > See here for the original report and reproducer:
> > https://lore.kernel.org/selinux/c02674c970fa292610402aa866c4068772d9ad4e.camel@btinternet.com/
> >
> > Reported-by: Richard Haines <richard_c_haines@btinternet.com>
> > Fixes: 3e1aeb00e6d1 ("vfs: Implement a filesystem superblock creation/configuration context")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Can we get this merged via the vfs tree, please? Possibly with
>
> CC: stable@vger.kernel.org # 5.4+
>
> > +     /*
> > +      * In the legacy+binary mode, skip the security_fs_context_parse_param()
> > +      * call and let the legacy handler process also the security options.
> > +      * It will format them into the monolithic string, where the FS can
> > +      * process them (with FS_BINARY_MOUNTDATA it is expected to do it).
> > +      *
> > +      * Currently, this matches only btrfs and coda. Coda is broken with
> > +      * fsconfig(2) anyway, because it does actually take binary data. Btrfs
> > +      * only *pretends* to take binary data to work around the SELinux's
> > +      * no-remount-with-different-options check, so this allows it to work
> > +      * with fsconfig(2) properly.
> > +      *
> > +      * Once btrfs is ported to the new mount API, this hack can be reverted.
> > +      */
> > +     if (fc->ops != &legacy_fs_context_ops || !(fc->fs_type->fs_flags & FS_BINARY_MOUNTDATA)) {
>
> Line is way over 80, it could be split like
>
>         if (fc->ops != &legacy_fs_context_ops ||
>             !(fc->fs_type->fs_flags & FS_BINARY_MOUNTDATA)) {

The chackpatch.pl limit is now 100 chars, so I hoped I would get away
with it :) Splitting conditionals always looks kinda awkward... But I
have no problem with changing it, if the VFS maintainers prefer that.
I would like to get at least *some* feedback from them before I respin
with just style changes...

>
> > +             ret = security_fs_context_parse_param(fc, param);
> > +             if (ret != -ENOPARAM)
> > +                     /* Param belongs to the LSM or is disallowed by the LSM;
> > +                      * so don't pass to the FS.
> > +                      */
>
> The multi line comment should have the /* on a separate line (yes it's
> in the original code too but such things could be fixed when the code is
> moved).

Okay. I prefer the "Linus" format as well, but since different
subsystems still have their own opinions, I figured I'd just leave it
be... But again, I'll be happy to change it if VFS maintainers don't
object.

>
> > +                     return ret;
> > +     }
> >
> >       if (fc->ops->parse_param) {
> >               ret = fc->ops->parse_param(fc, param);
>

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

