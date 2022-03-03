Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECE2C433F5
	for <selinux@archiver.kernel.org>; Thu,  3 Mar 2022 18:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbiCCSYl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Mar 2022 13:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiCCSYk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Mar 2022 13:24:40 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3941A39E0
        for <selinux@vger.kernel.org>; Thu,  3 Mar 2022 10:23:54 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id d134-20020a4a528c000000b00319244f4b04so6721367oob.8
        for <selinux@vger.kernel.org>; Thu, 03 Mar 2022 10:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t9Mnt6fTvuKhH0Nh/b8xZtzJQFZEpCfNQV6SLI5pfo8=;
        b=D4gK7iTKLtrabiQMQrnVbn72kOGoUtuGkdqEShXV5DIzpu7hehmuFYghnm+gjoOJgz
         qbvoUwEPvWwT/Z1cRuAhhRzqKlZAOSa9Rdk0Wu65OmMu69CSeK6bnwElajErIXcaPc9c
         8ROpTWWOh8RoRlPA/07SCnGdsHheREJS1mCG8o5PldGfBuy+xS8xxse0nx1TdQ98SCa8
         2MONlTRdQkkoHzzZbYZeEOLOAW2sYs3EkO5/gsdd9sOBHHUnV2+HhS/5K4H45ozT0lIG
         CJzDXXNkHpzAkMjj4QGjd5AEY0A+NkaX/HYwWflBFFG4fuG5iZpGEOhTgzB10uDjdNTo
         xuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t9Mnt6fTvuKhH0Nh/b8xZtzJQFZEpCfNQV6SLI5pfo8=;
        b=yrZ91YvmcD05IzCJV1ozSiSG0mxdLS8klIy88mG+UYWh1HMbR2sGycEVvOheuSErPs
         JVZZlPwgSGiu4zpokcK006o9/ZF1lTr9aCurMZuhrlCL6ZgTR3hTvMqWvLWHiy9nDgAD
         ufg0Y7QQ7+J1w0IBat8L6jpN8yjhn0LE3S2ymXjcUQJN3yEla7UborwY1RQ8XdiqOLUu
         G6BzhF2rmxaRCQlyQlM/N6KdZO3b6NQprRH41EpN7GYhjOQujVNv8q54gFRi/qVNSBrz
         1f6ZSR5yrEahUK42UY/0rrpqYrO13g0pbJ2IxyrXDnP81vBmlTxMUWkUYC7F9zedt7dm
         I7cw==
X-Gm-Message-State: AOAM531YyJB1twC6Kj8vxRRk3tJx+6HAGjGcQ0Z8JyEwKeO+lJxKDtox
        LO7WnX/nxNGf5d6X61+pW8iagnT9toneySSC8MI=
X-Google-Smtp-Source: ABdhPJy5M1+ivLpYWEksx3Og3BnwPjhjzEVD3RzMZWGmYLtNQacdtDDLjwlEIqiBP+0r0VNuCVyh0rNGALSEWLLddyo=
X-Received: by 2002:a05:6870:7a3:b0:d7:5fbf:37b7 with SMTP id
 en35-20020a05687007a300b000d75fbf37b7mr4988848oab.16.1646331834230; Thu, 03
 Mar 2022 10:23:54 -0800 (PST)
MIME-Version: 1.0
References: <20220302101415.431161-1-plautrba@redhat.com> <CAP+JOzRs3m1HcKGLCcQuxaTyqLNSikneHpqGnAzmegQuy7q-yw@mail.gmail.com>
In-Reply-To: <CAP+JOzRs3m1HcKGLCcQuxaTyqLNSikneHpqGnAzmegQuy7q-yw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 3 Mar 2022 13:23:43 -0500
Message-ID: <CAP+JOzTqv6gLUo7bp=Css2cUKytcjR1zUPWBQf-dh_YDuzYaQA@mail.gmail.com>
Subject: Re: [PATCH] semanage-fcontext.8: Drop extra )s after FILE_SPEC
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 2, 2022 at 1:50 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Mar 2, 2022 at 7:35 AM Petr Lautrbach <plautrba@redhat.com> wrote=
:
> >
> > Fixes: https://github.com/SELinuxProject/selinux/issues/340
> >
> > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  python/semanage/semanage-fcontext.8 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/python/semanage/semanage-fcontext.8 b/python/semanage/sema=
nage-fcontext.8
> > index 49635ba788f7..1ebf085faed8 100644
> > --- a/python/semanage/semanage-fcontext.8
> > +++ b/python/semanage/semanage-fcontext.8
> > @@ -3,7 +3,7 @@
> >  semanage\-fcontext \- SELinux Policy Management file context tool
> >
> >  .SH "SYNOPSIS"
> > -.B semanage fcontext [\-h] [\-n] [\-N] [\-S STORE] [ \-\-add ( \-t TYP=
E \-f FTYPE \-r RANGE \-s SEUSER | \-e EQUAL ) FILE_SPEC ) | \-\-delete ( \=
-t TYPE \-f FTYPE | \-e EQUAL ) FILE_SPEC ) | \-\-deleteall  | \-\-extract =
 | \-\-list [\-C] | \-\-modify ( \-t TYPE \-f FTYPE \-r RANGE \-s SEUSER | =
\-e EQUAL ) FILE_SPEC ) ]
> > +.B semanage fcontext [\-h] [\-n] [\-N] [\-S STORE] [ \-\-add ( \-t TYP=
E \-f FTYPE \-r RANGE \-s SEUSER | \-e EQUAL ) FILE_SPEC | \-\-delete ( \-t=
 TYPE \-f FTYPE | \-e EQUAL ) FILE_SPEC | \-\-deleteall  | \-\-extract  | \=
-\-list [\-C] | \-\-modify ( \-t TYPE \-f FTYPE \-r RANGE \-s SEUSER | \-e =
EQUAL ) FILE_SPEC ]
> >
> >  .SH "DESCRIPTION"
> >  semanage is used to configure certain elements of
> > --
> > 2.35.1
> >
