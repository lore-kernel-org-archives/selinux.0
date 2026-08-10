Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CC7346A0A
	for <selinux@vger.kernel.org>; Mon, 10 Aug 2026 16:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786377647; cv=pass; b=qsi8IeGJ5zFN7VYum0C7AYKT5B2HtLqGKPagx5jbD0xNcIvUav+hUNRBhiPQjA6YFEthv30XdSq7T8eUcbZCtE2fUZjMFBZdXEF6/thaJJIwbIVUrE88QBtRtBQvt5BWWdBsSaqdKf9hlZT86WDuirC63U/OwYyEpW+X6ahS6pA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786377647; c=relaxed/simple;
	bh=6f7+ghB7ZsZ9Ue+awqp6/hJlqoH6gS+7KkTuSOyyghQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GVCdr1wUlvFX1i3FOTIK4ip67bJk6L9c8GZLnmQ7XtDfrccYszMOn1rZij+2feoa1MzJp+KPqJwJb10QxeTrYICLRWM5CW8OIfEn9lIfUCjqg4L/BLm4glFHT5bIvjwQ9krFP1kwfmlG3iOuH29l/G8Vj0+/2HH8rfTKsBFYD/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlD17Td6; arc=pass smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlD17Td6"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-44cb057311bso1106970fac.0
        for <selinux@vger.kernel.org>; Mon, 10 Aug 2026 09:00:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786377643; cv=none;
        d=google.com; s=arc-20260327;
        b=sKDBQdKbLqIYkDmk5ot8FxtMvrLUD4U9vV0RFu1tkMP2M1PMBp6xMRxzCjNx+sS1ji
         rbpHu+e1mIb6Tr+MY8aazzr+cdTaumrpU9nkBr/J2kI9LFrNIFJEtVV9PsMOomKil7h2
         yFHIFeVqK0jBrIaxWfBCyMNH0E+tbK19V3hbjHQ7G/GgYhIwtORj6rGW7jllo7hA0xFd
         2VXHgxLdVoTo444YQg5Cjet79cb93ldrNLqXbN3q6S7U/q4jiUqCmhfxoizY03pBSkyM
         we1LQXjQmtmgI5hGWWcSvHg+CeGytsPSzmfjbolQOevKs/65itSFyK6p3DQPKwpqdMgI
         GzXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=R3yiQEOk6O8rnL+hv8LdqqI9vMGYYjtv3bKRE/F/TTA=;
        fh=o4EWA82M+vtfNglaTzMFhY8rIYTLnPpjxHW+AHnzuHs=;
        b=AcZygZptHXXL64rOmctl+DdjgRb70b9+rSYkeeJdbYPpmBnKvavJJ+TCmF6kTAlQl0
         L4/JFgdYGBdcOlvnVVgOo/Ya5WR7uFikyPCc5FrC1rzncI5IRCaGuuMZRZMTidHRCTRE
         pMDl3usXC0YyKJBUwPpX7ZZ6mxn6Tam9VeDx/b4FvVJzCr3yXlnxrF6cy6F5JBbL6RS0
         Pp0g5LX1zMmOrmKfZhgnDWrwCLf1rSlivdZ5wa6DAKj6qeOZBBtUgHvjag0NCk5IEvvx
         yFQ0vm0toK0Dux3I7njgJgqThWtavay1E59pCaC/lZ4i3lA0Sj9xEE6bYeZLTxveNWCF
         Ot6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786377643; x=1786982443; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R3yiQEOk6O8rnL+hv8LdqqI9vMGYYjtv3bKRE/F/TTA=;
        b=mlD17Td6vlZtGWVQl6xCMhHqTbiqHemJD6Zqf1aBgVnr/tOmxAtsbLy0d2PaUgsUxF
         M3d31qqmXEGC8DP9PcUpoBCyChASA4aXEX2nNleaRzDcmkdB27yidP8JbP0nqppoKWWq
         lWjChTxA/83NRRRzNlqmgTQxTN399ObGCIfA6gg064siZByU+Mf2ZEFIxfaBUH6zWcDL
         4JRcr/2GJ5VLYO2HlSKAlz7Hqhi59BoegsNqdvV+dYVRFEHBxhjlE4AsHzHKEzD7CPCj
         HlcFSdHOXgFLWyCBR+88+TUD/DMJ3id8XJavV7EVhkAyNg+nnZf8bXWGnvk7ylGM+v0K
         HTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786377643; x=1786982443;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=R3yiQEOk6O8rnL+hv8LdqqI9vMGYYjtv3bKRE/F/TTA=;
        b=oqOT25S2+Nj9gUhg9Cr+BA+QGHTKTO+zrwRchLmNbz+a0hU82NbUQQHMe5aqu0znPN
         04yqOZBNKvkTSkORuXuzeCs5KG6bqRf0+KDzpxmBuA9zBS2NUFvycDKTUsA6pQiGnSk+
         MH7rkdHTLzA+q4Drp0bpUpknkDbHl7ZWQZ14nfp5zTMdRiHrkO8u73g1NwnVPrgaZor9
         6QuQo6EcBn4TSP2X2HZ+kEeYSAZCA7MncBGJyyhyGq7Vf4jXGqU9tNJibCtwJdpMPJtC
         uleQpX7rcDJnSmKn/e577FnMHH4S4rUGFtDmaPvxF1tqVGAE5LjUZNGiidHYEPvkjdKV
         cTMA==
