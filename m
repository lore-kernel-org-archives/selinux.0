Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC7AC433EF
	for <selinux@archiver.kernel.org>; Wed, 13 Oct 2021 15:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 455A2610CF
	for <selinux@archiver.kernel.org>; Wed, 13 Oct 2021 15:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbhJMPrN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Oct 2021 11:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235222AbhJMPqm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Oct 2021 11:46:42 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69C7C061570
        for <selinux@vger.kernel.org>; Wed, 13 Oct 2021 08:44:38 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id x33-20020a9d37a4000000b0054733a85462so4197066otb.10
        for <selinux@vger.kernel.org>; Wed, 13 Oct 2021 08:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LzmFDcdwK2bVSBtnM4eUm3emXd1LdBfm5uvpnTRsLHo=;
        b=ZJZKndeN4g2I+mI94r/OmTpHdZw4TW0exBDWtzwXiR5FUpFjBBDviPyvgDMqfzKXZq
         3TwYXuxmn34IL/IUA79Wmnr5y3CjKNzyH8dWw8efSoQQXMo+OmcsVq/ZO+sIuDc331u5
         oCqALYT3NHsey1u783BjPsDXuf3hTz9AXcJSdTY0bUWqiBayEar5MiCJa2fIWUpdqiyu
         8qSRMN0f5vOme/ibpY5c22CqpA8FTJOI4HjM7bXIxyBpNiq0H/+Af1/VmiwIZL9yM1A7
         fIUny7caUrtK63lHx7PDHRbl3RmPnQsLv53yMuoaT6ysKJ6yFy9oUDtYdPvoYkIn9XU4
         CLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LzmFDcdwK2bVSBtnM4eUm3emXd1LdBfm5uvpnTRsLHo=;
        b=ZVdVxyL9DBMLY36uN7LsnTjJx4l4ofMbE/XeC1ap2g5TTp1yNQ5ww7RVjRCUv2JFoV
         ni6R31Xo6zIPjDHwYVVP7aZnqPgezdTeuspjU8xXHnyXsFMl1BtwMVkT75MK0VfV4X9h
         VBdFWA7qZGTiC2H/tRe8QCcl5kRo9vXy6x6r+HF6O9N8kPaDzKVSox4dNhajlQUtysFX
         G25m26+EsXo9Afno6afqEJjtiC0KQtQJ4YtdpNz6GK4jFHQqNBuRUC6w0wKqcpeNo8zD
         BM9pCLf3qZvoZt6YogutchivI/+681ifzhX+LCCOkg6D01LeeTxGPrHF9qTPsiNo/k2/
         wyYw==
X-Gm-Message-State: AOAM5329I7gXDiuFaTP25RlSDm6v7OtAih/DbXS0OWeUdMb8cpUABizQ
        rRt/NoyKDmbIXVS8cx59LPmCKp8WEQNF0TjcDusCx55H
X-Google-Smtp-Source: ABdhPJx71EtWXVKF7DaCS0ssPacdME9PxkcK+lBkjkN8gq5APv8OHPUZv4xnfdJJ0b5irCdHGML5uacGXPov5p95PAE=
X-Received: by 2002:a9d:7182:: with SMTP id o2mr9526266otj.53.1634139878093;
 Wed, 13 Oct 2021 08:44:38 -0700 (PDT)
MIME-Version: 1.0
References: <20211011162533.53404-1-cgzones@googlemail.com> <20211011162533.53404-28-cgzones@googlemail.com>
In-Reply-To: <20211011162533.53404-28-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 13 Oct 2021 11:44:26 -0400
Message-ID: <CAP+JOzQN7F-u4UdFcN_KZHGqdLxRC+mX87XoxgeJNPYZk_bU7w@mail.gmail.com>
Subject: Re: [RFC PATCH 27/35] libsepol: validate type of avtab type rules
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
>     =3D=3D80903=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on add=
ress 0x6020000005c0 at pc 0x0000005696c8 bp 0x7ffdb11ea560 sp 0x7ffdb11ea55=
8
>     READ of size 8 at 0x6020000005c0 thread T0
>         #0 0x5696c7 in avtab_node_to_str ./libsepol/src/kernel_to_conf.c:=
1736:9
>         #1 0x569013 in map_avtab_write_helper ./libsepol/src/kernel_to_co=
nf.c:1767:10
>         #2 0x5ab837 in avtab_map ./libsepol/src/avtab.c:347:10
>         #3 0x561f9a in write_avtab_flavor_to_conf ./libsepol/src/kernel_t=
o_conf.c:1798:7
>         #4 0x561f9a in write_avtab_to_conf ./libsepol/src/kernel_to_conf.=
c:1819:8
>         #5 0x55afba in sepol_kernel_policydb_to_conf ./libsepol/src/kerne=
l_to_conf.c:3159:7
>         #6 0x55a34f in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolicy-f=
uzzer.c:38:9
>         #7 0x45aed3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char cons=
t*, unsigned long) fuzzer.o
>         #8 0x446a12 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, u=
nsigned long) fuzzer.o
>         #9 0x44c93b in fuzzer::FuzzerDriver(int*, char***, int (*)(unsign=
ed char const*, unsigned long)) fuzzer.o
>         #10 0x475dd2 in main (./out/binpolicy-fuzzer+0x475dd2)
>         #11 0x7f97a83fd7ec in __libc_start_main csu/../csu/libc-start.c:3=
32:16
>         #12 0x423689 in _start (./out/binpolicy-fuzzer+0x423689)
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libsepol/src/policydb_validate.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index f0456583..9134e541 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -505,15 +505,22 @@ bad:
>         return -1;
>  }
>
> -static int validate_avtab_key_wrapper(avtab_key_t *k,  __attribute__ ((u=
nused)) avtab_datum_t *d, void *args)
> +static int validate_avtab(avtab_key_t *k, avtab_datum_t *d, void *args)
>  {

I don't like the function name (not that I liked the old one either).
I think validate_avtab_key_and_datum() would be better.

>         validate_t *flavors =3D (validate_t *)args;
> -       return validate_avtab_key(k, flavors);
> +
> +       if (validate_avtab_key(k, flavors))
> +               return -1;
> +
> +       if ((k->specified & AVTAB_TYPE) && validate_value(d->data, &flavo=
rs[SYM_TYPES]))
> +               return -1;
> +
> +       return 0;
>  }
>
> -static int validate_avtab(sepol_handle_t *handle, avtab_t *avtab, valida=
te_t flavors[])
> +static int validate_avtabs(sepol_handle_t *handle, avtab_t *avtab, valid=
ate_t flavors[])

I don't like this function name at all, because only one avtab is
being checked. With the name change for the function above, you can
leave this as validate_avtab().

Everything else about this patch looks good.

Thanks,
Jim

>  {
> -       if (avtab_map(avtab, validate_avtab_key_wrapper, flavors)) {
> +       if (avtab_map(avtab, validate_avtab, flavors)) {
>                 ERR(handle, "Invalid avtab");
>                 return -1;
>         }
> @@ -845,7 +852,7 @@ int validate_policydb(sepol_handle_t *handle, policyd=
b_t *p)
>                 goto bad;
>
>         if (p->policy_type =3D=3D POLICY_KERN) {
> -               if (validate_avtab(handle, &p->te_avtab, flavors))
> +               if (validate_avtabs(handle, &p->te_avtab, flavors))
>                         goto bad;
>                 if (p->policyvers >=3D POLICYDB_VERSION_BOOL)
>                         if (validate_cond_list(handle, p->cond_list, flav=
ors))
> --
> 2.33.0
>
