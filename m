Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD1E3AC0DC
	for <selinux@vger.kernel.org>; Fri, 21 Aug 2026 13:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787318502; cv=pass; b=Eb5MnHsDmfxTV2yuCaIBJhY2MopDqvJcIraNoFa27gFxVBDaMscHecWU+GAQlJi7Mx0ZRgq0LZltRi5oxjyWg3sWScPGgOexv4JOZQqaCuriASIS93BbMQILxnPocntfIm+Y3HaLcT9c/lZpjWQeN6OTVX5O1YBz2bcJ/iU8Eco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787318502; c=relaxed/simple;
	bh=pN79TuPnOXahuFvAPwFIg+UTJhH8/XD7NG8wQB4zfyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CL37pmrkdWfmviD4d8ItTAMITFgQjeXOIDf+Y6k6l43n4m+Kd40KvgbEKe4MHlrlblayvtQMx3CDViYOOA/Ijjmbai9DpSZzs4K3k9U4W5wv8RORdGv0w0wCb0EslcsSqGxyIX5iKHWCQhXgXc7aFhQn3Km6GvALmb5PaUkdEd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RyUyObZE; arc=pass smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyUyObZE"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e9f69ee6f4so1206969a34.2
        for <selinux@vger.kernel.org>; Fri, 21 Aug 2026 06:21:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787318494; cv=none;
        d=google.com; s=arc-20260327;
        b=svP7JkfN0TZzi098w/7WpzPmVJDwzH2rxNkRsS1UPUmX6CA4LVcx9GRQvEOXzNptOt
         LLm3RduEYYbnXFo/VqNgm+Eew9/utN6Ty2T0Um7ab9i0cgrzXC3765zdtMChK/AvR6lH
         4Hyz7EcH5ieF+RjF9qi7H1mDG+vSr+cfCsKRIMVxYmHhsiHqYngekvr2O7sH5YD0OjqF
         ZopMBE3dcUQF84/Epu564g6i9jqzSvBGNbzK4ke2tcsNDSqmhwIIGKLwkdtnPyTRLNnx
         KAopCN4hdThiQ1DME6kwkd/T+s3zzJ6YNvLx+/UCgNuaJDSlitpSSiBQfKhW4ve4apvv
         iP7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AJ6nOztJfky/szHsSkFaDUfztD/s4/VuHlqaKwCwC/E=;
        fh=zfDUEDhb3Au3NJI3MrDnWhPolJWjYyhfJ7v/XOCD7XQ=;
        b=WzP2Dx4Sh7bqsjr0Kk9Emovy8c8t6U0uEgtZWN4KV6lKc/wtdkM8oOoYnr6i4zdOkb
         cKvvGaAhIh5/BDdTZ20Q5m0Vpok+I6nz+OW3gQOjlsLAhMoB2UWSPcJaOW3AHdu2iE36
         R3sneV/Eb4oQjFTAvVLbOqcLttqkZDyADJrkjooZnlo+N00MgYJp9WiHnRy4QMlqrTO6
         GMIyV5Rl141+4eomgkiwnfhMv7eA9BXhdYfaaAB2EYbgcjG2x7kFP2f1wK9LeCCjEKdE
         caAJ7MTIz1vYQ+1jq39jQKvRlG2D1SGydhFHWrQy3p45cbH4YsCMWriarzhpOWPB2uhc
         0FAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787318494; x=1787923294; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AJ6nOztJfky/szHsSkFaDUfztD/s4/VuHlqaKwCwC/E=;
        b=RyUyObZENLKvQdl0+N4doZOBE9P98+7zKouKPyB0YujnVe+nf35TtnT+SfXOBfmtx9
         ID2OXAJ/DlmQoqJtdMBfm8bshbQw9NhLxxez4NWRjko/Fd1rByczYJvWQczV2pe0PdXB
         BxfYefe/ZQIM/ihTbdcCiP5iAkVgGUE713EG76rFtlEGcNMUBs1R8x8Kx8mL6t/2qs+/
         tItFUGoy8Zl0kwjS3eekx111KspXrn8VpAiLB6ESXnAj5IXIHeoA6l3TqwsZ1UbWy4Fg
         ctCFp//cR4kLXiTC3OwoNTVefU4vI4z5zsRLu2fUw/mtFVGm/FiPWiZ5z9iIUrGuP2fF
         YFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787318494; x=1787923294;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AJ6nOztJfky/szHsSkFaDUfztD/s4/VuHlqaKwCwC/E=;
        b=kcQ/x/afXNPd4SBs1L0sfeqM1V97YlN2z0gz34N+/rbTSrfrKx2i8f4E/8Uw0i6Ab5
         0JXrhdSNzxdUqjfpsIa7gittGbeZlLg5AoazCdu/t2+0Byt7tOucuBOCPTv/s5WiZjqX
         5euz5EjJLy4Q9UorKD93tkacMbF/hTOqsQwMrBDEOTFwlaeD/x6Jy/gRzpvpqoN9+V0e
         qSgbFH+ZE/0DBN1QZG+KlfFjYZCCoJ7PdVDTqnFarpfEIIL6D+rVm7wBZlmRUqhEqqhp
         t4mgKXCCvReh9uPe2WgzmmpH98miTAryD3XC3vnR1YfrsCLz+i5ynxM99Z8Hv7mLVIS5
         EjkA==
