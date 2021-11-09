Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026D1C433F5
	for <selinux@archiver.kernel.org>; Tue,  9 Nov 2021 18:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E06D761184
	for <selinux@archiver.kernel.org>; Tue,  9 Nov 2021 18:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242894AbhKITBs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Nov 2021 14:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242886AbhKITBr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Nov 2021 14:01:47 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164B7C061764
        for <selinux@vger.kernel.org>; Tue,  9 Nov 2021 10:59:01 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id be32so396285oib.11
        for <selinux@vger.kernel.org>; Tue, 09 Nov 2021 10:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v4OBs9AuKaKcTm19A8bHH2zy7ZehSDCwT1tFQEH8xGI=;
        b=EB2jYK9kYMBj/Ffklb0B6Nk9AftL7ND4Z2V3VW/M8VuptHHOG586VVkx1+dEd2UlUj
         8qO7ng/f/8VVWM3NzgFg7zbV2bBbmfjUAVJsci+PSvGR+/6hCxG1snyF1t0TwFFL9d+F
         YfENXS5c9AEDqCoOvNQM+ow7cphnyDbGZQBauqInm7Qhi+rLvTeasgDvzYBB0s8V03re
         5LhgS0yoxsySMAp1gWKk1Z3mUvZzCF0vud4O0sVK8tSM6JAIl8LNCIS9MfqWryHba7G3
         SOfLVqAi1Lvcprzd05NCCaYDSpDJVNUaEQMslUJdJeWFK85g+WfQsN3FzWoWqEXafCpW
         hEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v4OBs9AuKaKcTm19A8bHH2zy7ZehSDCwT1tFQEH8xGI=;
        b=3SplB3pBEWn3fjpGGYwQEDBgbrJmXqW5/8MineO9pcbs2D2Ws7uyi1WZ5NlizJRSsE
         aSvEEN2Lid67FmMeN6kjtayOo50EYJLLae86CN37qpsxmQlJLykS/iIXFRvHCbVGBfgO
         ywRhf7j0mqEp2o6Rz/td671t33S+qH2mKuMEe7rKEqLW+x/3Yzgn0uj81cY0AehZptrD
         GyQr1v0PGXwJwmeHVfV5mC+MPUd10+uFbCi/jgZtqGDo8fMrFtfStyFOLLKju/3uY1+P
         w32b6qXp7IyUMxHT8gJ75WX4jUnQE0jH6m0QAgZeR4h9oaJEfoD1poYv+Sgn1K0ifq3W
         AFkw==
X-Gm-Message-State: AOAM533vV57uPdNfA64T+NG6ktNuLGkCSFI8+rTNgVzIe9AUAhImBImN
        vL7qSLVRYBWiQg/utJfDFNFMHxD9SjIcfVNH4Gc=
X-Google-Smtp-Source: ABdhPJxyqhGAJ78/DGpuK/izOZnXI8FNMkZMGbHgeN0JEvS6sMdtR9ejJlTGKoRBsasgZpj/5ZdIqqcGLLoyklnXutU=
X-Received: by 2002:aca:b745:: with SMTP id h66mr7783499oif.144.1636484340385;
 Tue, 09 Nov 2021 10:59:00 -0800 (PST)
MIME-Version: 1.0
References: <20211011162533.53404-1-cgzones@googlemail.com>
 <20211105154542.38434-1-cgzones@googlemail.com> <20211105154542.38434-11-cgzones@googlemail.com>
 <CAP+JOzRwY9E1b_sEdgJe3Y_A+GXNZeG92EYK2a=bYFnJYUwJyw@mail.gmail.com>
