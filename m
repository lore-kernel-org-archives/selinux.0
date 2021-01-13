Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1810CC433E0
	for <selinux@archiver.kernel.org>; Wed, 13 Jan 2021 13:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1CC02339D
	for <selinux@archiver.kernel.org>; Wed, 13 Jan 2021 13:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbhAMN7N (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Jan 2021 08:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbhAMN7N (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Jan 2021 08:59:13 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B445FC061786
        for <selinux@vger.kernel.org>; Wed, 13 Jan 2021 05:58:32 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id jx16so3164102ejb.10
        for <selinux@vger.kernel.org>; Wed, 13 Jan 2021 05:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zqItoCOfuSv+2qkK3Evuj7XwM5IM1wzbm2c0jHam0o0=;
        b=Lks2y/RQSwP4EVX8ptalE3GY6ts0uz7Jed5akyMJRNDGQHuys0MKGqaAsl4/zzOrDa
         JQFdpMu0hvMSMDwmKrGp/KzKNkGX0015n01qr0DvOK61qsTsA7J1E6DsowDAYYFD3EAi
         YV2Dxegcum22ARls64U1BKy6G3Po3CYggDUiTw0EUU/8hYMcF44GexAiiCxTzU7I7kMs
         ZhLdXmyRLop5y2drqPfVYYMkvShc/VV3Tasw3iXfsE+w85m1VvQW5FcnXb56cK4iuWZ0
         rW0tXiLXLy4SslONbXmd7FcihRlDy7GmNHs/nY0/wmzCcwhFwDiSVykKcHQCcLESSr/M
         q3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zqItoCOfuSv+2qkK3Evuj7XwM5IM1wzbm2c0jHam0o0=;
        b=WeRJ/b3qSO8G/nW3BqOpKoA1w9cO6GHSN2+xD9KSnYoheBkZDmZHpL70fcZZgUypqW
         A7OsOfMXuI6i0czsbLPvrMq88z9rkl8jOtQ9+ttHOTKJfhtgK4q1IofCEcd7m5/57AM9
         XD81TwQTfUkYTkQWwUdYd6TsKfa/rqL2gWy5i+hSCa7PAGNVla8NMN3l49ww3lq4bhN8
         aNGfspyIcVumdqnISdLRpFFgzkPMBq+63e7KC2lwUdlPxDsItrxe0CNQOI1XzHheyLXd
         QbAfsgpH/cLx7781Ld25hkYzIgTfDO3i3iLEqGvffBOeh+0RutuFAA4w/IdPr5ggYhjv
         TuGA==
X-Gm-Message-State: AOAM532AzPtdA03celLpRNXtoveMc7uzGcCnZ+GjSGSiAYxCkvpRvoo2
        Cqjf+nTp9BQ4h+0xeVhXnF6bNWCR2+8Aj3BmRTVf
X-Google-Smtp-Source: ABdhPJwHiOl41/LbUDTq4kguyKvnyAdAhViPNEN0Tpf/RcZUK1+CuU3SqqqbRU/1GNv171I/Q7CLrzibCNTXn3xhn4Q=
X-Received: by 2002:a17:906:2e82:: with SMTP id o2mr1695521eji.106.1610546311339;
 Wed, 13 Jan 2021 05:58:31 -0800 (PST)
MIME-Version: 1.0
References: <20210113123802.63563-1-omosnace@redhat.com>
In-Reply-To: <20210113123802.63563-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 13 Jan 2021 08:58:20 -0500
Message-ID: <CAHC9VhSJVWd7S5s3HS+dt4n12Bi=5PQ2Z+aOqsJ5UYb1ejEohA@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: fall back to SECURITY_FS_USE_GENFS if no
 xattr support
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 13, 2021 at 7:38 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
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
>     # ls -Zd /mnt
>     system_u:object_r:ramfs_t:s0 /mnt
>
> See also:
> https://lore.kernel.org/selinux/20210105142148.GA3200@redhat.com/T/
> https://github.com/fedora-selinux/selinux-policy/pull/478
>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>
> v2:
>  - incorporated Paul's suggestions
>  - corrected the `ls` command in reproducer
>
>  security/selinux/hooks.c | 77 +++++++++++++++++++++++++++-------------
>  1 file changed, 52 insertions(+), 25 deletions(-)

This looks better to me, merged into selinux/next.  Thanks Ondrej!

-- 
paul moore
www.paul-moore.com
