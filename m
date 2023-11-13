Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2E4C4332F
	for <selinux@archiver.kernel.org>; Mon, 13 Nov 2023 20:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjKMUMj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Nov 2023 15:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMUMi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Nov 2023 15:12:38 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B1FD5D
        for <selinux@vger.kernel.org>; Mon, 13 Nov 2023 12:12:35 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-5079f9ec8d9so5305525e87.0
        for <selinux@vger.kernel.org>; Mon, 13 Nov 2023 12:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699906353; x=1700511153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRw1OPDakdWoLquYOeBBM4l2jy0sozjOonWM+JbgdR0=;
        b=K01uhNJ6+m5fyU5yx0ImQtGdkQ0I/XiID0gDow1PuzVk6zzeMklkhA0KzfuQXpxTIw
         hH8ibydwk3ClmIrOSwBnEz0lur8XoU1YglVJfPpTncB7iP9ZpPgTddkTiMTIH66BzKwE
         Tz0ynKovdJ7CwzbtHGeA5AYtqIeDoa1eb+Yc7eXNtOIF53Mi7nNgjfsqmi0DU6bFIXTe
         VUpYpwKYvNb48FP8GO7Y67TOmzcVxCY41VQIsdf8moKx+uE3rFg1N07mHjihCo5N4PGj
         t6SOTWjraM1ieR0rmfeyaWVbW0FN4FnaYSVoOXVtLc8f239UxRfl4FhJHTbuTLc6JDXT
         f9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699906353; x=1700511153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KRw1OPDakdWoLquYOeBBM4l2jy0sozjOonWM+JbgdR0=;
        b=DvZpE7LAyLgYWTlgL9I0LHrReCQhgCX0xvGGNYwkSCG433sFVE4bSpSI/9ii8rxxfF
         CBj7W6JiuV+67JHzjKl6XilSW+9XBPfbZOWD3d747Zuktvf2BP2qYV76e8KnbOsY5BUw
         b3wfCblkWenXygW4RNdAgMP4xJ6+/anSaEqpF8WvnuQFa9VGjCwfMyIhEV980JLsQjS3
         58i0jHfiWuLoUYZiWtCnyYQw5nRw2y99ZBH1e+HgRhtDei8hVdjYGHAAj/Azcoomfe/0
         w3sAgYmm/n/8+UdEec1czyyINMMVMs9ggF0dLtrn4dBtKGiVNeDSTIZn5tMl7OZ7TvuP
         sMDA==
X-Gm-Message-State: AOJu0Yxw55sXbkA5pwx7MygPOSlBTibTKpLI5lWOmfaxqvx1xICU7167
        weVMgDHFDrLGj2wC52vDcjiVuF1VcrBKnCxNn2I=
X-Google-Smtp-Source: AGHT+IHp5r96SMah7t/Z/aWehO3uD4YP/MimH5G+gl9R/ggawP9a6oX2grVP+mOSZ00rgHZLBR5MsB3RtOC6mtJl6W4=
X-Received: by 2002:a05:6512:234e:b0:509:30de:414a with SMTP id
 p14-20020a056512234e00b0050930de414amr203797lfu.28.1699906353318; Mon, 13 Nov
 2023 12:12:33 -0800 (PST)
MIME-Version: 1.0
References: <20231109135148.42688-1-cgzones@googlemail.com>
In-Reply-To: <20231109135148.42688-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 13 Nov 2023 15:12:21 -0500
Message-ID: <CAP+JOzTqSdFv+Cz9H3wZH=gaRmSpJM_CMeBd_DwR6_r6JGtswQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] Drop LGTM.com configuration
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 9, 2023 at 8:51=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> LGTM.com has been discontinued in 2022 and replaced by GitHub code
> scanning[1].
>
> [1]: https://github.blog/2022-08-15-the-next-step-for-lgtm-com-github-cod=
e-scanning/
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these seven patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  lgtm.yml | 5 -----
>  1 file changed, 5 deletions(-)
>  delete mode 100644 lgtm.yml
>
> diff --git a/lgtm.yml b/lgtm.yml
> deleted file mode 100644
> index f80bf146..00000000
> --- a/lgtm.yml
> +++ /dev/null
> @@ -1,5 +0,0 @@
> -extraction:
> -  cpp:
> -    index:
> -      build_command:
> -        - make DESTDIR=3D"$LGTM_WORKSPACE/destdir" install
> --
> 2.42.0
>
