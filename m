Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8B2311C07
	for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 13:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781618305; cv=pass; b=APKfFBtO+4SE1/ebLA1PELnZ64V2TeQWd/Fpn1b5Wl9OZE3bfJphTxT7gqu3zDnn2TlMA8tpltF1vF0lZQNY59wodSJAXBI/uoNHfSEL5LrjKUXCAfPgpifLmB1pJ3s4PnytOrQVMaia2RCAC4a97x2QraKokikql1HsvUAw+SU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781618305; c=relaxed/simple;
	bh=/7OTNgYeAp0rpztkItX6WzpvzQkf5cYtF4Tj64lSua8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ESCwwAKDZYi+x26qXgu9TIg2TYZqJvQe+AwWQ/bZLK4xrYWnQfejX7b2AGPBXP2pLgiUbRiSx8p5Qs/6zs5Hd7QrKo7kVuc/tfODB9K/ElQf10AjeQIGw9vd0VDcEPZ+UxIhGaDYIwcZg9hlrg5k4hAMZp2N9SNo/vIH5M3jgEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Punx+yTw; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Punx+yTw"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-39676ff4674so39805001fa.0
        for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 06:58:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781618302; cv=none;
        d=google.com; s=arc-20240605;
        b=hrvgKJIFNMoR+/nQtsa1vDeAGHq1ad4OoL1IZM6Qgw46RVEVUHkPebfUC9ptaCndac
         iMsYsawyRx7aE4L56Vas1KIhd35EEhpY1pSBYkcdnxfWSW2DIXt0GxrLVE6DyGNxtmL+
         4uycCKG1HvQO/DI6POqjPoUeLp9TCBQJcN7/xsIAvzQeT6MIUgJEMbQK3qT3OsBb0lFn
         u1OlKh6u+O+PYXApoOffDpe6silMLvZFL2OboOHAnxkvLf46A2QqtQ2X4VbWDseo7ZFD
         H4z7ABJytUgyL3JN2umNJPmsmFt5fqmhUHogRoHF6B/m+rdIMtrBnnEOuKcUGwFkak52
         oPqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F5AZPjjQ8xM5sQMPejUu96GNu3maWL1xncPuCKIxcYA=;
        fh=X5vnZCWuErBCX3HK8iUwBuHD6/CaNbIp7PYXEJ+WOF4=;
        b=cFpztly0ZEHd6rTwZf0uFf1gV7mD4eniJ5XVp67NnKa6zjW72rHbnIg96+fbdRocZY
         9NlMudYbP0JeUeGGlGIUeEybMaopqQNRMqM4YW0+ijq0q2yZZA4ihx6fTT8XRUOKkF6k
         5p6CSmILWZCsSoDYRUf4gw6QqVAs8o8MLRBv34wX7DEZ2Z4c5Fv7yc8AcY6pNLJlTWIX
         OYmeT+2JpPlc8hKIFil6otQmoIj+wX4MKJBl65+UR/38pHCmLvamIZqHqKLmaEz8o3BU
         xd5fNOGOKkGBt0uOEDvHuozFXm4szKd5rxqBqH10T/s+X/5gAsmvxNg8VwZHXDfPggMf
         mQBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781618302; x=1782223102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5AZPjjQ8xM5sQMPejUu96GNu3maWL1xncPuCKIxcYA=;
        b=Punx+yTwiZgUJgcClrGQPu/yxRyVxi2J9tCdRI8Go+gcIToVL6MYGFRkPJ3sJuNPKq
         DzLEvjZxF7LBI07Y5J9XW+MxKvR+YkN4+enIcuSmJ5vJmVpHcnFyaDhw7seGMt3E0DB/
         L50Rh7uOnX5ztq9mX19K09QZQlOUS12hTMXCiHHZEW2EP7LmC4VUm3cxbszn9Qre+fFV
         sUvptHtxQ9AN1HbvWim1T/Nk42DX+4OfBcZrChY4dB+GNKjz3nCSH1d4DEGUvSHJleA0
         nx0YOJUaF7Ot7XXFNG2mDPvFRjnhsc/qz+mZHnUEOchahpWv44B1+mwqLVCiz8eq3USk
         YowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781618302; x=1782223102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F5AZPjjQ8xM5sQMPejUu96GNu3maWL1xncPuCKIxcYA=;
        b=CY9wK503spoMrf0lRgq4hbtytUiaHw68cIlX+VFentJ3XcRMbXgFQ5arDjRz5J4vP4
         75LDk1GPHdSfhwnk0ZbouQYhCgZkL8WyYxzcCf2+bvoinalswoASb+Wdtz8CNVbxxHfj
         ZxS9w6Fgy0DWJMJMM9zMuIlREvSY27eEGOrw0zmoYrlz9OBHpIPrCmKurpen7fte3RdY
         sc+p3/iWyxWBgQgtBP0WyCxVSro8lGfCr5XWOM3Fvmc09s2/CmsapMjC24zaVHUoiHAg
         njCEDshY7/KqYZ0PRxVDzm0eC2jm7iGmoReMjO6XV0LLuNYmALkjYN5dxN+RhctoqEeg
         wK6g==
