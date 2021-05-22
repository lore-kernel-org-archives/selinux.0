Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43964C2B9F2
	for <selinux@archiver.kernel.org>; Sat, 22 May 2021 15:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FA3361182
	for <selinux@archiver.kernel.org>; Sat, 22 May 2021 15:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhEVPnN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 22 May 2021 11:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbhEVPnM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 22 May 2021 11:43:12 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206A3C061574
        for <selinux@vger.kernel.org>; Sat, 22 May 2021 08:41:48 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id s20-20020a4ae9940000b02902072d5df239so5295313ood.2
        for <selinux@vger.kernel.org>; Sat, 22 May 2021 08:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=i/OXriFlcKmR8hEMuMC2ZlZSFg/n5C5dKsAE+hEQbpo=;
        b=t2jUUD1OdQcw5RXPxrU58TL0E3J7Ph6W0j3JOfvTaw6rvl9FhNOazZ3Rs1U3K19Ayw
         ffnTHIQi/OgurjX3nnXJ1uBrCI1gQ/CxhcIJjDCEzuuAvl3yyU5SumLIeg9T9mkYBWp+
         PJPCWTNONPfMtNoRRreZ6v2X0DBdICbAVWyheMF8Ft0qJ1wVIxEFqvjsL3QCbkIM4Oos
         g9TiaxYCvWkDetIajMrlhyT4UACpCdZcCIIyeoP4GZNtUsyZYzhZNQCAmQEPskrkLVtu
         rOpy9x+SeuHGVgOaMbypTPdSLTXV8nu6qfyRKCuwtnaXuDE45g1PovRKPT1rA19WoUUy
         GeuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i/OXriFlcKmR8hEMuMC2ZlZSFg/n5C5dKsAE+hEQbpo=;
        b=VC28MSXjSsYHTBODiWNDWfs2CFHttC2dw8YTxVikwbAqK4f+VyvQZx5TB381ln6qjn
         z+YgovkD3xpRDLi8P5ybSnXOoOo9NSj12Y0wD2MFHE8SrlKgi8jv+8HSWeJhKKvWY1st
         7IQf58vOB/BPXXcKCeEJ/8vb8g1vUL1qoxbHyuTdbIcrQ59F1dVVH4hglCGokjuCA2Jb
         D4GGGPg1su/ecNt0FchZlL+r6+/ffATE7gl/kOMSoZu7XCZPj4eGn7UK7a0yG8KCaMcP
         6hMS+mRQ9LfUyk1UWYihfLLCSRzJMuVtoyV6hvZRhPJlkQlgPVzVrPMV8J2fr/bxUaJD
         UkAg==
X-Gm-Message-State: AOAM532+YkgFNBOehSfEg+T8hp5W4RZ5+aIK8NW3K0VlrBLTr3VWXB7O
        E/Pi63vWG0ksjg+ZDEoH/um9OgVbWcm/VTOeqAx4tYBDK68=
X-Google-Smtp-Source: ABdhPJyCZrKVAK3P8y2d6WIVVmy/46Y/tWbMl2EbvBckV+ZlWnkZWIgxVctHFBISapCgB6zE48aAB47gnxgfZ4pOXzA=
X-Received: by 2002:a4a:8dd6:: with SMTP id a22mr12446614ool.74.1621698107496;
 Sat, 22 May 2021 08:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210510110354.3585-1-liwugang@163.com>
