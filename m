Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EE847D476
	for <selinux@vger.kernel.org>; Thu,  6 Aug 2026 15:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030529; cv=pass; b=DBpv/xaB6TRX9yGPre1BpiOHs1JsFn0+WLYuvTpwg+pT1tOm7Add4ZExW7tn/fTWWtCaBx9ZOUejaSeoMzZe6e9zWTMV3k3z4hIpmrUBJmt1e30QPIeJNqR21gj/PvwpcUXAI/m3nZ6hJzKoQZ6dIDDzYIpJ3wgzju0mj5N9tcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030529; c=relaxed/simple;
	bh=dO/rtzg/MGYjmYJ5+ezMGGImkYqpTGAVVyfMuLuthQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sl3c8iaw6HoAyQTB9gAIRKGYOdphrVpgBNkmCKMorr7aoX6/at52RQ23TjtJBci0swvcAULpe9YqOpDybgaOttJEzzuRtZfFXMkQhpZ3mW/NN4cZyV9MtpNlLz6AdCjlsIQV/fQZrBUN68aaX+WkU2oKrewPGlK195sYL+qb9kM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3ckbqUG; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3ckbqUG"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-39c953950dfso20743201fa.1
        for <selinux@vger.kernel.org>; Thu, 06 Aug 2026 08:35:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786030526; cv=none;
        d=google.com; s=arc-20260327;
        b=lFqe/oubDORCy8m3nMmKf+ndKwlgNiV+4X78ESq4QrVU3swyfTyagCgIoM7QiSpEYG
         3avHvnme/1jhq43vTOvKJNQ8v6mxIQWP+mHbe832Aea672lm24f2meZ43AQm8YQ8iy+8
         4pqkU6SoV4SWpcykZRGIpOm8EQ0CYpzY5AYTuAaVwQvvWtpAKKsifCoee1z3c+rlBzY+
         bpMtF1Oz0rAbHdzAXGeHa3B1q4oGASMJIsaAyFOATCOUqtctW9zul95GEoKeVWKysmOw
         F+OANQDbagOVLYvdX7R9pfAdE3LVHBQQt9y90r4O09Fa2Wk8uR7YAaXUnhLS4Vc12/n7
         igFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QiAAI1946TmKNyWoPma6hNnfwwIvk3/OeQq9UNXgV04=;
        fh=9qqehjuxnn2X0mJ7hQbZg99PSLTxs4BCAql4/69ZoU8=;
        b=Hywu5QHx48F3LGKYfczVvJvPERUb2I4SOf4A2oyUUJmveEBsncbRAoKgJTA3rWAVr0
         eTc26wzb5ZCg/7US86OQRQvp+b+6nMl+cbUPH+j4zBF6VB6egDk/AuQIHG0e92WekRl1
         i+JJK1OuV7c5RCFCFrYlmlYkTx0ALajsTTchAgtq32c4wP7aK3Hz5xszVoyyOad2Lwi8
         7iW9YO0/Z29sThEwAjvoTfgt1rguNBomEL04gqsGqQ2vLNGWb5axUfY4m2kAHANAyLrT
         cVqf6Znree+qJC97Jmltoks4kSLpBC/uaQxnB1pYNHbFRHL6et+LqjtXSaLInYue6ncO
         HpZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786030526; x=1786635326; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QiAAI1946TmKNyWoPma6hNnfwwIvk3/OeQq9UNXgV04=;
        b=V3ckbqUGtXg2linfZ6/gtvTgyrhIRuP03Ol495D8NKT7AlqEDDgRxToJ3wUuGf1Mj0
         MXXfOHylV+8kD7uywCkiXBk7ggA1reJ6lU+WMfFkqn2YAspDndhb4F3xLWiwNUCflCSJ
         1K0z3CFfN+zWmsLR4EplC64ALxgeRNSFkUj9V+z4BNV+JR/2PIvFHopoV6QZ96r4eLhr
         E+g7SMcW9doVO4imWtT+EAkvkpAd/gSD4ZaEnOEOcBFCpR/viArl4txPkRof/qS9ie7c
         RnC6iGQ6AzI3pm23o4p7+6SAbBVi95zUflwZq9vmphs7/pCY/yFMHX9hxBonDh0/Dne6
         wJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786030526; x=1786635326;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QiAAI1946TmKNyWoPma6hNnfwwIvk3/OeQq9UNXgV04=;
        b=GAuQFOx6436/IJ5D4xrpWFO9Tp9tfkbTYgIeImDi6O7X5Gp+/aCdXmtv3wAvcB6/IY
         6zfMSce0AAcrayST7wind7yMZSAQB4f6sA87T3SFlU1TrdNba+4dF56CqKrTSkzdczga
         p++i06bsC/RarYw/jr9L5Fqn7Ucs01e+jlH8xQ4IQmvtwUssD0tH1j618QXGFf3Wdc2E
         JbxY//3dsbpRcGfzvdra9zapjtuqVxuaoOQg/k4yLV/hIV2rJK6LNYIuvbnx6kgd7REA
         0L9Zgk6LQ/nFL5DgjSQosPW+wdpuUzRTcoSUfjy83Bj9EkTKHWMJwj/fNftvPTfERk2q
         i3Dg==
