Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E6D202C48
	for <selinux@vger.kernel.org>; Fri, 14 Aug 2026 12:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786710276; cv=pass; b=GRZXFqNADWRdFGxYxH05hCtIK4SWlNjAAcS3TxeAjL9zmie8JcI+ikRGOaMG3UxH6ygwSoyu/b8HzrnjOXoA1lD1p/g5hoe42s1JN1u8XjNsnMFQkfkNkhioI/yvDDkR0iTk8+ZSexc6DQLJkR/VdXFwFPrGUYlQsTLeSHl5f9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786710276; c=relaxed/simple;
	bh=mtu5IjwyTKABbucVfucWA4B8Ib5j93b1aaX3z3Jwctw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mnFSCn+FLDYdF3CNexXSQyWTu5M1DA9L+OIUz93zzymZ7XEG3/hPfbJMryqhD1hRriINB1CpH+3S+sxAiVP4QWFCRKuJ5HndIqSu0zy869NJqmmn3eNyVGdJ3Gu0WJKmZRuQF0fJwdP/5t0SfajOipv4G83xDFvnYzugkUUDe8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TW2OD9Oa; arc=pass smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TW2OD9Oa"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6b049ea7a4fso344449eaf.2
        for <selinux@vger.kernel.org>; Fri, 14 Aug 2026 05:24:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786710273; cv=none;
        d=google.com; s=arc-20260327;
        b=I8qRwR5l6Ka9KcMP7wi9y58zNUu7IoVTCVZXP70xrP0IDqNVnzNXJUTe3FJ0I4rEyC
         sMrDcH6m8GkNscihgx8WmnuKwT9tG5+C9PRxfStuIam/j8iOW2YNR6Tpo9MyEuYRA5zp
         bkbSKtJFmB5kgaTaJz7EssFa3OP5QHQu+AK4pO7KH799A1vn9XZzJrqit5HnhGMMYbey
         8+qIiG/RuS+JSYUusNPh5b/3byrgEgGP4rE1EtmzyehU/zk+m/RzaKH3J/FnYuKTDEso
         VoXknuA0mEG+NzyWPwRjY3QEhwr3Kv0JB/46il5iZ1HyV0LV/OgCAGlsPSo9RQHM5tkD
         Rxmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mtu5IjwyTKABbucVfucWA4B8Ib5j93b1aaX3z3Jwctw=;
        fh=cVZI269ioQuwKzLGwbELyMvF9+q8sQJU42mbMSjvW4U=;
        b=gPy/flNWhetvF+A5s0rqlHMPfmfOjkvhimi7jo2kLC4or9DfzolrkzUe09n+IOV8an
         JmiWW661fG8d/QcSHDQl0+Wna70w1Z5VkWM3dy2Uzd0SOndeFdgGxkUUGTWjgzAQUSvp
         cd+0fdRNXR2YGhBJ1sjCyusTDHuwm/SF90K+Y1VuOqCjlCYLkOpPkmcQfyAJVxiY9iGL
         cb8b37U1wTCcqubjNgFMNxnGf8SHFlgDk95YUqHfY7IV9ha9OWC6YPshwBMIpdM/cjJR
         UWYZo0E5VnlGy2gE6BZxn9lqS9fumDentbOeVYUHbYQrnzhcdoxQOvzCO000zaHbHMLL
         KE3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786710273; x=1787315073; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mtu5IjwyTKABbucVfucWA4B8Ib5j93b1aaX3z3Jwctw=;
        b=TW2OD9OaiMPsfzLepTDKHxAd8tjKtclEVkXswV57u0WA1So0wppUUHNTR+W1S6QTyO
         MsJoo6SQu7SlEq/BNoRWumomsV6Qf+nWVFYkPoNH9TGo48ffOobMjZh+xpLlD4yenAcK
         MEXAMrKlaViDezwezSDVRNtdR4BmSJAIw2axKj+0qjdXP93zmHGAK0VXkPy33K/lAy0H
         8shSe2UWXglUl6uBrwSuPSQGy8DiKyg6yi7xwiCEdNjFcGAsWidE6eJlOgf2fen0dtyh
         PaKVoxvvDtWduq1umhvPItVOoml6BDge8GNSx6AChsXD+veOWRZIynDeCN3Q20L7Jtmn
         1d+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786710273; x=1787315073;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mtu5IjwyTKABbucVfucWA4B8Ib5j93b1aaX3z3Jwctw=;
        b=XNl9oKo2kPcrFP5a5FYGh1/KbSHbJ3pvtYnzmJXuH4YvBlgGQ3gbgcHctj0EVj2wNx
         3ojn6ZrtXm7E/fon1SQH3uAkpjQVDPQhepqfvjOET0D3e0X1HASyBZLYehWuYczhxQBN
         Ru209jYbitBgzuYiBExCj5SYvU3fpoKJUxAZXJhQgJWPEdM9xMb1lJGGS5WznSXF86Ni
         es4ICl99Hz+9xrj/119QGPka7eAgg+i2h/wO++cFMDSIu5fPOiFIYqM8hjY8dy5OHnx6
         C/MayZLHSdSLSn4ARRcAFvGv9p0D/uLW+th2I3lYXVd/0IQHAwvUJx0qscoBgbiGZQBy
         L/Wg==
