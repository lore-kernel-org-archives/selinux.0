Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFD4C433F5
	for <selinux@archiver.kernel.org>; Wed, 15 Dec 2021 17:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbhLORjZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Dec 2021 12:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235513AbhLORjZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Dec 2021 12:39:25 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26BAC06173F
        for <selinux@vger.kernel.org>; Wed, 15 Dec 2021 09:39:24 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id x43-20020a056830246b00b00570d09d34ebso25827619otr.2
        for <selinux@vger.kernel.org>; Wed, 15 Dec 2021 09:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=azU4A59ZKQfEam9ULIhU8U6ECETK9dHJYSQwHaVAyaM=;
        b=Qpg8BS4l81dtQMq5jrWmSdGkGmcCLUz7jepmH5C30t5cAupVfPU4qDxquzfyYrPiwn
         tYj8WhjVBANxjmOTZWdD56zSfdGl5EDruxeL9xPGlsdgUm33ziD0BVzMqCMEMNID04C9
         31iYWlIRuzHSKF6/joUjdylB3tImDeLdI5TCePUfRWRLL6bdQVG7Anr4y3VenZoW/rzz
         H1cd6miqQSym3MRdl6KU17DAUd/RIzZJfQBCkQjjLTsVrgfo+dggGgxP+BOQcoV9GmgT
         4dHqjscS643W55gNIgRI505XhOUMvDfc0JJ+0CxJbjKYgFtMtP7PTOW/7omgIOFr711B
         Vhfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=azU4A59ZKQfEam9ULIhU8U6ECETK9dHJYSQwHaVAyaM=;
        b=ArJMROJKD5NVho/xav3mXL+6lQpdTa8TW2P7vMLbXw0ur37YYQ8Qu6JqIH7IvPCa3P
         woTYKdqtd2atWVP2G2aj8QZgKFcu6bvQAwn4PxibAbEyinEnXyTCooaGZLFXeMT/El58
         RI2gEPVNKaCHfK9hTB0W36ttRJTxFjxWMz6MuEwfFakZkUYlWKcgiqN2n41q0bUMfftg
         Xbzvccu5BD4QZMRD+YYIn1ur4HQp7rIOq5n47Oh+wmhxtxG4+KWoBFmNq/gkHqmsUCgO
         TValc8QVCaKIAcW4qc0SER5m+u9mVFGBBVbbVpK8LFVr16lSXLBO66IELBWgQuMwwQzt
         2zeQ==
X-Gm-Message-State: AOAM531eRCqQvILMLmuYKXSCqlUyJkzgQgyXJJLOVRhSPqK0EGaL9PuF
        JHZmRsm+rd/dTGJxvep5QiFtHugh8cJDv1L8k9Pe5OAM
X-Google-Smtp-Source: ABdhPJyHhepaHkWuAbLWEVOMlmozqA3dwP5JIYiGxqAhjTLIGl8LzPzCt2W7KPoVHBko6sXWp2wctC8BXdoFHea+10A=
X-Received: by 2002:a9d:70d4:: with SMTP id w20mr9639923otj.154.1639589963803;
 Wed, 15 Dec 2021 09:39:23 -0800 (PST)
MIME-Version: 1.0
References: <20211105154542.38434-1-cgzones@googlemail.com>
 <20211209164928.87459-1-cgzones@googlemail.com> <20211209164928.87459-12-cgzones@googlemail.com>
