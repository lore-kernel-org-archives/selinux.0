Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197B725B0AE
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 12:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784638605; cv=pass; b=YUY413Edk/vZiHWy2XPLsiLLN8/S9ZRhkTlUWMl/7pYA9JB4EomoIEUHXgbIU+bURvV2OjaqpHZiuC/W3tp0UfKvfch4k7uPkgp8RUTuO/n2lXqHWLxMHWcHOWT7NWkUrRWvHOpuiTuvmTLDShq6G+dI9o/1JlGu6YGVFOURlcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784638605; c=relaxed/simple;
	bh=0G1bf7khy44sfgZXXUm7s6EcGzOEFF5MtVoMcFVWAEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QnMUx+tBfRWmIlcPFIq70Z2ZSGBQPCGu7Xsq3ZZiCEJ1uGTAaS8Aph0+h6cDzftrrbZPq/eol0TumOzaUenfP+79FqfuYF+DO554UiHKByX5Yd/J35Omy4K0W6p3NMN5iL4LG1wAIc+wwRuVgDvEqFtnxijiuVnG5WFaUrQoYig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klaKu2s8; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klaKu2s8"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so10463628a91.3
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 05:56:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784638603; cv=none;
        d=google.com; s=arc-20260327;
        b=Mv4//e7S4I3T38zk0nwotsHi3kQlCjgCzw1Si8NkfMv0vBPlAneccmlTm6wrOGKxrO
         KVISTT6Oxoh2/bLybC9tDHZ21ZEEgspu3OI2WXkQvcDkHsuUCl2l5Qm+DVM8MAhiLeGp
         rQstkH5fn1/1mwdyo/Azhmqu6IP/IUYJgVEvLSL8ZvQ3CcCzyrIaYOH4JrxCl+veTdXG
         Vw44Jy/ywFgUxJL6GbG8yiCD6qB93YezydLJAI2BvZpj/QpysTXuopa2ak+J1eC/E4FG
         qC8Td/lQVkyF4nIEKtqQuDKqCn5P1iRDTW+9kZtglXvGFVZFCMesTo9E61bcIIxwR0MD
         lGwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Lxm1XPOaRF8N7BCnSYQLMcDfg7RHds84wksb5QCU9Hs=;
        fh=gfzHzywM79Llzpb3oUi4mMfwpHTHBNavmzg+APAH/VE=;
        b=S4C7AQLp+zucxvWDmVxkd2QUEMotNoXyS4txh/kam7TKOi4T2gWgoTe+AJk6FPtdnk
         rQEIWHh2WaqKPO1yEMMH1cVvRtMWdIjEYpDwfqptGLhRQO/hyAJwh7dKWAqVFAT2Gz1p
         her2et7ooDiDR8TthHFHSpRqtS6X7eItnxzoQBIRRWf5WA+097qxpaI5cHB1Dsw5+MfF
         v68InUmteOMSIflT0yi+yd/vxaKo1jQrnRx/n8R/OnfF4jO/j8Gd2zIdKYfMRJ/RqzX8
         KvlyoqEOSDd5qqF0tmRzMbMXLMmiGnO93N7/rOEEWlSZD+nPaKrgIa342wjhErSL4v9V
         yzQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784638603; x=1785243403; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Lxm1XPOaRF8N7BCnSYQLMcDfg7RHds84wksb5QCU9Hs=;
        b=klaKu2s8kuY0OIDBLbdEpFFU6KYJpnRCzX5cyw+3g0+aoK4HrsvxSIbnVETA2H2ONF
         UjMbk0tEO9FKH7fmsrxnWwN6un9EXd+n9EwrCdJLMvRPl4RHno6UDHImxF072GWBDiFz
         Lgvy5G4FKr2X+xeIQxKF151VVVHnKnyg0H3tnfdOzH/6lFwoKn3wVDd0IyrjG3hz6i+R
         4hv/gtqbt8dxwePG5nyNLdmcv7ELnmpcAcH2+7NJp0xGvadpNjSaNO36u9gTLCkIOfmg
         9n3sfpNusb2EA7/o9V/IhuXTvtF2Rc0dPdILcWa0pnxoqEtrROAzSBhLKjCHxBYevbJM
         J8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784638603; x=1785243403;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lxm1XPOaRF8N7BCnSYQLMcDfg7RHds84wksb5QCU9Hs=;
        b=maiic/XgemxspSANj7HckE+4/V/WU0493+vSi6LLHBmc9SBqy5H5Hjab7VM0CaX6Dy
         KqdB9YVMDDcpadKJ/JkQjOmGGzEI6Cn55ql5+WCW71Mm8z7bUBfsPfBmzspiFuhNKete
         aQhLelXu8mUONtdZk1St0Gm8peT0uBKZDctpMGMmBWCAI+jSdKeN/AIKLZFGQtKWOT+7
         /CusSBJDzOsbMwfjtnQncWFQxrMmQLEWUTE4ey2/Y8HpBwDd+THoePysUQsKB5dqa5JN
         HEKRoNpPFWYREc2aV6tM1rRZikClGvzQ0+/pgSHiVURx8vBCyCJ3fPRTNRoboZU5GQeR
         fj4g==
X-Gm-Message-State: AOJu0Yy0jWheIvzDfryX1JsTkuAxt24vKRubGLkxIRyX9B3Q1+o6wEfj
	PH3nv2unJcqjNg16JO8fx8wbak6eRemwaNG+zvfm7nRqqu8i4yfciKJWCUSj1iBk61vqiQeO3hC
	xRhBF4gnPh5QXHTqIFmP3JTLzORzFxPjxaQ==
X-Gm-Gg: AR+sD13XesHmE/m7IkWGJP04do6JuMNyWeFaAhbpb7saOzHVLAMoGJ83Sny0cJaU7mC
	IEYgwcTTMsnwSnpy/bFWe9Tdhs7to3t921iBA9Z4uZ8yFKiCwK4cCVfFYxCq5beqqUxf4rZUsff
	amp4K0n60QCHQqB89EWwOFtjzf3kUDQeLPr4tUETj2vUSypflvNn9Qi6qBL3TAPQyFW0aMCmbSc
	5FYoRRxn06YjlNjbdX76iPG5GxN9WccwoO3YFFi11lHC5ft7hhmAJ58ovilo4FR8swC1F8P
X-Received: by 2002:a17:90b:5390:b0:36a:8240:2477 with SMTP id
 98e67ed59e1d1-38e4b47be8emr18549262a91.19.1784638603268; Tue, 21 Jul 2026
 05:56:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717183424.20324-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260717183424.20324-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 21 Jul 2026 08:56:30 -0400
X-Gm-Features: AUfX_my4wr4ao92lQQYdyjpGA3rF0t6GwNVRBe5amJ8AwZHAZP33Wv3dwf3FGeM
Message-ID: <CAEjxPJ6b41b09jt11_3ywbSJPYy+N0n+GRscOBojTPHcL86hZQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] sandbox/seunshare: free glob on error path
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 2:34=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Free the glob on the error path for a failed calloc.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This series has been merged.

> ---
>  sandbox/seunshare.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
> index f2d637e1..0c32d03f 100644
> --- a/sandbox/seunshare.c
> +++ b/sandbox/seunshare.c
> @@ -448,6 +448,7 @@ static int rsynccmd(const char *src, const char *dst,=
 char ***cmd)
>         *cmd =3D calloc(3 + fglob.gl_pathc + 2, sizeof(char *));
>         if (!*cmd) {
>                 fprintf(stderr, _("Out of memory\n"));
> +               globfree(&fglob);
>                 return -1;
>         }
>
> --
> 2.55.0
>