X-Gm-Message-State: AOJu0YxOOGFK4ZpQ0RLERtIKsA8EZEZRufnx7XqzT7COHjTSGMdwHn9W
	dRCR4IzhpIqeKSrNfeA31jIhYg+nrBhaunWREox8YtmQwtOLr0XrqkPtLAXQj/p3MJw3fQeZh+y
	rIgBGFCSYzB4b4pQdQP2OM7a24E280SY=
X-Gm-Gg: AR+sD11JFIAVqWfEZ5opn/L+sJCYeA0oY68Fi7sRUqNOrUGDh0gT1aWrFcmdg7FB+cK
	Em9Og2eV6eY6mIbEeQKim/AMJVLMQBFR61c/WjQ9b1gPNx5rH4+ItS8X6r6O2vxiSXImq4LF/wI
	O6qqYgh/ybHj+/tZu8JwdLojwpjdh09dAv99gBcTIEVnAmZ8V/HAg/JRIeQYaWAZDl3Klxgwwik
	mWrI62Fbk2AD/Kr2SGqneLUHbyJB2DN0FW9K4wmnggwbqvVncAbet3UQ8D0YBwXKdARwMfJeyY/
	hupv4pGxMTZHKWWUJRY4i48+sgAJIAS/n+3QRPOF9p6BJz9ZgXMTQHU=
X-Received: by 2002:a05:6820:16ac:b0:6b1:6462:7e35 with SMTP id
 006d021491bc7-6b16462963fmr1046401eaf.13.1787318494638; Fri, 21 Aug 2026
 06:21:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729131413.1390890-1-pmatyas@redhat.com> <CAEjxPJ48Ov9pT6oZ6Q-OU5eJMObA1spPnFhdcKOOjmrSAD7pQg@mail.gmail.com>
In-Reply-To: <CAEjxPJ48Ov9pT6oZ6Q-OU5eJMObA1spPnFhdcKOOjmrSAD7pQg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 21 Aug 2026 09:21:22 -0400
X-Gm-Features: AcwNN1XEzO8ETBRWP2xkmBjJS3kCTXlTmHu0Mc7EisXIST2nonetlRs9IkU9Mbs
Message-ID: <CAEjxPJ7uiGT9VDg_dqG9Y=p_Ckrd6BFYQPKOrsMGpBuJVVTGwQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] libselinux: prevent ReDoS in file context regex matching
To: Petr Matyas <p.matyas13@gmail.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Jeffrey Vander Stoep <jeffv@google.com>, Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, Petr Matyas <pmatyas@redhat.com>, 
	James Carter <jwcart2@gmail.com>, Petr Lautrbach <lautrbach@redhat.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 8:55=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Jul 29, 2026 at 9:40=E2=80=AFAM Petr Matyas <p.matyas13@gmail.com=
> wrote:
> >
> > The PCRE2 interpreter is susceptible to catastrophic backtracking on
> > crafted file context patterns or lookup keys. Since libselinux never
> > called pcre2_jit_compile(3) or pcre2_jit_match(3), the JIT was
> > available but unused, leaving the interpreter exposed on all platforms.
> >
> > Fix with two complementary mitigations:
> >
> > 1. Call pcre2_jit_compile() after every pattern compilation (including
> >    mmap deserialization) to engage JIT for both complete and partial
> >    matching. regex_match() now calls pcre2_jit_match() and falls back t=
o
> >    pcre2_match() only on PCRE2_ERROR_JIT_BADOPTION (JIT unavailable or
> >    not compiled for the requested mode).
> >
> > 2. Create a shared pcre2_match_context with a backtrack step limit of
> >    10 000 000 and pass it to both pcre2_jit_match() and the fallback
> >    pcre2_match(). PCRE2_ERROR_MATCHLIMIT is treated as no-match to keep
> >    the lookup safe rather than failing noisily. This bounds worst-case
> >    matching time to milliseconds for any pattern/subject combination,
> >    regardless of JIT availability.
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
> It occurs to me belatedly that this change (which we already merged
> along with several follow-ups)
> likely triggers SELinux execmem checks on any process that uses
> selabel_open(SELABEL_CTX_FILE,...)
> due to the JIT compilation.

I experimentally confirmed that this does trigger execmem denials on
Fedora if I setsebool deny_execmem=3DTrue. The denial is not fatal since
it falls back to the interpreter but it will show up in the audit logs
for any confined domain or if deny_execmem=3DTrue for all domains.

> Given that fact along with the fact that
> we are still seeing cases [1] where
> oss-fuzz can trigger stack smashing on pathological regexes and that
> this was originally motivated by
> concerns about such regexes and that the source of these regexes is
> always trusted (root-only config,
> and in the case of Android integrity-verified, I am starting to wonder
> if this change is harmful rather than
> beneficial. Open to others' thoughts. At the very least, I suspect
> Android might want to disable this.
>
> [1] https://lore.kernel.org/selinux/CAEjxPJ6-b4KmkgSgO7hXf+8ZGgRtR_JkS1ZQ=
U-ULVk0aex5zCw@mail.gmail.com/T/#t
