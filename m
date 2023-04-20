Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC3BC7618E
	for <selinux@archiver.kernel.org>; Thu, 20 Apr 2023 20:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjDTU7N (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Apr 2023 16:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjDTU7M (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Apr 2023 16:59:12 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930CD422A
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 13:59:10 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-94f4b911570so103225866b.0
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 13:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682024349; x=1684616349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1TtJf06BJ8DfG72LitwC5BH2sX7XJJy3NLD0V/xkxM=;
        b=sE5T9DDJ84irFCA3e8uL7Oovjh46eX7x4l7qWZ4bgJnQSm0uBizwoLXP7xglOjl4kK
         YvPXo4+n70POZuNuY7T/rCp17IXc0+jZX/xZqaRwEjg4bCMXXux8nXUrOfC3tmHfGrFn
         BYwnCiqAtCFQomBB0sZkLs7etP92fNJSWolDLuPKpGpk2xW7Q78WTAHxB2nCC68RAGCS
         PTVp3SHQPUHOtCw7/NvDz5+n7EM0zPpELjFgcPmfCteWHolcj5Y0gutaXZL9VIhuL9Ht
         rRLhSkdk1xMw0a4sQrftzR8i6NAuAvYOnObbw/buJbtCj+srA4cyISKkOVKHiqbVRQSP
         Nbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682024349; x=1684616349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1TtJf06BJ8DfG72LitwC5BH2sX7XJJy3NLD0V/xkxM=;
        b=c5272Lu6w1Qyu1MxBTJZxNNUhUorlnXlNEUOWnX+axJm0G86k8C51dSiCnT+pwHo0k
         wNfs1HZx0nDDCRrjg59FGqF4j/NNJEJRUqxypZMtAybL63rJerIomQt7x0HJgE6kTOzn
         VPXxGfXoVYDBqU45+OD7TOxqUU3vutOF8eSQYiAlguGGrsxBXtMD3Bw37D57KbSBt4li
         hPoou31jC3Qb7H6TZN5qYcz7dN0xZBI7BXFvQPpaol1kZaj7FOehVm+XxmZq6nRZIaYF
         py+Xn4P2btVoK9+kTSF3f7Teg8SerUlIOvlHVvTWnCGOBfRQYic2727MP+tcw5s2VbbB
         b9/A==
X-Gm-Message-State: AAQBX9cAfbAgdEEs0Kx7ED2pSGn9eq1Hg9kOc5rEVcu9HFjVLz9jKKhl
        ZjdgPI1F0yLZR8dLylis3c6zxfg4BDW9ZqNKJwQOQvNGEr8=
X-Google-Smtp-Source: AKy350bw2U37unCGC2daLXdrWqgCcXVtpLzGj4aU0eHe+m8gzKlHzpWDc+45LTVUGpy3I4dY6dBLE0TAs0AKW3vHp8A=
X-Received: by 2002:a17:906:6a2a:b0:94c:ea3b:27a with SMTP id
 qw42-20020a1709066a2a00b0094cea3b027amr318876ejc.16.1682024348856; Thu, 20
 Apr 2023 13:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230401124902.76959-1-cgzones@googlemail.com> <20230420151500.23679-1-cgzones@googlemail.com>
In-Reply-To: <20230420151500.23679-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 20 Apr 2023 16:58:57 -0400
Message-ID: <CAP+JOzTz_tm-wFby3xuiR1n8J-=CMc3E9ZXoao8gD2LSD8cs=g@mail.gmail.com>
Subject: Re: [PATCH RESEND] libsemanage: fix memory leak in semanage_user_roles
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 20, 2023 at 11:25=E2=80=AFAM Christian G=C3=B6ttsche
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
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> same as v1, only signed-of
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
