Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19620314A8D
	for <selinux@vger.kernel.org>; Thu, 11 Sep 2025 13:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757598158; cv=none; b=t/metZtir6czJDdGf4ht2V8/1NKMgUtg1ucDvB58D50DuBdggYk6zh3mzbnVzJw6Rngu7y7P8FcBVhK9JGcAjNYV4S2IGSeUbk1QpW7gYR3rZocfTFC4XLmF3S/2jR+1iafxa7DiJf1udmXoDOZYlr546NfgPjlJCWx4VjGaAQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757598158; c=relaxed/simple;
	bh=0VMCvd0zdO4DHzS2700pG1wPuNPo1k5byvbV8Lg9Xt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=shRJ1jzkeCA+7HkKAHsTP+K66AE21/nMEpSA8oTx41TpYK9AzXiE9aZzd3WRyfWI7LhAplTtadoWTdWZreWgnHjFQ11eEhNa/zq47n8QYN0j+Z/AP79MVrJlw7oOR9kdWBfqk5+Q+3kG+A0oftwtJAfG+HRBandEv8lQ2ntEvVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCzPtWXU; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCzPtWXU"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32d3e17d95dso487807a91.3
        for <selinux@vger.kernel.org>; Thu, 11 Sep 2025 06:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757598156; x=1758202956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VMCvd0zdO4DHzS2700pG1wPuNPo1k5byvbV8Lg9Xt8=;
        b=VCzPtWXUOyCvBeP2t3rcDzpViwXOUNpsXnWKzI/oYJwRmKShZr4E4xYsxBzEWCJkko
         IuJxMjjgeayFBgkDKveuiBZQ9+wwzfkiyWWNfVTOYJ+SKNP2akHvjejQWrTZ+75+9FbO
         +vxKP1jSLSWBaETAkboXCZUGspv/dgBMgQyoMT+DXZKXUzOrtvHLmlq8swllhbdVoUFh
         lT+6mXIYc6+G74WhrUNRqy0eJwBhslvMjIbodhFJPmzxIk7KBY7RtdUB0712S1rdo3yi
         kFhL6ypthugRAeylIVQfXHgxgfaSMd2GGwo2tTwR03DH6Kes4UrAvq4ELCrwwhXvR9c3
         pl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757598156; x=1758202956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0VMCvd0zdO4DHzS2700pG1wPuNPo1k5byvbV8Lg9Xt8=;
        b=Ew85ytiN4kHvaNy23lFCaUlHUZvu1iD0Ld9A93e8JCEUg0Le+dFT1sUvlX5ehoSTKK
         G/yPDSUA6RLydfypijAdQ9k3NIOuIJ1lQrhx7CzCZnFZHP8iEvaaI3IeOEaS+rSccT8x
         jAcSsbXQqVaG7TJ0UZJ1rjWWkuj3sVJqi1J1/zHxKY+a+k0bvbK1V8c6KC1kZoagGWJ9
         nQT3HeDWoLLR4Q7JwbEzx5LJC+4YSvy5/1BByJ4TD9UxPMF9GS9wfQ2P61dd5M8UMPPQ
         zklwrIuJvItW+3PvUt26LqiBhkfmGkM/NprlcZ0mwEkuEy1NhXmWrvjRMHn+Cus727wZ
         o9cw==
X-Gm-Message-State: AOJu0Yw58TDfoG5/Ie0u51uPZn33/lHmaFZZOhIXVQe5+r44tsVFCATv
	9ksw+dEJWo6sWccwlAT39nmdMgoayuCHQ4mfjquKizVmo27EQcMDI7n/PwrpgoWfQiLv6JTrNx3
	HpDQ2hRuUjtLgGoAaPDoaTcemTQImBy2kXg==
X-Gm-Gg: ASbGncuR6Nqy8sq3as0hrW2Dh6LUHOKxyCMHGlnc5tKnRwr9y+ylMyx8NsluOkYPKch
	BlRcrBkmEZPTSOwIUhHSrFm5TliNMDzOgYF5aw9JsE/jxoTtAepXld52shHmvs/4yf1MtmYuq9q
	2yRrSsRJ0tGPhrE5gwIsvQYBzIUcVSzC13DpEGNxLjXzwiZwB+kUODMbS9SKPz7ebOlNP+FC9Zg
	MXrXfQ=
X-Google-Smtp-Source: AGHT+IEZdhL/dPSq/u8meWvUh7i4aD/8Ff3tSgamEIuBJDtlQxPWSqUaiEs31Y5QJjJWsXls6wR1sATHGRyluWy0+Ys=
X-Received: by 2002:a17:90b:38d0:b0:32b:d183:facf with SMTP id
 98e67ed59e1d1-32d43f76ba9mr21110156a91.28.1757598156026; Thu, 11 Sep 2025
 06:42:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902183221.119333-1-lautrbach@redhat.com> <CAEjxPJ6_mz8YQWT5AwOxFCtvd+O0VsPhWvLdrEnGyaL=6bCpfA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6_mz8YQWT5AwOxFCtvd+O0VsPhWvLdrEnGyaL=6bCpfA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 11 Sep 2025 09:42:24 -0400
X-Gm-Features: Ac12FXzVtlWLHbsaYup19hhblnxL5A16diwTrtFisas4cpcQ5fjTUKKhhWivUPA
Message-ID: <CAEjxPJ61mrP0qtroN3=2FR=83O5WqVMymDWNWTvON0S==+jXeQ@mail.gmail.com>
Subject: Re: [PATCH] Add simple github PR template
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 9:47=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Sep 2, 2025 at 2:32=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.c=
om> wrote:
> >
> > Users tend to open pull request without notice that patches should be
> > sent to selinux@vger.kernel.org
> >
> > This template should give them a basic hint how to send patches for
> > review directly when they open a new PR.
> >
> > Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, merged.
