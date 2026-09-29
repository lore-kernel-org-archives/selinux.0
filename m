Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E621B3DA7D9
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 15:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790696526; cv=pass; b=SOd/Wox8ylzPmSl1TYtrR3Fp8SCcYHGzaRhLevMNXkIKcxalMhSQTniSgY2ccwYAhrLUptpiGsxHkq6Z1eWfZARs4TX8wN0jPP7faZSF8f3uBIGBmpPC6S0ucwRteax89tV3sGniAM9jYWm/LBe0ZQUsyhKaVi4x3M1+1vs4lt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790696526; c=relaxed/simple;
	bh=mLs6pBT9pNRnMG264V38n57wNmNjVWkAD5Ybi80k/cU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VUitLIRlpfa+DtFEys/0kcmEKm1tQMQpUyr+XJgUdn9uG+fFdNdaC0QoG49ho6YNeTh5Z9/T5gr18wSQiQ7mGerzO0JxLVAtuK2F4tQA8nE/YRSHVk6kyloY3zy+m9a9Mi0upNyj2ZvYRpblj2k4qe6P9X97gOX1QQsUs4Mf6og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqS9jEXO; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqS9jEXO"
Received: by mail-yx2-f42.google.com with SMTP id 00721157ae682-8a7411012b1so40232507b3.2
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 08:42:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790696524; cv=none;
        d=google.com; s=arc-20260327;
        b=Ry/oxIxeNyZA/cpuA+UDwn++RAZb/NUZzfXhaBcFDWP8mA66IEF6foHz0vlOq8c7Sn
         qCZJtgRw7veqCh7EjLgm8qdnJlPtrzVMmfC3Iw/pjidldx4rY7EhwtaTv+8dRhTOMKis
         NYo9Q0o1ZMeQN3YU4vh675mdX4nBFgbQLNjB+X18ilcR97YFT/1n7o4HCTy8mDNXgsM4
         S6h5gUYFaFvusVQeOvUZpZAa2wI3PsEQNDCmznBgLNplOy19iTpyg4X+QK3OgORszm6g
         9mKuYoAPuPGeFgtRT6vLl/mMHOxbmJLVYqKl1hT0r0vXp16idu9j87NZqigxNk45rV2Q
         Fq5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Tb9dl5RnzcAiJkeJNuHm3Nb7DxX9bNgaZJkwsUjfTZo=;
        fh=ynz/8+FwD6qg4pGsVrM1o3ZMcJz6Z9Ld9eMncvonVNU=;
        b=j2klL04yMg+fEhFDGjrnm1muRU4jcQ5VaUX1mxtT7P0FKfHKQkjsqVUJDk9M6wKXUV
         TxFnWPNkUOkE1s7rEI9hXEuv25pD8dsa+k5fZjBU8ChooZOxILD2xpZwlaZv4Gkt9gCg
         UValM1/7MWSikzH4vuNlFaJ1hCGxcTR431cyZugY5vEzt52FronX3H3gP2AIVgQgSulV
         mk2zeweKQzdPQ0i5UT4iuUlMQBuz23cMjb7p8fvRvjQgj8w5O5TayFFITFPmGlkdIMXx
         CLLHT2QbEz1D9/NdlIj1TSolbRFFNb1n+qoF6U4N9NtwY6NH8nXJhljFczJ4IyggyFVb
         lVGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790696524; x=1791301324; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Tb9dl5RnzcAiJkeJNuHm3Nb7DxX9bNgaZJkwsUjfTZo=;
        b=gqS9jEXOfJ8zdfFG1p7yvv4wg2WQstnCNxOh7yev5wIbTAzM+hK9JXuURMjeYCT+Er
         JkF8dGWLy1fm82WVNyZG98AVa7GFpxzuN6NoaSbiVCp6uKStCI7XfLjW6+061BSV6QfB
         D2mmojrWk5oJ32H8lSMxxVcUf+wt7bFmWCG63DZNTJvAuHRCfHADg9/ShihbkBgk2u1o
         Fh93sWuystYVMB5d1M6wRbGCxxVth1UkLLJQnWysWsa99WzCKaWh3OdIodcE8j+Whk/S
         Nx4swCpRWYUrrjSMOxZWdTSizjGYMi/4cXVr4lHc4kr3bBQflmbPTskrIzqDbbvSYZhN
         Kh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790696524; x=1791301324;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tb9dl5RnzcAiJkeJNuHm3Nb7DxX9bNgaZJkwsUjfTZo=;
        b=1zVQ3KlepFV/Es1QkczVa3tXN6PfJ6tkhYBenIZFZ6H/V8fafLBX0bL+MakpA9shbc
         XtqpZOFUexI1kqOrwJK3kO1xlx2TTBVL3DVpUY0Vjm7m745+AThwaNiRaKVNYZb/toE8
         Rf0+G+mR0BoO/krh9n2UC2IMPbo2lLnfdA9HNiu9iphpD4ldfs95ZIkpGWiaPNMWQ+9y
         b0sfV5oCyBgYdT3Nh4vwsvHqfaLhWX0IVXMecA8G9bGU4x4wb5KD7tf6l/vtMk8TomJH
         vWCOWFfxfzsRa7a16xbgn6TI0OkTESsDjqsH3DvQNWQAVNHztLWPHr1zVKt0BxraCC1N
         FOxQ==