In-Reply-To: <CAP+JOzRwY9E1b_sEdgJe3Y_A+GXNZeG92EYK2a=bYFnJYUwJyw@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Tue, 9 Nov 2021 19:58:49 +0100
Message-ID: <CAJ2a_DdmJusgsxXansov4MtUYAS_Jt+-d6ntXXeVFYDLBZxZsQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 10/36] libsepol: add checks for read sizes
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 9 Nov 2021 at 19:46, James Carter <jwcart2@gmail.com> wrote:
>
> On Fri, Nov 5, 2021 at 12:11 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Add checks for invalid read sizes from a binary policy to guard
> > allocations.
> >
> > The common and class permission counts needs to be limited more strict
> > otherwise a too high count of common or class permissions can lead to
> > permission values with a too high value, which can lead to overflows
> > in shift operations.
> >
> > In the fuzzer build the value will also be bounded to avoid oom reports=
.
> >
> >     =3D=3D29857=3D=3D ERROR: libFuzzer: out-of-memory (malloc(171798681=
60))
> >        To change the out-of-memory limit use -rss_limit_mb=3D<N>
> >
> >         #0 0x52dc61 in __sanitizer_print_stack_trace (./out/binpolicy-f=
uzzer+0x52dc61)
> >         #1 0x475618 in fuzzer::PrintStackTrace() fuzzer.o
> >         #2 0x458855 in fuzzer::Fuzzer::HandleMalloc(unsigned long) fuzz=
er.o
> >         #3 0x45876a in fuzzer::MallocHook(void const volatile*, unsigne=
d long) fuzzer.o
> >         #4 0x534557 in __sanitizer::RunMallocHooks(void const*, unsigne=
d long) (./out/binpolicy-fuzzer+0x534557)
> >         #5 0x4aa7d7 in __asan::Allocator::Allocate(unsigned long, unsig=
ned long, __sanitizer::BufferedStackTrace*, __asan::AllocType, bool) (./out=
/binpolicy-fuzzer+0x4aa7d7)
> >         #6 0x4aa143 in __asan::asan_malloc(unsigned long, __sanitizer::=
BufferedStackTrace*) (./out/binpolicy-fuzzer+0x4aa143)
> >         #7 0x5259cb in malloc (./out/binpolicy-fuzzer+0x5259cb)
> >         #8 0x580b5d in mallocarray ./libsepol/src/./private.h:93:9
> >         #9 0x57c2ed in scope_read ./libsepol/src/policydb.c:4120:7
> >         #10 0x576b0d in policydb_read ./libsepol/src/policydb.c:4462:9
> >         #11 0x55a214 in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolic=
y-fuzzer.c:26:6
> >         #12 0x45aed3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char c=
onst*, unsigned long) fuzzer.o
> >         #13 0x446a12 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*=
, unsigned long) fuzzer.o
> >         #14 0x44c93b in fuzzer::FuzzerDriver(int*, char***, int (*)(uns=
igned char const*, unsigned long)) fuzzer.o
> >         #15 0x475dd2 in main (./out/binpolicy-fuzzer+0x475dd2)
> >         #16 0x7ffad6e107ec in __libc_start_main csu/../csu/libc-start.c=
:332:16
> >         #17 0x423689 in _start (./out/binpolicy-fuzzer+0x423689)
> >
> >     =3D=3D19462=3D=3D ERROR: libFuzzer: out-of-memory (malloc(182536110=
08))
> >        To change the out-of-memory limit use -rss_limit_mb=3D<N>
> >
> >         #0 0x52dc61 in __sanitizer_print_stack_trace (./out/binpolicy-f=
uzzer+0x52dc61)
> >         #1 0x475618 in fuzzer::PrintStackTrace() fuzzer.o
> >         #2 0x458855 in fuzzer::Fuzzer::HandleMalloc(unsigned long) fuzz=
er.o
> >         #3 0x45876a in fuzzer::MallocHook(void const volatile*, unsigne=
d long) fuzzer.o
> >         #4 0x534557 in __sanitizer::RunMallocHooks(void const*, unsigne=
d long) (./out/binpolicy-fuzzer+0x534557)
> >         #5 0x4aa7d7 in __asan::Allocator::Allocate(unsigned long, unsig=
ned long, __sanitizer::BufferedStackTrace*, __asan::AllocType, bool) (./out=
/binpolicy-fuzzer+0x4aa7d7)
> >         #6 0x4aa999 in __asan::asan_calloc(unsigned long, unsigned long=
, __sanitizer::BufferedStackTrace*) (./out/binpolicy-fuzzer+0x4aa999)
> >         #7 0x525b63 in __interceptor_calloc (./out/binpolicy-fuzzer+0x5=
25b63)
> >         #8 0x570938 in policydb_index_others ./libsepol/src/policydb.c:=
1245:6
> >         #9 0x5771f3 in policydb_read ./src/policydb.c:4481:6
> >         #10 0x55a214 in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolic=
y-fuzzer.c:26:6
> >         #11 0x45aed3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char c=
onst*, unsigned long) fuzzer.o
> >         #12 0x446a12 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*=
, unsigned long) fuzzer.o
> >         #13 0x44c93b in fuzzer::FuzzerDriver(int*, char***, int (*)(uns=
igned char const*, unsigned long)) fuzzer.o
> >         #14 0x475dd2 in main (./out/binpolicy-fuzzer+0x475dd2)
> >         #15 0x7f4d933157ec in __libc_start_main csu/../csu/libc-start.c=
:332:16
> >         #16 0x423689 in _start (./out/binpolicy-fuzzer+0x423689)
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  libsepol/src/policydb.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> > index dcea1807..1408405d 100644
> > --- a/libsepol/src/policydb.c
> > +++ b/libsepol/src/policydb.c
> > @@ -2103,6 +2103,8 @@ static int common_read(policydb_t * p, hashtab_t =
h, struct policy_file *fp)
> >         if (symtab_init(&comdatum->permissions, PERM_SYMTAB_SIZE))
> >                 goto bad;
> >         comdatum->permissions.nprim =3D le32_to_cpu(buf[2]);
> > +       if (comdatum->permissions.nprim > 32)
>
> Should use PERM_SYMTAB_SIZE here (like in patch 22).

