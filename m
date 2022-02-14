Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2081DC433F5
	for <selinux@archiver.kernel.org>; Mon, 14 Feb 2022 21:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiBNVDs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Feb 2022 16:03:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiBNVDr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Feb 2022 16:03:47 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8232EA773
        for <selinux@vger.kernel.org>; Mon, 14 Feb 2022 13:03:39 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id o128-20020a4a4486000000b003181707ed40so20757127ooa.11
        for <selinux@vger.kernel.org>; Mon, 14 Feb 2022 13:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FY8maQzpT7iYpcjOXt1lRKxyrCsFn5N6RmwyeFVbZLE=;
        b=V80CJJLhJHcnwQtnqyXWRYra9gpLjXj9E/o970A9TXprTyqdbZ3I7mkIkqP7FQC+eQ
         Adztbvos7/pR5SMqm7/JU2+YxGN5zps9PtuOLHB7TYp3WT9gltbxdTBxXqbCFZMnGmwx
         8yLeAwsjfiJ2La/hs84sZ9cQIWILWIG4uu4RJ94TtawXrVVhuOJ0ZOJMgkHDh0lze8Zc
         u2M++/7A1IKntSf+b0Se9DBvos9UWAo9mMLCGR23YBJyv01aVQq/mw07R2ihxOFcYMl2
         UxGLCBANG72Lfw2+IIgka7PJbYdSR7TGT0jKnOUjPGgbaBZmtooLolpiuHI86OO3eC5R
         mhRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FY8maQzpT7iYpcjOXt1lRKxyrCsFn5N6RmwyeFVbZLE=;
        b=cpSKhM/UiIG+NaN5h6njsamTrG0KBzlrq2rQgLrF6P/th7iTfw6/DIUVxOIltXOAPx
         JlAua4JpqEtyqmha3wK2V8gJz61L5pMTjd+Z9q7P6VhI0Mgz23ebawKxMBhkEfLglx6g
         7bqjZQGbrHTiXlt9Tfi1hQwVJ/pYXx4etvGMJ6XpFqJ/1/ifw3lWE8AY4OwO3u9dnjnj
         KQjT8mIJxlg3nmdSKSTL4MiDMOITgzRG03Ov41v0Yhu7juuqHM/o5nrPoGTVOuZPIjXN
         TpMQLEb0+Qvjo1mqZJn4gWhTT+k7/rJdYPbo26tfv/Rn4bQZCCI2knwYvA6F7431njZe
         L+RA==
X-Gm-Message-State: AOAM533owkETw+m+jiuJC61salnbuTFMhfu0XCdq+NZGSS2hQ5bKY1F5
        8lS49kCFPleKLP/zHPa3m48Et8DYDPIO38ZJF08KvZB0Yps=
X-Google-Smtp-Source: ABdhPJwvj28RMB6CtZbpvDVc+C5wKQcIlEHMr9ETzbpiR91FuZlPN9FIyyrqJ8QlGEFtneTN51FwJY1x+AdpDxIe0Nk=
X-Received: by 2002:a54:408e:: with SMTP id i14mr239103oii.200.1644868764817;
 Mon, 14 Feb 2022 11:59:24 -0800 (PST)
MIME-Version: 1.0
References: <20220210185234.41362-1-cgzones@googlemail.com>
In-Reply-To: <20220210185234.41362-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 14 Feb 2022 14:59:13 -0500
Message-ID: <CAP+JOzQewp4ocnVqMOqHKjvCTUa4ruxav0NRGq9DyZokq51KqQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] libsepol: use correct error type to please UBSAN
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 10, 2022 at 4:09 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The callback function apply in hashtap_map has a return type of int and
> can return -1 on error.  Use int as type to save the return value to
> avoid implicit conversions:
>
>     hashtab.c:236:10: runtime error: implicit conversion from type 'int' =
of value -1 (32-bit, signed) to type 'unsigned int' changed the value to 42=
94967295 (32-bit, unsigned)
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For all three patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/hashtab.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/libsepol/src/hashtab.c b/libsepol/src/hashtab.c
> index 2eb35212..3ecaf165 100644
> --- a/libsepol/src/hashtab.c
> +++ b/libsepol/src/hashtab.c
> @@ -224,8 +224,9 @@ int hashtab_map(hashtab_t h,
>                 int (*apply) (hashtab_key_t k,
>                               hashtab_datum_t d, void *args), void *args)
>  {
> -       unsigned int i, ret;
> +       unsigned int i;
>         hashtab_ptr_t cur;
> +       int ret;
>
>         if (!h)
>                 return SEPOL_OK;
> --
> 2.34.1
>
