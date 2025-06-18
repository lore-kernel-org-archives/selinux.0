Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796A92F531C
	for <selinux@vger.kernel.org>; Wed, 18 Jun 2025 14:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750257384; cv=none; b=Ta5FywkI7UA3hVQVEatuTKcdeiCk0ATOkByoaLD7fSmJFbREOHwAuPm/4PdcKcvrjETzFr4MuAbQxndHdMu9EZwtWXMBaH5mc5R76GVf+rtWVG90QwAP4FeYzVAIyhEYN+GFl7o+XHLgsd3wascWJ7hSh46D713SC494eT6kFyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750257384; c=relaxed/simple;
	bh=0JucRu3EptsAoTm1q48B6YXjt3s27KLQmq/H3yPm1G8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RC5LSgdG08/74pp+lITV4vF4naQA+lf/V7ohlJjw/iBUFZ8lC9hrOaj1j0GvOMDsDaNqJDXYpVk/2FScDvxYCP1SMH38LPQlweVFAyR+48sOZ6U8viG/KcRzAspsIS83cxR69k24jL8/yQ4SLJOEgwfvg+YcyDsz91Pgar5JtAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLTILIth; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLTILIth"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-73972a54919so5992291b3a.3
        for <selinux@vger.kernel.org>; Wed, 18 Jun 2025 07:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750257383; x=1750862183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V99h3fOGOyr3HdyysHDdcknwl2R28TD8y4d6FVOxRCA=;
        b=DLTILIthFzewcrAWY0LNm1RP7fXkBqZPFALRPIkjDc8wxj6VKpsGcgWUGAwHXgz3a4
         wE253b2PAhoLDe0bILaKPlTQWWu2aYFaTH4l/QUbsjP6A8Wc0WJ4LjD4B1GKzfCigl4p
         D8UCfMvsNKsFiK7p5GqzAVa4N5Myp/CJd2Qgo9naOQId/X5BcmEjHCdIhiWk6F64/xrr
         JC5Ex6dxXHuhYb2BW+KsvnzQ+Z36kL+tGopiQmQxcfxeJdFY/dNn9R5eE7qDzRopy7y5
         AOC4OYn53NwpHAfUrKCVucLhErkYzVy1kTSjK9nUASXq724gpQGiFTwmIeGaflOxLxXo
         LVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750257383; x=1750862183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V99h3fOGOyr3HdyysHDdcknwl2R28TD8y4d6FVOxRCA=;
        b=EJ3tQMQ+fwxFfOZUjbIHTyZppGrzAfCWp+SrlYqXexL7XA6EFQ8ZPayAuBQEUYQlgh
         ZvnCdiJ5gPOC2ZOa65b0AA+EJpFozKBexcGicl/aPLmsQ9quE5RdRaUK4ursO05vXOBV
         j0E4Bgwxx/eQR/VoJp+gAp2/DwXN2R4fZ2I5BjloZVBi9IUk17olixP5V9gt1XztEuxT
         stWwwum39b2Twfz5TiWRpF+/VNeELvjBgsLbulZTToKGGJIUzZbitjrGeK/RQwyE1okP
         QCx8kuyR8/OCjuEAmbkb0+1AmmnRXddOy1shkw7aot9IoJnp2i9r/DDKvqEg9erCTe6z
         cIDQ==
X-Gm-Message-State: AOJu0YxXBryIzBLNi7Zo1Y4PKocYfoSw7UaO6jDMu/6gDBmbyWHwFAFe
	SDrjRgBgQheEfp0c9N2ymleZJd9FQBKo/RFwDwZd1etvPWkZpwhVf5NNc8DbTwdg5qFwuhtCG5N
	GlkFC7ywBA6zxQNMMvzFUDt3zJOqz/5A=
X-Gm-Gg: ASbGncsSDoIUp3kSZ6GjgsoRlaMZCl6oKWCz9qqYGNbrvBZkd/pp8m2ah4j5iqY+4iU
	81XhhVH+rHO/rIMDw4dxdRKEqRRDhqxUTJ3xHXAS07CjVWjbwkaPOQ6HT5xxiDbsvrfhhSY8RaG
	kCXfLaUSHICln7+SQQhmHVOwXAlUl1QMl//HRzIoWJ1dI=
X-Google-Smtp-Source: AGHT+IH2i25SQjCgvCftOFoPgZSWb23ZO56S6h0AzBi2Y7SGliwVqy8GoLQc77Nr/Lp0og9onBoFuczEOGJrf04X+NM=
X-Received: by 2002:a05:6a00:3a04:b0:736:d297:164 with SMTP id
 d2e1a72fcca58-7489cf6aad9mr24085203b3a.1.1750257382609; Wed, 18 Jun 2025
 07:36:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613185820.122384-1-jwcart2@gmail.com>
In-Reply-To: <20250613185820.122384-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 18 Jun 2025 10:36:10 -0400
X-Gm-Features: AX0GCFs2sHzcHuQ0kQeRykGwTJVovQhpCl-soFLUzFGyKWkHM15d_x3vozyhoIQ
Message-ID: <CAEjxPJ6BrtiUX05-GnyJWPe5RTUWA=Cy-p=c9LEz7B9faGwk=A@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: Ignore missing field initializers in swig
 generated code
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 2:58=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> The code generated by swig causes multiple warnings about missing field
> initializers. A sample follows:
>     semanageswig_wrap.c: In function =E2=80=98swig_varlink_type=E2=80=99:
>     semanageswig_wrap.c:1514:5: warning: missing initializer for field =
=E2=80=98tp_versions_used=E2=80=99 of =E2=80=98PyTypeObject=E2=80=99 {aka =
=E2=80=98const struct _typeobject=E2=80=99} [-Wmissing-field-initializers]
>      1514 |     };
>           |     ^
>
> Add "-Wno-missing-field-initializers" to SWIG_CFLAGS to ignore these
> warnings.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libsemanage/src/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
> index 1357ec71..fa3449fb 100644
> --- a/libsemanage/src/Makefile
> +++ b/libsemanage/src/Makefile
> @@ -58,7 +58,7 @@ CFLAGS ?=3D -Werror -Wall -W -Wundef -Wshadow -Wmissing=
-noreturn -Wmissing-format-
>           -fno-semantic-interposition
>
>  SWIG_CFLAGS +=3D -Wno-error -Wno-unused-but-set-variable -Wno-unused-var=
iable -Wno-shadow \
> -               -Wno-unused-parameter -Wno-missing-prototypes
> +               -Wno-unused-parameter -Wno-missing-prototypes -Wno-missin=
g-field-initializers
>
>  override CFLAGS +=3D -I../include -I../../libselinux/include -D_GNU_SOUR=
CE
>  RANLIB ?=3D ranlib
> --
> 2.49.0
>
>
