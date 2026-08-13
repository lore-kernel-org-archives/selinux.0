Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E6343DA26
	for <selinux@vger.kernel.org>; Thu, 13 Aug 2026 12:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786625445; cv=pass; b=Px9R8hU7XBfVFHnTCkIxAkmvLv68W4rPG6iGgPaPXM92N5qqBZydJLRG0qlwpQRlALoyyqwTdUrZIgMPLvkWgD8Mi3vQT0Ss/hzZk6TvOFntoj6FOu4ywKVxtoxKTU19lr96pdizdp9njEMcrgHlkZuz8WSCkMUADIDH931o4ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786625445; c=relaxed/simple;
	bh=kt3OsXGLIA6R0akLtnYItnHrWjmuOkzMttRCBOzOXkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jlcxvGuUzpPEmKCGpKMWr4qfvHxpuE9cg1HlbMx3yRPQePepRbguk3mms0sFqTrCwXJI3zfxMRAcfdz3Kl4vGRW5lkq+0Dlj8t9YPO19o4pBPZvoSooVCxxcXRfW52Q/UezMmtW1M2Eqs565ILwuHIkxiZ5Yiip/fnJ6AIuG10c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtsCJLzp; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtsCJLzp"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-458de93b53fso958117fac.2
        for <selinux@vger.kernel.org>; Thu, 13 Aug 2026 05:50:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786625442; cv=none;
        d=google.com; s=arc-20260327;
        b=DXtsffXx7GjVA5kh1hizvT2RhqJ8WySkd+tSibxtsAolGWrRhatEjarxSos5TCGyNh
         qrwQFF815Fz7lYsvg4hRHIEF8m/a7vzqg3XNMzHUg3aH3w/4Ksqo0B2hDjhLIHwB/XsN
         LrHG69vvHhuqATdFV/Uar/gbX6qjUy8Cym9JMZUA8kXQw3vl/3GyQ+g1BICwDa9UHyaR
         Q9NqxoVaxZRWw1UvCEnBtX/tvUCcr1t+B6GC6X8gBZSe0Y0FWVF1ws8REfUFy6H3h/bL
         vOaLXoUfxCj0SB5br3LUzxfDBIS+G67YwFlSVq3G9Tt2bBg3mOCoGfQ9KQfzFrx0d5KT
         dh8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=L+7EolQpCDf+CDeEekvn/ZPhUfdpf9q0pVfX+Zg9F5c=;
        fh=cVZI269ioQuwKzLGwbELyMvF9+q8sQJU42mbMSjvW4U=;
        b=JOC5keBppO5cscdJEz80rLfpsGBT+w4NQeN8gQPmt3JVacElO4I6GhA/NYfNtH8tps
         KC19m9pjk6sh6Yjb6nd5JdZG0mdGHuPI5ZTivalFbPdsPx8mz6WJWQxphMRh4gUP9iLh
         X66mcp+si9emB1z/b7XN1byZSZ4q6SxdIdJita9korU7a1I/z9DqsHaDph5bYsd8wXXg
         yvg8+Io3owb1eN0P7kp/DyCl/S4dKjB7eo5pNlJDjioWWjaO3AUrRaMI9Cb9CmxMpfH4
         hZ4jl6tV+ix6hBq5qzQfAavUyVZzoZky1HF17PdEJcIHr1i+kepDnXkUaUVWMA3GpPWZ
         KT2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786625442; x=1787230242; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L+7EolQpCDf+CDeEekvn/ZPhUfdpf9q0pVfX+Zg9F5c=;
        b=JtsCJLzpE+8HIzQXHUUmeIaE78l+1sczeX7gNBhPjpwLMmFTRZae7QymOPg+XDJ0I+
         eEVCHhI+2xyloUVpuwRRfKUU5AUKYHV9vDkl2gbYHwpbwp2FaJeno8zzBQ65TS0lcdE8
         uj3lqDWsKrC5OUDz8OgA7x7bjfDb3FnO9VmleH9yqTeE3M0LcTw5lynhAfEFeUWCn+Kr
         CUUL+zPqBqGwlRpULpAbDNcwXVObBkpAnFEq2sKyM4PxzErWczbqzIO4PvUA2AoE2fKF
         dai9J87piMaUulMl5ztYcpyIxB4fRtJdeLuBZOASG0q7pyW8tDH8A4YIdDROKoPPQ9oM
         ATbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786625442; x=1787230242;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=L+7EolQpCDf+CDeEekvn/ZPhUfdpf9q0pVfX+Zg9F5c=;
        b=QJdU14a/tleb2qqJXlRKsqevDsYui1DULSjDcXzCo0rAI+GoRx6EwI0tZ1kO9aVqR/
         YHiwMCMs/zIFzkDFw+FFARqTIsJj0MSz7rszlWvww1dWr/BFifSmfUpHTwjZXw7uqlOS
         SbU7GnJXieejNBCqYQ+aM1EPQL89T70zfTlch+3oM7UsNnKnd+rRnBKFAXebK6v5QgIU
         y7K0+rnaG402v976ovJcPDDS7q02ZiuYMRzwi8JateFSwcEUFh6Pqm8SALxV5yqHv0O2
         3QaL1B/rj8qW/lSESHOsQGRqF5bSpwvDOTvEnUhPWGCVOxhp1CGyBKl6ATu+CL52XwK6
         fqiw==
