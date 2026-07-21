Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A4B377EA5
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 13:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784642081; cv=pass; b=DA2xWVdphHIRpkBHQ4u0CfVtwEAAFDU46N+mTPlyXqYtR7ANifZWx3XUR5o6uXioLY5nFBukXZE/+mKCv6fg2822JlYsEBcAfzARgyo0LcHOpaMDQU0I0EwqTdcVMVLY88O5wTFdc2I53q7y3nTlAe6ecRqxLueud99JmxvkPS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784642081; c=relaxed/simple;
	bh=AXb85A9oekyLy7WzLFwgzn89z0QXiFNX/Ring++TpsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nnSCT9q6pWMWTA6QN4TIhn4hHWeOcwMJsGf3cKXoRk8P76yJS8cKVQ4VYRqEmbchDprFox7Mwexwik/ez3XVL3pUB+4A3AxPiuBv+oD+TWYIEbg0Ejs7jM8+EC92XO8PPCMY6fPN7RNLDZJ+FZqBcPWlRO6GBWJzwSvwbUsKro8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TM9/2JnB; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TM9/2JnB"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cb5a6aa8760so2007520a12.1
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 06:54:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784642079; cv=none;
        d=google.com; s=arc-20260327;
        b=o5oUJY6ApImYfHPY9y1WFZ1W/jVHWJuBPYNjCyS+fRK4Fr9HRJdZQpk1rgh2q8Jdrb
         zj1Ucyl/hE8aWU7r5TDysg2fOFulnKOPqztUBGMjDFeu09qBOOvwwoh5DGi35IrAUMsj
         R7nnkypHagjddga2wSwGce1s9O9GiNsYj5mYPN6TVyMDZtGqwfZR3WFR93XpuNdX8Hy3
         8UvNvarty8CYe633ggQscGpgY/nuFg8tnU3SZaQSEi6vKrTxk4TQsTkY8/NygWva1sbl
         L9QJCg6rt5xsQnURsS6NQNwcLNMRkYaf4g6V5OJ8IuxFRu/t1eXTU9TDUwGS08yN7vHn
         fawA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=22XJF6eI1S5J6D7TwyUWeBeNWgyHUaT+qt1i3sNoCiQ=;
        fh=E51Jjr8Bz9WzQ+Ik80n9UcoRPIh3NakEhV8l9xr/qbM=;
        b=A9YpRWXbZ8QRbs5aggiGPKca421zH9eEmZJoLYVIc+ac4iszx0NDF/y2jQOsOOSRhX
         VEoKJ+UoyNuptOnLhLH8W3pxYjts6kGOXCv33csUTuIqL7P2iuEomurMVOyv57BbtPRw
         eVghoyfKN+0EzG9X1A4MkR0ka5vsxqc4bmmt0ZREZiAxk71W+slq6toxV4PDpGtrocKg
         y7+LYtV8u+Ho4eQ5v4X7ZQYdPaKQPzytI53t/AvMxoEtmGrqngWCWvijNsrfebjP58Bm
         aGOigK46ro1UbfgLXHth0BTkef8AjxggBkeAIaE1FnMIsW2m8k3tkVaCQk0XjPbhC5rg
         B7uQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784642079; x=1785246879; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=22XJF6eI1S5J6D7TwyUWeBeNWgyHUaT+qt1i3sNoCiQ=;
        b=TM9/2JnBBdF/nnni0t3UKn+1u3oZ81b/mEzb3mRaDaJskZiFQxjnGFrMJMiIQXCtPB
         q9wzwJQHgK543BZpcnyaNoX+Jb60ivminLqZ6zkIaDaXK+i8SeGokXRHSaM9taRYgyGL
         EKsxQ5iKslNEVqL1xdE71Gr1FYvxMW3/526m6QMyIA2UVFXDGhcFkCwGmJqomA55EI51
         jo0zslCcKYRg0VdjrjcfJ9s35/nEYE+0u7aEFxjB6jBhoBUbBd3DXrmQp7PnqRGS+F+d
         KsiX8Fi6xLRjUDqtdNDKK/r3cm3ZEK1t/bnPR70Xdq+krLKgQKShB5/K5OMEZeTxIm6J
         iy7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784642079; x=1785246879;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=22XJF6eI1S5J6D7TwyUWeBeNWgyHUaT+qt1i3sNoCiQ=;
        b=tQKRd9gUxhAlN5h1ZOWMCA731x8vMP54r8shfuTjenFWAh8E1tsll/V1LF60F8Woru
         DugIGNmLS3N73T1lPf8aqSSXOzpvV4peWAORe5mPZvvesg91L1ItxDXk8u/4MSp6Iju6
         SOZnNjAKSHdhAGhxdRxoTNniEumXu43VKmK98LFw9gGVH4esWyaNINQaVJQtU9bRHaTS
         WPhrRuAyYXfSxkxzYcoJub4j4tWOgoZuopKUlpLKDmUJnBzVxvfouYDhCuGcXosST8rn
         Txsbd82nhf5Ic6jwpfaoU6iJ5zb7K+tjhsLJCBDqiquxI5758NQ9IOaVKt4sd2Bd8P0v
         QEkQ==
