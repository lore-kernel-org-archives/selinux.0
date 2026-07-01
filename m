Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB8E3D9030
	for <selinux@vger.kernel.org>; Wed,  1 Jul 2026 18:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782932113; cv=pass; b=mDO3yv3DR+mWcvsq+7niN+hcoatug9yktVYZISuoFpnckj5eO20AaqPDyqbdpjblS5hc0UpKmDsnRyMr+4THKf3Lqyqc9g4kfmSiqWGlBGh0vrf+s8o/+Ye6udI6LDs/bLsUDKGrk3zKF85h+cNUbwJQkwTMJumr9JmTAcOasAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782932113; c=relaxed/simple;
	bh=8buDy9oFy7HqwiHwNvC/IY1j1EOpHRqlqLYOv6/jg5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZneoxT613/Ng/NIDQrUJQGq5TExmNWKT2rBa8EG7L/CfQvR9aENSuAPqMDcG62BAXeZ/XSTJll4pBbrz9V3IE7qZ3rEUTqoktU1lvMDVxJuLsDpXEkV6ny+5Rrv1fBHCpAQDdIB13DVW4L8/HcwMGTOMpNHEx6XgQpHoh8TOXik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bzatAeQU; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bzatAeQU"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c81db32393so99355ad.0
        for <selinux@vger.kernel.org>; Wed, 01 Jul 2026 11:55:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782932110; cv=none;
        d=google.com; s=arc-20260327;
        b=b2rJ59GD8u0y6E3gPTco9FotzvckTrc4Aqc/XDbaLIlVGJaPx1whXzMlF46eQ2FFWK
         0abBSflKfkhqQknfkipHJ794Qh1zfBBulouqdTkgLT8BMvp0CLg06ExsqijE9h5ZJv2n
         rU4tuwRN7qSezTIbOmu5AAaH0CjS/oC8XE0LpNV2XF+ABTnXRavlv7aAeL+yRIoHeNQe
         nmil6eGJE2xMxFdRZ8td3DxxW49/HU9IC6tgaIOv93bt92HtozRtId49aHmN/iv5uq3x
         hemari+3B3HCFQUXASlopooaer2xLTKINayV4Fkjhi0rhhzs6PID5p6fRfkTxhgLZ7no
         OqLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0KVQLfMeEV5+XrO62oTopJy7auZvfc7K1ZIzGuRBDo0=;
        fh=sjJ+EnPAsXl1ruDkY4RrgbEJOCKktjkD24GtMSvq/t0=;
        b=YRVwVt3WzUO3wURAeIbFCUNfVeUdr9L/hJVNEwxlFDt8r69kR2O0Js+Keh/Qt8cK5x
         3t//Xa42qCmFEb+fIyWJD50Yh0kR4xkepktizCzUC4jgWwjvIDtG9NlZRWTBWTZeHgWh
         TVmp+Z69+GIDRqmPqORTigViaE50WuGuM3WppM30Pc6AQm0WzLpp0kN4nfPema75KLN4
         tXaPqCmNZ15JSZ2RgKYoNT2VHChSYIw9ac/ZP2odxabDBkuiyzG7FFBlMvMbESMn+96s
         l2q7ug70h0UuVYK16gK8QkKbhXtklR9vcYA23mGKO/3nu1ixj/pmouVZ0pvOr3AfV4Jc
         zYGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782932110; x=1783536910; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0KVQLfMeEV5+XrO62oTopJy7auZvfc7K1ZIzGuRBDo0=;
        b=bzatAeQU/RLXAy2qMom5Gv04X8bnpCQey2vyYnFWSXbaM5KwXAkcXNVjsCQVyZCero
         2QJ2IJ2XUjMSGpWnCauT2O8xcd9Q/cFhghMIeSlosiNQfJ1G0OH0l1uJs+t7Zv8V4CJj
         mf8N4NYJVHuDJ2rMh6jb2vuoCTC53PED0fiUl7v+fLMVR8QMFgwegf8ZxB6HpwvIsLW9
         Qh42q35SbiiC1f0+6WuKMfIDSsip8UzJuTyoadFN+wP669UU3cIW+df1H9SvXvmBDKui
         9gs6ntk4d2FAUfddyl1AXgQC+FXEuQXEPKV6+y89lpZ1ZSeHZD8lVilllPb/NOmCvJAN
         q5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782932110; x=1783536910;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0KVQLfMeEV5+XrO62oTopJy7auZvfc7K1ZIzGuRBDo0=;
        b=QaZ9LEaXvQwGHqUo6dqHjhVgNNnvao20MtI3L3APmb/UpCYekgkgRTMvjlIiHSyNer
         HERLi8AiryxGxjgU6TfP8toNFmwcVyPVXrOtnfVKhw0QOy33/GF4fgvzbz6YKNA8jzn4
         nOJgPSNGKmrVENJfnQCtYWnd8GqNcdwScd5mX1d8qqn7VkC14DW66xSkwFtMcUTx9It5
         Ztw/uAhaKetmhp9gqb7XV8lze9kFBgOjPvNuRvRzGQvBRnvYZr4qE1Jf1VCDWJTT9DsO
         sGZ6PBbWUZQnNhGN7GgpNXKLdEYFwBshg2G6pc29EjN8fGC+j1If6r25lPywAiKYbKIX
         RKwg==
