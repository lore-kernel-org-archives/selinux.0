Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38745430302
	for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 17:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785433378; cv=pass; b=mjju/iqBWfxv73toxuIMII/Z8LTgAaH6AdUETRVYrk82rzOJ3hvYeVBXgX4Kyb/2RXJqImAlcP7V0zGVn7djh0xeMxVUiiuqKM1DYKiqkXhPO0PJxtT+FmKYP21bp3MBapq9kAubqU1gqKmSPDNrdDsocf5V+aeTf2FQxPrXui4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785433378; c=relaxed/simple;
	bh=/dsxluCURJB95PXdQVsU6kMttiVqmHJqtcwOcOS3PB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=me82AjpST25KmMOiDXUAzca5qLtZQRstYd3xh7Cv1lf5c8EgXy6OKgx2srXTYRhhmkVrmC3BEs/nwmwoEMlJM/10AmJzT5aSmymM3d7DpZnPHT4WaVxpXnrcnQTM6/8atC6cOfVJTwvrnYrWiKywCkcZBgDfzruBvw5n0MgTPm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=US+8nZaM; arc=pass smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="US+8nZaM"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-455ca262ccbso110774fac.1
        for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 10:42:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785433376; cv=none;
        d=google.com; s=arc-20260327;
        b=ZruxGjB6n4iWqEbnXDJh69S9642sDUQaoEqdzJek+XBFWiGexFuGHXH+ecd5Ve7xUR
         xqBu/sy5kyfIv/s74ewwjob6SOZwXl7xEhGN6ujJifPPxUt//3z4QBPrbsmf0Zh3YmVy
         qL9e1R4wasDTt4Tw5+AlK64F9Yhf3oiiJ263mZz74K56CKgG99OLUmffwWBPCD8iwom8
         5YWZ/TfuOZXwZS8qyx4Y0dvwqV3qJIizcVHUQH3EOOQlYTXrxyRK7SnXVAVp2IFlRf6r
         24e24exj+ymMRG0VW9UdeKX0jZtQuEpQ6fdZYL5YoeVF4O9gqCYKiFa+9TzN0bLOhC/V
         7ygQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xMR/pSIy44zqtkRnqacGEIMS2LAoP0765Nc/3c8+lXY=;
        fh=o4EWA82M+vtfNglaTzMFhY8rIYTLnPpjxHW+AHnzuHs=;
        b=cq1sFR+VXVoUAhDSpi2qX4e1q3+Wfc6nO5YN6c0BnAvd02n13uSGbXh/L41xxwVO43
         XLK0upib8Cdqb2MY1NIvAm+HyhVdB2yCMOTWLORVQKSPxoQH0lAadO0pSq+11+rX62dJ
         +EeIPjx5M3UG3At5uWgwQxJy9UpvTLlZKfi6kpwyzaXsDABW9EXQiipTbio8Soj8L4zq
         PRd7xN73t/0K9hPM8nmymQPi5IyE1tkDS7OLYH/mUvchSJcf0faZexGi5bKB+eIbBxxN
         M/9HI472dvKCCl67jQi2nWIMPIQf+SP8mbH8fKpqNnQJKijJHak9CntkA4NASXbDCnze
         3xFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785433376; x=1786038176; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xMR/pSIy44zqtkRnqacGEIMS2LAoP0765Nc/3c8+lXY=;
        b=US+8nZaMhxA6JumMcKw0NIp0UlC9UF0jRfp/bH0UOCUgb5qqq/6uPAbmzJR/L9lYRw
         O4SAcJLRWkgUAJZ+zqMQIk2WXU0xX9bSF/kVDQyBoVGeJZxdkTSp+Eb3hmhDMQeUBZYJ
         FrT0wQF+xFhe93aoLwlz/1CiblcUl+XbNvAr40+3YbxUVlP46sdTscrkL2XPegcaKcul
         UVjh6dJkAfih25EGPpejalu9YEdvuYyxwfWjhNsFazWHkZV+j+WIcDJIHRlKq2VNeZ49
         NN/9vBBbaZGAG7OttRZffYmlTxR1WjPjCOEmn0+6fUAPSDUwP4d6lLV3PVmCTzE9twZr
         B6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785433376; x=1786038176;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xMR/pSIy44zqtkRnqacGEIMS2LAoP0765Nc/3c8+lXY=;
        b=K2idEwHYJVdfqmy6QZavMT2i5x8DZslM7XfpNykTzVuPo7S0IsT++6VvZv+ermYq3A
         OkpUnnshR8dvUZWLFRrCPmoO/NtXMTMfR/Eiv0GTkv2FHm2Ppmdfg2QgzX5R3Uv8cppf
         +SnzwYUsJoaxJWrPLP82It/wQ25vMf72NgncHiqsGEZe/nT+LVwTbP5JboT/GULJd6cN
         4gn5elHxSDlbXDokk2/MA24ubGtyxW8twIiT4j036YLc5kxUTPCj7PZFjBTRdPdOMXuj
         VB4REDdLoivHgaprUb+KajYHQvexDxB1v/o4r60k63EvxfNdYK+JNzzdpeO+JgJS8sk3
         HA7A==
