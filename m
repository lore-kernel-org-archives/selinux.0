Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808BA30BF69
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 16:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782231909; cv=pass; b=ujIuBYkffzd7Miuxm6Esrq4RAkfrH2W0UU48VB+own43914il10fY7QfVd4+wXvyFyWx9i78wMqaF8hUatXlYuBPUth1S5N8+TITWsTOPDQgg+XuZ/g/Fv5DMSRLcuGFCCvxt9qjzWwmsIi4WKrCXI4eUwY6fExIGsnl/n8MqOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782231909; c=relaxed/simple;
	bh=rTHAX23ztf/y3XZV9K98po6vRsHQd4NmlZpJumRdym0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s8ZPHZhpd7+m2NgECEGd7kGZhEJx6+6XW75mjGMBwovL8k7UNcAuftBSbC+YHGJ2vKXKlI3plBkZ/daQeg8i9ifRRfJkLrIKhaSZND9yOOjb4ESW5BDu/1x/uQwtOiuTaiRjuRO1ra8ng+6SgFzVBT3N365LRVNhw0AU3TTSNbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYydhi5I; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYydhi5I"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c88cc025f54so907a12.1
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 09:25:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782231908; cv=none;
        d=google.com; s=arc-20240605;
        b=E9/AI3Lxlo7CYNmbFvQy5JlD9c/AHKMQt/oiem44fxVifKtcWKGMyb7NEXW1DpIzBq
         SB5ePBp5ohh2g1s9FpasL2ngMsi88G+vYMdOWn7CfzUCsYgHny4w/AMCGSbUngyLD0jb
         KCZfqaqlmHVUFy54QG0T3VmaMUWV0ksCJ3yW9Zc935QGLn8DJX8nA1dDbm8wnW80n2uL
         yEXp+x6TIKikhAzipwHefK8/55b0eAaa7S4I/cMbbyJWE5EadR1tEyBVqurp6uMQfdtw
         f/tpon1oz1H0Rq7i9JDi2rUqBujM4ZTXJYTYmsna7zRMzyIcy1KHG4Qswg4Uc2jT7t1I
         Y4Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BFfydrJ3KffkImdn3XOVJzv9hh+F0JLq2Y49kiixr88=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=QjwJbNKGXSj22FK83tSA1A4bddl20jkSRiNvlI14gy4uJBtHQjyDw4N4MP+Os4eSsS
         Se38qfCvCSj+OtrL/p6NoZVPcrlH9Nm/IjfbqaeB2IBwEeNcJrcCk6zThidQgBk8ALyZ
         FSkolBZ8/xUc8KmGIDRHig1o6j+cdvR003hlgbqqM7HQgKU3Atz5y3Tzpop4IQInLlN9
         hJOSYtx50oLAseNWfu0QohOBbmBEWSc15rbr2s8RhxUOGtVB4DFWbPc5VcPDzPdNuM8V
         9Lwpl2Ie7o+Qm28zZIcsfAIRIidCQThUkYosmoEOu2hKGF6mhxsh6Svf5PZQdYYBwU2P
         OBEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782231908; x=1782836708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFfydrJ3KffkImdn3XOVJzv9hh+F0JLq2Y49kiixr88=;
        b=dYydhi5Iv16f3/J4+2DXG3/yMC76ND5lmoh4AV0AFnD0YYG0nZ/5lD9neAJvMJIbmt
         LLy0s+BQOUX+Tb6TkEsJRXySt/lsFHWLdzrBnU9S7AVhpkesSihKIMz26c90ggzeMG4X
         Hp8pbptmODrql7Kcyx1YKmlbAQeKA7lBZ8CMR8Lb9Yskc2J8KJXlavs2jLKlFbg4FwRc
         bjytbV3L3Qec2rNkz5N/jeuI+oJ5jFu6dV++Dy9Czl+c3nwMuFLpg768P+RUuY1G/YHQ
         3dNwlr10EsXj/s/0cPBXMobUty/0ed00Kk6hOzlAkqtCFJVthdRLNrlO3UP3ol3ZWNqw
         X0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782231908; x=1782836708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BFfydrJ3KffkImdn3XOVJzv9hh+F0JLq2Y49kiixr88=;
        b=AW5RBC+m1wWABHDM78mDW6V6We0mSEywS43Luc8afuD9Mkgb4PeLdGq6kpTBPwisuU
         xQX0+YNEv4jLKqxCeAw3Kw3Zb4hkXdEJ9JC9mg6lBWQoodEo19fNZIml/aKmQTkheudr
         s7RAOntbh4351XtXC76+Acgt+re7I7Q1t+taqpdmwYY/xxhG96L9Qt4oYcBtBOVlye0e
         uiphkJ86XXjKsgms95gcN7QwxJHHwyU0lSvDucH4qhenKrwfWRGhhpJpNtP861DVNTz+
         LcG6/oPLaOd0yewI+ZXrMSnQpj0UYYs343G9yJLPjIfjI3srp1HHpKMNI9O/+JuMqcvM
         9rXA==
