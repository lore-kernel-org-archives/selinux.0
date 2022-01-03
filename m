Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59379C433EF
	for <selinux@archiver.kernel.org>; Mon,  3 Jan 2022 18:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiACSok (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Jan 2022 13:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiACSok (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Jan 2022 13:44:40 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1000C061784
        for <selinux@vger.kernel.org>; Mon,  3 Jan 2022 10:44:39 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id v15-20020a9d604f000000b0056cdb373b82so44640059otj.7
        for <selinux@vger.kernel.org>; Mon, 03 Jan 2022 10:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hdcDgxtOvKpX06r6TtRNdWSI0wJ4lzUd6OS5j+dXow4=;
        b=W2kuO8cKGWqSFJrk1CrIBuxGc5CkOl60HFeN8/9c1ZhMeyuRwjNm8iAXpQplnq5wcC
         BeDzoUZ0Ki5uOUKQ3hxB6oTkuPgnN7QStW96XENGRH80UuH+TlkL3J5DpHV3BGLz99JH
         dPan8aeqCcWFfpM4hkW0tbbLHDW9CvN8pBVXhJWDq28NBg8G2ljA22xjY6gmaOlk4t/x
         TvL33EIwWEELcmHqnyqfTBgmwda8Wk0IXAg43WbPqhQjDk5esaY8jelxY7gWqIJI7vad
         KyzVD98D4nb7D4WI6vQ0JyrKGdoYk2GJCggA7B1nLUVvdRg5mBHnalCVGDl0IvVGJWyJ
         4eRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hdcDgxtOvKpX06r6TtRNdWSI0wJ4lzUd6OS5j+dXow4=;
        b=li71GPeR7/m+hYm8/WWDnGJg3UySth//zyc4tSvneBR+ybX2ZygXK0y1wUlNVj9jdc
         NV7NoRUVkQSxUmKqtA+L9Z3/GF3SyUkksX5cCvvLdf2FXZGD9dF1J3i2g6eswAGv3M/m
         fskn69mVeFNznKCi3dKWO1d4oDpq2hj+oR7j4in8bP2CM0/vrRXlwOUrppL97yJz65wH
         V8WrP2RmSEHC1ebT6A8zux+4ead4V2NrtdtneUWebWGROKEYYV3bL8i4HAYSGybRiHJW
         Ji1yTR+p4dnBeLC45dcIcEDlkhd0Wy8DcXk2lStKli5qR2B+sqCCt3NrwPqu4EMIDnhA
         S/lA==
X-Gm-Message-State: AOAM533bWdI2L8STKFH7nYlm7q/UBigyzjYwu3p3tjh+uGgJlk7CtYaz
        auMD7h7inv3zW14yWrWQl/a3nCUJWcbJtyEy2I5+hfLwGg8=
X-Google-Smtp-Source: ABdhPJwj/FLBJh1+R4Tyd0rYUbGGFDUA671iwv7Zotbg1qG7wuvAlTH7HkRZMrcYYqhyLyJnQBqFLExzxxu7ziTe3Tg=
X-Received: by 2002:a05:6830:4094:: with SMTP id x20mr33614077ott.53.1641235479379;
 Mon, 03 Jan 2022 10:44:39 -0800 (PST)
MIME-Version: 1.0
References: <20211223181945.68723-1-cgzones@googlemail.com>
In-Reply-To: <20211223181945.68723-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 3 Jan 2022 13:44:28 -0500
Message-ID: <CAP+JOzR-G0mre7PJcf=rvyapEAqP-nbwU3PJr_1TBw87XGQQ=A@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol: check for valid sensitivity before lookup
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Dec 24, 2021 at 8:09 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Check the sensitivity is valid and thus the lookup in the name array
> `p_sens_val_to_name` is valid.
>
> Found by oss-fuzz (#42729, #42730, #42735, #42741)
>
>     =3D=3D54784=3D=3DThe signal is caused by a READ memory access.
>         #0 0x5a10f3 in mls_semantic_level_expand ./selinux/libsepol/src/e=
xpand.c:934:11
>         #1 0x53839e in policydb_user_cache ./selinux/libsepol/src/policyd=
b.c:972:7
>         #2 0x5c6325 in hashtab_map ./selinux/libsepol/src/hashtab.c:236:1=
0
>         #3 0x5392e9 in policydb_index_others ./selinux/libsepol/src/polic=
ydb.c:1274:6
>         #4 0x53f90a in policydb_read ./selinux/libsepol/src/policydb.c:44=
96:6
>         #5 0x50c679 in LLVMFuzzerTestOneInput ./selinux/libsepol/fuzz/bin=
policy-fuzzer.c:35:6
>         #6 0x4409e3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char cons=
t*, unsigned long) (./selinux/out/binpolicy-fuzzer+0x4409e3)
>         #7 0x4295bf in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, u=
nsigned long) (./selinux/out/binpolicy-fuzzer+0x4295bf)
>         #8 0x42f850 in fuzzer::FuzzerDriver(int*, char***, int (*)(unsign=
ed char const*, unsigned long)) (./selinux/out/binpolicy-fuzzer+0x42f850)
>         #9 0x45b6d2 in main (./selinux/out/binpolicy-fuzzer+0x45b6d2)
>         #10 0x7f059fcd71c9 in __libc_start_call_main csu/../sysdeps/nptl/=
libc_start_call_main.h:58:16
>         #11 0x7f059fcd7277 in __libc_start_main csu/../csu/libc-start.c:4=
09:3
>         #12 0x423900 in _start (./out/binpolicy-fuzzer+0x423900)
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>

Someday it would be nice to have this validation of contexts done with
the other policydb validation, but I don't want to mess with that
right now.

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> v2: also check the entry is non-null
>
> ---
>  libsepol/src/expand.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index 8a7259a0..898e6b87 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -929,6 +929,10 @@ int mls_semantic_level_expand(mls_semantic_level_t *=
 sl, mls_level_t * l,
>         if (!sl->sens)
>                 return 0;
>
> +       /* Invalid sensitivity */
> +       if (sl->sens > p->p_levels.nprim || !p->p_sens_val_to_name[sl->se=
ns - 1])
> +               return -1;
> +
>         l->sens =3D sl->sens;
>         levdatum =3D (level_datum_t *) hashtab_search(p->p_levels.table,
>                                                     p->p_sens_val_to_name=
[l->sens - 1]);
> --
> 2.34.1
>
