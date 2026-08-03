Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39C02931FA
	for <selinux@vger.kernel.org>; Mon,  3 Aug 2026 15:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785769560; cv=pass; b=coxAMgWaDey+DxVYpZ7bltVkgMR5WX8hFt0udh/0M9sjiHfhprwAS5ggoT3z9lxtHmgVQmUfsPIEO2lsmQfQR4Oo6Q/DUPP+1jOhXjltVxgwNUHUl5L2mbkLEYkjH+G2x30/d1ayGK66gmLgHOTPYJudf7jcHMTNqm2VcnawV0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785769560; c=relaxed/simple;
	bh=wsuX2+pgzNypxkIdSoVoS8uQ5Q3/pXkGv5SdrqUJeDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DL/GNAIkNwiDZRYk9jLzrkJXZfzvKx5jKJnQPYzXalIA4/I2p0YUjIqPURAkZW1I21rOXID7+MuaU+TT2iCLk9LjvJsyF8TQpPDfP3ddt0R2M9dOXgv+a0WvuIxe1kvsuuQg/7tYSjxpbqv/xxzvLfhkaKh8K2EKphqSBAvYWe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVLxnHQA; arc=pass smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVLxnHQA"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-73b909fbb6bso2504216137.2
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2026 08:05:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785769558; cv=none;
        d=google.com; s=arc-20260327;
        b=dijOb7j2XqHNrW9f4qMhbSRaT4hXTHfeGkj+biR52G50wbP9jyZSeC9t9gI6vLZa1P
         teGcIZYanESHea7V/qEn6RTPmQipyk2Hjfz5oV8XXcoFIpmVuylo3AjEQAhw5I9z9Vnl
         HqC7UYDnemwzRwGdZAsKJRZ08ArDbYScXClu6/n7rrxe1d2Y6d1V2HS0mddj6qBV7Pfv
         8ggXB3YDk5Vop+pgXiBSAD9UhqbAQHaN0nUGKn7yhNkr19uzL448JNxzqs1IYtBIHMyx
         7JB4NTESs1g24cBeOE9NvwXOJGSa8+mAS0tctJks0LdjSgxmdi6B2uvdJYcmUrsn+jJR
         0Nyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1/EtkZanQ+me0smOhH8EvEpImf7OmFL6PCN//clffhs=;
        fh=EZaGJZlK/t/4tYD3yOqT7nVtZ7yLBq3fCd3ginjo96k=;
        b=nZfs6UhpAmcnoeKVbzkb/KtRd25unYJtcBpKSGbOHH8rSlQXn5GOB4MPcjV3ntO9pY
         5k0HDlIDKamGXxolrscs6/YDMd4fxKz+Lthn6xqyVojsFu6tOaf5Z/i08qtBbJ82iUzj
         38EAzb8r3I97E2pPRQGPRhSwba2Q+mXaZKSBqZboPkQupU5ziIVKqf/HFgEFqr/SEkjn
         IeZGoQD+NInVg+vQ39EbYWeIHt2AQzMcD6vDRcgnPv4dx3YFHGDmMe+VmCeeRI3T2zQp
         Ltk7eKu2zDgrvc5SyhxmUpiZGfSFWpAjAldoB0JATtAgZU7xNYGHVyny/uFWIUJx833b
         CdVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785769558; x=1786374358; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1/EtkZanQ+me0smOhH8EvEpImf7OmFL6PCN//clffhs=;
        b=jVLxnHQA7fdSmv9U1Cr78gEuIi8YMApf39kjBstsQztDezcRvx6phS0/tu+9rylbU1
         pBR6FZXogBoGDYb5/Z4ICVRfwSmbs8jVwbnJT9Mc0FXEzYjbh/ktLZKbV0g1RRhj7d+0
         JlQGwqIipzPlctpXyKG8M+Z0YJGDXzeAkhyOsCLpzIIy8MCLX7WGyHC7UZ8+W7QTSP2o
         35NiEBoHN+VmzI0t4DAlhLuPlsOq/6TGlpL64l4CgZIVbZ5V4wbdkkgVW7hqJue3kTRx
         oOk1aiijTsk/ebuloJgozgmlkJhx4LmC1Z1DIUH8FPIv9XxCQPB1kRcNhoKaop8p3Kdt
         egXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785769558; x=1786374358;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1/EtkZanQ+me0smOhH8EvEpImf7OmFL6PCN//clffhs=;
        b=IoAcz2lFhKAw119Zcb5u4PMzd3ZapA6jdCWrWD4dJjWkXlv1lePTFnEXB686Qxkmfd
         yypnKmg71Qn70u3sTZEgCVtADFxL19ccV6e6nQsofUxbt9MwARv6s36tMm9LuCAl9yXf
         Lh542KmCfUgHX6daWF37yofhkqLRGrTD1gzBB7AuXeLDxGyr5Yxc/CchrdUfuHGR4JNW
         0xkeI4H/RyIsCA4KX8HtMNX8lswNTBJYS0oxHC2LMn4vEAszDrRvTUvhpWtGKOopBsY+
         nXdzY0kbFG1W3c+2w2ncUptb4fBpqB26rR6Uq0tVc8Ak1K0P4boz4UuPeK8ZPEaRIQ5X
         4l2A==
