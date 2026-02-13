Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BE61E32D6
	for <selinux@vger.kernel.org>; Fri, 13 Feb 2026 15:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770995765; cv=pass; b=OV9qVdgnsMzFRn33+kUdXitRuCXB+touchTCXAZhx+bNkoYOM/N8MHaI3tnR5arF7k69IsO2XMDOa8yiTaQu08yhKM3yL2O0POKxXzBSL0J7c+aP1B2DoHntHneIlSZLPyTE/xTU/zTgQB/ehdsKwFWdLwl2ncNG8Tm2MUcukbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770995765; c=relaxed/simple;
	bh=iLhGMHCbhM+stZaGFe8/YxJ3YzZfHTNAguZKixvafTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HK1W3KNEPctusH5ehvKrS0AYSLJin5tgAvIYPxBdqWaEOrt20ewcQNf92qZXPO6pdDt4GKMKJiXDHpiHkTWSZgvWuBVIJiwNeuiBmAG2qnx6FuNvyQ9gMCo+mqRWT/XFFwqsB0/ljoNpWw+wHEjIMCgopLpbXfzB+P+REi9Gsj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gmm+d1jI; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gmm+d1jI"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-38706b63929so8634761fa.3
        for <selinux@vger.kernel.org>; Fri, 13 Feb 2026 07:16:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770995763; cv=none;
        d=google.com; s=arc-20240605;
        b=Mg8hKXUh1ya63G4EVDdQIJ2SHw02Hr3hUZR4rZCq0KLsDYbGD842M62zaU/Br6kuBZ
         JJMeA0d9E/cCTrsCZQ3lfEty9ztYJN/1DR251Y7ADwYB9fqv2i/kYRczGs+T01VnJIKf
         5CRPbZOjnpUCEfGPa1Zcm0gVo/cOaNwN4h6GM4MOnwLs/nDfdr8TCpp5XgNEnw+gHtlE
         YpcM0dQLY8GFfp796wZM8afBocgqrK6MwK7OzAECYWBx9nFO6HiVuKO2lzSLY0uizPYF
         oPdUXANgb3VUgmFud3UCjqD/gpiRlxeOLnlotNYn9dXHCEhgfncN2i1BvddhTI45V6Sc
         CWKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=78MsiaTUhsRFguXDPsBnBf7X9mY2549hwib3UoG7aMc=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=Bm9cNneokw1IqvCAnNDm6k9V8Vl+ekKvlaHcSJabxOz8aG4swMgWRoDDi1/+WBJEW3
         1dPec8IiUkiAAvRr+MWEeGDgwBxDfhvWcAi0PCMvCdn+HBZ55tSsjHCGG+xt53H6CMrc
         PIPQpNzAuI/KBPxN9VC3abKU4skWjYV8jwM7G02SIEnYZPQb1T2FpwmiCwIhSSTNKm/b
         BaFOCd9Hd36IlZOIzmdeB763uvw5gP/psBSJK/sguBmGEZhulQ5S5ar7d2oPj4izQpwr
         JHmrv9B45ce258HMcObQr1+mY5C4dbEB7mYbAWjRY180psBXY6EynMfCx2Vlk9GtAOSi
         0uew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770995763; x=1771600563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78MsiaTUhsRFguXDPsBnBf7X9mY2549hwib3UoG7aMc=;
        b=Gmm+d1jIeB8BslRKqaGhIrwq9TSyqkdlWpHxhItWG4OJWS8hYY137NSC9EVdtU+DGS
         f2Bw5SzfzqTKetEuAJ5qpo+TJUw9z9Lh/4Sg9BLi7chl9B4TffjOGmTsQ7E/LhIjEjJt
         AQ2YibjO6GexAbEV9YCcaAzCrYPmugywjHLCiUkoxlMgmBIUlqvC5lKxmGtgDhzdZ9Ql
         y3wDf4jqtuudS0CxeMW9a2Qq+kkMZYTrs7vHThjWR1jYz/06mxeuVsZ6I7Ln/QTRVeXU
         4IebF0wZCQpJKx7Zw177A4XzkSR8ikRmig+ify4iXb4skmggHsURMtEZobgIBXMoqCJm
         nueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770995763; x=1771600563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=78MsiaTUhsRFguXDPsBnBf7X9mY2549hwib3UoG7aMc=;
        b=cOH9rbpiHkkdpgxYphzaCh183Gp8z6ANFV7mZCQ2Ob5vNJlVKNNYCop+8aAKvnFn3J
         mdldzoqdnfUlbkoG6uaq3xq1vo1TcmYlPoHHZuo/wctBPK6YVNjmIcfBDxvm+okPYFvJ
         InD5eXhzJu0UnBDPliy95OyPvUKbicobtu6BsP8/ecJsfCQzbZPHQG+NLF9jJxHK68wi
         7Ws1nYTcjZGieTj7GNU/jidxX3yYYFnNAGA7Wt43J13viCsUbYNy1Nm2DUOleyyorn8e
         6oEkUzTQG1PqcpdwjDKvb+Hp6soj9XCQdOMxLb8QEdC4ZDXpyTAjwGTeD2c95hETSE3u
         6kfg==
