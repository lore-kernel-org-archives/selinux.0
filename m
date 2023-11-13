Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD75C4332F
	for <selinux@archiver.kernel.org>; Mon, 13 Nov 2023 21:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjKMVnh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Nov 2023 16:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMVng (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Nov 2023 16:43:36 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743421B9
        for <selinux@vger.kernel.org>; Mon, 13 Nov 2023 13:43:33 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50a80241f39so2392550e87.3
        for <selinux@vger.kernel.org>; Mon, 13 Nov 2023 13:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699911812; x=1700516612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sp5mTBvKr+R8O/BvjZXIip3AD+y1OGiB1A6vP14X5Nw=;
        b=RglTwKNZZHxIbbTYJVOy7SqxVX1q3dZ+8V5s71M4Q33NI6jfKNg7UOCkunbmIjlhyd
         Brzlr33XWiWMFrrglLaFmNATj5uTkdAe0nV3Sp/FX5Z6Ei5yaeJQ7xvWEiTUGdrmjNLn
         7L+oefgBit8MbMdEhHxR/P9x5LQ0FsdmQoIfOAKPG7mcqy3Vh9IMhCqJfEpKGOAHli2k
         0UhFHy1LFqwku7ZDlVRumwmd1g/0WIbHl3P8Yn2roPE/YaIDtwNDLYmHExBe6u44Klq6
         2T7qM10GOnWba2Zo4sC0/CiJQHEmF6Qz2YXmYkQypaLUoMl1/DW6/Cst8TDa4zz3dwA+
         5v8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699911812; x=1700516612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sp5mTBvKr+R8O/BvjZXIip3AD+y1OGiB1A6vP14X5Nw=;
        b=uL+ewaa4cFaoz45Ifrt9PnpC+CgjDrXQON4X0l3s8Xf425ie8H0IcXCNZFdM9uhq8L
         YoN+25msp7IFfYbeeDxADqLqEQGenbX32iD47Myyw4jYklhABRS6RqknjXD6/yRTMjn0
         UtIhXZJA45FRvlHmt7pqz8Uk0nDBiPmPjJYpOvyBKX09grlp5wXToC8vUjUr6v4zo2wd
         p6G4LAzn5PFOh49egajZ+Lgr4DvkkcI7MynLF3imha+ztl/xjhgn9tgrq3Y+Vfr/ZEJl
         qmDpy92fO9F3EDl27CWz/CGYt4K47l84GRbsyi7lZtUVtsmSPWFfP914pc60120T1dLV
         MK4g==
X-Gm-Message-State: AOJu0YzFqiT5RFjOSwRZrWs4OWPoey6fmLKMYqEHDQc+0LWv2d5IFr7G
        WvhdvBBZeRKazIz9VshuQ8LYgPMWm1Jy8qWNnHjDqRQyV+s=
X-Google-Smtp-Source: AGHT+IE7PmxBOKQ6MjQ/6xBRlpvxkgl3Mo+yCaMW21jkqwR58xtLP4WzQsoIt0t00QiJIgah+6E9pvz5yhy4YmAiKU8=
X-Received: by 2002:a05:6512:2399:b0:500:be57:ce53 with SMTP id
 c25-20020a056512239900b00500be57ce53mr7141226lfv.42.1699911811391; Mon, 13
 Nov 2023 13:43:31 -0800 (PST)
MIME-Version: 1.0
References: <20231109135315.44095-1-cgzones@googlemail.com>
In-Reply-To: <20231109135315.44095-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 13 Nov 2023 16:43:20 -0500
Message-ID: <CAP+JOzRd6GbNJXykF-0jCscXyvxntBvZpF-sE1wiKwSt3paZRw@mail.gmail.com>
Subject: Re: [PATCH 1/5] semodule_link: avoid NULL dereference on OOM
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 9, 2023 at 8:53=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> In case the initial calloc(3) call fails the variable mods is still NULL
> while its size hint num_mods is set.
>
> Reported by Clang Analyzer:
>
>     semodule_link.c:182:29: warning: Array access (from variable 'mods') =
results in a null pointer dereference [core.NullDereference]
>       182 |                 sepol_module_package_free(mods[i]);
>           |                                           ^~~~~~~
>
> Fixes: 63e798a2034a ("semodule_link: update")
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these five patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  semodule-utils/semodule_link/semodule_link.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/semodule-utils/semodule_link/semodule_link.c b/semodule-util=
s/semodule_link/semodule_link.c
> index 0f157bd9..58fca34d 100644
> --- a/semodule-utils/semodule_link/semodule_link.c
> +++ b/semodule-utils/semodule_link/semodule_link.c
> @@ -178,9 +178,11 @@ failure:
>         ret =3D EXIT_FAILURE;
>
>  cleanup:
> -       for (i =3D 0; i < num_mods; i++)
> -               sepol_module_package_free(mods[i]);
> -       free(mods);
> +       if (mods) {
> +               for (i =3D 0; i < num_mods; i++)
> +                       sepol_module_package_free(mods[i]);
> +               free(mods);
> +       }
>         sepol_module_package_free(base);
>
>         return ret;
> --
> 2.42.0
>
