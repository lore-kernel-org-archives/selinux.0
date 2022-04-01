Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7911C433F5
	for <selinux@archiver.kernel.org>; Fri,  1 Apr 2022 20:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236796AbiDAVA3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Apr 2022 17:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiDAVA2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Apr 2022 17:00:28 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE4819C08
        for <selinux@vger.kernel.org>; Fri,  1 Apr 2022 13:58:35 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-dee0378ce7so4026718fac.4
        for <selinux@vger.kernel.org>; Fri, 01 Apr 2022 13:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/0WYxOZUqoBcQvDuJURX4kSx7Py0urZ/dVWQDYu9lRw=;
        b=PMjJjZUIs1Ne43a/puien7wA5lNgyINrCJRiA+KB8oNVhtB9VC7qBZ77aW/Z6fPgx5
         XQhVixD+2rWpron1D7I36EaJfgEh+yH3VESgjjjAqOwLWJeJ32ecpZgwtWGzelSbWDjp
         tpttnG77hn+tv+L+OHo3SRKjLYfPVEWFWvqU33gItdlyFhY8yf+od/n++FS1E50fOEkB
         U8MNvt2/2Ip2wTBckEgP+2McAo/qEgqJFoRjCBImuLvyOrFnHhjX4XJTmalUMySb6i2O
         0+luNHhX655NJYAZ+k9GrEvfLRBhGs+bOpSRTIqvDpyJBGfRJi6lif8QqQ9jjWblG8E3
         6p2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/0WYxOZUqoBcQvDuJURX4kSx7Py0urZ/dVWQDYu9lRw=;
        b=X89htx6KCUrIXT8UR3091QAJIqnWWh7MpTgAapY2H6YFwZMWHGlmH23w8feUX6o4Wk
         TapRipQ9inieNSPZNA0pCl+j28Ym+ZotscA9Hhz8QITB97GbGjeXnH4fwJLSUG9/zj3w
         rGBN4WrAWOGL3t16VyaIH46J7v+J00Z99Wx04k5ZtmiIkzyFkGVlfXC5BtsHgpLGPL2a
         LaBpoAI9fuhxd3kcwqytzkXUTMqUvjmEh8/TCMdkR644N4HE9FgoNe8CcrbMy4VoytJA
         uSTTFUYbZBHaxWNPCblX+M5DCuSDkmgIBaAjPoqxaXsH+20FMs4pEahsl9+dNi3n4954
         sdCw==
X-Gm-Message-State: AOAM530c6RiedqFr0tjsG2BZPMBNwKB3lW4T2fWJCsIDoYRuTO6HPw0s
        DorryM0FSSn6GBk5BjUeFf6jQQ1FRGeOyJWDm8g=
X-Google-Smtp-Source: ABdhPJwfJiwYBBvJcSmF1Ers5x4cMeH53lqicwisbnE9IzlCuDaAexH2hScxMe2nnLyoR6PY7US4fOZxoRsPsDG4tb4=
X-Received: by 2002:a05:6871:81e:b0:dd:9f3e:c94a with SMTP id
 q30-20020a056871081e00b000dd9f3ec94amr5843921oap.156.1648846714436; Fri, 01
 Apr 2022 13:58:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220331144752.31495-1-cgzones@googlemail.com> <20220331144752.31495-4-cgzones@googlemail.com>
In-Reply-To: <20220331144752.31495-4-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 1 Apr 2022 16:58:23 -0400
Message-ID: <CAP+JOzQZxXYyosq8emxgkddJkrT3OwgtWgKNByTFFg5rZr2aTQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] Enable missing prototypes
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 31, 2022 at 2:36 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Check for missing prototypes like file local functions not declared
> static or external functions not being declared to avoid declaration/
> definition desynchronizations.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

We're not ready for this one yet.

    ../cil/src/cil_verify.c:973:5: warning: no previous prototype for
=E2=80=98__cil_verify_rule=E2=80=99 [-Wmissing-prototypes]

This one is easy to handle. The function is not used, or, rather, not
fully implemented and not used. So it can be removed.

    semanageswig_wrap.c:2759:24: warning: no previous prototype for
=E2=80=98PyInit__semanage=E2=80=99 [-Wmissing-prototypes]

This one I am not sure about.

Jim


> ---
>  Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Makefile b/Makefile
> index 215e313e..2ffba8e9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -14,6 +14,7 @@ else
>                 -Winit-self \
>                 -Wmissing-format-attribute \
>                 -Wmissing-noreturn \
> +               -Wmissing-prototypes \
>                 -Wnull-dereference \
>                 -Wpointer-arith \
>                 -Wshadow \
> --
> 2.35.1
>
