Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BB4C636CD
	for <selinux@archiver.kernel.org>; Fri, 10 Feb 2023 15:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbjBJPGN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Feb 2023 10:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbjBJPGG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Feb 2023 10:06:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8373B211CD
        for <selinux@vger.kernel.org>; Fri, 10 Feb 2023 07:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676041389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6yQzSuuSRXzPvRmxVo2dOCXPHQf0nRDXT3urFZYhCuo=;
        b=Gvo/wAbCuAlTGbOok9dZDkLxOTS3mq6e7L/veL6QHaUI9QxVpU9/qDqx2nr1vgcLOy0eiw
        ArcdHfRm+gSgm9zWD1dThXRQw/N6PzcxiNfMEAfj9iBXlo/RCI68OKMb3xM5UvwHWgsJ1r
        Vm+/sNjyIYcDMO0jN+eY0lVXH0i2yNk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-596-qUN0WTqfPLO_2jqLlR2tzg-1; Fri, 10 Feb 2023 10:03:08 -0500
X-MC-Unique: qUN0WTqfPLO_2jqLlR2tzg-1
Received: by mail-pj1-f69.google.com with SMTP id o18-20020a17090a5b1200b00230e9fe4ea0so2648766pji.8
        for <selinux@vger.kernel.org>; Fri, 10 Feb 2023 07:03:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6yQzSuuSRXzPvRmxVo2dOCXPHQf0nRDXT3urFZYhCuo=;
        b=TAUv/Jo4JjCvCN5Lx030rVskBTtbZoJzKrA90v/gOQM5zWX9Au4AeGAdCr4iDjjey+
         LumNPwveVq9X3hbXwNra9ZDZX4ELFZCbZ19d4Tz5LFswTCM/fEu29DDdD9J8nQucjn+x
         dKAr5iw65Qb9TbOcyEelRuTjzetMaYGvHc8m7ioGc7UwOzXyapTHSUSK+mYw5C2WtKtn
         C1Kq10exy2GcpbTBFwh5B7mm8zJXU7nD1fuKUXsKL//bbYa6gVGrBKW4gI8kH/wEFECm
         h3gVYKASYDItWjf3bEzncMTFt/TzhWDJrajtxtJu/7Tf5rRhj2/tyFEY3DTwhE06UIo6
         sQrg==
X-Gm-Message-State: AO0yUKXUG9cTwQ9OzKRy+b5oJfibaCoqqzlalTqZvuAQ/fdAa91vUpnf
        GzV1xH5dnRmXe9RweJXSeV/pcGwPUQE2BCLYkKOZTri1sbKJ0i/M2dNQ+puRXRTkR8xdARTwd6J
        Y2MzvPqCxjZH3FNFCFkcRlpSIJQplH7DpQ0JIY64HQFbm
X-Received: by 2002:a17:903:41d2:b0:196:7555:f810 with SMTP id u18-20020a17090341d200b001967555f810mr3849664ple.7.1676041386722;
        Fri, 10 Feb 2023 07:03:06 -0800 (PST)
X-Google-Smtp-Source: AK7set+3sbRQxBRN9q/GT0u5LN+ZHGVRAod0j562C9/2Cz8zl6x5lH8mnlRE7QLTR1U7L9LU2IQe7zOqyyxurO5mUI4=
X-Received: by 2002:a17:903:41d2:b0:196:7555:f810 with SMTP id
 u18-20020a17090341d200b001967555f810mr3849659ple.7.1676041386416; Fri, 10 Feb
 2023 07:03:06 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhRT0d-XWkw8uLGOmXsaQFpA4MMP6+sL5kfONbf-Mz8UJg@mail.gmail.com>
 <CAFqZXNuv780r04wsLyGvi+CmBFp_v=m1KCNA=ycPRwy5J0YQ9g@mail.gmail.com>
In-Reply-To: <CAFqZXNuv780r04wsLyGvi+CmBFp_v=m1KCNA=ycPRwy5J0YQ9g@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 10 Feb 2023 16:02:55 +0100
Message-ID: <CAFqZXNsuhzn7JjwXH-r88yiDuKyD-Oedyv1N33aZhxZD8DSwvg@mail.gmail.com>
Subject: Re: selinux-testsuite failures, CONFIG_LEGACY_TIOCSTI, and recent
 Rawhide builds
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 10, 2023 at 9:35 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Thu, Feb 9, 2023 at 11:09 PM Paul Moore <paul@paul-moore.com> wrote:
> > Hi all,
> >
> > I just noticed a selinux-testsuite failure in the tests/file test:
> >
> > # Test 8 got: "512" (file/test at line 103)
> > #   Expected: "0"
> > #  file/test line 103 is: ok( $result, 0 );
> > file/test ................... Failed 1/16 subtests
> >
> > Digging into this a bit more it looks like the the fnctl(TIOCSTI) call
> > in test_sigiotask.c is failing due to a recent Rawhide change to
> > undefine CONFIG_LEGACY_TIOCSTI, disabling TIOCSTI.  Upstream kernel
> > commit 83efeeeb3d04 ("tty: Allow TIOCSTI to be disabled") has more
> > information on the Kconfig option.
> >
> > I'm not going to argue for reenabling CONFIG_LEGACY_TIOCSTI, I think
> > turning it off is a good idea, but it does mean we need to adjust the
> > selinux-testsuite.
>
> I noticed that in our CI yesterday and had a brief look. Unfortunately
> I don't (yet) fully understand the terminal device voodoo being done
> in test_sigiotask.c and I don't have any idea how to make it work
> without TIOCSTI. So the best fix for now seems to be to use the
> dev.tty.legacy_tiocsti sysctl (see the Kconfig). However, it seems to
> be broken currently:
>
> # sysctl dev.tty.legacy_tiocsti
> # sysctl -w dev.tty.legacy_tiocsti=1
> sysctl: setting key "/proc/sys/dev/tty/legacy_tiocsti": Invalid argument
> #
>
> I will look into fixing it...

https://lore.kernel.org/lkml/20230210145823.756906-1-omosnace@redhat.com/

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

