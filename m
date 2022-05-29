Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E822AC433EF
	for <selinux@archiver.kernel.org>; Sun, 29 May 2022 22:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbiE2Wwb convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Sun, 29 May 2022 18:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiE2Wwa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 29 May 2022 18:52:30 -0400
Received: from mx1.polytechnique.org (mx1.polytechnique.org [129.104.30.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D261B45518
        for <selinux@vger.kernel.org>; Sun, 29 May 2022 15:52:29 -0700 (PDT)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id A589156493F
        for <selinux@vger.kernel.org>; Mon, 30 May 2022 00:52:27 +0200 (CEST)
Received: by mail-pf1-f181.google.com with SMTP id c65so8529349pfb.1
        for <selinux@vger.kernel.org>; Sun, 29 May 2022 15:52:27 -0700 (PDT)
X-Gm-Message-State: AOAM5320Lp5ylro1eqqlPH2yquyOg47M1oXvx5/OTvJ7oX0gROzIm0Uu
        oN1QWgTn3M+2HMOMknH0xIVV+6s7cGPRMcVTm9c=
X-Google-Smtp-Source: ABdhPJxAiPVIFHJIMoiZ24nqon8NUSAnvzEz6qetBlH3D4i8sJCIIOYrPhVVBKu+xSr3RT5wBUDhY2TMaXJHxe8rjMA=
X-Received: by 2002:a63:ba48:0:b0:3fc:136f:a1d7 with SMTP id
 l8-20020a63ba48000000b003fc136fa1d7mr2640689pgu.200.1653864746505; Sun, 29
 May 2022 15:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220520131952.12286-1-cgzones@googlemail.com>
In-Reply-To: <20220520131952.12286-1-cgzones@googlemail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 30 May 2022 00:52:15 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=k7C5tozzohGREYNuj8OP7VzrN_E3Ng0yi+=Vi0JW3weA@mail.gmail.com>
Message-ID: <CAJfZ7=k7C5tozzohGREYNuj8OP7VzrN_E3Ng0yi+=Vi0JW3weA@mail.gmail.com>
Subject: Re: [PATCH] semodule: avoid toctou on output module
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon May 30 00:52:28 2022 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 20, 2022 at 3:20 PM Christian Göttsche
<cgzones@googlemail.com> wrote:
>
> Do not check for file existence and open afterwards, open with the
> exclusive flag (supported in Glibc and musl 0.9.6 and also standardized
> in C11).
>
> Found by GitHub CodeQL.
>
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

This looks good to me.

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks!

> ---
>  policycoreutils/semodule/semodule.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
> index 1ed8e690..48bc28dd 100644
> --- a/policycoreutils/semodule/semodule.c
> +++ b/policycoreutils/semodule/semodule.c
> @@ -550,15 +550,12 @@ int main(int argc, char *argv[])
>                                         goto cleanup_extract;
>                                 }
>
> -                               if (access(output_path, F_OK) == 0) {
> -                                       fprintf(stderr, "%s: %s is already extracted with extension %s.\n", argv[0], mode_arg, lang_ext);
> -                                       result = -1;
> -                                       goto cleanup_extract;
> -                               }
> -
> -                               output_fd = fopen(output_path, "w");
> +                               output_fd = fopen(output_path, "wx");
>                                 if (output_fd == NULL) {
> -                                       fprintf(stderr, "%s: Unable to open %s\n", argv[0], output_path);
> +                                       if (errno == EEXIST)
> +                                               fprintf(stderr, "%s: %s is already extracted with extension %s.\n", argv[0], mode_arg, lang_ext);
> +                                       else
> +                                               fprintf(stderr, "%s: Unable to open %s:  %s\n", argv[0], output_path, strerror(errno));
>                                         result = -1;
>                                         goto cleanup_extract;
>                                 }
> --
> 2.36.1
>

