Return-Path: <SRS0=NQFP=7X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF329C433E2
	for <selinux@archiver.kernel.org>; Wed, 10 Jun 2020 15:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BE0F206F4
	for <selinux@archiver.kernel.org>; Wed, 10 Jun 2020 15:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m84DcRUV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgFJP4k (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Jun 2020 11:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbgFJP4k (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Jun 2020 11:56:40 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778C7C03E96B
        for <selinux@vger.kernel.org>; Wed, 10 Jun 2020 08:56:40 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id p70so2474121oic.12
        for <selinux@vger.kernel.org>; Wed, 10 Jun 2020 08:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=s6DAKm8zQviMlrajY1jsjMq6QhEyw65JL3enOfEdExI=;
        b=m84DcRUVJFxGTVan7qRcDb9siES2rYS0T+YbPg+LeVvOAc97URCT2de5yqgMVTCNBs
         Xx9BlBD8ut2/mVBMsOAhGIgY03L35yyBTCb4PCZqbDdMHscmK0NllAIk3aJLei9N8dGM
         WzSyi4jRQDTV+/bLrFLV7J4s0+M1fSxC8JlVh+GtUX8159dN4E7Zn6+gc5cktP3FlPSm
         2+Y+mS8f+Jcc5ZXzOJuSJvOyGQxfY6fSyb/uGTVzwYTHAqoNP/FdxSE0dfl+k9gJhPA1
         d5SggslckuaYfMdrvTfc2Dpk6kVAIdcqNe/25r2mNlJ+fDhIwrvlZ/cwPxtWxJ7KytzC
         3SiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=s6DAKm8zQviMlrajY1jsjMq6QhEyw65JL3enOfEdExI=;
        b=GI5kNW6/31oYqiXJYhCoWDF9NazfyxjkxvuBL+QNITuk0C+75oTB1oQUQgix+XYhn9
         RbxvFXklH4XfhxgJuPnh60UXof8bSAOlcYN80MeuJHpa/JBoF4zkyfqOwa175JGxq+Vn
         uMtF8Q9BZg68SgEEUEQ0E/XKxGaM5WnVFMZZPJD60xhY7hRCCE8zfOferGtBNKiEo44A
         Vpz7FCNrIQVARhecwx7eTaG1ZpelUspgdil7zVVJLuONBHKCV6gPQyb8pVSK6QXoLRxu
         83zKuvbL0DtajmUKvoBLJ1xX97KqQP4p3gixnrQ2L37S7EYoDFZ0pwKmtPGZrTOHDzHG
         i9ew==
X-Gm-Message-State: AOAM533137z3siAM3AEI5yNcXaKllKHvKBoOZ5e8bYw+6pLsmrSA53bO
        9upJ+OfV3kpxExhoRcimqFCC8s4OrIjW2w8DLLiv9m0p
X-Google-Smtp-Source: ABdhPJwc5wdpPa8aPy822G6jYvpSiUpT7ZKGvOuR3Wjw7LitMiZWSXzaStBlytzHL3x5FBwQvWaDFsLLAQlvVnFt+nM=
X-Received: by 2002:aca:ec97:: with SMTP id k145mr2925795oih.92.1591804599652;
 Wed, 10 Jun 2020 08:56:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200604200831.28866-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20200604200831.28866-1-stephen.smalley.work@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 10 Jun 2020 11:56:28 -0400
Message-ID: <CAEjxPJ503XEoYEKdRpsfrzaf1A8gBfxXj9quG7tP0=2+Ect4zA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: fix selinux_restorecon() statfs bug
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 4, 2020 at 4:08 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> As reported in https://github.com/SELinuxProject/selinux/issues/248,
> setfiles -r (rootpath) fails when the alternate root contains a symlink
> that is correct relative to the alternate root but not in the current root.
> This is a regression introduced by commit e016502c0a26 ("libselinux: Save
> digest of all partial matches for directory").  Do not call statfs(2) here
> if acting on a symbolic link.  Unfortunately there is no lstatfs() call.
> Ensure that we initialize the statfs buffer always.  If the supplied
> file is a symlink, then we don't need to worry about the later tests of
> filesystem type because we wouldn't be setting the digest anyway and
> we are not performing a full sysfs relabel.  While here, fix the earlier
> test for a directory to use the correct test.
>
> Reproducer:
> $ mkdir /root/my-chroot && echo foo > /root/my-chroot/link-target && ln -s /link-target /root/my-chroot/symlink
> $ echo "/root/my-chroot/symlink" | setfiles -vFi -r /root/my-chroot -f - /etc/selinux/targeted/contexts/files/file_contexts
>
> Before:
> setfiles: statfs(/root/my-chroot/symlink) failed: No such file or directory
>
> After:
> Relabeled /root/my-chroot/symlink from unconfined_u:object_r:admin_home_t:s0 to system_u:object_r:default_t:s0
>
> Fixes: https://github.com/SELinuxProject/selinux/issues/248
> Fixes: e016502c0a26 ("libselinux: Save digest of all partial matches for directory")
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Anyone want to ack or object to this patch?

> ---
>  libselinux/src/selinux_restorecon.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
> index 91dfeb66..d1ce830c 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -938,7 +938,7 @@ int selinux_restorecon(const char *pathname_orig,
>         }
>
>         /* Skip digest if not a directory */
> -       if ((sb.st_mode & S_IFDIR) != S_IFDIR)
> +       if (!S_ISDIR(sb.st_mode))
>                 setrestorecondigest = false;
>
>         if (!flags.recurse) {
> @@ -952,7 +952,8 @@ int selinux_restorecon(const char *pathname_orig,
>         }
>
>         /* Obtain fs type */
> -       if (statfs(pathname, &sfsb) < 0) {
> +       memset(&sfsb, 0, sizeof sfsb);
> +       if (!S_ISLNK(sb.st_mode) && statfs(pathname, &sfsb) < 0) {
>                 selinux_log(SELINUX_ERROR,
>                             "statfs(%s) failed: %s\n",
>                             pathname, strerror(errno));
> --
> 2.23.3
>
