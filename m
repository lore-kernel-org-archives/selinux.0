Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F832ECD3A
	for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 00:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784854375; cv=pass; b=S7j+bH1xh2fg+OaERsf8vNz6R3Tvse5s728Ge2kG0lkis5ocrIuSw7kSTPiUXfwnC0fDR7eMrwLAwDDn/E/V6+4AMRN6QiMcD74Z/R8kvx8FAk+DKMlnNo7PyWfep88gNGstAVDs3LjCVMcuK+7C/hP3w8DfNZ71QYVI0JIbtv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784854375; c=relaxed/simple;
	bh=IMDo82cO4VffsnHNbYp//daNiFGzi/8z7IDyD/BV6EY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TQbQtkM9VqBAdCa8Kh3zWDOXj+SnRgzbJVnHBpcB0Y5XqcgmrzGnIaHDbk2OTmcPCbnVYu3S7QSJs4EcnRTv+Y6G9JFCFGvTM1jEPmnNf9AnZ0awKe3dNE/ajRzXEhMKkRR5bGzgklrxioe6SPevGLegZz7m1Bt33nx2S/Bxels=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JYTA4WGJ; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JYTA4WGJ"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-69f21b7f6cdso943a12.0
        for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 17:52:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784854371; cv=none;
        d=google.com; s=arc-20260327;
        b=MYizbzxH8EJ/Ml2PSGnxFIbvDzfTN+ddhBG3BkQL+py27YXGXsX1jS+pQ/6nI819tO
         w7f6nO1A3um/uwHi6/X207tWkojQXeVazWeCrYT98IWZ9YmRkSsCB8zhYJynGcq7F2/J
         zVTrYgMsw4pG3E5zl0/fd9LsNuHQ80m4S8oJp9TT2JdMj9QNTR27VPWebXM2iDNuKGQA
         KbsrOjlVoWiyclzpDg1HYLtgH+E6+Cbhbsmg5tfCXwR7qkuSDscO34HGGkmF8ULvCuoh
         CHrDyWesG7ZOBdydrrjcE4BgkQoMkkfMbqIWK22u7BZZWlVY3r642/ysTebtvxyvz42j
         Q54Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ncBG/aB1f6g55uZ7jLfZiPGN4G0USBiEIvXshyGyzKk=;
        fh=TmFA3aFv+IMSIqyHJoxC3a1cpq7MV4BGgZjRkjKraVU=;
        b=mjBnxN3J2CWKWM/i0w3nAhQOaNGc8j2S8yGaQaolbPSFw5u141RrFF0XkCuI5bI59b
         TksdASwEpvTrHeGo2t/njJu4Ttfs7C1znypQSm3CwQaSdRV1EacvDgWCCQmpS+2F2Yj0
         dX8usZcJf+aNA7M0/HDtnDNd7sDte0P3cI3d5n2IE5WwxR9LaRxcmBsDYVfkBxRnuLE2
         Ewz4QZt6Yoe4nBxWZyQlSYqYtm+vFut3KOVWnpXR4fkPtG1if6az8I3tKvu+6ksJiBRM
         ihxjQBhPgd/G0+cq4rV+scyBZYTJns1UPQ1sMovdx1X84Un9Y6W7ycpRum41WmF5UrxQ
         y7wA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784854371; x=1785459171; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ncBG/aB1f6g55uZ7jLfZiPGN4G0USBiEIvXshyGyzKk=;
        b=JYTA4WGJ4WvqSXKb1IVx3KNyLCtQ9ThGFPGLE6yHoWi1ASGueeudFG7U64pFH0+BAA
         Ah/gfQajR2lXu2GOC456sqSN/1LigHCNvx0N6XRJNFmeBpJVLXOPK4N6iDCUvZN/vv8v
         2Z3vZT4NqKAIB4hZKQ/fMm0CaHWc2P4oJTcnedqxNCz8FSFYb7cKHBz2a8t7N/P0u2jE
         5VwkTTcJYRM5s/rs8Gep3lwVBRaVAztwW8ITtwb7wiydoN1a9gQmGmW9AMjKP91FZSvn
         65X/5iSyGgbl6WouEpEdSDjCfpPz775yJ32gDyRh9XxVIm0oLowC8QTjSZWHY01K54+h
         NwPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784854371; x=1785459171;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ncBG/aB1f6g55uZ7jLfZiPGN4G0USBiEIvXshyGyzKk=;
        b=khSqUqoW3z5nLGwFew8PL9Qx0vl0cn6AhNOgqiLPRjpyedoS0f6e3lBRag/pPOs2mC
         bhltkR/w+T6mfCj6upeewfob46PhVXK8GJrZL2crHGt87TrqWmMEPmmpo0wh8/HM+4id
         9wdB5lkCvk00vQ054o6FKsQMFGpuKMu7dR+4IlSnF28xNg8Ucv9PCmo3LZ9RG1wP9QKo
         2AoxyNpikoWkCNQLt6P+NV1cBCevIWvNBqtKPlgHyJi6Rt6ARVtZGiIXPTzQr8EYtm7h
         DQ9oVI2kqLPINM5FpOIQ1aHwoPP5CpzO5DMgzv1lTCgA3XRiEo4g8jjn6j6hTl4BsTKl
         eqgg==