X-Gm-Message-State: AOJu0Yxkbii59EX4P2Ye0BYsxxlHVgbkUyvSZPOTR6vnsGwYO3KNORIt
	KU0mUa32187TQhmneieAHiKAZIOqQ2cM7ZzQrL05pnV8E5TWkTdHLSyhm/gJr9QECBqVLRDDFC/
	ljZUkXFt0trWjRF59hahT1qy5OCDwCxHn/A==
X-Gm-Gg: AR+sD12i+EwdH26NUqQvaW1zd5DWDuLXPJMfg37fvuTlYN6htGMbyAQ9FmI0PcRttFc
	vzQHC04l5i+BQ16pjdmccT3KpVdzyl87Z+p5ztgoxG9ULQYhfVXppxtAG+pyC9E3Gag2/vLFK8g
	0lzNXnxbcPW5tJ+xxRk6dc6PYbjJL3Ih3Kv5mpEIf3ADwlGjk5fDOKlYpL7DNLdSjPsl/Szt103
	j1mIlmM8Qg68vnFQ76iAIL880ZfBGgjPjcVYpO3HJ7Jm5QL/fVZ7bxlL1LEaSuV+ge+g0VkyqyQ
	xxhhxHHYB1Dx72/MggPwViaSMC4lO2nd+YYWUmXoJrLM
X-Received: by 2002:a05:6870:390a:b0:448:952a:d3c8 with SMTP id
 586e51a60fabf-458c0f0f70bmr2564404fac.12.1785433376004; Thu, 30 Jul 2026
 10:42:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730085713.1484927-1-pmatyas@redhat.com> <20260730135601.1510501-1-pmatyas@redhat.com>
 <CAEjxPJ6-dU+zGDQejk_uUbH=a971ZHFY2W34oM+e2+=8xfh-BA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6-dU+zGDQejk_uUbH=a971ZHFY2W34oM+e2+=8xfh-BA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 30 Jul 2026 13:42:44 -0400
X-Gm-Features: AUfX_mybra0Q1A9fVlF5EqLraKhg87HlXyazP7vetjQfB7dAXxhrnqlWWwDq79A
Message-ID: <CAEjxPJ6qonOZwyspc_nA6WGfbYUi0k74p+P7RNRWdSizqsXgZw@mail.gmail.com>
Subject: Re: [PATCH v3] libselinux: prevent ReDoS in file context regex matching
To: Petr Matyas <p.matyas13@gmail.com>
Cc: selinux@vger.kernel.org, Petr Matyas <pmatyas@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 1:23=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Jul 30, 2026 at 10:05=E2=80=AFAM Petr Matyas <p.matyas13@gmail.co=
m> wrote:
> >
> > The PCRE2 interpreter is susceptible to catastrophic backtracking on
> > crafted file context patterns or lookup keys. Since libselinux never
> > called pcre2_jit_compile(3), the JIT was available but unused, leaving
> > the interpreter exposed on all platforms.
> >
> > Fix with two complementary mitigations:
> >
> > 1. Call pcre2_jit_compile() after every pattern compilation (including
> >    mmap deserialization) for both complete and partial matching modes.
> >    pcre2_match() uses the JIT automatically when available, which avoid=
s
> >    the interpreter's susceptibility to catastrophic backtracking.
> >    Note: pcre2_jit_match() is deliberately NOT used as it is known to
> >    produce incorrect results on some platforms (e.g. aarch64).
> >
> > 2. Create a shared pcre2_match_context with a backtrack step limit of
> >    10 000 000 and pass it to pcre2_match(). PCRE2_ERROR_MATCHLIMIT is
> >    treated as no-match to keep the lookup safe rather than failing
> >    noisily. This bounds worst-case matching time to milliseconds for
> >    any pattern/subject combination, regardless of JIT availability.
> >
> > The vulnerability was reproduced and confirmed fixed on:
> > - RHIVOS 2.0 / aarch64
> > - RHEL 10.3 / x86_64
> > - Fedora 44 / x86_64
> >
> > Reproducer (149 bytes, base64):
> > AwovMi0GLy8GCygKeAYGKwYLKAoKCgAAAPpXKgsoCi8vBgs8PG5vbmU+PgovMi0GLy8GCyg=
KeAYG
> > KwYLKAoKCiNXLy8wCwsoCgojV1dXClcqCygKLy8vV1cueHhXV1d4eHgveCsGCygKCgonVy9=
XV3cy
> > eHgveAcGJAsoCi8tLwYvMi0GLy8GCzw8bm9uZT4+3q2+7y8=3D
> >
> > Signed-off-by: Petr Matyas <pmatyas@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.