X-Gm-Message-State: AOJu0YzGLC86H9PbPCWkN4Cdbx7B8DErwhX0PO4RxU0Z3FJCrTLw2/9+
	o1iKGxK9oXcgRmhdknz6fb+bubLOh5vYw4leAXAVKERMgS3PBbf9S6X9ukS/suroNo7eQkQIFX9
	dxZBkA8cRLiXs5dDBTAgAemGH3xw7fsTpnbzP
X-Gm-Gg: AfdE7cmU2MLOxTZuZauLvq6Sc6kpHxpsqFbO+uQNp25WQXRVJlzLTtq6jo9zAze/hvz
	VXmcOZO1Huj9Z4Rmfgf0U//tmeUav3Iy81EYBhXPW6gVCw0SIhka90eRosAPdt0QL9NjMjm4BCI
	f6+kEXOBPHZB+9dhv+wrD1mRHdzWDCaP6sscHFaU8tZqTXgTNk09vfO7ZNXqeA8tvpd/807kHYR
	kD/3EMapsm/wFj2VRfS5bvfCsi/dr5hfDUJMmMtFUu7WDIr/ecmV8Vh16kGbIgrHngAH8oT
X-Received: by 2002:a05:6a00:3e15:b0:842:38d2:a35f with SMTP id
 d2e1a72fcca58-845952d836dmr4649223b3a.31.1782231907684; Tue, 23 Jun 2026
 09:25:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623154937.16913-1-jwcart2@gmail.com> <20260623154937.16913-4-jwcart2@gmail.com>
In-Reply-To: <20260623154937.16913-4-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Jun 2026 12:24:55 -0400
X-Gm-Features: AVVi8CfJFR1DWvN12a7epSuyrDe_j9aZjuf_JTg-SEZBZCADgxKJ9BGOGEkrDjI
Message-ID: <CAEjxPJ4Pean50WgM8FkGVsJYTq137orPwyQ9zLz7TD4N6y4_vA@mail.gmail.com>
Subject: Re: [PATCH 4/6 v4] libsepol/cil: Add overflow checks and cil_reallocarray
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 11:49=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> The CIL stack implementation uses "stack->size *=3D 2" to grow the
> size of the stack without checking for overflow and calls
> cil_realloc() using a multiplcation that could overflow.
>
> Use __builtin_smul_overflow() to grow the stack size and exit
> with an error if there is an overflow. Add the function
> cil_reallocarray() that checks for overflow of the multiplication
> of the array member size with the number of members and exits with
> an error if there is an overflow.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> v4: Switch args for call to cil_reallocarray() to the correct order
>
>  libsepol/cil/src/cil_mem.c   | 12 ++++++++++++
>  libsepol/cil/src/cil_mem.h   |  1 +
>  libsepol/cil/src/cil_stack.c |  9 ++++++---
>  3 files changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_mem.c b/libsepol/cil/src/cil_mem.c
> index aeffdae2..4f75122a 100644
> --- a/libsepol/cil/src/cil_mem.c
> +++ b/libsepol/cil/src/cil_mem.c
> @@ -74,6 +74,18 @@ void *cil_realloc(void *ptr, size_t size)
>         return mem;
>  }
>
> +void *cil_reallocarray(void *ptr, size_t nmemb, size_t size)
> +{
> +       size_t array_size;
> +
> +       if (__builtin_mul_overflow(nmemb, size, &array_size)) {
> +               cil_log(CIL_ERR, "Overflow\n");
> +               exit(1);
> +       }
> +
> +       return cil_realloc(ptr, array_size);
> +}
> +
>  char *cil_strdup(const char *str)
>  {
>         char *mem =3D NULL;
> diff --git a/libsepol/cil/src/cil_mem.h b/libsepol/cil/src/cil_mem.h
> index 7ec316af..f3f40c46 100644
> --- a/libsepol/cil/src/cil_mem.h
> +++ b/libsepol/cil/src/cil_mem.h
> @@ -34,6 +34,7 @@
>  void *cil_malloc(size_t size);
>  void *cil_calloc(size_t num_elements, size_t element_size);
>  void *cil_realloc(void *ptr, size_t size);
> +void *cil_reallocarray(void *ptr, size_t nmemb, size_t size);
>  char *cil_strdup(const char *str);
>  int cil_asprintf(char **strp, const char *fmt, ...);
>
> diff --git a/libsepol/cil/src/cil_stack.c b/libsepol/cil/src/cil_stack.c
> index d9c7b0c0..da2efa5f 100644
> --- a/libsepol/cil/src/cil_stack.c
> +++ b/libsepol/cil/src/cil_stack.c
> @@ -77,9 +77,12 @@ void cil_stack_push(struct cil_stack *stack, enum cil_=
flavor flavor, void *data)
>         stack->pos++;
>
>         if (stack->pos =3D=3D stack->size) {
> -               stack->size *=3D 2;
> -               stack->stack =3D cil_realloc(stack->stack,
> -                                          sizeof(*stack->stack) * stack-=
>size);
> +               if (__builtin_smul_overflow(stack->size, 2, &stack->size)=
) {
> +                       cil_log(CIL_ERR, "Overflow\n");
> +                       exit(1);
> +               }
> +               stack->stack =3D cil_reallocarray(stack->stack, stack->si=
ze,
> +                                               sizeof(*stack->stack));
>         }
>
>         stack->stack[stack->pos].flavor =3D flavor;
> --
> 2.54.0
>