X-Gm-Message-State: AOJu0Yxw4Rn6hoP2zx5OVZGC+7+jHcEZh2f0mNsbUHWUdCPJttn/ZDwm
	2vSpvgrReFnJGfWqiW/ZVZTxl91NBGKu6eyJd3/WTXyVAn+utX42yta/0O10dsTUVGraXrh7kVK
	mvH11nYul1elvSlPChL0IcasA42Vbkz/1tAUFFCf6
X-Gm-Gg: AR+sD13DyXrWdt5yKchheU1MTBKeqsZYw4Qw1PXwwloYMUFZwg5J2GXtLALybUjMC9L
	NP7pUc75zgUs/aHsdKk5CBTQk5uBRKCy5frh2AQtwobP7sAbc+vuEJimR6WYvsPRjCPNz7M8EHX
	H8kvWoxa/6IDOHD+0Cd7SpJPy+Tp+l8pFOnYzbWejmZwMxyfkpdRD8nOyS+XC7hp+Ki3zNj3PJx
	2tgTfrvCtNzMFAGNjymNW8RPOGjPij6jUi4xh0gWN0EwnIzevusE8iIi0nLmeBhzQsRLRxyItrv
	7CRwRmegMzQh7Xc/ZcNr2+PGiQ==
X-Received: by 2002:a05:6402:a6c6:10b0:696:b77c:ba9a with SMTP id
 4fb4d7f45d1cf-69f92649f99mr13634a12.1.1784854370318; Thu, 23 Jul 2026
 17:52:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723085829.318778-1-inseob@google.com> <CAEjxPJ5pux18BCR4FoQ38LsWHz4faXhsQvPQCGyC-YsqVzibRw@mail.gmail.com>
In-Reply-To: <CAEjxPJ5pux18BCR4FoQ38LsWHz4faXhsQvPQCGyC-YsqVzibRw@mail.gmail.com>
From: Inseob Kim <inseob@google.com>
Date: Fri, 24 Jul 2026 09:52:38 +0900
X-Gm-Features: AUfX_myNCm8bzG95pG8tfsAMObZ1YHKF5ntfSuAPc8CxSOYiengQYSGJSS1Q5WE
Message-ID: <CA+QFDK=u3Rejm4mESPiHmJD4QZKdHQuFL3A-idzJ7Oyun4FxXw@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: improve performance with pcre matches
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, tweek@google.com, 
	Eric Biggers <ebiggers@kernel.org>, =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 12:44=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Jul 23, 2026 at 4:58=E2=80=AFAM Inseob Kim <inseob@google.com> wr=
ote:
> >
> > From: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> >
> > Since 30b3e9d2 (libselinux: Workaround for heap overhead of pcre,
> > 2023-01-12), performance of PCRE2 matches has been affected due to
> > excesive recreation of the match_data in an attempt to reduce memory
>
> spelling /excessive/
>
> > utilization; instead of a workaround, it would be better to address
> > the problem and maybe even improve performance in the process.
> >
> > The issue is that currently the structure that holds PCRE state has
> > both a pcre2_code (which is per pattern) and a pcre2_match_data (which
> > is per match), forcing us to add a mutex to prevent multiple matches to
> > step on each other.
> >
> > Lets remove the match_data and the mutex and instead allocate one once
> > in a thread independent way that could be used and reused, by extending
> > our pthread interface to not only store TLS variables but also retrieve
> > them, and then use one of those.
> >
> > Since we are not interested on the capture groups (if any) lets only
> > allocate 1 pair which is all that will be needed and change the logic
> > so that a return of 0 (which means the pattern matched but there were
> > not enough capture spots) is also considered a match.
> >
> > This will ensure that the memory use would be bound to the number of
> > concurrent matches instead of the number of patterns and therefore
> > reduce the impact that recent changes on the way that the frames used
> > for matching are allocated might had brough since 10.41 was released.
>
> should this be "have brought"? And is 10.41 the pcre version?
>
> >
> > For cases where threads are not available, just keep it working in slow
> > mode as done before the workaround was reverted.
> >
> > Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> > Signed-off-by: Inseob Kim <inseob@google.com>
> > ---
> > v2:
> >  - Fix the dual destructor antipattern by separating the thread-exit
> >    destructor (match_data_thread_free) from the library-unload key clea=
nup
> >    (match_data_key_destroy, annotated with __attribute__((destructor)))=
.
>
> This won't free the data on dlclose() of libselinux, right? Not sure if w=
e care.

You're correct, it will leak on dlclose(). And I believe we don't
care. Freeing that memory would require maintaining a global list of
active threads, which is infeasible. And dynamically unloading
libselinux is extremely rare anyway.

>
> >  - Eliminate the data race on match_data_key_initialized by using pthre=
ad_once
> >    (via __selinux_once) for safe, race-free initialization of match_dat=
a_key.
> >  - Remove redundant match_data_initialized thread-local variable, makin=
g
> >    lookups purely based on __selinux_getspecific().
> > ---
