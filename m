Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23BDC433F5
	for <selinux@archiver.kernel.org>; Mon,  3 Jan 2022 18:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235241AbiACSKd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Jan 2022 13:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235234AbiACSKc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Jan 2022 13:10:32 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D218C061761
        for <selinux@vger.kernel.org>; Mon,  3 Jan 2022 10:10:32 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id o3-20020a9d4043000000b0058f31f4312fso42323512oti.1
        for <selinux@vger.kernel.org>; Mon, 03 Jan 2022 10:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MqXIXgU1qDWC+awW6KTyBkl4SOzOa2wyDbms0ZdHnRs=;
        b=FMPcn6qhi23LPK2TadOixwphn6SujSzO81z3JaneNSlZ0YCtF32ilBRn+xQzDHF8Lp
         37dt/t/KUzFpNIm9HV7kZ8chG96hjUjrh8hfIqMdcpGcymlaG2XTyDL7zlsFWERiDM/a
         YVBrCgaCfgDPEai3Sr7GUsl6eWlaMjMk3xROXcci5XZ3X/kAWkX254xVm6iGwaOEzZGO
         mk9vq6ssP9QKOsjzRdib3dyexpFUmv4epIJ6lUmUP/9Q30kJIQ1lUV5KKasM9T4F1wkt
         d3RlhmYfSMg7ePa5U0JmdxwQeEvXKyKn9902l2b0cn0OELuzZOi/kxOyfU7zJ5mmJBTt
         SkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MqXIXgU1qDWC+awW6KTyBkl4SOzOa2wyDbms0ZdHnRs=;
        b=s8jaSjuES0quH4xCQDUhHz5BlE7zd7P3D0EDGQsKuCUT4sDBvvKf/gFNIz2HvbsFVu
         6LBnQdQse5QMEJoUdACqtUEljHelG0blNjwHie9hpnHac0svbeMBnBF8oapdJlmK1z5d
         DgpEDu78lgtxnXzZBfGiHLTA0qkL/b+8P7iMJnqMd7mjtjg5UHi0tHyamPHrO/wJKTea
         zAjnn4jK3SajSnX7O4YDfqq5F12jf01TuKJHhiTnirxsvl8EDKrRVgaR5DgiNJ/Emlmj
         jJn0dibkzr5YEGFgZq+VLA2FCWcF9v/Me69vQd7Rb73ookgRzPuqJGzZoXehhpSagtky
         6Nwg==
X-Gm-Message-State: AOAM530ziMiG1sp3iTY1vanfcXnACumWaStP9lVsyAT9ilWC3BbCSeqa
        RdeLpiU+ujsdSjntljTiij+XWC0JhYc0+h6B8vk=
X-Google-Smtp-Source: ABdhPJxoWb9McZ1x0LlAe/0o703mHj4tJBVWINNha85+6ayY0+9V2nMtWaU5+PumpuV7BXKpOnTVkwkH0+HqbipzbZ8=
X-Received: by 2002:a05:6830:4094:: with SMTP id x20mr33533492ott.53.1641233431677;
 Mon, 03 Jan 2022 10:10:31 -0800 (PST)
MIME-Version: 1.0
References: <20211223185004.77862-1-cgzones@googlemail.com>
In-Reply-To: <20211223185004.77862-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 3 Jan 2022 13:10:20 -0500
Message-ID: <CAP+JOzS0SbxgcUdK9EcM4raFoGd2iPuy1tpf=JQyZHRa2Fg4qw@mail.gmail.com>
Subject: Re: [PATCH] libsepol: handle type gaps when optimizing
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Dec 24, 2021 at 8:10 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> For policy versions between 20 and 23 the type_val_to_struct array might
> contain gaps. Skip those gaps to avoid NULL pointer dereferences:
>
>     =3D=3D1250=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x00=
0000000008 (pc 0x00000058560b bp 0x7ffdca60c110 sp 0x7ffdca60bfc0 T0)
>     =3D=3D1250=3D=3DThe signal is caused by a READ memory access.
>     =3D=3D1250=3D=3DHint: address points to the zero page.
>         #0 0x58560b in build_type_map selinux/libsepol/src/optimize.c:107=
:33
>         #1 0x58560b in policydb_optimize selinux/libsepol/src/optimize.c:=
441:13
>         #2 0x55e63e in LLVMFuzzerTestOneInput selinux/libsepol/fuzz/binpo=
licy-fuzzer.c:42:10
>         #3 0x455283 in fuzzer::Fuzzer::ExecuteCallback(unsigned char cons=
t*, unsigned long) cxa_noexception.cpp:0
>         #4 0x440ec2 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, u=
nsigned long) /src/llvm-project/compiler-rt/lib/fuzzer/FuzzerDriver.cpp:324=
:6
>         #5 0x44671c in fuzzer::FuzzerDriver(int*, char***, int (*)(unsign=
ed char const*, unsigned long)) cxa_noexception.cpp:0
>         #6 0x46f522 in main /src/llvm-project/compiler-rt/lib/fuzzer/Fuzz=
erMain.cpp:20:10
>         #7 0x7f9c160d00b2 in __libc_start_main /build/glibc-eX1tMB/glibc-=
2.31/csu/libc-start.c:308:16
>         #8 0x41f67d in _start
>
> Found by oss-fuzz (#42697)
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libsepol/src/optimize.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/libsepol/src/optimize.c b/libsepol/src/optimize.c
> index 8a048702..678d22bd 100644
> --- a/libsepol/src/optimize.c
> +++ b/libsepol/src/optimize.c
> @@ -104,6 +104,10 @@ static struct type_vec *build_type_map(const policyd=
b_t *p)
>                 if (type_vec_init(&map[i]))
>                         goto err;
>
> +               /* Gap in types for policy versions between 20 and 23 */
> +               if (!p->type_val_to_struct[i])
> +                       continue;
> +
>                 if (p->type_val_to_struct[i]->flavor !=3D TYPE_ATTRIB) {
>                         ebitmap_for_each_positive_bit(&p->type_attr_map[i=
],
>                                                       n, k) {
> @@ -114,11 +118,17 @@ static struct type_vec *build_type_map(const policy=
db_t *p)
>                         ebitmap_t *types_i =3D &p->attr_type_map[i];
>
>                         for (k =3D 0; k < p->p_types.nprim; k++) {
> -                               ebitmap_t *types_k =3D &p->attr_type_map[=
k];
> +                               ebitmap_t *types_k;
> +
> +                               /* Gap in types for policy versions betwe=
en 20 and 23 */
> +                               if (!p->type_val_to_struct[k])
> +                                       continue;
>
>                                 if (p->type_val_to_struct[k]->flavor !=3D=
 TYPE_ATTRIB)
>                                         continue;
>
> +                               types_k =3D &p->attr_type_map[k];
> +
>                                 if (ebitmap_contains(types_k, types_i)) {
>                                         if (type_vec_append(&map[i], k))
>                                                 goto err;
> --
> 2.34.1
>

Before policy version 20, there are no attributes, so I think that a
check should be made in policydb_optimize() for a version less than 24
and just exit with an error there with an error message.

Policy version 23 has not been the latest for more than 10 years.

Thanks,
Jim
