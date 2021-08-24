Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4A7C4338F
	for <selinux@archiver.kernel.org>; Tue, 24 Aug 2021 12:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7695C61357
	for <selinux@archiver.kernel.org>; Tue, 24 Aug 2021 12:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237403AbhHXMsF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Aug 2021 08:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237295AbhHXMr4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Aug 2021 08:47:56 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7101C061796
        for <selinux@vger.kernel.org>; Tue, 24 Aug 2021 05:47:12 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id g13so45242475lfj.12
        for <selinux@vger.kernel.org>; Tue, 24 Aug 2021 05:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=94RpWgD7LIplUW521seKKJ9pCErObOhDJ0u9dTv7EQU=;
        b=OaFXj9VOndi5HO7oC3/+FMkBa4gz3Z23N9giial+3sWgaZCwCIszTiaERgBbxC+e12
         8XarZtBCAjRkdvmJN96uqbsjLS8KSYPLW083enJCv9HHpk3i1Eegj2Nd//I2sQtbNK0I
         S8UMXbgK81T5AmtPnDco2DtlX9hseHHgIe3RicsSaoF0I8Rhckn/QX9xP3i57sqRyXfu
         prkIMrSyLPdMDDdEV7V4l1J3m/mOG6MCdzJNtv+Nuj4527Fv0+b/M8TuXCjNA0jupeZ8
         fH7XFnXOGZEECkbsFAcleeFA/CVZHRNXxt4sWBIPC1FnphPGU9gFr6wUWKADuEIHEPmD
         1tTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=94RpWgD7LIplUW521seKKJ9pCErObOhDJ0u9dTv7EQU=;
        b=TeACSfbLXdBJRRTiS+nIJY15paXwNhCGT+Y2+jMXB51+YabG20wSTfDfRNmiiQhXKF
         z9LfQb6m+H7aY9mMXGaw612W3PoiMNqa+H52uHbBzRWexEH+K5Q118kL+IqVYiAlfvjr
         61e0snChdQopV+mLLWgqCbB8MP0WlzMtUSkJGTESlQ5rNtnutQRbs/5HK+jnBKbStCIg
         T3AdJGQwEENx7xiuVpNaAZznIN2EsiY1s8+rJOQUHTiEpIC5dNp7tTgCx7+Q/qyhG1/N
         /jBIZzNIXN4BDlgpa2sgmFOXEQo2aUoPE9ocbZvqOUPHuW305eMw7Yh83TiTebp4q66q
         HMUA==
X-Gm-Message-State: AOAM533n2WLI+ICHJ4h8a2LrmrMeYlZHPfmT8P3ELP7tZ7mMve9fi/BH
        Hr4nwuQ+IbpcGXLKPOZJJAMfxFzikDcOFWg7Ws0=
X-Google-Smtp-Source: ABdhPJwbiSiqQj/tyXzeHI+fOrxqAR4svnf8xMTs1v+vSFMqzaN8lyDeSXYsR0oXz5HSfAUkRx9VKakZyeG5S1hpuvA=
X-Received: by 2002:a05:6512:2626:: with SMTP id bt38mr29220607lfb.181.1629809231053;
 Tue, 24 Aug 2021 05:47:11 -0700 (PDT)