X-Gm-Message-State: AOJu0Yye8Sw/ZVgW56WYNqY3M9VVfoOYUnbeERlrvaAsN2XvFMGsxDnG
	i6KNdTCC3sxzFAzaIeAOY+Np5hY0lkdld7lRLf1p3atykjdSAblUZmLbGXnyfOtWvAq9VmvrW0U
	g1iq+ZQJsDtRgcSCN1tLfu+LN06Oj6xwjrO1X
X-Gm-Gg: AR+sD12ay0mpgasLVGaryr5lK7qJj74fOP7KCFNHrryddJBNo7dXePqCE2EYfA1bDoj
	DmqJjkfF/w66OTxkx9W6aqlrvvtftLERbivyREX5u4gCM08u1NsZKGhTIeUrVFsDKfTSVP4FLf6
	PCopJMUaP0nkvSHP6xWTxpchwcAGE4NtmdEJPLE9yI5McImkigoIH5tl9T+JO5/g/rIFlwQBmn4
	FmNCl9ByBTPHBk6OwNmJK1hSLrkaCg9U3BLfnFmeR6mXk4lFU3rOP3hYOlK2aFDk2ryxMyxowh8
	k+U4DNHLsirF88OPiG/6xRKu68AyyWJnmwCHtAtx+Afm
X-Received: by 2002:a05:6871:1cd:b0:456:b6b3:5b64 with SMTP id
 586e51a60fabf-45e621d99b1mr5063931fac.1.1786625442201; Thu, 13 Aug 2026
 05:50:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813073533.3253251-1-pmatyas@redhat.com>
In-Reply-To: <20260813073533.3253251-1-pmatyas@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 13 Aug 2026 08:50:31 -0400
X-Gm-Features: AUfX_my9Oj_fjB7J_NuVR3XgAxmTdgs7CcuHa3gX4muMLLjp8y1bN-qFu__iVPM
Message-ID: <CAEjxPJ4yW94x_DLSe=zdmfKB95aagFmydTKsBnWGfjc6efr4hA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: fix SEGV in JIT matching of recursive
 patterns in partial mode
To: Petr Matyas <p.matyas13@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000d47df40658ed2662"

