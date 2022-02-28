Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA342C433F5
	for <selinux@archiver.kernel.org>; Mon, 28 Feb 2022 21:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiB1VzZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 28 Feb 2022 16:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiB1VzZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 28 Feb 2022 16:55:25 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A0229C99
        for <selinux@vger.kernel.org>; Mon, 28 Feb 2022 13:54:45 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id r41-20020a4a966c000000b0031bf85a4124so20399336ooi.0
        for <selinux@vger.kernel.org>; Mon, 28 Feb 2022 13:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XT5YdVQF2GvUiiqnB2oZVuoesDnhJj/lqrn3QQB7718=;
        b=WRNBUHULBKeZSEz5jmcg+9HzFIvRD6AV6JkaRhynmucf04RIGhSVOnQmudveLyZ3ZI
         +Xx56ShjTO/kFN4eY9blsV8Edww99dBBrh4cigpHLbM9hdA9tJbQ9C6BAianWkqe+Pnv
         AsmfXn0/ZQswkBHD/0BCAK++rJl25ErzaGIyabdjDCpblUPCcDSilbkQZUWgOoqhJeoD
         yZbworZ3BnOeG2riqGH80wwdeFRD1h+BrB/29aLkjkkxFEaBM9BhIU05rkw6KHeUXwxL
         f5d0c54LzvxWQYzHejfqjxjGh5lEv9Jq2xcHAYksLW26LkOtNYVlEzRmvKKcIpiPwHEr
         N94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XT5YdVQF2GvUiiqnB2oZVuoesDnhJj/lqrn3QQB7718=;
        b=25WhTJmG9T838r1/yNEtle2bcnfyDYACqpA7HWdMhV6xokgvjjVC8Dm8th+LLazCtZ
         YVyfVWl4kLwSABLNYelcdo5Dh3uM78fk3Zp07dsQffsQd2LOYA4EB0Bdxg0rainWKKVV
         sx/Zd8Yb4/kPruYLQgcuuZRXaXAsRsM/sWIlE+RUmvud+49n+USnj8ngApiktJ5dH+T1
         nl/a300S/tJquq54384DlwjqtZz3gt9vq1movkHsYvvx7t2yJbRpGwKCyMWXhBunT/jJ
         zLTbMT9Qix2XfFrfPyoG9wNCXFzGOnqkMw17hbAvoYUbdT0DMczjT7mcpgZyfM2bZh9j
         +nQw==
X-Gm-Message-State: AOAM531lgL9v8/2LPf5ggZegMuc476YCmopZm7SnXwESbNv/R/OYgF5i
        8UY9GAfp69l4T4JHCMwJH7/42kbRfEqBpd11OPQ=
X-Google-Smtp-Source: ABdhPJzglackLCMmfIkg+v9QKpdRe2xQbOjQX/henA812Sla93GFxXXmlw3cnmxD8AVP5tjsXba8/lGZ9lwdQi4zENI=
X-Received: by 2002:a05:6870:569f:b0:d6:e441:553e with SMTP id
 p31-20020a056870569f00b000d6e441553emr1952767oao.16.1646085285077; Mon, 28
 Feb 2022 13:54:45 -0800 (PST)
MIME-Version: 1.0
References: <20220222134956.30277-1-cgzones@googlemail.com>
In-Reply-To: <20220222134956.30277-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 28 Feb 2022 16:54:34 -0500
Message-ID: <CAP+JOzQ2EJoYb_tZ2LLr8OLuq7owTmQwP8-zzv7uXzy3bqWXAw@mail.gmail.com>
Subject: Re: [PATCH] libsepol: NULL pointer offset fix
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 22, 2022 at 10:36 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On the first loop iteration the variables `r_buf` and `reason_buf_used`
> are NULL respective 0.  Please UBSAN by not adding them but instead
> directly assign NULL.
>
>     services.c:800:16: runtime error: applying zero offset to null pointe=
r
>         #0 0x4d4fce in constraint_expr_eval_reason ./libsepol/src/service=
s.c:800:16
>         #1 0x4cf31a in sepol_validate_transition_reason_buffer ./libsepol=
/src/services.c:1079:8
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/services.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/src/services.c b/libsepol/src/services.c
> index 7becfd1b..29723729 100644
> --- a/libsepol/src/services.c
> +++ b/libsepol/src/services.c
> @@ -797,7 +797,7 @@ mls_ops:
>
>                 for (x =3D 0; buffers[x] !=3D NULL; x++) {
>                         while (1) {
> -                               p =3D *r_buf + reason_buf_used;
> +                               p =3D *r_buf ? (*r_buf + reason_buf_used)=
 : NULL;
>                                 len =3D snprintf(p, reason_buf_len - reas=
on_buf_used,
>                                                 "%s", buffers[x]);
>                                 if (len < 0 || len >=3D reason_buf_len - =
reason_buf_used) {
> --
> 2.35.1
>
