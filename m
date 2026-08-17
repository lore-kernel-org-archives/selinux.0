Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8300441D21A
	for <selinux@vger.kernel.org>; Mon, 17 Aug 2026 12:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786970623; cv=pass; b=faXXZlSw92zkKAHd52pnjdkqRNex66Zt7uMyJaLU/6SwffWMgLsNJ+Se5k+aKlCUlxwpfvcQlZU45yXK60NRFzzBAIY2aiHZt64+itdAMwPDB8DIhQSUvpiS2hPujpYuDvr1RfzNQzYmkpKzmHfrFLOmXXTIqabwl8bx6Zf1CBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786970623; c=relaxed/simple;
	bh=2O2XZ+KhLm1utfYob2dFOag/aJsek+2Z3gjdq8N/GMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SYhhayEiXNbV4600Rha9Zdhr/Z91iN61HvgdlUstBlBRDiWo+Iw844Ilz+kSWqQl5li/w1wDo2WFwhtgIR2MBdOO8gcOOqO0zyOffwO0v/yOHPmBFIGG35M9E2/qCv9cCTbJ+5xmazsFR9l/xbZQENBZzgSwAT30lQI9UWhNuLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkNu/YwX; arc=pass smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkNu/YwX"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-4560d6f82edso2364848fac.3
        for <selinux@vger.kernel.org>; Mon, 17 Aug 2026 05:43:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786970619; cv=none;
        d=google.com; s=arc-20260327;
        b=NKRi4uoPnc/Yri9eIyefU+S0aZtAgdgJyimld7ZTNHd/s3QYhjkhg9tyP9zBlqkyY4
         luIp9gGRbR2AQQiuTnoci3vq5uToSdz3T7D/ytI9nw1FYTMb4z12JJAsvdKBk2RbWP8V
         sKBZmxTIrCq4WSybiZkOgVikPYrpDUriA4pwThvSpIXTcnZScCHFPOKV7AcVZvR9VIK0
         NupUqHARiSq0rsNkwebKgEtHXmBfzE7oBb2DC3rLaa8hJz/GI6X4YdKWd4RwY/7wm9xi
         Csdq0XuKrZUU1aB6ow4TwFdFUS96xnP4u1hvEB9jugObRH1UHW7VhELoHw4mIxD4Z2Vm
         F1FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2O2XZ+KhLm1utfYob2dFOag/aJsek+2Z3gjdq8N/GMU=;
        fh=jKypAQsinffTBS4PaCHk3Yr1oHjcu9N+jEMdzGkSCq0=;
        b=J4U4eRNUrXV/oK05XQ6TY/AF7OBdZDRg7J8UoLzPqccGiRpG4N/jBt6QcoOXJo+mxa
         NQbiyv7GFSaqhG8bLqQAK6237XpTfy87J/QRxv46EsBjYopKGozhidnFBXO34ayqLY3G
         s4YWa3kOpjeDvhlEqwQw0GYMFKXgeh/JUY0xCDxpUFcfAmH7pzc/of0ruaBpdM1OYvta
         catdQyndroNF0SjYQ3w24JxUa1Rjoo4lxn4eQay2KJy3tQRfQ0xhmF53wwUGOpNnQbYr
         H8XMwMhSynuWS9IB0bThjs5RZDsB/3b9XsqREZYSfT59/Rrq8CG4JYfUBcm3K6iWCFkt
         7GEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786970619; x=1787575419; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2O2XZ+KhLm1utfYob2dFOag/aJsek+2Z3gjdq8N/GMU=;
        b=dkNu/YwXcigAfLTSyvMby4SxchZ8aVGYZx0RHX7PF1jVYuG/tX0vUiLl8DNsywZkAB
         fYC9GD+mDOwDEjasLM06I0CLjIlapqshxAPa+cJDg6UKGtkGy2gmyawLbpm/LYqSTFC8
         y1QPURbiPS3FZbm1D3+DhkdrOQrymocqCSRUKJyIstv69mbtK3KJehqRuOosZahkKbse
         T167X+UsKUd0kw2uKaKWkNTYwpPc+rSdNt6Wlc4Zn2OEbU9kjCJqRvHZX/NRsY2jxEdi
         sN9pHd42P0Nkx85TEypKiwgR2YdUcJGgsA8TqM7ZC2H4H34EvFJ7Z3g5jqyrOZgHsa09
         LqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786970619; x=1787575419;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2O2XZ+KhLm1utfYob2dFOag/aJsek+2Z3gjdq8N/GMU=;
        b=fhBgHAhLN1DQ8t9tXkJZvi0Lx3jk7KjZasvoPtdd/azaUFfYmytvxeGQtoohs+6nCa
         56Bbm5lhrxrAW2Ff5TpacAdR70gveHSPvpeaPh3Cy17sS8msQvZgxDKxPhgTwoVc/Ox0
         K2PdcSY9mKwHd/JLxGV3FEeDct5h8cLwzyak6D5JpWuy0DO1hkNRR3P6YrNw9e4CxxDT
         3wq31tSH8UjGjBTtZkc3imUDNoTdcKoPBty3Q4k+nZCkGtjihTJRlEQUoFwQRXclo82/
         Ceh2YCZi3/1Oe82CC9pRmjiaId3Cre2WPl9VmL9crpUxsnAgmHx6ms5v39PgKv+1HjCr
         snMQ==
