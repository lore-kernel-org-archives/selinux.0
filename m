Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00CAC07E96
	for <selinux@archiver.kernel.org>; Tue,  6 Jul 2021 14:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D83C611AE
	for <selinux@archiver.kernel.org>; Tue,  6 Jul 2021 14:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhGFPBF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Jul 2021 11:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbhGFPBF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Jul 2021 11:01:05 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330D1C06178C
        for <selinux@vger.kernel.org>; Tue,  6 Jul 2021 07:58:25 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 75-20020a9d08510000b02904acfe6bcccaso1720353oty.12
        for <selinux@vger.kernel.org>; Tue, 06 Jul 2021 07:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ABHsEDAe7jeHknzilwbQyRf2izfZqjgd1nWnhAiaiQk=;
        b=uMpnTX44mjzpazAY2ilQcObj5A/pSOGLP/YfsYtsXYlhXK6HRLBFV62AxB2sgzSE70
         Vcmlk6WA0teR+cdJaTi7N4OfgDjalO3wEDdeYxgjejWTkccbDMck03rd/3VPh5Q3yBUs
         FwgJklswpjJMN2jvehRU2k+dkRDGnpAlJ8bNKuKP5GF3aFEoV8GoK4wLwCd4Zn0hwUSq
         sSG0ALBuCmRJir1XVBf+uMR/TN8b3KvYNK+BmIH2juEPo7PhP7chnxXzS3NCObrmCmB4
         ZG2bot7f1tV+KdZxyN6HF9wy084oICZQ6rc1hpCTUMs4wc4ri6x/DsOYJO8El/zOkh6k
         +DSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ABHsEDAe7jeHknzilwbQyRf2izfZqjgd1nWnhAiaiQk=;
        b=ffmHpA2O3h3Cw90VypOqdiWEOnCmBX4YOTBO3XNKxZyD5py9E+6dN4U0RBPhz//Gez
         Yb/uI9lp3Se4awVy1P0ivTRBMxKEfqnauqPjzURpovXW0584iWQM5zVqPASSbjphCR8n
         ceS7LjIDSzjfx7djl22KOtw0bQvrpnynkOI1NWnRE2Ue3ljHfFevsh1AhfeZl+66yZVx
         wJEB65LeGkfWqTKWuFsLOqc6AjIsVI5w74U29/hND2uibindisOK44pi9RUquhn7i4uL
         PdrqwzGu5ffbMTvenZKy0PBZPd+SD2UdtpGuSCOOg2DbZGMl1Mib6LA6muGVujL2YBAs
         m30w==
X-Gm-Message-State: AOAM532i+JwZ5AUqk/nd02yFm6xay6Pm7RrU71tz0qG5jZcJS6skBBUO
        RS9fb5dT7m9RoIpo4NKX9cE6Zn9u+U0HtrfP+K8l3/qFT6KAMA==
X-Google-Smtp-Source: ABdhPJynjvKz9OedddsT/jy7hHBZ3PDkF/yz4mFRdak2O4QIR/VgeZ8U9ewIKvYtlsWfdw1humGFL9dBok0YiI4kEVQ=
X-Received: by 2002:a05:6830:16d2:: with SMTP id l18mr703050otr.196.1625583504620;
 Tue, 06 Jul 2021 07:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210702110705.435223-1-nicolas.iooss@m4x.org>
In-Reply-To: <20210702110705.435223-1-nicolas.iooss@m4x.org>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 6 Jul 2021 10:58:13 -0400
Message-ID: <CAP+JOzQM=p9Kg2grQWeKzgwWe+N+HTTJNdaiQ++HhW+mPYb9+w@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: do not override previous results of __cil_verify_classperms
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 2, 2021 at 7:15 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> When __cil_verify_map_class() verifies a classpermission, it calls
> __verify_map_perm_classperms() on each item. If the first item reports a
> failure and the next one succeeds, the failure is overwritten in
> map_args->rc. This is a bug which causes a NULL pointer dereference in
> the CIL compiler when compiling the following policy:
>
>     (sid SID)
>     (sidorder (SID))
>
>     (class CLASS (PERM1))
>     (classorder (CLASS))
>
>     (classpermission CLSPERM)
>     (classpermissionset CLSPERM (CLASS (PERM1)))
>     (classmap files (CLAMAPxx x))
>     (classmapping files CLAMAPxx CLSPERM)
>
> Fixes: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=30286
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_verify.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
> index 59397f70f2ea..8ad3dc9e114a 100644
> --- a/libsepol/cil/src/cil_verify.c
> +++ b/libsepol/cil/src/cil_verify.c
> @@ -1786,8 +1786,12 @@ static int __verify_map_perm_classperms(__attribute__((unused)) hashtab_key_t k,
>  {
>         struct cil_verify_map_args *map_args = args;
>         struct cil_perm *cmp = (struct cil_perm *)d;
> +       int rc;
>
> -       map_args->rc = __cil_verify_classperms(cmp->classperms, &cmp->datum, &map_args->class->datum, &cmp->datum, CIL_MAP_PERM, 0, 2);
> +       rc = __cil_verify_classperms(cmp->classperms, &cmp->datum, &map_args->class->datum, &cmp->datum, CIL_MAP_PERM, 0, 2);
> +       if (rc != SEPOL_OK) {
> +               map_args->rc = rc;
> +       }
>
>         return SEPOL_OK;
>  }
> --
> 2.32.0
>