In-Reply-To: <20210510110354.3585-1-liwugang@163.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Sat, 22 May 2021 17:41:36 +0200
Message-ID: <CAJ2a_Dd96HTDCnsgsNEZtN=bdhkjLUw+B2OFTYjGLT9RcgaLGg@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: fix the leak memory when uses xperms
To:     SElinux list <selinux@vger.kernel.org>
Cc:     liwugang <liwugang@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Am Mo., 10. Mai 2021 um 13:21 Uhr schrieb liwugang <liwugang@163.com>:
>
> In the define_te_avtab_ioctl function:
> 1. the parameter avrule_template has been copies to
> new elements which added to avrule list through
> the function avrule_cpy, so it should free avrule_template.
> 2. And for rangelist, it does not free the allocated memory.
>
> The memory leak can by found by using memory sanitizer:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D20021=3D=3DERROR: LeakSanitizer: detected memory leaks
>
> Direct leak of 10336 byte(s) in 76 object(s) allocated from:
>     #0 0x7f8f96d9cb50 in __interceptor_malloc (/usr/lib/x86_64-linux-gnu/=
libasan.so.4+0xdeb50)
>     #1 0x55c2e9447fb3 in define_te_avtab_xperms_helper /mnt/sources/tools=
/selinux/checkpolicy/policy_define.c:2046
>     #2 0x55c2e944a6ca in define_te_avtab_extended_perms /mnt/sources/tool=
s/selinux/checkpolicy/policy_define.c:2479
>     #3 0x55c2e943126b in yyparse /mnt/sources/tools/selinux/checkpolicy/p=
olicy_parse.y:494
>     #4 0x55c2e9440221 in read_source_policy /mnt/sources/tools/selinux/ch=
eckpolicy/parse_util.c:64
>     #5 0x55c2e945a3df in main /mnt/sources/tools/selinux/checkpolicy/chec=
kpolicy.c:619
>     #6 0x7f8f968eeb96 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so=
.6+0x21b96)
>
> Direct leak of 240 byte(s) in 15 object(s) allocated from:
>     #0 0x7f8f96d9cb50 in __interceptor_malloc (/usr/lib/x86_64-linux-gnu/=
libasan.so.4+0xdeb50)
>     #1 0x55c2e9446cd9 in avrule_sort_ioctls /mnt/sources/tools/selinux/ch=
eckpolicy/policy_define.c:1846
>     #2 0x55c2e9447d8f in avrule_ioctl_ranges /mnt/sources/tools/selinux/c=
heckpolicy/policy_define.c:2020
>     #3 0x55c2e944a0de in define_te_avtab_ioctl /mnt/sources/tools/selinux=
/checkpolicy/policy_define.c:2409
>     #4 0x55c2e944a744 in define_te_avtab_extended_perms /mnt/sources/tool=
s/selinux/checkpolicy/policy_define.c:2485
>     #5 0x55c2e94312bf in yyparse /mnt/sources/tools/selinux/checkpolicy/p=
olicy_parse.y:503
>     #6 0x55c2e9440221 in read_source_policy /mnt/sources/tools/selinux/ch=
eckpolicy/parse_util.c:64
>     #7 0x55c2e945a3df in main /mnt/sources/tools/selinux/checkpolicy/chec=
kpolicy.c:619
>     #8 0x7f8f968eeb96 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so=
.6+0x21b96)
>
> Signed-off-by: liwugang <liwugang@163.com>

I am able to reproduce this leaks and this patch fixes them.

Tested-By: Christian G=C3=B6ttsche <cgzones@googlemail.com>

> ---
>  checkpolicy/policy_define.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 16234f31..04064af2 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -2400,7 +2400,7 @@ int avrule_cpy(avrule_t *dest, avrule_t *src)
>  int define_te_avtab_ioctl(avrule_t *avrule_template)
>  {
>         avrule_t *avrule;
> -       struct av_ioctl_range_list *rangelist;
> +       struct av_ioctl_range_list *rangelist, *r, *r2;
>         av_extended_perms_t *complete_driver, *partial_driver, *xperms;
>         unsigned int i;
>
> @@ -2458,6 +2458,13 @@ done:
>         if (partial_driver)
>                 free(partial_driver);
>
> +       r =3D rangelist;
> +       while (r !=3D NULL) {
> +               r2 =3D r;
> +               r =3D r->next;
> +               free(r2);
> +       }
> +
>         return 0;
>  }
>
> @@ -2484,6 +2491,8 @@ int define_te_avtab_extended_perms(int which)
>                 free(id);
>                 if (define_te_avtab_ioctl(avrule_template))
>                         return -1;
> +               avrule_destroy(avrule_template);
> +               free(avrule_template);
>         } else {
>                 yyerror("only ioctl extended permissions are supported");
>                 free(id);
> --
> 2.17.1
>
>