I thought about that, but it seemed a bit unrelated.
In patch 25 (https://patchwork.kernel.org/project/selinux/patch/20211105154=
542.38434-26-cgzones@googlemail.com/)
the number of permissions in commons and classes is checked against
the logical limit (which is imposed by the implementation via a bitset
on a 32 bit integer).
The check here is to prevent overflows on subsequent left-shifts by
the checked value on a 32 bit integer.
Maybe `sizeof(uint32_t)` is more expressive?
However I do not object your comment, so I fine to change to PERM_SYMTAB_SI=
ZE.

> > +               goto bad;
> >         nel =3D le32_to_cpu(buf[3]);
> >
> >         key =3D malloc(len + 1);
> > @@ -2251,6 +2253,8 @@ static int class_read(policydb_t * p, hashtab_t h=
, struct policy_file *fp)
> >         if (symtab_init(&cladatum->permissions, PERM_SYMTAB_SIZE))
> >                 goto bad;
> >         cladatum->permissions.nprim =3D le32_to_cpu(buf[3]);
> > +       if (cladatum->permissions.nprim > 32)
>
> Same here.
>
>
> > +               goto bad;
> >         nel =3D le32_to_cpu(buf[4]);
> >
> >         ncons =3D le32_to_cpu(buf[5]);
> > @@ -3980,6 +3984,8 @@ static int avrule_decl_read(policydb_t * p, avrul=
e_decl_t * decl,
> >                 if (rc < 0)
> >                         return -1;
> >                 nprim =3D le32_to_cpu(buf[0]);
> > +               if (is_saturated(nprim))
> > +                       return -1;
> >                 nel =3D le32_to_cpu(buf[1]);
> >                 for (j =3D 0; j < nel; j++) {
> >                         if (read_f[i] (p, decl->symtab[i].table, fp)) {
> > @@ -4106,7 +4112,7 @@ static int scope_read(policydb_t * p, int symnum,=
 struct policy_file *fp)
> >                 goto cleanup;
> >         scope->scope =3D le32_to_cpu(buf[0]);
> >         scope->decl_ids_len =3D le32_to_cpu(buf[1]);
> > -       if (scope->decl_ids_len =3D=3D 0) {
> > +       if (zero_or_saturated(scope->decl_ids_len)) {
> >                 ERR(fp->handle, "invalid scope with no declaration");
> >                 goto cleanup;
> >         }
> > @@ -4396,6 +4402,8 @@ int policydb_read(policydb_t * p, struct policy_f=
ile *fp, unsigned verbose)
> >                 if (rc < 0)
> >                         goto bad;
> >                 nprim =3D le32_to_cpu(buf[0]);
> > +               if (is_saturated(nprim))
> > +                       goto bad;
> >                 nel =3D le32_to_cpu(buf[1]);
> >                 if (nel && !nprim) {
> >                         ERR(fp->handle, "unexpected items in symbol tab=
le with no symbol");
> > --
> > 2.33.1
> >