X-Gm-Message-State: AOJu0Yy6dtLiKqgTF+Sx5ois9uccJb8RAzoHp3c7GbHCw/s9BmYoK22c
	EWtcV98sYg85i/vF4Gib/SRCTuuES1yrgi0BP6LXeHQ9yJJB13+6Ypa9EPeNmlfca4a8peYK7sO
	ZU9KJgzBE6++wi0GQxBmlDnKw1jNyBzI=
X-Gm-Gg: Acq92OHHVBtajUWwcppkRSjmrjcmfZfSG5bTAJRWmal9BsYMQ+VZ+w2FQ5TTf8sJbJZ
	dRlRU+JKPnvZExaZhynPHU4hlzLlW/oIq66yT2lawtxB4L+vTn/GA619Ajypbsrdudkdr5YBaG9
	fSGBb7MVRPYERvyJajGeUYlctnwF57rt0+FWgNpA9r8VT8lWNSUL2FGCO/q1aZmCm+d0v64jLTR
	OtgQEyb/RGwvMHNZVZvXS2cZB1EpeLcQsCjkwrbQnPQxYsrWiIZ9Vgg311JVj+LRbI3WdQ3FBSi
	jbNa
X-Received: by 2002:a2e:bd8a:0:b0:38e:d3ec:4f91 with SMTP id
 38308e7fff4ca-399355994c7mr42217911fa.8.1781618301800; Tue, 16 Jun 2026
 06:58:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616123816.52192-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260616123816.52192-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 16 Jun 2026 09:58:10 -0400
X-Gm-Features: AVVi8CfrdfWagrVvxICtBeHVqAlVIwk3VAQYs8JM6aydWsvlXxKIvx4-BYgubY4
Message-ID: <CAP+JOzS-UzZvod1E1AvqqZR569MJETU1oOG=j8z83NCi-NS3rQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: null-terminate temporary buffer in mls_to_string
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	netliomax25-code <netliomax25@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 8:38=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> From: netliomax25-code <netliomax25@gmail.com>
>
> mls_to_string() allocates a temporary buffer of
> mls_compute_context_len() + 1 bytes and fills it with
> mls_sid_to_context(), which writes exactly mls_compute_context_len()
> bytes and does not NUL-terminate. The buffer is then passed to
> strcpy(), but its last byte is never set, so the copy reads past the
> written MLS data (an uninitialized byte and then out of bounds) and
> can write past the end of the destination buffer. Terminate the buffer
> before the copy, matching context_to_string().
>
> Fixes: https://github.com/SELinuxProject/selinux/pull/527
> Signed-off-by: Kartik Kenchi <netliomax25@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/mls.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/libsepol/src/mls.c b/libsepol/src/mls.c
> index 1cc4e881..ab382e96 100644
> --- a/libsepol/src/mls.c
> +++ b/libsepol/src/mls.c
> @@ -50,6 +50,7 @@ int mls_to_string(sepol_handle_t *handle, const policyd=
b_t *policydb,
>         ptr =3D (char *)malloc(len);
>         if (ptr =3D=3D NULL)
>                 goto omem;
> +       ptr[len - 1] =3D '\0';
>
>         /* Final string w/ ':' cut off */
>         ptr2 =3D (char *)malloc(len - 1);
> --
> 2.54.0
>
