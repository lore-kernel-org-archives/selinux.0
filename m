Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D66C433DB
	for <selinux@archiver.kernel.org>; Mon, 15 Mar 2021 21:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4E7764F0F
	for <selinux@archiver.kernel.org>; Mon, 15 Mar 2021 21:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbhCOVCz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Mar 2021 17:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbhCOVCv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 15 Mar 2021 17:02:51 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD22C06174A
        for <selinux@vger.kernel.org>; Mon, 15 Mar 2021 14:02:50 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id c12-20020a4ae24c0000b02901bad05f40e4so3624649oot.4
        for <selinux@vger.kernel.org>; Mon, 15 Mar 2021 14:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B7PzFc/MJvVvzh3WwpFHzntIsp84nGMmKSlhVLUH5/o=;
        b=jo90gPXg5yA4Pudc36xAhfvFDCfio1hmNT8UdycjI40d4yMU2FpRwbUcF2XgqMcTvC
         kReIrGe935OAmjsZfuhMbIkbqaFC0yw0hen4YRzfROgT4izjkR3mXfi00yhGfhoGIP2V
         Fy1uRFHHDp2aAxOwOI1xu0jWRJUlFaujBbGvJDHTDLnkjpJkuzwISXEIIUygIOIaMduu
         9jytwFwv1yGSyAnuBIMVtPmc1f0+f58/Wuf658Mv8ixGrSZQwK4GQr9dXa4ikAVgKXmL
         NeqOaMLvrXdm700Ni3MD3fql90TQabqepnNDTMBmcDjPjZPJkd4L61FLjh910cZegFuR
         6yJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B7PzFc/MJvVvzh3WwpFHzntIsp84nGMmKSlhVLUH5/o=;
        b=HCkOJF/4VFvR+nI5KXpKSxrVG9DuzoDJI9ns02dNTw/RkHHslB/Cq9D6c2T/mqF47/
         QJ3rhTzi0389wv2R2F8i4+x50AsTF2cGzHN1Zz7mHnMryBWminJgadsshM+qx3qNQ8rX
         eNhc68Ko9wvkhGFRjTjpK2JitMPD5+bXwwJr0qItd0aMctldRxGFtn2ZQPm+HFVpf1O6
         CnIcLAZzftdMztmHWHV+1AwSYv6faGwzYFTo4LK1E/YcyENZ+4kd4/EcUn9gqTCGHC7j
         pP1n74NQByhkqn3Rsmy5h4oFFAOUk4SIUkkNzPwsPpbFoeOXnSJ+AaFhx117z9WL9FHx
         IrMw==
X-Gm-Message-State: AOAM531g1XmBjOfP0k59+sktsFPu9TXfNnezIwKcVo+rY6jh/UaCyCjO
        3AYpBbh+kBgY9+mOaSCPh73Yn11XqgEhFg+GT8Q=
X-Google-Smtp-Source: ABdhPJwAPHY+oGnclpZOdESdNwZpSUCpyeLrDIT377uM/UG+RY+Q+b5emVsLZdsONS1z8iIFE3FTKrKG+3fpNP9hFAM=
X-Received: by 2002:a4a:bb14:: with SMTP id f20mr750922oop.1.1615842169720;
 Mon, 15 Mar 2021 14:02:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210314201651.474432-1-nicolas.iooss@m4x.org>
In-Reply-To: <20210314201651.474432-1-nicolas.iooss@m4x.org>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 15 Mar 2021 17:02:39 -0400
Message-ID: <CAP+JOzThBfc5-JtYYuPfhBHX6phxWMCJksy8WPggDiDFJyTpaw@mail.gmail.com>
Subject: Re: [PATCH 1/6] libsepol/cil: fix out-of-bound read of a file context
 pattern ending with "\"
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Mar 14, 2021 at 4:23 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> OSS-Fuzz found a Heap-buffer-overflow in the CIL compiler when trying to
> compile the following policy:
>
>     (sid SID)
>     (sidorder(SID))
>     (filecon "\" any ())
>     (filecon "" any ())
>
> When cil_post_fc_fill_data() processes "\", it goes beyond the NUL
> terminator of the string. Fix this by returning when '\0' is read after
> a backslash.
>
> Fixes: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28484
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libsepol/cil/src/cil_post.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
> index a55df1ea5bb0..5f9cf4efd242 100644
> --- a/libsepol/cil/src/cil_post.c
> +++ b/libsepol/cil/src/cil_post.c
> @@ -179,6 +179,12 @@ void cil_post_fc_fill_data(struct fc_data *fc, char *path)
>                         break;
>                 case '\\':
>                         c++;

The patch below is fine, but I can't figure out the reason for the
line above. I guess it means that fc->str_len++ will be skipped, but
if that is the purpose, it is not very clear. Does anyone know if this
is correct?

Jim


> +                       if (path[c] == '\0') {
> +                               if (!fc->meta) {
> +                                       fc->stem_len++;
> +                               }
> +                               return;
> +                       }
>                         /* FALLTHRU */
>                 default:
>                         if (!fc->meta) {
> --
> 2.30.2
>