X-Gm-Message-State: AOJu0YzWoQxdGAjJOdQQiXK9MgW2TI/U+bR1fp1tgXMrsQxWOZqUAQcP
	ri+ZkLMWfwe5iHen7FzSP+vUCEuWushiSQRrev1XJ8Kg74OfM3nmVL8O/h8dVOjFBPpI1gwn+Yy
	NVwAr5Xuh/SoH3oQDe/XeJ9R4UvfZRiY=
X-Gm-Gg: AR+sD10jxepg9np1eX00RyQ/y6kxJgET3McNzi9IlM7bElFIT0lETjTdZ2BLaJCanPB
	rICTUKFvwKm9yCf24UY+XFhX3ZriIPkQBDZD5wG63gKkjxHo924wMQn4txrWE6eqNBcLI8+X5on
	H3uAdNNI4Le5o/eWdKrbdX1ssARZriQsWzt5aBCvntcifCNDXnFe53agUkX+g3B+KwgX9TRPesl
	xmgjPEuxU3bAMQn7hdluS7POQr4Rw+9n+BeTwoRSeNYkeU/0IxfsTtqoid+f4WpMcqdwTb1gv1D
	U5rCWKkPTFaKFvZ5eVL5s3lHtdOIJlGDHyY200KCdLph
X-Received: by 2002:a05:6871:3428:b0:441:f3f6:622b with SMTP id
 586e51a60fabf-45f357456famr25513fac.5.1786970619269; Mon, 17 Aug 2026
 05:43:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814230432.53831-1-kalevi@kolttonen.fi>
In-Reply-To: <20260814230432.53831-1-kalevi@kolttonen.fi>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 17 Aug 2026 08:43:24 -0400
X-Gm-Features: AcwNN1XblgttrrZ7fU6VAPpw7lr1vPnQegkzcZySq4PgSMWXrlofdD4SzcFqTfQ
Message-ID: <CAEjxPJ7diECpC9H+ceKZwZzDVXQ9bbn5R37P+uD8JnpBe3jVyQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: use bool instead of int in validation functions
To: Kalevi Kolttonen <kalevi@kolttonen.fi>, James Carter <jwcart2@gmail.com>, 
	Petr Lautrbach <lautrbach@redhat.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Jason Zaman <jason@perfinion.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 7:32=E2=80=AFPM Kalevi Kolttonen <kalevi@kolttonen.=
fi> wrote:
>
> This is an effort to use boolean return values instead of
> int in as many libsepol validation functions as possible.
> The functions passed to hashtab_map() have been kept as is
> to avoid excessive reworking of the codebase.
>
> The change from int to bool requires adjusting the callers
> to invert their return value checking logic. The caller
> conversion has been performed to keep the existing logic
> intact.
>
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>

I am hesitant to apply this patch for the following reasons:
1. It changes the semantics of the return type of a function that is
exposed to multiple source files,
2. It does not rename the functions to make the change in return type
explicit and ensure all
callers are updated.
3. It doesn't provide any runtime or memory benefit.

Other SELinux userspace maintainers are free to disagree with me and
merge it if they desire.
