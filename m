Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921CFC77B73
	for <selinux@archiver.kernel.org>; Thu, 20 Apr 2023 14:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjDTOIA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Apr 2023 10:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbjDTOH7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Apr 2023 10:07:59 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BAF2133
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 07:07:58 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-94f0dd117dcso64657366b.3
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 07:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681999677; x=1684591677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWmsPbAhwm2H7YParhvNj2v1HQUEyXyn8tA+D81x+vM=;
        b=LZ59JkC+yT17BuWKB8jzURWBj8FDYdxbYlVy7Z/hcRPZHwsy2sTQ8Nn1ptQq2mbP2M
         889BF46zA1UkGVqXOLFM3UhZ+Hsqg53h42kHgXzQg6tipEW/trHR8szA49LlAPn3TDp8
         srQ7DVIllrwg09a0G/ED8TyqiCQ5ESqqclbPNeO9q2vg+14cvWRg9DR+dCIMuzKQpS6Q
         UghnLpKX10wj5P7h2Y4Z6oX0+MhjtrGyoGhbIUyTOGhRUX+ZF14x+klmhYTIbqInr1d6
         R+rVguxNUKXqMA80tQQPLZj5X2dkqXJlMWXuMfHqkJNV1TVWeci++U3PiKz2gHSTYx6Y
         BgaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681999677; x=1684591677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GWmsPbAhwm2H7YParhvNj2v1HQUEyXyn8tA+D81x+vM=;
        b=hionXZ6xMfSezxN7Mg5iwXRH9DtDVrAKt5TGmEQnC1ce+uimd26MJWfHYm9V5nUjv8
         vDbdXBkI0F1i+L2iAAywP8j88k/RASquAoOdGBThfVizL7LoCqpRP1LZ2yVyDLJQ9Nh1
         IZfJisMrBNYzKFvO88FTcnpEg1QIVZGbansooCe+lcwNOF8Gw5R8qjpv8Pyf6tEFVUOo
         oUSnQHcBlJE40223RM6P1YwfORt1K48864XbNSDNGgDFJMk7s3XKZSSY1n0MoCix2juV
         MV0LXaFf9FqCaHwrIZR2BQncR4cczZVC0OSBC5u5nfHIihAcCZC1mbolSV1cagkiKbyV
         6d2g==
X-Gm-Message-State: AAQBX9feS8vcdnf17GHEkJ5NvyvcEcYNXpQMoARo6GMXoq4h1jGr8zs2
        h8V4QHyN4XTQFwtSI8X1s10KuITE58RAX+8NVotxK4ID
X-Google-Smtp-Source: AKy350b1TtBwArS4BR2RcibyxCFwOtUgl65jut5YV0BH5Zcqk93B8tyTdJpR0GPl9b736dxSfYffuQQf40H/kl90tx0=
X-Received: by 2002:aa7:d94d:0:b0:504:80a4:d019 with SMTP id
 l13-20020aa7d94d000000b0050480a4d019mr2133638eds.12.1681999676870; Thu, 20
 Apr 2023 07:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230401124902.76959-1-cgzones@googlemail.com>
In-Reply-To: <20230401124902.76959-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 20 Apr 2023 10:07:45 -0400
Message-ID: <CAP+JOzSTkhfxLOYpbmpOjo7gi_9GNAGu=+rrJ=j=X8mSoywofw@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: fix memory leak in semanage_user_roles
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Apr 1, 2023 at 8:50=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The output parameter `role_arr` of semanage_user_get_roles() is an array
> of non-owned role names.  Since the array is never used again, as its
> contents have been copied into the return value `roles`, free it.
>
> Example leak report from useradd(8):
>
>     Direct leak of 8 byte(s) in 1 object(s) allocated from:
>     #0 0x5597624284a8 in __interceptor_calloc (./shadow/src/useradd+0xee4=
a8)
>     #1 0x7f53aefcbbf9 in sepol_user_get_roles src/user_record.c:270:21

I was going to ack this, but I just noticed that it doesn't have a
signed-off line.
Jim

> ---
>  libsemanage/src/seusers_local.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/libsemanage/src/seusers_local.c b/libsemanage/src/seusers_lo=
cal.c
> index 6508ec05..795a33d6 100644
> --- a/libsemanage/src/seusers_local.c
> +++ b/libsemanage/src/seusers_local.c
> @@ -47,6 +47,7 @@ static char *semanage_user_roles(semanage_handle_t * ha=
ndle, const char *sename)
>                                                 }
>                                         }
>                                 }
> +                               free(roles_arr);
>                         }
>                         semanage_user_free(user);
>                 }
> --
> 2.40.0
>