--000000000000d47df40658ed2662
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 3:35=E2=80=AFAM Petr Matyas <p.matyas13@gmail.com> =
wrote:
>
> The PCRE2 JIT compiler has a bug in its PCRE2_JIT_PARTIAL_SOFT code
> path: patterns containing recursive subroutine calls (the (?1...)
> syntax) cause the generated native code to dereference a null pointer
> at match time. pcre2_jit_compile() returns 0 (success) and the
> compiled JIT size is non-zero, so the bug is undetectable at compile
> time and only manifests when pcre2_match() executes the JIT code.
>
> The root cause is an interaction between OP_RECURSE backtracking and
> the hit_start tracking mechanism that the partial-soft JIT uses to
> remember the earliest position at which a partial match was seen.
> No fix is currently available in PCRE2.
>
> Commit 92af7f1b61db ("libselinux: prevent ReDoS in file context regex
> matching") introduced pcre2_jit_compile() calls with both
> PCRE2_JIT_COMPLETE and PCRE2_JIT_PARTIAL_SOFT. ClusterFuzz
> subsequently reported a SEGV in selabel_file_compiled-fuzzer via a
> crafted compiled file_contexts input that triggers the bug through
> the lazy text-compilation fallback path (version/arch mismatch causes
> the pre-compiled PCRE2 data to be skipped, so the embedded regex
> string is compiled on demand via regex_prepare_data()).
>
> Fix by dropping PCRE2_JIT_PARTIAL_SOFT. Per the PCRE2 documentation,
> when partial-soft JIT code has not been compiled, pcre2_match()
> automatically falls back to the interpreter for partial matches.
> Partial matches remain protected against ReDoS by the 10 000 000-step
> backtrack limit that was introduced in the same commit. Full matches
> continue to use PCRE2_JIT_COMPLETE and are unaffected.
>
> Reported-by: ClusterFuzz (testcase 5660382656790528)
> Fixes: 92af7f1b61db ("libselinux: prevent ReDoS in file context regex mat=
ching")
> Signed-off-by: Petr Matyas <pmatyas@redhat.com>

Thank you! This also appears to fix another new oss-fuzz report
(selinux:selabel_file_text-fuzzer: Heap-buffer-overflow in _pcre2_script_ru=
n_8)
that just showed up (reproducer attached and output below).

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

 =3D=3D250=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on address
0x7bf4d87e0032 at pc 0x591ed94e7dd5 bp 0x7ffd3265e3f0 sp
0x7ffd3265e3e8
READ of size 1 at 0x7bf4d87e0032 thread T0
    #0 0x591ed94e7dd4 in _pcre2_script_run_8
/tmp/pcre2-src/src/pcre2_script_run.c:332:3
    #1 0x591ed9437b56 in do_script_run
/tmp/pcre2-src/src/pcre2_jit_compile.c:9599:7
    #2 0x7fd4d942cc0c  (<unknown module>)
0x7bf4d87e0032 is located 0 bytes after 2-byte region
[0x7bf4d87e0030,0x7bf4d87e0032)
allocated by thread T0 here:
    #0 0x591ed90f70e4 in __interceptor_malloc
/src/llvm-project/compiler-rt/lib/asan/asan_malloc_linux.cpp:67:3
    #1 0x591ed913b958 in LLVMFuzzerTestOneInput
selinux/libselinux/fuzz/selabel_file_text-fuzzer.c:137:8
    #2 0x591ed913b5a9 in ExecuteFilesOnyByOne
/src/aflplusplus/utils/aflpp_driver/aflpp_driver.c:267:7
SUMMARY: AddressSanitizer: heap-buffer-overflow
(/mnt/scratch0/clusterfuzz/bot/builds/clusterfuzz-builds-afl_selinux_32ddf7=
8d9f476617df7a8f4cf22b4d9340aef874/revisions/selabel_file_text-fuzzer+0x57f=
dd4)
Shadow bytes around the buggy address:
  0x7bf4d87dfd80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7bf4d87dfe00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7bf4d87dfe80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7bf4d87dff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7bf4d87dff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=3D>0x7bf4d87e0000: fa fa 00 05 fa fa[02]fa fa fa 00 04 fa fa 02 fa
  0x7bf4d87e0080: fa fa fd fd fa fa 00 fa fa fa fa fa fa fa fa fa
  0x7bf4d87e0100: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x7bf4d87e0180: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x7bf4d87e0200: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x7bf4d87e0280: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
=3D=3D250=3D=3DABORTING


> ---
>  libselinux/src/regex.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
> index 3f7df4c7..017647b4 100644
> --- a/libselinux/src/regex.c
> +++ b/libselinux/src/regex.c
> @@ -103,11 +103,12 @@ int regex_prepare_data(struct regex_data **regex, c=
har const *pattern_string,
>                 goto err;
>         }
>
> -       /* JIT-compile for complete and partial matching. pcre2_match() u=
ses the
> -        * JIT automatically when available, avoiding the interpreter's
> -        * susceptibility to catastrophic backtracking. Failures are non-=
fatal. */
> -       (void)pcre2_jit_compile((*regex)->regex,
> -                               PCRE2_JIT_COMPLETE | PCRE2_JIT_PARTIAL_SO=
FT);
> +       /* JIT-compile for complete matching only. pcre2_match() uses the=
 JIT
> +        * automatically when available, avoiding the interpreter's
> +        * susceptibility to catastrophic backtracking. Partial matches f=
all
> +        * back to the interpreter, protected by the match limit. Failure=
s
> +        * are non-fatal. */
> +       (void)pcre2_jit_compile((*regex)->regex, PCRE2_JIT_COMPLETE);
>
>         return 0;
>
> @@ -163,9 +164,7 @@ int regex_load_mmap(struct mmap_area *mmap_area, stru=
ct regex_data **regex,
>                 if (rc !=3D 1)
>                         goto err;
>
> -               (void)pcre2_jit_compile((*regex)->regex,
> -                                       PCRE2_JIT_COMPLETE |
> -                                               PCRE2_JIT_PARTIAL_SOFT);
> +               (void)pcre2_jit_compile((*regex)->regex, PCRE2_JIT_COMPLE=
TE);
>
>                 *regex_compiled =3D true;
>         }
> --
> 2.55.0
>

--000000000000d47df40658ed2662
Content-Type: application/octet-stream; 
	name=clusterfuzz-testcase-minimized-selabel_file_text-fuzzer-4919041035403264
Content-Disposition: attachment; 
	filename=clusterfuzz-testcase-minimized-selabel_file_text-fuzzer-4919041035403264
Content-Transfer-Encoding: base64
Content-ID: <f_msridjb70>
X-Attachment-Id: f_msridjb70

Aygqc3I6LnssOH0pIC/erb7vIA==
--000000000000d47df40658ed2662--