X-Gm-Message-State: AOJu0YzQJndlzspXhbvEnPHKmVTdI2LYymBSKN3g8YhMJxWl+J0YX1Mb
	RXX+P9Fjw7BQtSdzW1tnn01ovumHxcwiYq0dk/r4UeD3cuhWBEUewtqBdvF4/oNnDEPkMg5gwf0
	5buXqrKDEy2YtFawk6MDxrrbPtV9Gc9j4deap
X-Gm-Gg: AR+sD12ya5a5WKcp0SAUs9y6I28Cp9zsOMIe4xQLK06sxNHqGLMSt0NOV4oyj6C7iDr
	prg47IE7MTvtbZNzuHBCM6anTwO2EzNzWyFEt/9F+KEP6ZyerZcfYcLDDj1tnpBFduruKFAoYd/
	gO4AbMrSoFpq1ALt6jkEhl9BppMbxjVO9F7l0DHlwgkHxznmrFNfOhiu8zXBsx2IiyXEYEarzX7
	CGYT3xdLKwhxyJqgYtt4qNbrZFzhu3o4zmcFmsnQDVLoDgVfPBR++TFW1Ei2DX+4dHtY/ZuN1tV
	D3O8OYCh54olog81thVI+DVuPRZNmJeszzRFASJVxvD3
X-Received: by 2002:a05:6870:304c:b0:448:c1f5:90f7 with SMTP id
 586e51a60fabf-4599eec3bb9mr23629984fac.19.1786377642958; Mon, 10 Aug 2026
 09:00:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805101817.2195037-1-pmatyas@redhat.com> <CAEjxPJ5-tmkUfL53LAtg9=2_LgcB3BB875D0T4JdW5K7c-AnCA@mail.gmail.com>
 <CAEjxPJ4L9QL_HbQgtFOMxNo1RrOtaFXVjZUNGA0x=oKQ2uihcA@mail.gmail.com> <CAEjxPJ4w8NHXYTuwr4=oz8yEhDf8LAwiTOwx_VhMGqX65q0BpQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ4w8NHXYTuwr4=oz8yEhDf8LAwiTOwx_VhMGqX65q0BpQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 10 Aug 2026 12:00:32 -0400
X-Gm-Features: AUfX_mw3X5Gm66YQS1LFts5N6WCmFZPoRldWxBpJwTjUJ2EHHMOMpJWR-dDycw8
Message-ID: <CAEjxPJ4QSN4X=VRsamy9TJNq7gPQK_3KLdEwg-c_-3opJ7SEjQ@mail.gmail.com>
Subject: Re: [PATCH] scripts/oss-fuzz: build PCRE2 from source with sanitizer instrumentation
To: Petr Matyas <p.matyas13@gmail.com>
Cc: selinux@vger.kernel.org, Petr Matyas <pmatyas@redhat.com>
Content-Type: multipart/mixed; boundary="000000000000d82fa10658b374ec"

