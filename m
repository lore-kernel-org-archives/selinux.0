Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E324C433F5
	for <selinux@archiver.kernel.org>; Tue,  9 Nov 2021 18:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6D0B61052
	for <selinux@archiver.kernel.org>; Tue,  9 Nov 2021 18:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242499AbhKIStY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Nov 2021 13:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237469AbhKIStX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Nov 2021 13:49:23 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7425C061764
        for <selinux@vger.kernel.org>; Tue,  9 Nov 2021 10:46:37 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso114254otj.1
        for <selinux@vger.kernel.org>; Tue, 09 Nov 2021 10:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=buxDMlJyK5/PYjPnRrr1NCfr0SeJty8Q8sSDWdQtbXQ=;
        b=LFS+O+0QmsPXf5dN6AjNosnrRIckABqX4b1uRvWyzB8Iv0JNov5zT0+P6VQQAQLU2b
         UjHMmGB1xYEh+PQ2RuqqjdFoAoEF+EY0BB9tB7MwRl834GQazWryDORaGKFnfQox1SNY
         1xuoLCQ/LmQRK4CK9lOKT66qLApc8TcNxQKtAniJ961nkugMuaDNjEJlyXfTc/UvL/wz
         nhmmeKBACdu1yXnj3hILLpYEMQedHw87o7pHpCdTo3QAOoc3zXPCzqYwV9zOqhYfPFHy
         uPwnLBdUscLWlowJfSTPHgeW9Op8XA+Yaruc4PE3Jvd4zTOt5php/pTwvueghz6FJAHx
         etbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=buxDMlJyK5/PYjPnRrr1NCfr0SeJty8Q8sSDWdQtbXQ=;
        b=YV/T77mUkY0DGhkAeBWNhuVATiYLAjCrc2J8YHpXeS/Yj4oOhyAusb7CL0WGGn3wGq
         8ZducQmmq0GVoNNvqdOjbzWLoy6z3HycmBqfOR/7BKzvNakfBGINUJ3+IJF9YcNrUpS6
         k/15JRQWxVCMY+5KH7GNNj5nlA4X5GKua9i9AvfBZgeHkk15sP26Xu9W/3gOQGIPLzAk
         TRNJL4NH6VuhOg0j+UGj4Q7mR/14MRPVri0IWOvWzauq2saqCO78onfJIzFNiAIkvxC+
         V+do3jXd5fMHa5ROe740Egkb1hk6lEv4TpvVP0xqnaIivx03NxEwZ583fp2HDUWsM2bA
         fabw==
X-Gm-Message-State: AOAM532tJ+yKY9rkpH+5foRLDHuJ+4hvB2cM1YWV4OJcYa6QSKjh4imb
        Y7IsLGtN78fldvCuq9/Z+ThBzgqGqLRps8pGcLWE5GpA
X-Google-Smtp-Source: ABdhPJyl84XM3KFE3oIax2AQ/mi6SnzR3MzUnxne6lC0djoAvYMpvjaVEh3Y/LJ4KKuY9ZAKrXAPmrjyoWmzyTn3I+0=
X-Received: by 2002:a9d:6346:: with SMTP id y6mr8094219otk.154.1636483597154;
 Tue, 09 Nov 2021 10:46:37 -0800 (PST)
MIME-Version: 1.0
References: <20211011162533.53404-1-cgzones@googlemail.com>
 <20211105154542.38434-1-cgzones@googlemail.com> <20211105154542.38434-11-cgzones@googlemail.com>
