Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1587CC433F5
	for <selinux@archiver.kernel.org>; Wed, 13 Oct 2021 15:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1A8C610A0
	for <selinux@archiver.kernel.org>; Wed, 13 Oct 2021 15:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhJMPnY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Oct 2021 11:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbhJMPnY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Oct 2021 11:43:24 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79CAC061570
        for <selinux@vger.kernel.org>; Wed, 13 Oct 2021 08:41:20 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id n63so4370144oif.7
        for <selinux@vger.kernel.org>; Wed, 13 Oct 2021 08:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vZbUSJ34kkGm16C8A+Z+EQmDK1dQFebvRCXGvqss9ac=;
        b=XxcY9GucaCeZio/Ggzx41eORzYNoRLe95nqfDGREBflVe4e+yJJ+/ZgX22PNoku57R
         A8eWLYvHz3nA4S18LLdTkc0zTSRBrJ+rbm+ZWLJC210+UuCy6dzpOFKoxnwdSjprZFdF
         1X3YYiZd1naoR5TC/h+8/A0Wj3zS8GGRQedrqqbf8liUzCbDiW/LoMypL641BfUsGYbx
         4X9+ul7OrVQNSjv2XNGUTHzTyv7hN5S+jjZg73Y3PimTDXs+sYyIkxzo6ohCvuzyuKoT
         y1ptpt9lnixP7OXru1wxs8b1ymOLo/9lUEQ4fPPKyZKsXTNTadKXnn3To1bKKfX15qZT
         D02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vZbUSJ34kkGm16C8A+Z+EQmDK1dQFebvRCXGvqss9ac=;
        b=6Xw75LXE6ylFDB8vkRZqWkUM9Rq1lwkU4jt+0eeaqYAoP6KNAw3DdIYU0qIwV+i3jg
         CyeAFL2FbRJElHuvKCMLIRUEp8v/++YWmKy4edrB330ClFNhl6kcm/f8pubfWEwzjQ5j
         aXbd0ecGwMNg37fhrM95yoQhkrfAzaWro5BFNn9pVQeuXCHQl49GNeBgZ94eL48Utmtv
         cBe0LTitF5YhFqogHmJ5Yb2ydn23fYfw+753SWh3RPgo8SAUA0M8R0PJ4xCVga5x5U8j
         H7C+seWCUGI+upbh+g683EwUc5MEDu6+uVzuEVTyMIDgDqWyN2dO8XfM40iec9EO0rvg
         BBLQ==
X-Gm-Message-State: AOAM533NaONc+/M5kA0RNK4Pm/vOLAmDBIOmRzdKkS2m7CdlG/6Riqye
        RS3Csqrq9J+F2tRPhxA+vlGIHNha7lGoZHDtS8HDmHR1
X-Google-Smtp-Source: ABdhPJzZhoOgo0kJFS9q6OnKvpmDWIatQip4jIZLOInqu75VXit/OFKJCq/vJIKD25XqrlH+H6YcihdSKuhROMpBFSA=
X-Received: by 2002:aca:f189:: with SMTP id p131mr8827359oih.128.1634139680181;
 Wed, 13 Oct 2021 08:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <20211011162533.53404-1-cgzones@googlemail.com> <20211011162533.53404-23-cgzones@googlemail.com>
In-Reply-To: <20211011162533.53404-23-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 13 Oct 2021 11:41:09 -0400
Message-ID: <CAP+JOzT_FRxoQpEQqVjrYc9THtBd2hES02SzpA3F4NF-kmV0+A@mail.gmail.com>
Subject: Re: [RFC PATCH 22/35] libsepol: validate permission count of classes
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 11, 2021 at 12:41 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Check a class has not more than the supported 32 permissions.
>
>     =3D=3D28413=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x0=
00000000000 (pc 0x7f74ec3341a3 bp 0x7ffd0b7e5030 sp 0x7ffd0b7e47e8 T0)
>     =3D=3D28413=3D=3DThe signal is caused by a READ memory access.
>     =3D=3D28413=3D=3DHint: address points to the zero page.
>         #0 0x7f74ec3341a3  string/../sysdeps/x86_64/multiarch/../strchr.S=
:32
>         #1 0x4bfc78 in strchr (./out/binpolicy-fuzzer+0x4bfc78)
>         #2 0x55b7f2 in class_constraint_rules_to_strs ./libsepol/src/kern=
el_to_conf.c:288:7
>         #3 0x55b7f2 in constraint_rules_to_strs ./libsepol/src/kernel_to_=
conf.c:364:9
>         #4 0x55ac80 in sepol_kernel_policydb_to_conf ./libsepol/src/kerne=
l_to_conf.c:3071:7
>         #5 0x55a34f in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolicy-f=
uzzer.c:38:9
>         #6 0x45aed3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char cons=
t*, unsigned long) fuzzer.o
>         #7 0x446a12 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, u=
nsigned long) fuzzer.o
>         #8 0x44c93b in fuzzer::FuzzerDriver(int*, char***, int (*)(unsign=
ed char const*, unsigned long)) fuzzer.o
>         #9 0x475dd2 in main (./out/binpolicy-fuzzer+0x475dd2)
>         #10 0x7f74ec2be7ec in __libc_start_main csu/../csu/libc-start.c:3=
32:16
>         #11 0x423689 in _start (./out/binpolicy-fuzzer+0x423689)
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libsepol/src/policydb_validate.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index c9700399..7ec0675c 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -203,6 +203,8 @@ static int validate_class_datum(sepol_handle_t *handl=
e, class_datum_t *class, va
>                 goto bad;
>         if (validate_constraint_nodes(handle, class->validatetrans, flavo=
rs))
>                 goto bad;
> +       if (class->permissions.nprim > PERM_SYMTAB_SIZE)
> +               goto bad;
>

This is good, but it also needs to be done for commons. See comments
for patch 13.

Thanks,
Jim


>         return 0;
>
> --
> 2.33.0
>