X-Forwarded-Encrypted: i=1; AHgh+Rp+RW/0G9ezA7dd5M04ZxImXaiAV+WlOUaNO43DmVEUyMYoldk1qtgQK8LIvLNzQbvnrDhzBqo1@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0ipRq3cH4yHsalRKqTs7Bc8sVjDwZR2+AJw+rHAcIvWim1EHd
	5b1wz1aFFC51u9UVwKZiVMUZ+CYpQFbuVdngtWdsi1OsyKS2E1a6ylfSeB+uCCishwVtBbsF2CS
	TmeI4byqYp97n/IhpXtYW6cR7IYWr9H3gXGczwW6V
X-Gm-Gg: AfdE7ck25MS0gnDpBCAiwK0ah7Oh2SdccZV7PmE9bz9zlc1UukBus/fi+ya4TzKtOx0
	9nbTFENYC2AZ8+ZAeeVvF1OnCn2JCBwxW9th3wFlXUObrxxUuVzPII//mlcN0NLIymjooWDqxiq
	UtwqVhA08HRqca0QvnE/fjevPS/pqL3m8ixH12FbW7RMTUZJM3yGkC1BFZPVxRkb90Q+1cyW+ub
	ZFuoGquQ1WJsNPsZRJITr2IbjkWd+D/NKoedJQJ/1nGlBcW+maHZwdTEr2ECCOfX9ckt7s4fw==
X-Received: by 2002:a17:903:2411:b0:2c9:cb98:f4cf with SMTP id
 d9443c01a7336-2ca702dee37mr3196675ad.14.1782932109302; Wed, 01 Jul 2026
 11:55:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701062321.517351-1-omosnace@redhat.com> <20260701064301.GH48970@noisy.programming.kicks-ass.net>
 <43dd9d9f-2348-43c0-8af5-77ef260c64a3@amd.com>
In-Reply-To: <43dd9d9f-2348-43c0-8af5-77ef260c64a3@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 1 Jul 2026 11:54:57 -0700
X-Gm-Features: AVVi8CdPAA2Awq9Kv3THzlusc-_st-D6y-Dp_4NP8MgglOFbQydRDtJegutCxds
Message-ID: <CAP-5=fWDjNUPgzoFMQkHZV_5t175_L9JTjU-k7=5LWD2TCoQjA@mail.gmail.com>
Subject: Re: [PATCH v2] perf test amd ibs: avoid using executable heap
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 9:59=E2=80=AFAM Ravi Bangoria <ravi.bangoria@amd.com=
> wrote:
>
> Hi Peter, Ondrej,
>
> >> permission under SELinux (things like JIT or regex compilation need it
> >> as well). mmap() with MAP_ANONYMOUS will give us a zeroed mapping that
> >> begins on a page boundary, so the result is equivalent to the original
> >> code even without a memset() or the page-alignment dance.
> >
> > I would argue that having RWX is a problem, you really want RW->RO->RX
> > transitions, so even with mmap() you want to combine with mprotect().
>
> My original intent for using RWX was to generate sufficient Icache miss
> samples for the IBS Fetch unit by overwriting the code prior to execution=
.
> I am wondering whether it would be possible to achieve the same result
> by using CLFLUSH with RX permissions. Something like below (build tested
> only).

