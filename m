Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D53C433EF
	for <selinux@archiver.kernel.org>; Wed, 13 Oct 2021 14:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9D7961027
	for <selinux@archiver.kernel.org>; Wed, 13 Oct 2021 14:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbhJMOMe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Oct 2021 10:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhJMOMd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Oct 2021 10:12:33 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCD2C061570
        for <selinux@vger.kernel.org>; Wed, 13 Oct 2021 07:10:30 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id n64so4017303oih.2
        for <selinux@vger.kernel.org>; Wed, 13 Oct 2021 07:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d5ooUKKRjHeXp658AQBwSEZ56AS3uJV/saZJxo1ZpAw=;
        b=kJzgFdgfox1BGDz2pVR28x/hMPEqgrlcezojWLUGObm+CVekj0LCbANB5ALlaH+Iso
         NVSfYBtkTKQi5qJG1H7tXqUx8ljhg5Vjhu7IQBP8As49uZKr1IYBkOpDNPiYxso6YMb2
         WWNSilRKFWbf2TwgMTrtF6Z3CtkGEQam19at2bhqN11K2wtfn77mEdc2IRvSKGew+TyO
         4VQztUFYXzKT0zyq+g3Cnvjs9YwyHruavmaZtAV0fsMvkcS9dvcDq/h/JeyWhAWEOu7h
         MFLeD06C+b2IFnQDRLztuqMXgp5UCdz7HRvVPtpAutUpnZulz4nmPCiB0nMrvhLSiEAw
         7Lsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d5ooUKKRjHeXp658AQBwSEZ56AS3uJV/saZJxo1ZpAw=;
        b=qWP0tOYnBgebAlHGPSOQMto0E4dI60i2hqt9t+GeqmybYZAhehim2ba7dsrGK/wzLO
         8rGP+ULCuio/GhCI+aE+wkxdRKus/YzSIyNPEzd9Sdhjd9BFwQZCOarwopKw3tSqn3hX
         nzdSJ1lMDCTEv7TXMYyD3n0xEYOIaK8syUmUHdtR957yBuzidwVcBNvysrgJkFW1Lgml
         2zRTpN2FBHyobDyyWlqw8xBbiYt1GmJ8VaXBj0g0l/tKg1ljbB2xuAYsgyt0SOvbYYnO
         XD8/q2AyGQc1xEjcImoK3RjxwTlMnWokgKqM5NaYy/lmlI3aw1A6jLweWmYzpgr/JNjC
         HK7g==
X-Gm-Message-State: AOAM533Ab5ieMi+q/AEBREe3zzXl5AOC3q/Nc8vszRSZPwE1ftjLCAe9
        AQhGMDsHjTs1zzcnVOZG+2vf73bbenf/+FyCPfny1fkV
X-Google-Smtp-Source: ABdhPJznXJI3lumXt69IBiyz30Ch6a6Md4Ik0Db1ga6mjar9fnzP41vS+FV/ax9lsYchjUApXZDqaDF1yeB5hVHn3Qc=
X-Received: by 2002:aca:c288:: with SMTP id s130mr8358465oif.138.1634134230070;
 Wed, 13 Oct 2021 07:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <20211011162533.53404-1-cgzones@googlemail.com> <20211011162533.53404-13-cgzones@googlemail.com>
In-Reply-To: <20211011162533.53404-13-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 13 Oct 2021 10:10:19 -0400
Message-ID: <CAP+JOzSsiuSqgLdebsrTgNyqFEXAeEJCcCneisJ1JVzpcuPP8w@mail.gmail.com>
Subject: Re: [RFC PATCH 12/35] libsepol: clean memory on conditional read failure
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
> Free the local access vector list on failure as it does not get moved
> into the policy structure.
>
>     Direct leak of 16 byte(s) in 1 object(s) allocated from:
>         #0 0x52596d in malloc (./out/binpolicy-fuzzer+0x52596d)
>         #1 0x5b30d2 in cond_insertf ./libsepol/src/conditional.c:682:9
>         #2 0x5ac218 in avtab_read_item ./libsepol/src/avtab.c:583:10
>         #3 0x5b21f4 in cond_read_av_list ./libsepol/src/conditional.c:725=
:8
>         #4 0x5b21f4 in cond_read_node ./libsepol/src/conditional.c:798:7
>         #5 0x5b21f4 in cond_read_list ./libsepol/src/conditional.c:847:7
>         #6 0x576b6e in policydb_read ./libsepol/src/policydb.c:4436:8
>         #7 0x55a1fe in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolicy-f=
uzzer.c:24:6
>         #8 0x45aed3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char cons=
t*, unsigned long) fuzzer.o
>         #9 0x446a12 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, u=
nsigned long) fuzzer.o
>         #10 0x44c93b in fuzzer::FuzzerDriver(int*, char***, int (*)(unsig=
ned char const*, unsigned long)) fuzzer.o
>         #11 0x475dd2 in main (./out/binpolicy-fuzzer+0x475dd2)
>         #12 0x7f47abeb87ec in __libc_start_main csu/../csu/libc-start.c:3=
32:16
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libsepol/src/conditional.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c
> index 9a10aae1..50cb5395 100644
> --- a/libsepol/src/conditional.c
> +++ b/libsepol/src/conditional.c
> @@ -724,8 +724,10 @@ static int cond_read_av_list(policydb_t * p, void *f=
p,
>         for (i =3D 0; i < len; i++) {
>                 rc =3D avtab_read_item(fp, p->policyvers, &p->te_cond_avt=
ab,
>                                      cond_insertf, &data);
> -               if (rc)
> +               if (rc) {
> +                       cond_av_list_destroy(data.head);
>                         return rc;
> +               }
>
>         }
>
> --
> 2.33.0
>

Please remove the cond_av_list_destroy() call in cond_insertf(). That
won't be needed with it being called here.

Jim
