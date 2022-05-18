Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7307C433F5
	for <selinux@archiver.kernel.org>; Wed, 18 May 2022 13:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238462AbiERNzb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 May 2022 09:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238386AbiERNzH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 May 2022 09:55:07 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3A71C94E7
        for <selinux@vger.kernel.org>; Wed, 18 May 2022 06:54:54 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-e656032735so2795513fac.0
        for <selinux@vger.kernel.org>; Wed, 18 May 2022 06:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+pioNeeK3F7bcCqqsHHVYbD9gsvsaiS7DXTypXhevAw=;
        b=kkUW7gVNMlkMLqRG9Z+4jiGVqsPWYzae8wYjw8FA/Nk4Nb9WzUxcb2Jee/YjGpfWGk
         mJn+miXY0GnqrIhQ4Zh1s1jE83BERcfpL50X9ZzjR3Fa1y9gH9qn2l3nj5fg0ETwAdgP
         cJisCfxZUnoW1OwIpDG3f19prrGv7V/B+C44IZMAeWhZAg5rLBywQYH7ReZXzm0L/x34
         /6a7sdQkc/om57uBTSur8s8NFo0j3ksX+NBlzMbJDsogmueDgpdG8jmMmwQinacyjNki
         gUE2MT4iHHQSWOyb3vczaUq/6NUWg8vOQJmr30V8XZuhCL4RltAr+9C1w6IQjZQPwPAu
         VxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+pioNeeK3F7bcCqqsHHVYbD9gsvsaiS7DXTypXhevAw=;
        b=Mx+mGXLRBcEL3MFfn0cvc/H3dpWZt7uz0NYrZFG0kwxPvyKc4a/KBsRNGyqg1WbvN3
         3uMzDGO2Jrpt+ey/0gQQJbsTAA8VW2C8baxT85x5sePocpXasNkC/BqxChR631mVvzW/
         cybIngCaE12c0EU637vcyylbjCHsufx4f8k4QU6ncOfHMit55gAKC0DXOuF1e97grQWP
         lxeg8HreJZUd0YAXMGBlcU6+rU+WrqSVBQThn0w85XzUFwbQw8coKBxaUyYIhP183pxq
         GBMY0uBEaUKtA6g3jQ8W0B0M+uTfNXxDLJOtc5NORr1EQcuqJGJziRAlDCwokBG/CZgU
         4+JA==
X-Gm-Message-State: AOAM531sC/XuCwEPrJ9ZvzXyAH5NDA0D0MXj7jacetlM6/5FRbX5hrfY
        uWgbyNUF3b1tfWrkFkAHo6EXkc35tdT6k1QIXf8x+2HP
X-Google-Smtp-Source: ABdhPJzvT9B/h06/WZPQNXcu2MbUhu7ya7/4Yl/9SxS+n4Tk+x+Lbam+ul+XZ3IeUNugLWWvxejGN5b1QuzkEho1pTE=
X-Received: by 2002:a05:6870:c692:b0:e9:5368:10df with SMTP id
 cv18-20020a056870c69200b000e9536810dfmr60739oab.182.1652882093536; Wed, 18
 May 2022 06:54:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220517140748.24238-1-cgzones@googlemail.com> <20220517140748.24238-2-cgzones@googlemail.com>
In-Reply-To: <20220517140748.24238-2-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 18 May 2022 09:54:42 -0400
Message-ID: <CAP+JOzTaf4XNWVy1opWxFx+ymu-f=+LJ6ht7vwDWbQXy71LHWw@mail.gmail.com>
Subject: Re: [PATCH 2/2] libselinux: restorecon: avoid printing NULL pointer
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, May 17, 2022 at 3:20 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The variable `curcon` is NULL in case the file has no current security
> context.  Most C standard libraries handle it fine, avoid it nonetheless
> for standard conformance.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> "(null)" might not be the best token to display, it was only taken to
> not change current behavior
> ---
>  libselinux/src/selinux_restorecon.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index 1a185ced..1b21a605 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -771,7 +771,9 @@ static int restorecon_sb(const char *pathname, struct=
 rest_flags *flags, bool fi
>                         selinux_log(SELINUX_INFO,
>                                     "%s %s from %s to %s\n",
>                                     updated ? "Relabeled" : "Would relabe=
l",
> -                                   pathname, curcon, newcon);
> +                                   pathname,
> +                                   curcon ? curcon : "(null)",

Use "<<none>>", this is already used in file context files to indicate
a file should not have a label.

Thanks,
Jim

> +                                   newcon);
>
>                 if (flags->syslog_changes && !flags->nochange) {
>                         if (curcon)
> --
> 2.36.1
>