MIME-Version: 1.0
References: <f505f5bd-437a-2e38-5a93-b4abfac9fe81@gmail.com>
In-Reply-To: <f505f5bd-437a-2e38-5a93-b4abfac9fe81@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 24 Aug 2021 08:47:00 -0400
Message-ID: <CAEjxPJ4FsWcme+Pk+OqZzG6M3p27Fs+8C4oMCTTxPZVUS0uBzQ@mail.gmail.com>
Subject: Re: security/selinux/hooks.c: FILE__ perms used as DIR__ perms
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 24, 2021 at 6:55 AM Topi Miettinen <toiwoton@gmail.com> wrote:
>
> Hello,
>
> Doing some post-processing of the SELinux policy (more about this some
> other time), I noticed that permissions for class "dir" could be
> tightened, for example "execmod" doesn't make a lot of sense for
> directories. Perhaps there are even more useless permissions? Let's grep
> for all use cases of permissions with DIR__ prefix:
>
> $ git grep DIR__ -- :^drivers/ :^arch/
> security/selinux/hooks.c:                         DIR__ADD_NAME |
> DIR__SEARCH,
> security/selinux/hooks.c:       av = DIR__SEARCH;
> security/selinux/hooks.c:       av |= (kind ? DIR__REMOVE_NAME :
> DIR__ADD_NAME);
> security/selinux/hooks.c:               av = DIR__RMDIR;
> security/selinux/hooks.c:                         DIR__REMOVE_NAME |
> DIR__SEARCH, &ad);
> security/selinux/hooks.c:
> old_isec->sclass, DIR__REPARENT, &ad);
> security/selinux/hooks.c:       av = DIR__ADD_NAME | DIR__SEARCH;
> security/selinux/hooks.c:               av |= DIR__REMOVE_NAME;
> security/selinux/hooks.c:                                 (new_is_dir ?
> DIR__RMDIR : FILE__UNLINK), &ad);
> security/selinux/hooks.c:                       av |= DIR__SEARCH;
> security/selinux/hooks.c:                       av |= DIR__WRITE;
> security/selinux/hooks.c:                       av |= DIR__READ;
>
> So, no instances of for example DIR__IOCTL or DIR__OPEN can be seen. But
> blindly removing all unreferenced DIR__ perms from policy is a big
> mistake, which I learned the hard way as the system didn't work normally
> anymore after installing such a filtered policy.
>
> The reason for this is that in security/selinux/hooks.c, FILE__ perms
> are used sometimes as DIR__ perms and "git grep" won't find them. While
> semantically incorrect, the #defines for DIR__xyz are identical bitwise
> to corresponding FILE__xyz and so either works.
>
> Perhaps the situation could be improved:
>
> 1. Add a comment to security/selinux/hooks.c to alert readers that
> FILE__ perms are sometimes used in place of DIR__ perms and why this is
> in fact OK.
>
> 2. Add static asserts to verify the hard way that each DIR__abc #define
> matches the corresponding FILE__abc #define. If one day this would no
> longer be the case, the compiler would warn.
>
> 3. Add a new unified set of #defines, for example COMMON_INODE__xyz, to
> document that the same perms are used for both files and directories.
>
> 4. Replace the semantically incorrect uses of FILE__ with something more
> complex (but technically useless) like
> if (S_ISDIR(xyz)
>         av = DIR__abc
> else
>         av = FILE__abc
> and since the values are identical bitwise, compilers could be expected
> to eliminate the useless checks and branches.
>
> Would patches be acceptable along some of these ideas?
>
> Maybe the unused permissions could be even removed entirely with lots of
> work and perhaps no real benefit.

Some history and a few observations. These are the common file
permissions as declared in the common access vector blocks in the
policy inherited by all the file classes and as defined as
COMMON_FILE_PERMS in security/selinux/include/classmap.h.
We used to have COMMON_FILE__READ, COMMON_FILE__WRITE, ... permission
definitions as well but those went away with the migration to dynamic
class/perm mapping and weren't being used in the code anyway; we have
always just used FILE__x in the code when it was a common file
permission. execmod was moved from being file-specific to being
duplicated for chr_file to being taken into the common file perms
(b424485abe2b16580a178b469917a7b6ee0c152a). open was moved to common
file perms and the explicit per-class mapping dropped from the code in
49b7b8de46d293113a0a0bb026ff7bd833c73367.

Before removing a permission from a class you need to ensure that the
check can never fire. It isn't enough that the operation might not be
implemented for the object; if the permission check can be reached
then we either need the permission to remain or replicate the check
against the object type before checking permission and return the same
error as the underlying code ala ENOTSUP or whatever.

Only options #2 and #4 ensure that the code won't compile if someone
removes a permission that is still being checked, so if we make a
change, I'd be inclined to do one of those two.
If we were to go with option 4, then the conditional should be based
on the security class stored in the inode security blob not based on
the mode bits.