--000000000000d82fa10658b374ec
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 8:27=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Aug 5, 2026 at 12:17=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Wed, Aug 5, 2026 at 9:29=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Wed, Aug 5, 2026 at 6:18=E2=80=AFAM Petr Matyas <p.matyas13@gmail.=
com> wrote:
> > > >
> > > > The selabel_file fuzzers link against the system libpcre2, which is=
 not
> > > > instrumented when building with -fsanitize=3Dmemory.  MSan requires=
 all
> > > > libraries to be instrumented; uninstrumented libraries can produce =
false
> > > > positives because their writes do not update the sanitizer's shadow=
 memory.
> > > >
> > > > In practice this causes a spurious use-of-uninitialized-value repor=
t:
> > > > pcre2_compile() writes literal character bytes via direct assignmen=
t (not
> > > > through memset/memcpy), so MSan's shadow memory does not reflect th=
ose
> > > > writes.  pcre2_jit_compile() then calls memcmp() in detect_repeat()=
 over
> > > > compiled bytecode containing those character bytes, and MSan flags =
the
> > > > comparison as reading uninitialized memory.
> > > >
> > > > The PCRE2 maintainers confirmed this is a false positive per MSan
> > > > documentation and declined to change the library [1].
> > > >
> > > > Fix by building PCRE2 from source with the same -fsanitize=3D flags=
 as the
> > > > rest of the fuzzer build.  With instrumentation, all pcre2_compile(=
)
> > > > writes are tracked, detect_repeat()'s memcmp() sees properly initia=
lized
> > > > bytes, and the false positive disappears.  Both selabel_file fuzzer=
s are
> > > > now linked against the resulting static libpcre2-8.a from DESTDIR i=
nstead
> > > > of the system shared library.
> > > >
> > > > [1] https://github.com/KwisatzHaderach/pcre2/pull/1
> > > >
> > > > Signed-off-by: Petr Matyas <pmatyas@redhat.com>
> > >
> > > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >
> > Merged.
>
> This resolved the issue with oss-fuzz. Thank you for investigating and
> fixing it!

Got a new oss-fuzz report that doesn't reproduce if I revert your
earlier prevent ReDOS patch,
so it seems to be tied to the use of the pcre2 JIT even though the
stack trace isn't helpful.
Output below and reproducer attached.

 +----------------------------------------Release Build
Stacktrace----------------------------------------+
Command: /mnt/scratch0/clusterfuzz/bot/builds/clusterfuzz-builds-honggfuzz_=
selinux_32ddf78d9f476617df7a8f4cf22b4d9340aef874/revisions/selabel_file_com=
piled-fuzzer
Time ran: 0.02901911735534668
Accepting input from '[STDIN]'
Usage for fuzzing: honggfuzz -P [flags] --
/mnt/scratch0/clusterfuzz/bot/builds/clusterfuzz-builds-honggfuzz_selinux_3=
2ddf78d9f476617df7a8f4cf22b4d9340aef874/revisions/selabel_file_compiled-fuz=
zer
AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D250=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x000000000=
000
(pc 0x79a295c29113 bp 0x75a2940e2e20 sp 0x7ffe28467260 T0)
=3D=3D250=3D=3DThe signal is caused by a READ memory access.
=3D=3D250=3D=3DHint: address points to the zero page.
    #0 0x79a295c29113  (<unknown module>)
=3D=3D250=3D=3DRegister values:
rax =3D 0x000075c2951e002f  rbx =3D 0x000075c2951e0031  rcx =3D
0x000075c2951e002f  rdx =3D 0x0000000000000000
rdi =3D 0x000075c2951e002f  rsi =3D 0x0000000000000001  rbp =3D
0x000075a2940e2e20  rsp =3D 0x00007ffe28467260
 r8 =3D 0x000079a295c290b2   r9 =3D 0x00007fffffffff01  r10 =3D
