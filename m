Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C724195B5
	for <selinux@vger.kernel.org>; Mon,  3 Aug 2026 12:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785761030; cv=pass; b=N8IByV6nL4dXQjPk4+FU0OA0AbVzGKc+/9ZSo7hyDDUq/rBGUiezSgQJOSzZd4+edK0zPLWu46kpIk56mh31Y0iiIyzSTKKTSxpNILueqB6/DQB4i0GEbpYLl8W+EIrHi60CL/XT8V1i8juiU4O7J4uK2B9E4HYxiaxKZzEXnJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785761030; c=relaxed/simple;
	bh=3YWtK9lgSR6Sbo+x81Jh3jsOnx6s/HUHPUO6GNsp1Eg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LobPjhqf076qdeaGjj5d7YmYiTp/HU1wAtQ8mw/1GfH6YEBa1VnuBEw7ltjhqfxgDct7l8ny5DfP9wYlZlSDM+XEe4+H2KWJHzrheBU6lM9h9d0WY9YajpkaI4rxUSQy/UJDQBx7PI9h1UvsYi+FK/L2wAXVoJLeGfF70e7pqB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkW+Hcf1; arc=pass smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkW+Hcf1"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-4472500e25fso1642894fac.1
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2026 05:43:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785761027; cv=none;
        d=google.com; s=arc-20260327;
        b=nfVFr5FpMYTm3u81wJbqeNCvpPfUWLiOLuH6OtPjbVxIeeJ/uG4XZKlb8uMl01Egvs
         1Zy2vO3RizXExSDgSUbc3ieu/RZWeUfG2fNs+6BV89uxp1jFdnAxCtQ842F4L0ebgnPp
         rxqJ1m+xjIc5KJMX6J0TzxtjJ4aUoqKSKCpnIqP7jr5VICFzFo3jjZAcodBrKvytKbep
         sr/aldl2ghpAlHcoZdSVQBxoqYPVdyXFbzzwpk6u8U8RXp2m4sdnhnQhs3WtYFS6ZIiY
         ujR+gzjazYgjXir1L8dnK6cmvoArTUCKh9ouRCRO4bm81yCV7tI4M+QCrqsGcz+bfLFO
         HmzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IgzR/PJkEinvk0p1OPhrajO4AGanpp8Q20ngALZ2bhM=;
        fh=/vJneOmbd7NM0stcpK599OIWn95pVOZ52dy6lRxJ8nw=;
        b=WY/AaikELrSzuc/8r+87M1lXQvHnAxKC2oCLR4TCcQBoyBpP8rehhUhJ3rDjeHk+q2
         bt+HYEjLMfe67kN/9E/q9Zb+hIrrT3wM3q05nmDxO+58Ox3uPtf5MsyDhGmMVl8xA6Mx
         8N4NF0kYC3uOHwoUz1zu9T+dj0BAJk0gnQzJkY9zUQCqkR32Lzk9lTT/0KXvee+y/BBs
         L6LfnSN8eva3bJ6XX838jmHn1HU9Ozry9Xc6cHqrScDPsAmJdty791984Cy8RJVFE8Gr
         5Lfhl0tsQ7CRjD0J+HPTzh83VA6y3a+inJM13bnA2HImw58MzWY20JBTjB9qrhMwbz4G
         E0bQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785761027; x=1786365827; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IgzR/PJkEinvk0p1OPhrajO4AGanpp8Q20ngALZ2bhM=;
        b=bkW+Hcf1huY/iJJCxsvubia+iN4mOZCtXIBnDICWfAr15zREtNK3fMa271flWHa29S
         u8tcVr2gsW4hGTtO4VQKPxrEbGaWCcWXQyh9kBISf+3hz8riPv6sdjTPkmcFDEQPu602
         ZEkM6PHYDlZBy8eS/hyvVzsg7uPFENSk5klLolajbiimpkG2EDmgFUA/qdDj59z4uM0H
         NUsYa3HcixDfCneIe1dwvffCNnYXai5eKBufC7kEGCqY4EudNCEZOxFQn4/OSvqHm5on
         fH/i2D/Cp8bP2Msqsr3hlVZ+uD9VPFNu4tkEy8LJkEj35w0iPu8RPQv1Z6t+J+q4YFCb
         dy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785761027; x=1786365827;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IgzR/PJkEinvk0p1OPhrajO4AGanpp8Q20ngALZ2bhM=;
        b=M2Q/p7ytY+B+a2708AOzybX22mwB2Waq0JIUvvYrRvOyGA+nzugZretWW6IA7gIlI4
         9Lr4J5Vwvp67xeUql9GcIAvhAr55FQC0/aWCKCSUv4eyusbRNaHMsvjrhK6EqaAGuT88
         TZwBlK154NMkjv6YQG0Jn+Rb7sozuHOzbjKCKD53qYdYi5NsTOIui84aK7QOGQXzq4OP
         2IAY9d5eukSoxSX7y5DEZrd3keJUsyv0PWMpQkMJIM91csuFn8mz9o61/ztct3QoFrCG
         aro9sIPtQVvtdC91w1XNgSjqUiE+O5FJqX26H/FOm/BmwGfAEaCHdhc4TLjYf40sGtTl
         WcYA==