X-Gm-Message-State: AOJu0YyO3mA3RCKfnyf/XQbJyuhzfN84osdoIRqLit/sc0Mztgj0VSm+
	86Szs4gIzCKZO5XVepANOiOn53dShIe3StwDskZsfUVAKHpuSwaZ2oZVnZfNIhrtvn0yPnqJRia
	tganrxta3uRW7ZGTBx/tUaZmAMVTVdaB3xvuh
X-Gm-Gg: AZuq6aKO3eHLMfdrSUTxwVDBSlJRMnYlEv9dEkJpjgLpfkvf5FjtDas6im9L9W5c53f
	N/eQiZ1nZ8xuF16mMBG8WnMTYS2czMtpXEN+xsuGainucRd1SAnGxjlsb8poKv0eBjv8VPVBa42
	fo9nK1GJ71K8JhcdVkDKxivgnzeJFJPClZ6fYld9DC7yP0IpFUULJoPfN9WCWSs3iPix7KTmt6E
	+YcbVDhYbrHMFk9nfidMLv7X44X7n7sbb+L/6MkXhyzRisUFNpOT72CB83VUPp2+679yAlV5utv
	KPHz
X-Received: by 2002:a2e:bc0f:0:b0:385:ed8d:b7f4 with SMTP id
 38308e7fff4ca-38810570a1dmr7090871fa.34.1770995762208; Fri, 13 Feb 2026
 07:16:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202142404.92347-1-cgoettsche@seltendoof.de> <20260202142404.92347-8-cgoettsche@seltendoof.de>
In-Reply-To: <20260202142404.92347-8-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 13 Feb 2026 10:15:50 -0500
X-Gm-Features: AZwV_Qh-rgFyfQxVegmbo0Suz45i-rV6kHPxmZrR7IzEVLldi2N-dOim4oiyHYM
Message-ID: <CAP+JOzQJybDw21=q1_NODitUp3v4-MV+3Qzv4ONpqXKE=RaH+w@mail.gmail.com>
Subject: Re: [PATCH 1/8] libselinux: drop duplicate include header
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 4:14=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these eight patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/utils/selinux_check_securetty_context.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/libselinux/utils/selinux_check_securetty_context.c b/libseli=
nux/utils/selinux_check_securetty_context.c
> index 5581dde1..0abbdfb9 100644
> --- a/libselinux/utils/selinux_check_securetty_context.c
> +++ b/libselinux/utils/selinux_check_securetty_context.c
> @@ -3,7 +3,6 @@
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <getopt.h>
> -#include <errno.h>
>  #include <string.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> --
> 2.51.0
>
>