In-Reply-To: <20211105154542.38434-11-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 9 Nov 2021 13:46:26 -0500
Message-ID: <CAP+JOzRwY9E1b_sEdgJe3Y_A+GXNZeG92EYK2a=bYFnJYUwJyw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 10/36] libsepol: add checks for read sizes
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 5, 2021 at 12:11 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Add checks for invalid read sizes from a binary policy to guard
> allocations.
>
> The common and class permission counts needs to be limited more strict
> otherwise a too high count of common or class permissions can lead to
> permission values with a too high value, which can lead to overflows
> in shift operations.
>
> In the fuzzer build the value will also be bounded to avoid oom reports.
>
>     =3D=3D29857=3D=3D ERROR: libFuzzer: out-of-memory (malloc(17179868160=
))
>        To change the out-of-memory limit use -rss_limit_mb=3D<N>
>
>         #0 0x52dc61 in __sanitizer_print_stack_trace (./out/binpolicy-fuz=
zer+0x52dc61)
>         #1 0x475618 in fuzzer::PrintStackTrace() fuzzer.o
>         #2 0x458855 in fuzzer::Fuzzer::HandleMalloc(unsigned long) fuzzer=
.o
>         #3 0x45876a in fuzzer::MallocHook(void const volatile*, unsigned =
long) fuzzer.o
>         #4 0x534557 in __sanitizer::RunMallocHooks(void const*, unsigned =
long) (./out/binpolicy-fuzzer+0x534557)
>         #5 0x4aa7d7 in __asan::Allocator::Allocate(unsigned long, unsigne=
d long, __sanitizer::BufferedStackTrace*, __asan::AllocType, bool) (./out/b=
inpolicy-fuzzer+0x4aa7d7)
>         #6 0x4aa143 in __asan::asan_malloc(unsigned long, __sanitizer::Bu=
fferedStackTrace*) (./out/binpolicy-fuzzer+0x4aa143)
>         #7 0x5259cb in malloc (./out/binpolicy-fuzzer+0x5259cb)
>         #8 0x580b5d in mallocarray ./libsepol/src/./private.h:93:9
>         #9 0x57c2ed in scope_read ./libsepol/src/policydb.c:4120:7
>         #10 0x576b0d in policydb_read ./libsepol/src/policydb.c:4462:9
>         #11 0x55a214 in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolicy-=
fuzzer.c:26:6
>         #12 0x45aed3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char con=
st*, unsigned long) fuzzer.o
>         #13 0x446a12 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, =
unsigned long) fuzzer.o
>         #14 0x44c93b in fuzzer::FuzzerDriver(int*, char***, int (*)(unsig=
ned char const*, unsigned long)) fuzzer.o
>         #15 0x475dd2 in main (./out/binpolicy-fuzzer+0x475dd2)
>         #16 0x7ffad6e107ec in __libc_start_main csu/../csu/libc-start.c:3=
32:16
>         #17 0x423689 in _start (./out/binpolicy-fuzzer+0x423689)
>
>     =3D=3D19462=3D=3D ERROR: libFuzzer: out-of-memory (malloc(18253611008=
))
>        To change the out-of-memory limit use -rss_limit_mb=3D<N>
>
>         #0 0x52dc61 in __sanitizer_print_stack_trace (./out/binpolicy-fuz=
zer+0x52dc61)
>         #1 0x475618 in fuzzer::PrintStackTrace() fuzzer.o
>         #2 0x458855 in fuzzer::Fuzzer::HandleMalloc(unsigned long) fuzzer=
.o
>         #3 0x45876a in fuzzer::MallocHook(void const volatile*, unsigned =
long) fuzzer.o
>         #4 0x534557 in __sanitizer::RunMallocHooks(void const*, unsigned =
long) (./out/binpolicy-fuzzer+0x534557)
>         #5 0x4aa7d7 in __asan::Allocator::Allocate(unsigned long, unsigne=
d long, __sanitizer::BufferedStackTrace*, __asan::AllocType, bool) (./out/b=
inpolicy-fuzzer+0x4aa7d7)
>         #6 0x4aa999 in __asan::asan_calloc(unsigned long, unsigned long, =
__sanitizer::BufferedStackTrace*) (./out/binpolicy-fuzzer+0x4aa999)
>         #7 0x525b63 in __interceptor_calloc (./out/binpolicy-fuzzer+0x525=
b63)
>         #8 0x570938 in policydb_index_others ./libsepol/src/policydb.c:12=
45:6
>         #9 0x5771f3 in policydb_read ./src/policydb.c:4481:6
>         #10 0x55a214 in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolicy-=
fuzzer.c:26:6
>         #11 0x45aed3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char con=
st*, unsigned long) fuzzer.o
>         #12 0x446a12 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, =
unsigned long) fuzzer.o
>         #13 0x44c93b in fuzzer::FuzzerDriver(int*, char***, int (*)(unsig=
ned char const*, unsigned long)) fuzzer.o
>         #14 0x475dd2 in main (./out/binpolicy-fuzzer+0x475dd2)
>         #15 0x7f4d933157ec in __libc_start_main csu/../csu/libc-start.c:3=
32:16
>         #16 0x423689 in _start (./out/binpolicy-fuzzer+0x423689)
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libsepol/src/policydb.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index dcea1807..1408405d 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -2103,6 +2103,8 @@ static int common_read(policydb_t * p, hashtab_t h,=
 struct policy_file *fp)
>         if (symtab_init(&comdatum->permissions, PERM_SYMTAB_SIZE))
>                 goto bad;
>         comdatum->permissions.nprim =3D le32_to_cpu(buf[2]);
> +       if (comdatum->permissions.nprim > 32)

Should use PERM_SYMTAB_SIZE here (like in patch 22).

> +               goto bad;
>         nel =3D le32_to_cpu(buf[3]);
>
>         key =3D malloc(len + 1);
> @@ -2251,6 +2253,8 @@ static int class_read(policydb_t * p, hashtab_t h, =
struct policy_file *fp)
>         if (symtab_init(&cladatum->permissions, PERM_SYMTAB_SIZE))
>                 goto bad;
>         cladatum->permissions.nprim =3D le32_to_cpu(buf[3]);
> +       if (cladatum->permissions.nprim > 32)

Same here.


> +               goto bad;
>         nel =3D le32_to_cpu(buf[4]);
>
>         ncons =3D le32_to_cpu(buf[5]);
> @@ -3980,6 +3984,8 @@ static int avrule_decl_read(policydb_t * p, avrule_=
decl_t * decl,
>                 if (rc < 0)
>                         return -1;
>                 nprim =3D le32_to_cpu(buf[0]);
> +               if (is_saturated(nprim))
> +                       return -1;
>                 nel =3D le32_to_cpu(buf[1]);
>                 for (j =3D 0; j < nel; j++) {
>                         if (read_f[i] (p, decl->symtab[i].table, fp)) {
> @@ -4106,7 +4112,7 @@ static int scope_read(policydb_t * p, int symnum, s=
truct policy_file *fp)
>                 goto cleanup;
>         scope->scope =3D le32_to_cpu(buf[0]);
>         scope->decl_ids_len =3D le32_to_cpu(buf[1]);
> -       if (scope->decl_ids_len =3D=3D 0) {
> +       if (zero_or_saturated(scope->decl_ids_len)) {
>                 ERR(fp->handle, "invalid scope with no declaration");
>                 goto cleanup;
>         }
> @@ -4396,6 +4402,8 @@ int policydb_read(policydb_t * p, struct policy_fil=
e *fp, unsigned verbose)
>                 if (rc < 0)
>                         goto bad;
>                 nprim =3D le32_to_cpu(buf[0]);
> +               if (is_saturated(nprim))
> +                       goto bad;
>                 nel =3D le32_to_cpu(buf[1]);
>                 if (nel && !nprim) {
>                         ERR(fp->handle, "unexpected items in symbol table=
 with no symbol");
> --
> 2.33.1
>