X-Gm-Message-State: AOJu0YzSWH3Bn2EXhia6GczY6XAh3s2vv0S6d+74xom8pFeX4lq3O3sX
	3k/ltBabMIDGffskUwgEIGFzPF/taPowIo1jZiv3J6CbkydlrgF8dD4s1KeYUnmn/X5EnKSRcHP
	Qy412O+wRLVNz0KZd+4+wxf6/94S3F74=
X-Gm-Gg: AR+sD130umngW73gBdZz7ay6oimoCQ9TDn7Ip5Wg9XqGTfByaP1Iz3zt8+mFmfPBZGG
	Qa04K2gqeah1tOGKRy1TgTbWPm1r2NOR4KC0Zwy73tBf/9H9RmsB0IWcLL3mxHo4UyfVViFcaxH
	NdzDm2G3axiozhsyEKU6zrnax+7/Z59Cxa6rrUz37bQzlwWBYMLKsQvxNuQZfLWM6i6NpuvanPQ
	hhV1rnKKYfsocjP6tgnAGy9+nV0qffAmopSBw5k37c+FX64RlbvEia+MFheuda+JVzXVE8fJHdz
	mozIKLfoWLDeTutO2mpMsWMUkr/5HpBxJTnZr07xXJJ7FZ0kmnVKDuIS
X-Received: by 2002:a05:6820:1f08:b0:6aa:de55:1351 with SMTP id
 006d021491bc7-6ae433ef09emr14073398eaf.33.1785761027417; Mon, 03 Aug 2026
 05:43:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730085713.1484927-1-pmatyas@redhat.com> <20260730135601.1510501-1-pmatyas@redhat.com>
 <CAEjxPJ6-dU+zGDQejk_uUbH=a971ZHFY2W34oM+e2+=8xfh-BA@mail.gmail.com> <CAEjxPJ6qonOZwyspc_nA6WGfbYUi0k74p+P7RNRWdSizqsXgZw@mail.gmail.com>
In-Reply-To: <CAEjxPJ6qonOZwyspc_nA6WGfbYUi0k74p+P7RNRWdSizqsXgZw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 3 Aug 2026 08:43:36 -0400
X-Gm-Features: AUfX_mwQCe2YgjHagTaFm1epuE9kQDipgSX4jaP2wkhrxeEYc0IwlmvUtEgSumM
Message-ID: <CAEjxPJ7q_G5VBFcY1+-1YMM18cvXtFyP-Oj97BLtc3SgJKWNWg@mail.gmail.com>
Subject: Re: [PATCH v3] libselinux: prevent ReDoS in file context regex matching
To: Petr Matyas <p.matyas13@gmail.com>
Cc: selinux@vger.kernel.org, Petr Matyas <pmatyas@redhat.com>, 
	James Carter <jwcart2@gmail.com>, Paul Moore <paul@paul-moore.com>, 
	Jason Zaman <jason@perfinion.com>, Petr Lautrbach <lautrbach@redhat.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 1:42=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Jul 30, 2026 at 1:23=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Thu, Jul 30, 2026 at 10:05=E2=80=AFAM Petr Matyas <p.matyas13@gmail.=
