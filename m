Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189F1C433DB
	for <selinux@archiver.kernel.org>; Tue, 16 Mar 2021 18:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D75E065115
	for <selinux@archiver.kernel.org>; Tue, 16 Mar 2021 18:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240009AbhCPSWO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Mar 2021 14:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239957AbhCPSWA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Mar 2021 14:22:00 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA9FC06175F
        for <selinux@vger.kernel.org>; Tue, 16 Mar 2021 11:21:58 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id dx17so73838991ejb.2
        for <selinux@vger.kernel.org>; Tue, 16 Mar 2021 11:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ATABy9zC/tpLcxYv7za8wFx5cG2fi4BhjQqu6fqauiE=;
        b=WOvMvJ1w4n0kwkZkiSBl+DIH+994/5gt2UqnTHqURDX1c/7qeYwKaPxxig788s704v
         Fgy88286V76RbS20ulEx9KrYgyKPqAlGoAlAY+CvVxipGnvExtDxgpSgxcTHS2BTNT85
         LC6zNyJsfbKczUmSaLJQ6Fo+z94JOQsYPmX9zZXyN8BXCdYsNy3lDElEBKBstCQFHGcE
         3AUXlu+WakebXWpjomCzCx5TIYpo4VBYX+aCaGnKVBcYJe8R3J+gh4HIcfM95X6FMySi
         jElbrnixG4bxtVKqDSeN6sBv5SAm4FK0/HlMMMf1AzXMCCp2+8KgbCLbqHRDF89fft8o
         eIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ATABy9zC/tpLcxYv7za8wFx5cG2fi4BhjQqu6fqauiE=;
        b=ax7hxVv1mV2OdVyWsLH/iTf0ClcmVdv275c3XNEI/DY3/9KYB7AJ8GnlJOAuIz+tA1
         G2yx5cRC9Y4c6Oe/KCiaAJF3olaGLWEhwMxyv5OcuSzE1dNFoLXwA6BOYQDW8RxD9aws
         yCOhx5IQ1P/60xKMX5ubX0Ng8i/TDQzeGSCn9z5OEee4oA1I7r+J865NrZZQsDeGPM2G
         SuiakHbXLVxnKOnsS7jbL2NLXgWB5HD51uweT0Kp5U0x5wN7x4n2h6PjaBkDyICESfSB
         dTtOCdw2rEpQ0CYTcPRn6sTUdnPiygZtesDgWTGdqzyMtsDsqfL1ieq9nZUdXB79mBJf
         9dWQ==
X-Gm-Message-State: AOAM530i3FFvFvLb5wGlzeIG0OlaZDlkMzpIS9eiThzpBWxLSfasEuE6
        FgyNYT/bgWw/3IdvsUa1o4B9/5nRi6ozTQMc6cGPo18kc4vV
X-Google-Smtp-Source: ABdhPJytMntTpbhMGOMIpQmZ7H1iaR8dMCR2XbneRFjMaW2Nb4vDQR2cNklasjGICk7QZmWfC9NBqS17BujPWyf99o0=
X-Received: by 2002:a17:906:edca:: with SMTP id sb10mr14495392ejb.398.1615918916813;
 Tue, 16 Mar 2021 11:21:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210316144823.2188946-1-omosnace@redhat.com>