X-Gm-Message-State: AOJu0YyJRsyb/l68m8+fwvv6X0sdskt1PpYLvSCM1G8Y3RRI/joW+/yj
	eXrVOmVZvOaJ/wg9KPTOdF94/8vCSxzNc8TnHFYFZqR8gNGpiG8nAxR2Jip7BsHQmyAwRipB+uv
	KcMnmm/IjRMegoO6u1O6yYUl3O03alaL5jg==
X-Gm-Gg: AR+sD12hWnTiFZVR9EAdjlBEQVMsIJejxfaPgSKInLxW/PWgi2EiG0lU/6+qvml8H6J
	LAAHfKZPWeLBt9K6j6RS1VnandP72abHzPajCoCKp5/JKr4Z4fI4XY0iDQCA7Ly7hbQ7pMCqXGl
	yS/zEEqRs3qztBOi43VxGm/G8bYG0ZKbtllpwlW9gQybjfAS0x1vPl/1R92Y/cB8qPaZnd6qIBb
	rNsmYkI+PY7nTIO0+5/eKPsgyT1m5YqDQvSR3ArGVWcBvMf9XD+oq+4EIWHG9dy/hUvUsGehnM8
	nML9ZZpY5jvxMa3XvQgy1JhP23iiL5R1cQFJJ0mnMtOa
X-Received: by 2002:a05:6820:f07:b0:6ae:55f6:2cdb with SMTP id
 006d021491bc7-6b0d5fca98bmr4328015eaf.1.1786710273313; Fri, 14 Aug 2026
 05:24:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813073533.3253251-1-pmatyas@redhat.com> <CAEjxPJ4yW94x_DLSe=zdmfKB95aagFmydTKsBnWGfjc6efr4hA@mail.gmail.com>
 <CAEjxPJ6uL5L=hMc3Gz0B20e=UhDcnWL2WyK-_xbM6Gv5KruDRA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6uL5L=hMc3Gz0B20e=UhDcnWL2WyK-_xbM6Gv5KruDRA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 14 Aug 2026 08:24:21 -0400
X-Gm-Features: AcwNN1V51SmyMAhRwLljnAwjWgtoKCuHAnXifBRCkXk70_THWB3EEqKK10cbahI
Message-ID: <CAEjxPJ50Stiwx49xS4rkvcRjuzGsEYhAyECCAckw1g0EWvZpOA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: fix SEGV in JIT matching of recursive
 patterns in partial mode
To: Petr Matyas <p.matyas13@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 11:35=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Aug 13, 2026 at 8:50=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Thu, Aug 13, 2026 at 3:35=E2=80=AFAM Petr Matyas <p.matyas13@gmail.c=
om> wrote:
> > >
> > > The PCRE2 JIT compiler has a bug in its PCRE2_JIT_PARTIAL_SOFT code
> > > path: patterns containing recursive subroutine calls (the (?1...)
> > > syntax) cause the generated native code to dereference a null pointer
> > > at match time. pcre2_jit_compile() returns 0 (success) and the
> > > compiled JIT size is non-zero, so the bug is undetectable at compile
> > > time and only manifests when pcre2_match() executes the JIT code.
> > >
> > > The root cause is an interaction between OP_RECURSE backtracking and
> > > the hit_start tracking mechanism that the partial-soft JIT uses to
> > > remember the earliest position at which a partial match was seen.
> > > No fix is currently available in PCRE2.
> > >
> > > Commit 92af7f1b61db ("libselinux: prevent ReDoS in file context regex
> > > matching") introduced pcre2_jit_compile() calls with both
> > > PCRE2_JIT_COMPLETE and PCRE2_JIT_PARTIAL_SOFT. ClusterFuzz
> > > subsequently reported a SEGV in selabel_file_compiled-fuzzer via a
> > > crafted compiled file_contexts input that triggers the bug through
> > > the lazy text-compilation fallback path (version/arch mismatch causes
> > > the pre-compiled PCRE2 data to be skipped, so the embedded regex
> > > string is compiled on demand via regex_prepare_data()).
> > >
> > > Fix by dropping PCRE2_JIT_PARTIAL_SOFT. Per the PCRE2 documentation,
> > > when partial-soft JIT code has not been compiled, pcre2_match()
> > > automatically falls back to the interpreter for partial matches.
> > > Partial matches remain protected against ReDoS by the 10 000 000-step
> > > backtrack limit that was introduced in the same commit. Full matches
> > > continue to use PCRE2_JIT_COMPLETE and are unaffected.
> > >
> > > Reported-by: ClusterFuzz (testcase 5660382656790528)
> > > Fixes: 92af7f1b61db ("libselinux: prevent ReDoS in file context regex=
 matching")
> > > Signed-off-by: Petr Matyas <pmatyas@redhat.com>
> >
> > Thank you! This also appears to fix another new oss-fuzz report
> > (selinux:selabel_file_text-fuzzer: Heap-buffer-overflow in _pcre2_scrip=
t_run_8)
> > that just showed up (reproducer attached and output below).
> >
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> This is merged now. oss-fuzz should let us know whether it fixed both
> of the recent reports.

Just to close the loop on this, oss-fuzz confirmed both as fixed by this co=
mmit.
Thanks again!
