Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8EC383994
	for <selinux@vger.kernel.org>; Fri, 21 Aug 2026 18:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787336444; cv=pass; b=dmxiwOsQavr/yyiFI6OQyC9mqLHAOMzko07JpgKZTFOKJ9gOCz8mgwOscR6QI2Q/HTDG7m7sMH9FQMyJEFqnHc1VBic09K+t5pXLGMNJGSs3LBMzCyl5LDc9wJTzz3mPpbjTCIk56mpjNsTRkdR7Gvn12bFNZkilYKeVVCBwfv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787336444; c=relaxed/simple;
	bh=0jl6nI4TwrprIJeWhBr1CYQZqt57EJMbSePY6OM4ARY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bt0O6tjdX5T3NQxoFDkOnY4IXJxFEh4RDSHlsfvErOQn30nv5tlwRR83O0uYFwgMInB8XrkR9KJGszTtLmPiknbg5RT055wAZb3HFdrJZln+HiDWZM+bmmmYvLRhh4WfXbeDJqVCq5SLerD5VuIsr98hSPQBiUC5sJllE/3iRVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aiM6sOw7; arc=pass smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiM6sOw7"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-455ee8f529dso453200fac.1
        for <selinux@vger.kernel.org>; Fri, 21 Aug 2026 11:20:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787336442; cv=none;
        d=google.com; s=arc-20260327;
        b=FekqB3npsxoOmm1cmRDbGoxSxyJQLa1Mq5e8NWC0fMrIrX1pw6nPFn6n/+HHI2zSWi
         bLGaiNO6cDG04NnrW7VHpir68Z5pt5qs6Zsrjpmtd2bsgMXeJASnZyQlhybG/6w205u4
         coHSAhhOhRa2aTIVYJVg3YkkTj58F11upitvrN8GCGaHYNj+ZSogHsgFpFTzXXPf/f+B
         mR3MI5Hm3vtfpbI2pb5LiPu3WOFPQRgslS6wgnqv6t+G1YiGqXC25/5Wf7PvsVSY35ia
         HfdHtEuk9YMQkW/O7JUnUty7R/Df9z5ER6OxWK81TdaiS/BNWxYdqnR8pKz5eQAoye66
         T8NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T7Dv4TrPaoSXba2WCG6znATh5Fj8cQnvCq6iaJnQwe0=;
        fh=zfDUEDhb3Au3NJI3MrDnWhPolJWjYyhfJ7v/XOCD7XQ=;
        b=eXWuzspNWQamK8azjAoVjM9GiWGKcV8SYRpK312DQDDMjCNzSFB8zsb7FliKg1rY/L
         3RexvYExXNEFJEgnYhnEvH20n5FybjrTbCdVi0cCTAflf3YqeSFHZLi0uKKxAQLdJsDc
         jACeHMSgqcd38ERubEbUjetzgpBCvaRsJAT1P5oMARMQ7TU/GWOHmGYcAzutdMCw5Ny+
         unRvl4VZYqdeiUg8VMr2OO87QFViF2gYEGL1/ySLC3eqjWzGkWJIymO2UmXTAQuLX+vQ
         0HD0R8B2TDdmIl1wvghiC+IecciEaOCAeFTnL2CdepV7ZJffsTx8nlMCOk8iTmgaiH47
         IiOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787336442; x=1787941242; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T7Dv4TrPaoSXba2WCG6znATh5Fj8cQnvCq6iaJnQwe0=;
        b=aiM6sOw7Ig9mu12SCq5qAYx2S63Z2xubfGa1TAZXn8jcvz4TPad1nNSXP6ED2Hj/hZ
         yoEKPpG+Tl8atGoSKMwM7SthYiaCO7BR2GhCS6YcsNukOUzjVsncr8/B+NLxiqUuDSEE
         A/WFmDuiOANxSxdGHh2qmQS8wazdO0PoktS9LlecQxic2X2vmhY0xbiWP7K/0GsiVMXS
         i6r9JPhqVy77XU4fZIxe8yOLO2GuPCwewSRpAgfgn04uSXqwNr/z46t73mha1Q9maMXA
         Yk2LanweaGDqqNWmH8WZqtGm/47LPwMHucL7IucvH6FmfzFodnEsno1RF54v5ImHTV/w
         lO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787336442; x=1787941242;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T7Dv4TrPaoSXba2WCG6znATh5Fj8cQnvCq6iaJnQwe0=;
        b=h60VRXXD9420Sr4BWYyqBHzX+ZfknvOk22QutEPTMTlcF8a/hi8PkuD5cXsG7CPkvl
         9+u+0CDHlvVGrMnEpV7MNb0OPElKm4qwr26bhVLs0mJuHF/fJWUN6dtRm2Sq4QtnY5WI
         ncegF9XfP4fyWeq8li2WNW/5BdcLlRAw3/ENC39P1JkXd8QFEQVAvKniOxenVUCRacC0
         O9pnlrv8x3CQdu0IYcqxi5CFMId15PGfDWqEk1sTx8Ng87DWRK+o27340A+y9WoRwu12
         K4jaC15/1nYTGNLJWIV1jtz1DghaEHRIvLgBMAimAsXfYBHYa4N/VWLlXtkTmvsU3SkH
         L6uA==
