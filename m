Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B754147CC89
	for <selinux@vger.kernel.org>; Fri,  4 Sep 2026 12:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788523723; cv=pass; b=nEEq6511VDmg4OJ7H458IvszAQZRMpmTi+K00TemXOMr6TyU1e2Xu9MkrRCVyg5oEiF3oIeDOgyKm0kjnMDvS3mMtpv9pW/QSBqzmGbKTVU0yPfbqK9soYRzG47wBIr4HD7UD/NntQRZ0LMxWjhPYhGCcNE3ZMKIpS4jpKlAkHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788523723; c=relaxed/simple;
	bh=Czvxw7qtXzRV0JVQVR9yU1D3xhP1tgkd5pqgHJZHd7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SjjckRZvBuAhlv1ppvXsHPfDBsuhzb9kP/TMKvfz8zn7zx40qRirWtSvEX5S31jBwtNMvJ49ESQEj3Xww/jAao3np7G2UUi/42AIqnN0xHrjuJbiZkacMNc2ZbQ2E/U4/IN9WqD99h8QKL0Wx3Gnmoz7nHoFs6VjWvm7Gg06hGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDAttB5/; arc=pass smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDAttB5/"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-46556b9e02cso707985fac.1
        for <selinux@vger.kernel.org>; Fri, 04 Sep 2026 05:08:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788523720; cv=none;
        d=google.com; s=arc-20260327;
        b=gbXBbMxZAnry9RClDH8V1Ib9WFTnl56y2zET8stk+bPgPaNZ33yY5q5Mvy3lUL+xiq
         BFkPSjZHCWs3klZ8r8wMRq02aSnzc8N03+g+1k+214bfkYl5ebgOijSqZ/swmlxzh275
         QHeacp7ubcSD5TZWOxoZJK9tWw02XHMIt7hVQiS/+d65y7xoBUQy2GzhaJNak8iyJSAS
         she1fG07mF+wY4VXQSYL9bXNooerd87U42g76FNF1ql797QdSZdFZiTAlez4QGU3GjHn
         olmD8pnKzPCjPKpZLSJw3CobwD/hp3yQPSgNmNcl2PVwKIeEZd9l577CZ9Tsnh85+erT
         eUGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1ji/mjIdTPDH3hTkzrPAlDsgqMbZqRadYK3qlvo+JX0=;
        fh=Xi5WcNFenDGnt90By0YfT5Or0jEYYineyDnk1HeJPFo=;
        b=rkk3QDvvFs1XfN68CLvR4CLP/3nT4TFGzCEKG0SkcdLFAF2uIAsoFoSl6rojcLxd+I
         7IS9nRu6zG/rHHGdlx/I97kJXLpsIDz86WpzPYWYf/CiplHiL5LYK8os11DfEGG+6DzP
         HRYoI8qeOpd6rBp1cZ/i5e/J/7Y8wvPtWTTZ6JNFfJk9M7s2FAgL5uOpo9Nmutj465VE
         BT1O1IVUPVybLxKoqbtA9WfsFxQxW2Q5qlFxJSAFwqKkWENW+TohvT0LwWCpPS2W0hhx
         RQKgYYdk3ubGAuHHlkKt6hj+OIcajJdFUGLV6MzuGzFW8bbG6y3CxwO0DJpirzbkcnbt
         2p8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788523720; x=1789128520; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1ji/mjIdTPDH3hTkzrPAlDsgqMbZqRadYK3qlvo+JX0=;
        b=PDAttB5/dt6/D5WuuyUX8zYepamXbunYIx7OMaoQB97Z2ZlcbD7coLCUV5K5OU6hsl
         W6pJmkLewxsRffiWgneWj+MYxFheytQlY8fbLcOxOAMkXua1JP32pUzhxzBJnZIZSYHA
         wvNJqIUdksXhroJRE39ONyIz27CZj+aIJDaxHEOY+NwOVZreRXl6S7r1jplf2Xiu9LWW
         sS+UCidSe3MiCwEhxpydGkgU30kS/CDdm/GIMsCWI67SZqNHumFPONzkZAHFVTpaY93b
         pYxEaSxSlPTR01Z6MPTC7MxtwTN7vyBLzQHPiXlIMVK1yIX6rdmPhh1g2coBQ8ZJuL5Z
         A+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788523720; x=1789128520;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1ji/mjIdTPDH3hTkzrPAlDsgqMbZqRadYK3qlvo+JX0=;
        b=roImVTcBgYXGcOnlHh1fGjDAQ9hYmWT1mp/U5ER96dweIpZTWangRHITJKzsSX7fYw
         WVIvpi7PBluklsNCchyGzzEoYMDIwQxz9nb/lasjXXSrnt9lSMSNIILki8HaDLU7RhKk
         lTrKBxBpBw76+5ndR5v6LC1m/xZh+15yfyV5AnHpOWX3Hh3yOSr+De+Wk8f8keHMjK8z
         8wIXdhmDqcP/u7BHkskpkk2Jz/f47IQw0me647/AEnmdcRGgLUNSaIHY9oe5uagVz7uB
         /kvsbJOeXfhAV8+DJ6o3SxUFmsoQx0Iyzvigtty4HrHhPZfzuObvoWY1gg8xSIl2mgSF
         xGww==