In-Reply-To: <20211209164928.87459-12-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 15 Dec 2021 12:39:12 -0500
Message-ID: <CAP+JOzTqe2dU4M3WDfSJjbebenO2BEn-R+_Q0CS9iU0FWK3r_A@mail.gmail.com>
Subject: Re: [PATCH v3 11/36] libsepol: enforce avtab item limit
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Dec 9, 2021 at 2:07 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Check the current item count does not exceed the maximum allowed to
> avoid stack overflows.
>
>     =3D=3D33660=3D=3DERROR: AddressSanitizer: stack-buffer-overflow on ad=
dress 0x7fa64b8fc070 at pc 0x0000005acba0 bp 0x7ffc1f0b2870 sp 0x7ffc1f0b28=
68
>     READ of size 4 at 0x7fa64b8fc070 thread T0
>         #0 0x5acb9f in avtab_read_item ./libsepol/src/avtab.c:507:18
>         #1 0x5acec4 in avtab_read ./libsepol/src/avtab.c:611:8
>         #2 0x576ae3 in policydb_read ./libsepol/src/policydb.c:4433:7
>         #3 0x55a1fe in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolicy-f=
uzzer.c:24:6
>         #4 0x45aed3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char cons=
t*, unsigned long) fuzzer.o
>         #5 0x446a12 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, u=
nsigned long) fuzzer.o
>         #6 0x44c93b in fuzzer::FuzzerDriver(int*, char***, int (*)(unsign=
ed char const*, unsigned long)) fuzzer.o
>         #7 0x475dd2 in main (./out/binpolicy-fuzzer+0x475dd2)
>         #8 0x7fa64cc867ec in __libc_start_main csu/../csu/libc-start.c:33=
2:16
>         #9 0x423689 in _start (./out/binpolicy-fuzzer+0x423689)
>
>     Address 0x7fa64b8fc070 is located in stack of thread T0 at offset 112=
 in frame
>         #0 0x5aabdf in avtab_read_item ./libsepol/src/avtab.c:437
>
>       This frame has 6 object(s):
>         [32, 33) 'buf8' (line 438)
>         [48, 56) 'buf16' (line 439)
>         [80, 112) 'buf32' (line 440) <=3D=3D Memory access at offset 112 =
overflows this variable
>         [144, 152) 'key' (line 441)
>         [176, 192) 'datum' (line 442)
>         [208, 244) 'xperms' (line 443)
>     HINT: this may be a false positive if your program uses some custom s=
tack unwind mechanism, swapcontext or vfork
>           (longjmp and C++ exceptions *are* supported)
>     SUMMARY: AddressSanitizer: stack-buffer-overflow ./libsepol/src/avtab=
.c:507:18 in avtab_read_item
>     Shadow bytes around the buggy address:
>       0x0ff5497177b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>       0x0ff5497177c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>       0x0ff5497177d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>       0x0ff5497177e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>       0x0ff5497177f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>     =3D>0x0ff549717800: f1 f1 f1 f1 01 f2 00 f2 f2 f2 00 00 00 00[f2]f2
>       0x0ff549717810: f2 f2 00 f2 f2 f2 00 00 f2 f2 00 00 00 00 04 f3
>       0x0ff549717820: f3 f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
>       0x0ff549717830: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>       0x0ff549717840: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>       0x0ff549717850: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>     Shadow byte legend (one shadow byte represents 8 application bytes):
>       Addressable:           00
>       Partially addressable: 01 02 03 04 05 06 07
>       Heap left redzone:       fa
>       Freed heap region:       fd
>       Stack left redzone:      f1
>       Stack mid redzone:       f2
>       Stack right redzone:     f3
>       Stack after return:      f5
>       Stack use after scope:   f8
>       Global redzone:          f9
>       Global init order:       f6
>       Poisoned by user:        f7
>       Container overflow:      fc
>       Array cookie:            ac
>       Intra object redzone:    bb
>       ASan internal:           fe
>       Left alloca redzone:     ca
>       Right alloca redzone:    cb
>     =3D=3D33660=3D=3DABORTING
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> v3:
>    take zero based numbering of variable items into account
> ---
>  libsepol/src/avtab.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
> index 46e1e75d..e9b17664 100644
> --- a/libsepol/src/avtab.c
> +++ b/libsepol/src/avtab.c
> @@ -503,6 +503,12 @@ int avtab_read_item(struct policy_file *fp, uint32_t=
 vers, avtab_t * a,
>
>                 for (i =3D 0; i < ARRAY_SIZE(spec_order); i++) {
>                         if (val & spec_order[i]) {
> +                               if (items >=3D items2) {
> +                                       ERR(fp->handle,
> +                                           "entry has too many items (%d=
/%d)",
> +                                           items + /* zero based numbere=
d */ 1, items2);

I do not like comments in the middle of an expression. I will fix this
when I apply the series.
Jim


> +                                       return -1;
> +                               }
>                                 key.specified =3D spec_order[i] | enabled=
;
>                                 datum.data =3D le32_to_cpu(buf32[items++]=
);
>                                 rc =3D insertf(a, &key, &datum, p);
> --
> 2.34.1
>