X-Gm-Message-State: AOJu0Yw7TglRITOyFN98R7YHbdjRVlqk3ADNdBhbiZLPEEIrCmC0pkNH
	CRJITfnOoUwARJ7kPtNrfXGafrnL9ICtGaqDz+nrMBRgotkuxUTwE6GOGcNjYi0QIOkdKbuvpC4
	5GKeA9ZtC8hcPLC5bxZMsuafdKVdqU4NAOQ==
X-Gm-Gg: AR+sD100uos7pifEIX1s54/cPPtG8rwfbQy2oL6grdyQ58o6Fa3mlzPzXH8PM4JjXDq
	3Ox8AifMtY3tcHUJLp/UKGKZsDvHYuRE6txpGzOyBS1f3Na+imhtbkRuB033DNMzoJIkcs0UG/d
	92Xk4nVmM6+J1k4kiDInxmHv72uaJZHUFhxeYo1pyXcNXJtdoFS+2ctdoXE+24xQqu0hKPJblGh
	2Y1oEQzzndJS4ILVdvvpCJWvVHWYYjNMk/7dg+Aa0WoX9IwDJp6S9cX/uywZ9keGBhG0VpYHTpf
	kSiME/28FynLiyfZbLSfmTB0XGDnDsBq1coNXA4Y/vp4
X-Received: by 2002:a05:6820:f02e:b0:6b1:28bc:c7c3 with SMTP id
 006d021491bc7-6b16b4d7a25mr260118eaf.36.1787336441787; Fri, 21 Aug 2026
 11:20:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729131413.1390890-1-pmatyas@redhat.com> <CAEjxPJ48Ov9pT6oZ6Q-OU5eJMObA1spPnFhdcKOOjmrSAD7pQg@mail.gmail.com>
 <CAEjxPJ7uiGT9VDg_dqG9Y=p_Ckrd6BFYQPKOrsMGpBuJVVTGwQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ7uiGT9VDg_dqG9Y=p_Ckrd6BFYQPKOrsMGpBuJVVTGwQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 21 Aug 2026 14:20:30 -0400
X-Gm-Features: AcwNN1Upzo99shjhSA36mKdnKylQOuMEynrlIxmaUn8Afjud6zGjOuoCITlx7tc
Message-ID: <CAEjxPJ68QBO9TDBN26z3WGG_eJCUxrBbJGLxk_=Na4acipmvEA@mail.gmail.com>
Subject: Re: [PATCH 1/2] libselinux: prevent ReDoS in file context regex matching
To: Petr Matyas <p.matyas13@gmail.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Jeffrey Vander Stoep <jeffv@google.com>, Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, Petr Matyas <pmatyas@redhat.com>, 
	James Carter <jwcart2@gmail.com>, Petr Lautrbach <lautrbach@redhat.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 9:21=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Aug 21, 2026 at 8:55=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Wed, Jul 29, 2026 at 9:40=E2=80=AFAM Petr Matyas <p.matyas13@gmail.c=
om> wrote:
> > >
> > > The PCRE2 interpreter is susceptible to catastrophic backtracking on
> > > crafted file context patterns or lookup keys. Since libselinux never
> > > called pcre2_jit_compile(3) or pcre2_jit_match(3), the JIT was
> > > available but unused, leaving the interpreter exposed on all platform=
s.
> > >
> > > Fix with two complementary mitigations:
> > >
> > > 1. Call pcre2_jit_compile() after every pattern compilation (includin=
g
> > >    mmap deserialization) to engage JIT for both complete and partial
> > >    matching. regex_match() now calls pcre2_jit_match() and falls back=
 to
> > >    pcre2_match() only on PCRE2_ERROR_JIT_BADOPTION (JIT unavailable o=
r
> > >    not compiled for the requested mode).
> > >
> > > 2. Create a shared pcre2_match_context with a backtrack step limit of
> > >    10 000 000 and pass it to both pcre2_jit_match() and the fallback
> > >    pcre2_match(). PCRE2_ERROR_MATCHLIMIT is treated as no-match to ke=
ep
> > >    the lookup safe rather than failing noisily. This bounds worst-cas=
e
> > >    matching time to milliseconds for any pattern/subject combination,
> > >    regardless of JIT availability.
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
> > It occurs to me belatedly that this change (which we already merged
> > along with several follow-ups)
> > likely triggers SELinux execmem checks on any process that uses
> > selabel_open(SELABEL_CTX_FILE,...)
> > due to the JIT compilation.
>
> I experimentally confirmed that this does trigger execmem denials on
> Fedora if I setsebool deny_execmem=3DTrue. The denial is not fatal since
> it falls back to the interpreter but it will show up in the audit logs
> for any confined domain or if deny_execmem=3DTrue for all domains.
>
> > Given that fact along with the fact that
> > we are still seeing cases [1] where
> > oss-fuzz can trigger stack smashing on pathological regexes and that
> > this was originally motivated by
> > concerns about such regexes and that the source of these regexes is
> > always trusted (root-only config,
> > and in the case of Android integrity-verified, I am starting to wonder
> > if this change is harmful rather than
> > beneficial. Open to others' thoughts. At the very least, I suspect
> > Android might want to disable this.

Barring objections or counter-proposals, I think we may want to revert
the use of the PCRE2 JIT
to avoid users of libselinux selabel_open(SELABEL_CTX_FILE, ...)
suddenly triggering execmem denials.
We can keep the other part of this change intact.

> >
> > [1] https://lore.kernel.org/selinux/CAEjxPJ6-b4KmkgSgO7hXf+8ZGgRtR_JkS1=
ZQU-ULVk0aex5zCw@mail.gmail.com/T/#t