X-Gm-Message-State: AFuF++mEqRGvKGRKnm51JfCfOtJG5AaHgQiyAHONJ/d9Vp6/Bdi+Dzfh
	KmaPigGKVpDm20Kz8ovxyMpL9K/YUf6Wt2XqzwStUM9dE/pNK8VFlHgJ/pBqvYhq4h2XWS69fC/
	WbvdK72JTqhcxli0Y98SYt4mVNhv0yK4=
X-Gm-Gg: AYBFou2WmR89q56mWYjzPwi8Zxqnc0hD5BNPhfXrdYYuiKjhtShrcAEXOsIG1cSd2Gh
	WEiBoxNGwmwft52bZdNaSL8OXH6JGxv/6i/Gkm52uD6do4LvYG0gj13h9Wf/heZk3ymuaHh9csd
	cKeHjfPFRgIj5p4x/VXpw4/CKhiwnHStncHQ9HHfpi6y6WP3KBMqY2F+ok+DbnFEESIWegLYS/D
	a7l4U6rFZHVfskunE4qtxeLjx4P4/hNJf0jEThwXPEUxpleVJ8lGBdHLGJW5XUvAj6nq8M7kCLT
	KOtCtY1IYuChv0qSd7F5Zxq4jU92Lj/VWGE1nn8gz6zX
X-Received: by 2002:a05:6870:d389:b0:470:e96b:43e3 with SMTP id
 586e51a60fabf-4757d145fd9mr1899696fac.15.1788523720253; Fri, 04 Sep 2026
 05:08:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903155837.516393-1-omosnacek@gmail.com>
In-Reply-To: <20260903155837.516393-1-omosnacek@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 4 Sep 2026 08:08:29 -0400
X-Gm-Features: AcwNN1V0ehm_4fe8KCVlLJisKVylgDbfbySqg4LWZEMxN19YpDL5I-yo46XBb7c
Message-ID: <CAEjxPJ4Au6bNUeBk=iHGP3fH17HY4sgpZEuYZSP+gViA8=5jig@mail.gmail.com>
Subject: Re: [PATCH userspace] SECURITY.md: update Ondrej's email address and
 add GPG fingerprint
To: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	Petr Lautrbach <plautrba@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 12:08=E2=80=AFPM Ondrej Mosn=C3=A1=C4=8Dek <omosnace=
k@gmail.com> wrote:
>
> I'm going to use my personal email for upstream contributions from now
> on. Update SECURITY.md to reflect this.
>
> Also add my GPG fingerpint. The key is not yet signed by other patries,

A couple of typos above but otherwise, if you could get Petr to verify
that this is really your key out-of-band,
that would give me more confidence in merging it.

> but I've been using it to sign my git commits for a while now. It can be
> also found at:
> * https://github.com/WOnder93.gpg
> * https://gitlab.com/omos.gpg
> * https://keyserver.ubuntu.com/pks/lookup?search=3DCEEE4E9CF1676119&finge=
rprint=3Don&op=3Dindex
>
> Link: https://lore.kernel.org/selinux/CAFqZXNvOGbzy8-ZnJtKi94jfu2H173Tz7V=
YpK8KuseMQS-9tNA@mail.gmail.com/
> Signed-off-by: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>
> ---
>  SECURITY.md | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/SECURITY.md b/SECURITY.md
> index 52ab863c..1f255c81 100644
> --- a/SECURITY.md
> +++ b/SECURITY.md
> @@ -40,7 +40,8 @@ window.
>    *  (GPG fingerprint) 578C 4211 832F 0A7E A2C5  A7C2 21A4 6E60 3F74 4EC=
F
>  * Jason Zaman, perfinion@gentoo.org
>    *  (GPG fingerprint) 6319 1CE9 4183 0986 89CA  B8DB 7EF1 37EC 935B 0EA=
F
> -* Ondrej Mosnacek, omosnace@redhat.com
> +* Ondrej Mosn=C3=A1=C4=8Dek, omosnacek@gmail.com
> +  *  (GPG fingerprint) 9F17 354B 2928 339C 5130  906D CEEE 4E9C F167 611=
9
>
>  If unsure about whether an issue is in kernel or userspace, feel free
>  to send it to both the kernel and userspace maintainers and the
> --
> 2.54.0
>
>