com> wrote:
> > >
> > > The PCRE2 interpreter is susceptible to catastrophic backtracking on
> > > crafted file context patterns or lookup keys. Since libselinux never
> > > called pcre2_jit_compile(3), the JIT was available but unused, leavin=
g
> > > the interpreter exposed on all platforms.
> > >
> > > Fix with two complementary mitigations:
> > >
> > > 1. Call pcre2_jit_compile() after every pattern compilation (includin=
g
> > >    mmap deserialization) for both complete and partial matching modes=
.
> > >    pcre2_match() uses the JIT automatically when available, which avo=
ids
> > >    the interpreter's susceptibility to catastrophic backtracking.
> > >    Note: pcre2_jit_match() is deliberately NOT used as it is known to
> > >    produce incorrect results on some platforms (e.g. aarch64).
> > >
> > > 2. Create a shared pcre2_match_context with a backtrack step limit of
> > >    10 000 000 and pass it to pcre2_match(). PCRE2_ERROR_MATCHLIMIT is
> > >    treated as no-match to keep the lookup safe rather than failing
> > >    noisily. This bounds worst-case matching time to milliseconds for
> > >    any pattern/subject combination, regardless of JIT availability.
> > >
> > > The vulnerability was reproduced and confirmed fixed on:
> > > - RHIVOS 2.0 / aarch64
> > > - RHEL 10.3 / x86_64
> > > - Fedora 44 / x86_64
> > >
> > > Reproducer (149 bytes, base64):
> > > AwovMi0GLy8GCygKeAYGKwYLKAoKCgAAAPpXKgsoCi8vBgs8PG5vbmU+PgovMi0GLy8GC=
ygKeAYG
> > > KwYLKAoKCiNXLy8wCwsoCgojV1dXClcqCygKLy8vV1cueHhXV1d4eHgveCsGCygKCgonV=
y9XV3cy
> > > eHgveAcGJAsoCi8tLwYvMi0GLy8GCzw8bm9uZT4+3q2+7y8=3D
> > >
> > > Signed-off-by: Petr Matyas <pmatyas@redhat.com>
> >
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Merged.

This commit produces a new oss-fuzz issue report,
https://issues.oss-fuzz.com/issues/541525193
but quoting the stack trace below since you may lack access to the report:

Uninitialized bytes in MemcmpInterceptorCommon at offset 0 inside
[0x70b00000008c, 8)
=3D=3D248=3D=3DWARNING: MemorySanitizer: use-of-uninitialized-value
#0 0x56474054202c in ___interceptor_memcmp
/src/llvm-project/compiler-rt/lib/sanitizer_common/sanitizer_common_interce=
ptors.inc:880:10
#1 0x793bcb92efb3 in libpcre2-8.so.0
#2 0x793bcb94ecf1 in libpcre2-8.so.0
#3 0x793bcb952edc in pcre2_jit_compile_8
#4 0x5647405c1509 in regex_prepare_data selinux/libselinux/src/regex.c:109:=
8
#5 0x5647405b4828 in compile_regex selinux/libselinux/src/label_file.h:476:=
7
#6 0x5647405a04b5 in insert_spec selinux/libselinux/src/label_file.h:657:8
#7 0x5647405a04b5 in process_line selinux/libselinux/src/label_file.h:898:9
#8 0x5647405a04b5 in process_text_file selinux/libselinux/src/label_file.c:=
226:8
#9 0x56474059baa1 in LLVMFuzzerTestOneInput
selinux/libselinux/fuzz/selabel_file_text-fuzzer.c:171:7
#10 0x56474048522d in fuzzer::Fuzzer::ExecuteCallback(unsigned char
const*, unsigned long)
/src/llvm-project/compiler-rt/lib/fuzzer/FuzzerLoop.cpp:619:13
#11 0x56474046ffa2 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*,
unsigned long) /src/llvm-project/compiler-rt/lib/fuzzer/FuzzerDriver.cpp:32=
9:6
#12 0x564740475e70 in fuzzer::FuzzerDriver(int*, char***, int
(*)(unsigned char const*, unsigned long))
/src/llvm-project/compiler-rt/lib/fuzzer/FuzzerDriver.cpp:865:9
#13 0x5647404a19a2 in main
/src/llvm-project/compiler-rt/lib/fuzzer/FuzzerMain.cpp:20:10
#14 0x793bcb580082 in __libc_start_main
/build/glibc-B3wQXB/glibc-2.31/csu/libc-start.c:308:16
#15 0x56474046908d in _start
Uninitialized value was created by a heap allocation
#0 0x56474053d7a2 in __interceptor_malloc
/src/llvm-project/compiler-rt/lib/msan/msan_interceptors.cpp:1047:3
#1 0x793bcb915f61 in pcre2_compile_8
SUMMARY: MemorySanitizer: use-of-uninitialized-value
(/mnt/scratch0/clusterfuzz/bot/builds/clusterfuzz-builds_selinux_f4e9262b6c=
04d654efaf1cf4240d4d2ed1e93020/revisions/selabel_file_text-fuzzer+0x12c02c)
Exiting

When I asked an AI about possible causes, it said the following:
---<snip>---
The most likely cause is simply that this patch is the first time
libselinux has ever called `pcre2_jit_compile()` =E2=80=94 the commit messa=
ge
says as much ("the JIT was available but unused"). Before this patch,
`regex_match()` always ran through PCRE2's plain interpreter. After
it, `pcre2_match()` automatically switches to the JIT-compiled matcher
whenever compilation succeeded, which is a completely different code
path with its own memory-access patterns.

PCRE2's JIT is known to read some stack/register slots that sanitizers
flag as uninitialized, even though the values are never actually used
to affect output =E2=80=94 this is a known, discussed behavior on the PCRE2
mailing list, where a user reproduced "Conditional jump or move
depends on uninitialised value(s)" originating from a stack
allocation, specifically when pcre2_jit_compile() was used, and
removing the JIT compile call made the warning disappear
[Oss-fuzz](https://issues.oss-fuzz.com/issues/474186379) . A PCRE2
maintainer's response in that thread characterized it as intentional
optimization behavior in the JIT rather than a genuine bug. Under
libFuzzer+MSan (which oss-fuzz uses), this shows up as
"use-of-uninitialized-value" because MSan is stricter about
propagating "poisoned" bytes than Valgrind is.

So the fuzzer isn't necessarily finding a new bug in libselinux's
logic =E2=80=94 it's newly exercising PCRE2's JIT matcher (previously dorma=
nt
in this codebase) on crafted/fuzzed file-context patterns, and the JIT
engine's normal register/stack handling trips MSan. This is consistent
with the patch note that `pcre2_jit_match()` was avoided due to known
correctness issues on some platforms =E2=80=94 the JIT engine here has a tr=
ack
record of subtle divergence from the interpreter.

Practical next steps if you're triaging this upstream:
- Check whether the crash reproduces with `pcre2_jit_compile()`
removed (isolate JIT vs. non-JIT).
- Check whether it reproduces under regular ASan/UBSan (a true bug)
vs. only MSan (more likely a sanitizer-visibility artifact of JIT
codegen).
- If MSan-only, this is likely worth reporting upstream to PCRE2
rather than something fixable in libselinux, since libselinux only
added the `pcre2_jit_compile()` call and doesn't control the generated
machine code.
---snip>---

Not sure anything needs to be done here but noting it in case anyone
else has further insights.