X-Gm-Message-State: AOJu0YzkZeFOST8OWyYW17AOtno2kQxBK3BnASkhEgEbycSe1ZawLTSJ
	WnK9mEH5k6M2qzriQh1ca9K2U02CqFE4RRjq4zR2ADyKhuMPH6VCRvrAg8Gh4yv1A+yxuVHeCAk
	ydJGtb8S6S/UyRxg7WUs+B68c5Mt6u+U=
X-Gm-Gg: AR+sD12HMZN+ENRqffeAgPkud9OpOcx4yEwxNQhdvTo9DsB9sgusPmOwOLgm/ImJGHN
	Nc0Q1Y7uz1hx0ZtlpFJD0vDT7ti22IOW7RAxNLlCVJCslwTTlcQP0ckmOcgjDsBNkovsjt0/um0
	+rOiMqnxcY6DgpHOeHaYN4zTsEuWs+eQG4zLEGdo5/Rc8qQsw4xxlVVMtY+QQrGtcoJvdv0sVBP
	h8ShuZhhVz/0qt6pCvbpDphjkKQiZxwpSmtIogD/SyePahiHge0/ZZEAsesIFyILgOfiDkpD2Bf
	liJVrjBfr9D5KFpYbY4A2eBuJwHt80ZMUAeGP3agFpdS
X-Received: by 2002:a05:6102:2b9b:b0:738:9d06:2a1e with SMTP id
 ada2fe7eead31-75b2255b7demr8026013137.8.1785769557693; Mon, 03 Aug 2026
 08:05:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730085713.1484927-1-pmatyas@redhat.com> <20260730135601.1510501-1-pmatyas@redhat.com>
 <CAEjxPJ6-dU+zGDQejk_uUbH=a971ZHFY2W34oM+e2+=8xfh-BA@mail.gmail.com>
 <CAEjxPJ6qonOZwyspc_nA6WGfbYUi0k74p+P7RNRWdSizqsXgZw@mail.gmail.com> <CAEjxPJ7q_G5VBFcY1+-1YMM18cvXtFyP-Oj97BLtc3SgJKWNWg@mail.gmail.com>
In-Reply-To: <CAEjxPJ7q_G5VBFcY1+-1YMM18cvXtFyP-Oj97BLtc3SgJKWNWg@mail.gmail.com>
From: =?UTF-8?B?UGV0ciBNYXR5w6HFoQ==?= <p.matyas13@gmail.com>
Date: Mon, 3 Aug 2026 17:05:45 +0200
X-Gm-Features: AUfX_mxf0h-qp07zFcU11Kp9aA3KOpVyON6Y4LzKMPa-M1yOyv_ESJXOTbKvUWM
Message-ID: <CAJ9hfpWKAa=-woBfvHRM3CMY9KG=52xGPAp+ivKWaNhEAiEeFQ@mail.gmail.com>
Subject: Re: [PATCH v3] libselinux: prevent ReDoS in file context regex matching
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, Petr Matyas <pmatyas@redhat.com>, 
	James Carter <jwcart2@gmail.com>, Paul Moore <paul@paul-moore.com>, 
	Jason Zaman <jason@perfinion.com>, Petr Lautrbach <lautrbach@redhat.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, thanks for getting me the output, I really don't have access there.
Looking into the fix in pcre2 (well Claude is), probably easier than
reporting an issue there.