In-Reply-To: <20210316144823.2188946-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 16 Mar 2021 14:21:45 -0400
Message-ID: <CAHC9VhRoTjimpKrrQ5f04SE7AOcGv6p5iBgSnoSRgtiUP47rRg@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: fix fsconfig(2) LSM mount option handling for btrfs
To:     linux-btrfs@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 16, 2021 at 10:48 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> When SELinux security options are passed to btrfs via fsconfig(2) rather
> than via mount(2), the operation aborts with an error. What happens is
> roughly this sequence:
>
> 1. vfs_parse_fs_param() eats away the LSM options and parses them into
>    fc->security.
> 2. legacy_get_tree() finds nothing in ctx->legacy_data, passes this
>    nothing to btrfs.
> [here btrfs calls another layer of vfs_kern_mount(), but let's ignore
>  that for simplicity]
> 3. btrfs calls security_sb_set_mnt_opts() with empty options.
> 4. vfs_get_tree() then calls its own security_sb_set_mnt_opts() with the
>    options stashed in fc->security.
> 5. SELinux doesn't like that different options were used for the same
>    superblock and returns -EINVAL.
>
> In the case of mount(2), the options are parsed by
> legacy_parse_monolithic(), which skips the eating away of security
> opts because of the FS_BINARY_MOUNTDATA flag, so they are passed to the
> FS via ctx->legacy_data. The second call to security_sb_set_mnt_opts()
> (from vfs_get_tree()) now passes empty opts, but the non-empty -> empty
> sequence is allowed by SELinux for the FS_BINARY_MOUNTDATA case.
>
> It is a total mess, but the only sane fix for now seems to be to skip
> processing the security opts in vfs_parse_fs_param() if the fc has
> legacy opts set AND the fs specfies the FS_BINARY_MOUNTDATA flag. This
> combination currently matches only btrfs and coda. For btrfs this fixes
> the fsconfig(2) behavior, and for coda it makes setting security opts
> via fsconfig(2) fail the same way as it would with mount(2) (because
> FS_BINARY_MOUNTDATA filesystems are expected to call the mount opts LSM
> hooks themselves, but coda never cared enough to do that). I believe
> that is an acceptable state until both filesystems (or at least btrfs)
> are converted to the new mount API (at which point btrfs won't need to
> pretend it takes binary mount data any more and also won't need to call
> the LSM hooks itself, assuming it will pass the fc->security information
> properly).
>
> Note that we can't skip LSM opts handling in vfs_parse_fs_param() solely
> based on FS_BINARY_MOUNTDATA because that would break NFS.
>
> See here for the original report and reproducer:
> https://lore.kernel.org/selinux/c02674c970fa292610402aa866c4068772d9ad4e.camel@btinternet.com/
>
> Reported-by: Richard Haines <richard_c_haines@btinternet.com>
> Tested-by: Richard Haines <richard_c_haines@btinternet.com>
> Fixes: 3e1aeb00e6d1 ("vfs: Implement a filesystem superblock creation/configuration context")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>
> Trying to revive this patch... Sending v2 with style tweaks as suggested
> by David Sterba.
>
> v2:
> - split the if condition over two lines (David Sterba)
> - fix comment style in the comment being reindented (David Sterba)
>
>  fs/fs_context.c | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)

VFS folks, can we get a verdict/feedback on this patch?  The v1 draft
of this patch was posted almost four months ago with no serious
comments/feedback.  It's a bit ugly, but it does appear to work and at
the very least SELinux needs this to handle btrfs properly, other LSMs
may need this too.

> diff --git a/fs/fs_context.c b/fs/fs_context.c
> index 2834d1afa6e8..e6575102bbbd 100644
> --- a/fs/fs_context.c
> +++ b/fs/fs_context.c
> @@ -106,12 +106,30 @@ int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param)
>         if (ret != -ENOPARAM)
>                 return ret;
>
> -       ret = security_fs_context_parse_param(fc, param);
> -       if (ret != -ENOPARAM)
> -               /* Param belongs to the LSM or is disallowed by the LSM; so
> -                * don't pass to the FS.
> -                */
> -               return ret;
> +       /*
> +        * In the legacy+binary mode, skip the security_fs_context_parse_param()
> +        * call and let the legacy handler process also the security options.
> +        * It will format them into the monolithic string, where the FS can
> +        * process them (with FS_BINARY_MOUNTDATA it is expected to do it).
> +        *
> +        * Currently, this matches only btrfs and coda. Coda is broken with
> +        * fsconfig(2) anyway, because it does actually take binary data. Btrfs
> +        * only *pretends* to take binary data to work around the SELinux's
> +        * no-remount-with-different-options check, so this allows it to work
> +        * with fsconfig(2) properly.
> +        *
> +        * Once btrfs is ported to the new mount API, this hack can be reverted.
> +        */
> +       if (fc->ops != &legacy_fs_context_ops ||
> +           !(fc->fs_type->fs_flags & FS_BINARY_MOUNTDATA)) {
> +               ret = security_fs_context_parse_param(fc, param);
> +               if (ret != -ENOPARAM)
> +                       /*
> +                        * Param belongs to the LSM or is disallowed by the LSM;
> +                        * so don't pass to the FS.
> +                        */
> +                       return ret;
> +       }
>
>         if (fc->ops->parse_param) {
>                 ret = fc->ops->parse_param(fc, param);
> --
> 2.30.2

-- 
paul moore
www.paul-moore.com