X-Gm-Message-State: AOJu0YxHsch6FnIMsVXQGBrRz8slbhCAXJU8fiZUnimPDkqDVqC0zR+o
	81EIimhNYyWWsDGRcCJDMyRyckHMD5+gg876tmHAquWtRabMgm4w0Ye1LFiLDiDRiuY8ymOGCH0
	WfL9IR6sLwWBEAEnOpPYwP7pTaz9LU79gKA==
X-Gm-Gg: AfdE7cnBJubjV8aHFtVliVXF9PLVeRuf2118+bWpmlKYZxvBVa66A+v2UY+XG7C2muf
	9prvyfsY8vY+GH+N1MI5VE+QC9KlURfWAUHzcSuUzIBZSwpC8vLRSP1Ir4o08yPxXesPGnDoeks
	wndyjYspBKXvhLQmt4EOSOqa0e9KWkxvP6tYrmn6T1HKcRBXESHS+JmeMeaJyvjy3IlYDr8sTrS
	uCvLXCbH5M3FQywpwfgdYXdwDspJaoEt6oc0diipljc7BiuKaA595wO8iH+/Q==
X-Received: by 2002:a05:6a21:512:b0:3b5:a008:683c with SMTP id
 adf61e73a8af0-3c3ada190c4mr17125430637.45.1784642079341; Tue, 21 Jul 2026
 06:54:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <al8dIlPQqf4eHINW@suse.com>
In-Reply-To: <al8dIlPQqf4eHINW@suse.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 21 Jul 2026 09:54:28 -0400
X-Gm-Features: AUfX_my7cdUThTFKgnVXuK0rMEB6RslE1WgnfVKPUIZemQgQUWOkumGiu3YNBRc
Message-ID: <CAEjxPJ7+=671kRb2fxSgZsyDuysDatMamUZT_vtFkug6_5x2nQ@mail.gmail.com>
Subject: Re: [PATCH] selinux_restorecon: Do not exit on directory cycles
To: Johannes Segitz <jsegitz@suse.de>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 3:23=E2=80=AFAM Johannes Segitz <jsegitz@suse.de> w=
rote:
>
> All other failures are handled gracefully. Directory cycles can e.g.
> happen on BTRFS filesystems with subvolumes. Skip them and continue
> instead of exiting
>
> Signed-off-by: Johannes Segitz <jsegitz@suse.de>

This doesn't apply on selinux/main.

> ---
>  libselinux/src/selinux_restorecon.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index 7ef2d45d..33d315a2 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -883,13 +883,12 @@ loop_body:
>
>                 switch (ftsent->fts_info) {
>                 case FTS_DC:
> -                       selinux_log(SELINUX_ERROR,
> +                       selinux_log(SELINUX_WARNING,
>                                     "Directory cycle on %s.\n",
>                                     ftsent->fts_path);
>                         errno =3D ELOOP;
> -                       state->error =3D -1;
> -                       state->abort =3D true;
> -                       goto finish;
> +                       fts_set(fts, ftsent, FTS_SKIP);
> +                       continue;
>                 case FTS_DP:
>                         continue;
>                 case FTS_DNR:
> --
> 2.55.0