Not sure if you/oss-fuzz are picking up pcre2 from a package (RHEL
uses 10.44 which is 2 years old)
or building from source so it might be failing for a while, unless you
want me to add an ignorelist entry to oss-fuzz,
which would then need to be removed after the fix is available to
oss-fuzz tested system.
Assuming I can create a fix and not just end up reporting an issue after al=
l.

Best regards
Petr Matyas



On Mon, 3 Aug 2026 at 14:43, Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Jul 30, 2026 at 1:42=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Thu, Jul 30, 2026 at 1:23=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Thu, Jul 30, 2026 at 10:05=E2=80=AFAM Petr Matyas <p.matyas13@gmai=
l.com> wrote:
> > > >
> > > > The PCRE2 interpreter is susceptible to catastrophic backtracking o=
n
> > > > crafted file context patterns or lookup keys. Since libselinux neve=
r
> > > > called pcre2_jit_compile(3), the JIT was available but unused, leav=
ing
> > > > the interpreter exposed on all platforms.
> > > >
> > > > Fix with two complementary mitigations:
> > > >
> > > > 1. Call pcre2_jit_compile() after every pattern compilation (includ=
ing
> > > >    mmap deserialization) for both complete and partial matching mod=
es.
> > > >    pcre2_match() uses the JIT automatically when available, which a=
voids
> > > >    the interpreter's susceptibility to catastrophic backtracking.
> > > >    Note: pcre2_jit_match() is deliberately NOT used as it is known =
to
> > > >    produce incorrect results on some platforms (e.g. aarch64).
> > > >
> > > > 2. Create a shared pcre2_match_context with a backtrack step limit =
of
> > > >    10 000 000 and pass it to pcre2_match(). PCRE2_ERROR_MATCHLIMIT =
is
> > > >    treated as no-match to keep the lookup safe rather than failing
> > > >    noisily. This bounds worst-case matching time to milliseconds fo=
r
> > > >    any pattern/subject combination, regardless of JIT availability.
> > > >
> > > > The vulnerability was reproduced and confirmed fixed on:
> > > > - RHIVOS 2.0 / aarch64
> > > > - RHEL 10.3 / x86_64
> > > > - Fedora 44 / x86_64
> > > >
> > > > Reproducer (149 bytes, base64):
> > > > AwovMi0GLy8GCygKeAYGKwYLKAoKCgAAAPpXKgsoCi8vBgs8PG5vbmU+PgovMi0GLy8=
GCygKeAYG
> > > > KwYLKAoKCiNXLy8wCwsoCgojV1dXClcqCygKLy8vV1cueHhXV1d4eHgveCsGCygKCgo=
nVy9XV3cy
> > > > eHgveAcGJAsoCi8tLwYvMi0GLy8GCzw8bm9uZT4+3q2+7y8=3D
> > > >
> > > > Signed-off-by: Petr Matyas <pmatyas@redhat.com>
> > >
> > > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >
> > Merged.
>
> This commit produces a new oss-fuzz issue report,
> https://issues.oss-fuzz.com/issues/541525193
> but quoting the stack trace below since you may lack access to the report=
:
>
> Uninitialized bytes in MemcmpInterceptorCommon at offset 0 inside
> [0x70b00000008c, 8)
> =3D=3D248=3D=3DWARNING: MemorySanitizer: use-of-uninitialized-value
> #0 0x56474054202c in ___interceptor_memcmp
> /src/llvm-project/compiler-rt/lib/sanitizer_common/sanitizer_common_inter=
ceptors.inc:880:10
> #1 0x793bcb92efb3 in libpcre2-8.so.0
> #2 0x793bcb94ecf1 in libpcre2-8.so.0
> #3 0x793bcb952edc in pcre2_jit_compile_8
> #4 0x5647405c1509 in regex_prepare_data selinux/libselinux/src/regex.c:10=
9:8
> #5 0x5647405b4828 in compile_regex selinux/libselinux/src/label_file.h:47=
6:7
> #6 0x5647405a04b5 in insert_spec selinux/libselinux/src/label_file.h:657:=
8
> #7 0x5647405a04b5 in process_line selinux/libselinux/src/label_file.h:898=
:9
> #8 0x5647405a04b5 in process_text_file selinux/libselinux/src/label_file.=
c:226:8
> #9 0x56474059baa1 in LLVMFuzzerTestOneInput
> selinux/libselinux/fuzz/selabel_file_text-fuzzer.c:171:7
> #10 0x56474048522d in fuzzer::Fuzzer::ExecuteCallback(unsigned char
> const*, unsigned long)
> /src/llvm-project/compiler-rt/lib/fuzzer/FuzzerLoop.cpp:619:13
> #11 0x56474046ffa2 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*,
> unsigned long) /src/llvm-project/compiler-rt/lib/fuzzer/FuzzerDriver.cpp:=
329:6
> #12 0x564740475e70 in fuzzer::FuzzerDriver(int*, char***, int
> (*)(unsigned char const*, unsigned long))
> /src/llvm-project/compiler-rt/lib/fuzzer/FuzzerDriver.cpp:865:9
> #13 0x5647404a19a2 in main
> /src/llvm-project/compiler-rt/lib/fuzzer/FuzzerMain.cpp:20:10
> #14 0x793bcb580082 in __libc_start_main
> /build/glibc-B3wQXB/glibc-2.31/csu/libc-start.c:308:16
> #15 0x56474046908d in _start
> Uninitialized value was created by a heap allocation
> #0 0x56474053d7a2 in __interceptor_malloc
> /src/llvm-project/compiler-rt/lib/msan/msan_interceptors.cpp:1047:3
> #1 0x793bcb915f61 in pcre2_compile_8
> SUMMARY: MemorySanitizer: use-of-uninitialized-value
> (/mnt/scratch0/clusterfuzz/bot/builds/clusterfuzz-builds_selinux_f4e9262b=
6c04d654efaf1cf4240d4d2ed1e93020/revisions/selabel_file_text-fuzzer+0x12c02=
c)
> Exiting
>
> When I asked an AI about possible causes, it said the following:
> ---<snip>---
> The most likely cause is simply that this patch is the first time
> libselinux has ever called `pcre2_jit_compile()` =E2=80=94 the commit mes=
sage
> says as much ("the JIT was available but unused"). Before this patch,
> `regex_match()` always ran through PCRE2's plain interpreter. After
> it, `pcre2_match()` automatically switches to the JIT-compiled matcher
> whenever compilation succeeded, which is a completely different code
> path with its own memory-access patterns.
>
> PCRE2's JIT is known to read some stack/register slots that sanitizers
> flag as uninitialized, even though the values are never actually used
> to affect output =E2=80=94 this is a known, discussed behavior on the PCR=
E2
> mailing list, where a user reproduced "Conditional jump or move
> depends on uninitialised value(s)" originating from a stack
> allocation, specifically when pcre2_jit_compile() was used, and
> removing the JIT compile call made the warning disappear
> [Oss-fuzz](https://issues.oss-fuzz.com/issues/474186379) . A PCRE2
> maintainer's response in that thread characterized it as intentional
> optimization behavior in the JIT rather than a genuine bug. Under
> libFuzzer+MSan (which oss-fuzz uses), this shows up as
> "use-of-uninitialized-value" because MSan is stricter about
> propagating "poisoned" bytes than Valgrind is.
>
> So the fuzzer isn't necessarily finding a new bug in libselinux's
> logic =E2=80=94 it's newly exercising PCRE2's JIT matcher (previously dor=
mant
> in this codebase) on crafted/fuzzed file-context patterns, and the JIT
> engine's normal register/stack handling trips MSan. This is consistent
> with the patch note that `pcre2_jit_match()` was avoided due to known
> correctness issues on some platforms =E2=80=94 the JIT engine here has a =
track
> record of subtle divergence from the interpreter.
>
> Practical next steps if you're triaging this upstream:
> - Check whether the crash reproduces with `pcre2_jit_compile()`
> removed (isolate JIT vs. non-JIT).
> - Check whether it reproduces under regular ASan/UBSan (a true bug)
> vs. only MSan (more likely a sanitizer-visibility artifact of JIT
> codegen).
> - If MSan-only, this is likely worth reporting upstream to PCRE2
> rather than something fixable in libselinux, since libselinux only
> added the `pcre2_jit_compile()` call and doesn't control the generated
> machine code.
> ---snip>---
>
> Not sure anything needs to be done here but noting it in case anyone
> else has further insights.