(Minor 2 cents) To make the code more canonical JIT code it should
probably use memory protection keys for permissions.

Thanks,
Ian

> --- a/tools/perf/arch/x86/tests/amd-ibs-period.c
> +++ b/tools/perf/arch/x86/tests/amd-ibs-period.c
> @@ -25,6 +25,7 @@ static int page_size;
>  #define PERF_MMAP_TOTAL_PAGES   (PERF_MMAP_DATA_PAGES + 1)
>  #define PERF_MMAP_TOTAL_SIZE    (PERF_MMAP_TOTAL_PAGES * page_size)
>
> +#define mb()                   asm volatile("mfence":::"memory")
>  #define rmb()                   asm volatile("lfence":::"memory")
>
>  enum {
> @@ -41,10 +42,16 @@ struct perf_pmu *fetch_pmu;
>  struct perf_pmu *op_pmu;
>  unsigned int perf_event_max_sample_rate;
>
> +static inline void clflush(const volatile void *p)
> +{
> +       asm volatile("clflush (%0)" :: "r"(p) : "memory");
> +}
> +
>  /* Dummy workload to generate IBS samples. */
>  static int dummy_workload_1(unsigned long count)
>  {
> -       int (*func)(void);
> +       int (*func1)(void);
> +       int (*func2)(void);
>         int ret =3D 0;
>         char *p;
>         char insn1[] =3D {
> @@ -59,33 +66,42 @@ static int dummy_workload_1(unsigned long count)
>                 0xcc, /* int 3 */
>         };
>
> -       p =3D calloc(2, page_size);
> -       if (!p) {
> -               printf("malloc() failed. %m");
> +
> +       p =3D mmap(NULL, page_size, PROT_READ | PROT_WRITE,
> +                MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +       if (p =3D=3D MAP_FAILED) {
> +               printf("mmap() failed. %m");
>                 return 1;
>         }
>
> -       func =3D (void *)((unsigned long)(p + page_size - 1) & ~(page_siz=
e - 1));
> +       memcpy(p, insn1, sizeof(insn1));
> +       memcpy(p + 128, insn2, sizeof(insn2));
>
> -       ret =3D mprotect(func, page_size, PROT_READ | PROT_WRITE | PROT_E=
XEC);
> +       ret =3D mprotect(p, page_size, PROT_READ | PROT_EXEC);
>         if (ret) {
>                 printf("mprotect() failed. %m");
>                 goto out;
>         }
>
> +       func1 =3D (void *)(p);
> +       func2 =3D (void *)(p + 128);
> +
>         if (count < 100000)
>                 count =3D 100000;
>         else if (count > 10000000)
>                 count =3D 10000000;
>         while (count--) {
> -               memcpy((void *)func, insn1, sizeof(insn1));
> -               if (func() !=3D 1) {
> +               clflush(func1);
> +               mb();
> +               if (func1() !=3D 1) {
>                         pr_debug("ERROR insn1\n");
>                         ret =3D -1;
>                         goto out;
>                 }
> -               memcpy((void *)func, insn2, sizeof(insn2));
> -               if (func() !=3D 2) {
> +
> +               clflush(func2);
> +               mb();
> +               if (func2() !=3D 2) {
>                         pr_debug("ERROR insn2\n");
>                         ret =3D -1;
>                         goto out;
> @@ -93,7 +109,7 @@ static int dummy_workload_1(unsigned long count)
>         }
>
>  out:
> -       free(p);
> +       munmap(p, page_size);
>         return ret;
>  }
>
> ---
>
> Thanks,
> Ravi