0x00007fffffffff01  r11 =3D 0x00000eced2a34001
r12 =3D 0x000075a2940e2e20  r13 =3D 0x0000000000989680  r14 =3D
0x000075a2948d0020  r15 =3D 0x000075a2948d8020
AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV (<unknown module>)
=3D=3D250=3D=3DABORTING
Original Stacktrace on revision
64c49eb31cdfa4336b1c71e09b13b8b08435cc59 (26 lines)
[Environment] ASAN_OPTIONS=3Dexitcode=3D77
+----------------------------------------Release Build
Stacktrace----------------------------------------+
Command: /mnt/scratch0/clusterfuzz/resources/platform/linux/unshare -c
-n /mnt/scratch0/clusterfuzz/bot/builds/clusterfuzz-builds_selinux_32ddf78d=
9f476617df7a8f4cf22b4d9340aef874/revisions/selabel_file_compiled-fuzzer
-runs=3D100 '/mnt/scratch0/clusterfuzz/bot/inputs/fuzzer-testcases/cec16e5e=
e8803994da27df80ea97364cE.-6.ADDR.0.INSTR.[UNKNOWN].fuzz'
Time ran: 0.040236473083496094
INFO: Running with entropic power schedule (0xFF, 100).
INFO: Seed: 3046068775
INFO: Loaded 1 modules   (32680 inline 8-bit counters): 32680
[0x5ae1f2ea5fe0, 0x5ae1f2eadf88),
INFO: Loaded 1 PC tables (32680 PCs): 32680 [0x5ae1f2eadf88,0x5ae1f2f2da08)=
,
/mnt/scratch0/clusterfuzz/bot/builds/clusterfuzz-builds_selinux_32ddf78d9f4=
76617df7a8f4cf22b4d9340aef874/revisions/selabel_file_compiled-fuzzer:
Running 1 inputs 100 time(s) each.
Running: /mnt/scratch0/clusterfuzz/bot/inputs/fuzzer-testcases/cec16e5ee880=
3994da27df80ea97364cE.-6.ADDR.0.INSTR.[UNKNOWN].fuzz
AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D1036=3D=3DERROR: AddressSanitizer: SEGV on unknown address
0x000000000000 (pc 0x7e85a7a65680 bp 0x7a85a5cf1220 sp 0x7ffcef4417a0
T0)
=3D=3D1036=3D=3DThe signal is caused by a READ memory access.
=3D=3D1036=3D=3DHint: address points to the zero page.
    #0 0x7e85a7a65680  (<unknown module>)
=3D=3D1036=3D=3DRegister values:
rax =3D 0x0000000000000000  rbx =3D 0x00007aa5a6de0091  rcx =3D
0x0000000000000000  rdx =3D 0x00007e85a7a66108
rdi =3D 0x00007aa5a6de008f  rsi =3D 0x0000000000000001  rbp =3D
0x00007a85a5cf1220  rsp =3D 0x00007ffcef4417a0
 r8 =3D 0x00007e85a7a65456   r9 =3D 0x00005ae1f2e4f7e0  r10 =3D
0x00007fffffffff01  r11 =3D 0x00000f6b34db4001
r12 =3D 0x00007a85a5cf1220  r13 =3D 0x000000000098967d  r14 =3D
0x00007a85a64d0020  r15 =3D 0x00007a85a64d7fe0
AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV (<unknown module>)
=3D=3D1036=3D=3DABORTING

--000000000000d82fa10658b374ec
Content-Type: application/octet-stream; 
	name=clusterfuzz-testcase-minimized-selabel_file_compiled-fuzzer-5660382656790528
Content-Disposition: attachment; 
	filename=clusterfuzz-testcase-minimized-selabel_file_compiled-fuzzer-5660382656790528
Content-Transfer-Encoding: base64
Content-ID: <f_msnf2j8k0>
X-Attachment-Id: f_msnf2j8k0

A/l8/4oAAAAGAAAAAAAAAAAgICAgICAgIAAAAAEABv///yAgIAABIAAAAAAAAAABAAAAASD///8B
ASAgfCggICAgICAgICAgICAgKD8xKDAxKSkgICAgICAgKCAgKSAgICAgICAgICAg/yAgICD//yAg
KCAgKSkqKyAgICAgKCAgKSAgICAgICAg//8gICggICggICkpICAgICAgKCAgKSAgICAgICAg/yAg
ICAgICAgICD///8gICAgICAgICAgICAgICAgICAgICAgIHwoICAgICAgICAgICAgICAgICAgICAg
ICAgICAgKSAgICAgICAgICAgICAgICAgICAgICAgIP8gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAg/yAgIP////8gICAgICAgICAgICAgICAAACAAAAAAAAAAAADerb7vIA==
--000000000000d82fa10658b374ec--