X-Gm-Message-State: AOJu0YyXM5iyu2tTvDAk7Efpa50Dpei1hZ1Xb+kLiBgGrvapA+eKA6tT
	FsuZXRHCXa2O390gmesGrXMVZtIPQOxzbrCBDx/27ev2OU4gOmhWSKCeFP2yx2DHbPKKiTVch8p
	uidfbcu7NDvDEUJoEfBPxUDighg3DqqRcIJKv
X-Gm-Gg: AR+sD10dG3M156V5M9QttiPlvoEjKKBkEenstwiA7M91hDJkaDAp/J9PptEyVQ7t5Gm
	a/g1j4Ave2Xtg65Nb9BvUR48tCTK3V4TcJQYFQYPV8FrF1BW+79XJj6TcwzfjlDVc36RVHz6cd3
	NI5ytYf5EwSDEt6fnIDA841ynlbzzS6TMAenm0nTQLnPu2aKMtmfEGvvGqWShHp3PzkF8YxZXBX
	XgObK47HsH8SALCCUeQ7khLqKpEbCXYGV4bPlbon/bYjSSqO/vRWonBdhieWVvZ49Ay7l+qHLxm
	R6/eoOI6bFZBI/ZkYtSp/e2tVmiHHr1tUJ6/vL1p5tuSf87Elrja
X-Received: by 2002:a05:651c:1586:b0:39e:ea4f:4202 with SMTP id
 38308e7fff4ca-39fbb262b33mr19762801fa.31.1786030525815; Thu, 06 Aug 2026
 08:35:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806141514.101723-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260806141514.101723-2-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 6 Aug 2026 11:35:14 -0400
X-Gm-Features: AUfX_mxtWxr56WM5dC-OTI3efh6IDyqp3PJENCmufpmbqfUuuoOc4IAFULZ4O8g
Message-ID: <CAP+JOzQ-yqb7KBVABmZic8A1qCZ+6SQAbjT64St04Q=U8uFPRw@mail.gmail.com>
Subject: Re: [PATCH v2] checkpolicy-fuzzer: drop invalid assertion
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 10:15=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> The checkpolicy-fuzzer has an invalid assertion; checkpolicy
> intentionally tracks errors via policydb_errors and does not always
> return non-zero from yyparse() if there were any errors during the
> compilation.
>
> Reported-by: oss-fuzz (issue 471491765)
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> v2 removes both asserts.
>
>  checkpolicy/fuzz/checkpolicy-fuzzer.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/checkpolicy/fuzz/checkpolicy-fuzzer.c b/checkpolicy/fuzz/che=
ckpolicy-fuzzer.c
> index c58d10e9..401f24e3 100644
> --- a/checkpolicy/fuzz/checkpolicy-fuzzer.c
> +++ b/checkpolicy/fuzz/checkpolicy-fuzzer.c
> @@ -106,8 +106,6 @@ static int read_source_policy(policydb_t *p, const ui=
nt8_t *data, size_t size)
>         }
>
>         rc =3D yyparse();
> -       // TODO: drop global variable policydb_errors if proven to be red=
undant
> -       assert(rc || !policydb_errors);
>         if (rc || policydb_errors) {
>                 queue_destroy(id_queue);
>                 fclose(yyin);
> @@ -120,7 +118,6 @@ static int read_source_policy(policydb_t *p, const ui=
nt8_t *data, size_t size)
>         yyrestart(yyin);
>
>         rc =3D yyparse();
> -       assert(rc || !policydb_errors);
>         if (rc || policydb_errors) {
>                 queue_destroy(id_queue);
>                 fclose(yyin);
> --
> 2.55.0
>
