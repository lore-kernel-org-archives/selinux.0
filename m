Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC522C433EF
	for <selinux@archiver.kernel.org>; Wed,  2 Feb 2022 20:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiBBUjy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Feb 2022 15:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiBBUjy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 2 Feb 2022 15:39:54 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A392C061714
        for <selinux@vger.kernel.org>; Wed,  2 Feb 2022 12:39:54 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id v10-20020a4a860a000000b002ddc59f8900so190608ooh.7
        for <selinux@vger.kernel.org>; Wed, 02 Feb 2022 12:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=73Sale5LxFM/yxo7Fn1QgtgDIZqW3zrHJYkiDAk7PN0=;
        b=dl5hr8+pn91OwL/Saa5NRwwjitP2Cg5fPnycVQnS1FgDosV100jHIzZ42GuJqVfD00
         ybjkSR/UkQjgRtSmPa1Iy4AOuDGsw3BrMgqq4NbwFTJCl4c3Dd24tf6ZHRh2WOC/ceFa
         mt4ok2gCkQ59z8FQ7UdprW/qzottIRDo80v/6Y2ZO3c9NJscgZ1k7Djay15N1BTbuddF
         DVQ/n9+NyCjI4cUN8Sh3xfTibv1iHlO7tceR3I4pFpw9sHj7w3thqIGj9aptiKTTqdq8
         05dN5/GY9fAy+g/V6S7NWvxvNNEE/Ny5549hVW0S+0o1C9H0W8JYuaw7mjJ49WUNp0zJ
         a7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=73Sale5LxFM/yxo7Fn1QgtgDIZqW3zrHJYkiDAk7PN0=;
        b=KPO31uYLAYxDkcMzu62buu/SMOk7jrGf4/fIGsQ+GMLdNL8ZdcGEcStND0P2eSW4Yz
         vE4DYRosIZ8L3P49m4BNtq6udZ1X7X++ZKAdDGv1VzdD5aEf9YxLSV1hktC2s3UVhI0p
         zieOQFQ3t+27IZ2GPcMIQsBWgm3jzAismi5lE+A52iIfhnQzm0uR8dcnOIDTiXdjQp+D
         aDpKFfPyWwxfp/A1gBvsYyuPuVTc7tWQ5IvuBCTNhzhV7KJlvkO05/zsGck9+zaKGjJK
         XMJUX6gPibyD7Ujx6/Mc7nbEUTRl3mO4GVANqUCSoPU0VwGOxCOXlQUOa++QBPpVpnM2
         rwKg==
X-Gm-Message-State: AOAM532z+OymsMNIaU/KO3pRL36Fg5Kiu7YMEMWqkVhZCrGke5rO3Jt+
        6X20PlATzRk9PfeT9HxJi9UYmYBl3xfOY3uO82U=
X-Google-Smtp-Source: ABdhPJyXYRZelbxictMp4MoZghcuwoNWlA/jiwNRemFFY4YBoQ6EEQIRWycjMTzIfYu6CnQ1rhMiLTLLpJdm0uL/1Bo=
X-Received: by 2002:a4a:98c8:: with SMTP id b8mr15582918ooj.50.1643834393352;
 Wed, 02 Feb 2022 12:39:53 -0800 (PST)
MIME-Version: 1.0
References: <20220131105608.31380-1-cgzones@googlemail.com>
In-Reply-To: <20220131105608.31380-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 2 Feb 2022 15:39:42 -0500
Message-ID: <CAP+JOzS=VRws6GNqQxLGofNZMqqYy6=dnjCnsGfQYLe2Lsmcyw@mail.gmail.com>
Subject: Re: [PATCH] libsepol: do not add gaps to string list
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 1, 2022 at 11:31 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> When converting an ebitmap into a string list, skip potential gaps in
> ebitmap_to_strs(). All converting functions like strs_to_str(),
> strs_write_each() and strs_write_each_indented() do already skip NULL
> elements, but sorting such a list will lead to a NULL dereference.
>
>     #0 0x432ce5 in strcmp /src/llvm-project/compiler-rt/lib/sanitizer_com=
mon/sanitizer_common_interceptors.inc:462:25
>     #1 0x4f4893 in strs_cmp selinux/libsepol/src/kernel_to_common.c:258:9
>     #2 0x47b74b in qsort_r /src/llvm-project/compiler-rt/lib/sanitizer_co=
mmon/sanitizer_common_interceptors.inc:9994:7
>     #3 0x4f481d in strs_sort selinux/libsepol/src/kernel_to_common.c:266:=
2
>     #4 0x4fe781 in attrmap_to_str selinux/libsepol/src/kernel_to_conf.c:1=
560:2
>     #5 0x4fe781 in write_type_attribute_sets_to_conf selinux/libsepol/src=
/kernel_to_conf.c:1599:11
>     #6 0x4f8098 in sepol_kernel_policydb_to_conf selinux/libsepol/src/ker=
nel_to_conf.c:3182:7
>     #7 0x4e0277 in LLVMFuzzerTestOneInput selinux/libsepol/fuzz/binpolicy=
-fuzzer.c:50:9
>     #8 0x4d613b in main
>     #9 0x7fa2d50260b2 in __libc_start_main /build/glibc-eX1tMB/glibc-2.31=
/csu/libc-start.c:308:16
>     #10 0x41d4ed in _start
>
> Found by oss-fuzz (#44170)
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/kernel_to_common.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_com=
mon.c
> index 9f5400c9..dc9e689e 100644
> --- a/libsepol/src/kernel_to_common.c
> +++ b/libsepol/src/kernel_to_common.c
> @@ -366,6 +366,9 @@ int ebitmap_to_strs(struct ebitmap *map, struct strs =
*strs, char **val_to_name)
>         int rc;
>
>         ebitmap_for_each_positive_bit(map, node, i) {
> +               if (!val_to_name[i])
> +                       continue;
> +
>                 rc =3D strs_add(strs, val_to_name[i]);
>                 if (rc !=3D 0) {
>                         return -1;
> --
> 2.34.1
>
