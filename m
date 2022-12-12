Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A00C4167B
	for <selinux@archiver.kernel.org>; Mon, 12 Dec 2022 15:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiLLPOD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Dec 2022 10:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbiLLPOC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Dec 2022 10:14:02 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E264BB874
        for <selinux@vger.kernel.org>; Mon, 12 Dec 2022 07:14:01 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id js9so85663pjb.2
        for <selinux@vger.kernel.org>; Mon, 12 Dec 2022 07:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oaklXxkbIiYoImFmFezu9dvYcxv1tz73rjvfGv0RE30=;
        b=o2or34TaEgrt8xjTLl5WqkwYipUuu9HoTqGzwGDhiIFJ59LPKVd+S3hqcOCZ0pR/AI
         v/tXylm1spLwtlL85DhGRK5JUhpp0ZBTjwQrbJTnT90oufjvk/p+Koyd1ksmUm+YpGJW
         6h1xhDj4d3oVfNV6opnbLy2mOeZzzDlxeAu+AJC5CRYTteTcY+dUpG/cYcR87yqwljmG
         lPM0GsnsrXdnPo2CDpHoB0dJolXtn6o41cLbK3Vgcl823Wx1WZeXJSGZ9QbjqO00+OK2
         ZVg7+Ajn2fUKX2HEBEGeLvnJSv+YIDuoKkLHAFf2oW/4vdYap9ZoXP8no+n7EvIfTfEQ
         Y1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oaklXxkbIiYoImFmFezu9dvYcxv1tz73rjvfGv0RE30=;
        b=uAjriX+ks9s9BdUuMJ9ObVG4Guy73T9OuvPE8NQ7Ltdj5/DM6mVu74kihQ/JgKHZHF
         NYz74dX2p4SekNBZpS6uSELFEI44EC19Vk/ODQMm+H/t7H1QO4w+mABolxjMKNpFWTC2
         iIov6mKI51rttigaMM0LazOdeiq2/b68baZ8k+PUsiRbfOy6FERuvPuIb4o4rFbn7BKK
         L2F2DrJ8i2d6F4Zq05yeQvIGKTl/tqbGLO5bVgpVdXvlKQxY8Qz2E60NmrUBpDDzCBiK
         JSm+o99Znxv1aMxokAeun+LSeyTi8dY0563RO0t1DA8MaK3W+8ckn19zWNEpI8hUPktN
         6niw==
X-Gm-Message-State: ANoB5pnHRCVRkO4Kdr7RRsLIsrtM6YKn8BB3CIQ3jAOSH1hl7BZWUcOI
        WHIDX+pnqGVgCcwRcpoosTsgwJMBor7WnbjbVL3N4YqXBN8s
X-Google-Smtp-Source: AA0mqf4vmppTuYYlnAYgGNE8LLeIYX4lnjZ+mT9JNgKwYF3w+zo4ujAsIJo2Ld3bXyyEiVQ0dq323o5KhsJH4fkV9zo=
X-Received: by 2002:a17:90b:892:b0:219:b79d:c308 with SMTP id
 bj18-20020a17090b089200b00219b79dc308mr25906969pjb.69.1670858041392; Mon, 12
 Dec 2022 07:14:01 -0800 (PST)
MIME-Version: 1.0
References: <20221209130220.451845-1-omosnace@redhat.com> <CAFqZXNvTi-VQkH1VmSuJG0bHttSoFToEbdUM7=CyvsSX8RGw1Q@mail.gmail.com>
In-Reply-To: <CAFqZXNvTi-VQkH1VmSuJG0bHttSoFToEbdUM7=CyvsSX8RGw1Q@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 12 Dec 2022 10:13:50 -0500
Message-ID: <CAHC9VhR8eyTN3u4B=F4+ycH2+KEybSRQx+U_AHj1dWCVBKrOoA@mail.gmail.com>
Subject: Re: [PATCH testsuite] policy: allow user_namespace::create where appropriate
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Dec 12, 2022 at 10:05 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Fri, Dec 9, 2022 at 2:02 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > The cap_userns test's helper program needs this new permission for its
> > operation - detect the support of it and conditionally add the necessary
> > rule.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  policy/Makefile           | 4 ++++
> >  policy/test_cap_userns.te | 1 +
> >  policy/test_global.te     | 4 ++++
> >  3 files changed, 9 insertions(+)

...

> This patch is now applied:
> https://github.com/SELinuxProject/selinux-testsuite/commit/3389abeaa3bb6fdf23a0f2d8b1550fae69f9c52e

Thanks

-- 
paul-moore.com