X-Gm-Message-State: AFq9FYJIhNMw+3aFNqSLpl7v0CU0t/kzKXaqcRot5/PrG1nHXbVZ2Unv
	SpfBqkKQLHX5QlmDWWJ8xZfY0EKTZFMeiaZdFC3Yjeds61QZiFAGuzqZLwwayprRtV7Zg9MaUv0
	sSGd6Ga0OziNLPpOKVwqBuNE7xde2LUA=
X-Gm-Gg: AYBFou26/kRSlqJN6DLHmxYiTZYRJYqb9LzJWJGkuCTWYwNEaJN/JsnX5FJinR2KaAQ
	K5KVFcVIp1AjIR4HgQd07zarAy97hkYMvhEvvUXCue1CdFlhM6biOfZhfkLyYpPuJ5R07qY8412
	fTW5BFWwcQgM4WQoY/NU2eszi3k1i47vZqaL9fQwXsmG4Ow9YkDq8xBaMUyoh15mEnUu/7YPreR
	h9um7112oP+q3O/NoLWS9sm24wS0mCtOqxm12VjEtSjoDKBtvfGmY2ZPyiQTzD8xLRrhyXK81dI
	RZzWhY4fxkk7rNF99FPfPxI0E/kuOl3okzX+oTjGPwz2lZ4bpcIR0b0=
X-Received: by 2002:a05:690c:c6d4:b0:887:f24e:cb60 with SMTP id
 00721157ae682-8a86d67354cmr37371517b3.38.1790696523762; Tue, 29 Sep 2026
 08:42:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de> <20260928174643.2458710-14-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-14-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 11:41:52 -0400
X-Gm-Features: AclHuK_OkM7gQdQt0vjqZHplffIOCQmXpGNjtT4DoLLn_6TxzLzrxaRfOYAnkfc
Message-ID: <CAEjxPJ4MxRzs2tVAtq7EcsL8R0=PtxA-aKnPKyEi63qhRRN2Ug@mail.gmail.com>
Subject: Re: [RFC PATCH 15/32] selinux: make mls_level_isvalid() static
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnacek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 5:23=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> It is only used within mls.c.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Will collide with
https://lore.kernel.org/selinux/20260928165253.2388012-1-cgoettsche@seltend=
oof.de/
Recommend dropping this one.

> ---
>  security/selinux/ss/mls.c | 3 ++-
>  security/selinux/ss/mls.h | 1 -
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
> index 3b2f888506af..81e6cfd0272b 100644
> --- a/security/selinux/ss/mls.c
> +++ b/security/selinux/ss/mls.c
> @@ -156,7 +156,8 @@ void mls_sid_to_context(struct policydb *p, struct co=
ntext *context,
>         *scontext =3D scontextp;
>  }
>
> -bool mls_level_isvalid(const struct policydb *p, const struct mls_level =
*l)
> +static bool mls_level_isvalid(const struct policydb *p,
> +                             const struct mls_level *l)
>  {
>         const char *name;
>         const struct level_datum *levdatum;
> diff --git a/security/selinux/ss/mls.h b/security/selinux/ss/mls.h
> index c107b5182fb7..49efb1808ef0 100644
> --- a/security/selinux/ss/mls.h
> +++ b/security/selinux/ss/mls.h
> @@ -29,7 +29,6 @@ void mls_sid_to_context(struct policydb *p, struct cont=
ext *context,
>                         char **scontext);
>  bool mls_context_isvalid(const struct policydb *p, const struct context =
*c);
>  bool mls_range_isvalid(const struct policydb *p, const struct mls_range =
*r);
> -bool mls_level_isvalid(const struct policydb *p, const struct mls_level =
*l);
>
>  int mls_context_to_sid(struct policydb *p, char oldc, char *scontext,
>                        struct context *context, struct sidtab *s, u32 def=
_sid);
> --
> 2.55.0
>
