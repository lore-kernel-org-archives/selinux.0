Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BFA379999
	for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 18:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781719888; cv=pass; b=l0ri5ln4HmCsIdDCqWUYxmixwCXoWOmEsIQYS2fRrikdr9nvaBIud65IYBkDvQx0t9KrS3Xr/E/knREn6oGl1qKibNb9Nz52jCrpj5+YWNEX36v/ndXKqn4Gjt4lr129nYxcVPUSGeWynM2zz62XnJqtVA/9TYyrV1PUumCz5MY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781719888; c=relaxed/simple;
	bh=U/Y31rtd5cy6BBgOdvBL9QR1XgQCVRuWfAOKxeS45bc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WKLUyxrkE4d9gahYTL4f0mHhumwbYF5cV9KY8s0hUrdOcNfjwJ7Tgk9OqMSB4LkmoL2znjI2VL53HQ/V1TdfG1grh2WfenVYLJCT/vduB2c80MnH3bDHlSeThA4/IFts71nm6PLJ2WA/xsMJQXlwIxvHt/7+Z5trrKYPoVyYzHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ls3MKb2/; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ls3MKb2/"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84226d0f1d2so6767b3a.1
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 11:11:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781719886; cv=none;
        d=google.com; s=arc-20240605;
        b=gD7fYMe2hs0XMmwqqJie/QG+qfX7zdWCAy9x41iBIW5wrNjaKAUmolC/9qgQKL22Gu
         UP+Jth6hI/GEP7+1VyOZAfQbBR59PBpMryaNpCzJNZnjDvtEl6WreFHGwUvEBsN2Pdon
         nKd+onuHkJo9tNO66nY1DocUpii5bME7O96ZJ+ITiuvUYkqABklPk5f1bd5k2mm9Q3z4
         Hg9p41Iozp1ojln5egfnqD1sf7P3M6ZtgXaNzH4MJhRR/bmOXXs6VV1hJRaK7tBxWVZx
         yeQjWnST4dFc0EJT5779blb7bMlKT1bqR3vbnO/iSiSdlX6jpDK4boVDE+saMg83rk6b
         +h6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6DdzAtxnnbdChmL15sbJ9GB/DOJE1j+3xzVc0Lyi+/4=;
        fh=+ymDRLpvH5V4NxzbU6EHTgZVOx8LXRvHxwaIgjsFoxU=;
        b=QURu+P5KhmPvj3R2lvxyUgE0jFX1iCuDw7nW845wNDOnwPUWjz+cTjfHcvqSs+zmES
         K9eZTO4aDpvXXVs880NfREVYBh0Hb53Vj/H0DxpnaLSwow4SuN8EITmcyjLHxVPYsOaD
         NkVm5s8LxOXmpFGjKYfVv4CIpYYA32On37eeQ7DlK3o/y3jTUB2Nt5qR7MqbiAmSB9jM
         64Pkymai3k3uRUy8gVBqDCBBvP4kfJd07PPKC1r8kmHQFQhXNm2pJqmtmVUJ1RYjwUfC
         p/mj3G+c5PE9vpVkGdk+pxtaWQ7TqG62ih/XyfDqNGJlvd5KVIkjZojuqVT7bmIv+vjY
         u77g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781719886; x=1782324686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6DdzAtxnnbdChmL15sbJ9GB/DOJE1j+3xzVc0Lyi+/4=;
        b=ls3MKb2/w861iVsRkP17+Vx7GffqIs2YI0RKFm00+SUsyuFELjpyz8zMfjXQdFiGO/
         GXVk+oHU35dZ5t6icCKl2nCciq0Str43FpXy4zYon/cobTvDVszRK5fWoNpsY21OEinQ
         5m2v0fCJ3iAzvOQNQRUufCyz3wcLMVzWqIBw/tR5COFuClldUwDvrrpLEnpY5dVQ/8qv
         8JRNDs25eolbsfjRSB0/tKzRarEnu2NbUR9YINFF+/JcoohtFrWmfE88MM08m9fYx7Ar
         QI3i1kaEB2e3Zhp2UJXMaLgk22KJ/D5Bs+Lvp7gSatSl2vgnFY/8z/qhTd++RHXowh7i
         Q3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781719886; x=1782324686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6DdzAtxnnbdChmL15sbJ9GB/DOJE1j+3xzVc0Lyi+/4=;
        b=WlQuBXufsksYxbqzIycG+J5rZIX3xjWI4vCBhb3a37mA6YHmHxSjL+uA7YWW6Jhk24
         9WRAUi/2vedTyaV/xy9znMdgBsXEcVN7X2IM3QNriFzyX8UYjkB3Zr0GV9G5m0Y/tEX/
         s49lgGemWcGBqx6Chh/oolgkFXCPxlp++sMSxy1EuZF4r/urkYAxxThHEoxbUB7F/U7v
         lFngvUKHyQ2UV0lMBlPQkVcca0Mfiyj3E+xSbbWmkbv3UMdcOxwSSo+W6Khit3ErsePa
         WcH8hyDL5yJymgRDOnVEsRZ8x+2bbypGQMfswIxRP3xdD3Uz4g0crCGccd8o+wD74SmE
         GN5w==
X-Gm-Message-State: AOJu0YzxJA1ofVEzRwtOjfCR7hEITjqacXcn/zL0298/N5hhKjfQlUhK
	vT6jOpO9G3ZMFNqvCit+0qwdLJMpp2R4ZScJONDhkMu7/X8P671YoNlF9iBxw5gNz/JmZzfZ/+8
	9+A0/vv140co/P2/zzYI6rSkzATOE4i82hw==
X-Gm-Gg: AfdE7cnpg6fERarVk8ISFk9K8RFRE9GpFavlzhZk3HyMnbEpZKjat2p9PgWXDEWd6NW
	aIXKImpREc2yODXYDkp/JgV6KM+WUp39e7Pm6fxZdC0RtWM5QqYk4DnyMKtbac6u5bASIEzIXMH
	OaF+sUnlVJsKPn3XrPbZ2p2fqdAVroqgu4jKfceUxoUxXMedESV6xD2eo4pmHe7enAIQxVMwsR4
	PBsXCwxD8GRtIEXYH4PDGiyUZO5NO49JiKeXDnIS0NEg/Jir4yRyG4n5cy4rpt1ifMfCeLO
X-Received: by 2002:a05:6a00:1147:b0:82c:9e00:f958 with SMTP id
 d2e1a72fcca58-845241467d8mr5236347b3a.0.1781719886417; Wed, 17 Jun 2026
 11:11:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617154214.67285-1-stephen.smalley.work@gmail.com> <CAEjxPJ6fjdMyOmENtA+bEiw=JoMr259LUkwBErezbV0Ht_0BkQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ6fjdMyOmENtA+bEiw=JoMr259LUkwBErezbV0Ht_0BkQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 17 Jun 2026 14:11:14 -0400
X-Gm-Features: AVVi8CeF64HE-zysRXeyYeCjOca72RHNM3T59XJF-VH1EtwWx29RKoxfIS1oZBo
Message-ID: <CAEjxPJ4jM1BRccC2ZX_c6ZDqqYjRpL==pR=JhpZ_TjNFFS=Qow@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: guard end of path in semanage_fc_find_meta
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	netliomax25-code <netliomax25@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 12:28=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Jun 17, 2026 at 11:42=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > From: netliomax25-code <netliomax25@gmail.com>
> >
> > semanage_fc_find_meta() skips the character after a backslash with c++
> > but does not check whether that lands on the terminating NUL. A
> > file_contexts regex token ending in a single backslash advances past th=
e
> > NUL on the next loop iteration and reads one byte past the strndup
> > buffer. Return when the skip reaches the end of the string, matching th=
e
> > guard already used in cil_post.c.
> >
> > Fixes: https://github.com/SELinuxProject/selinux/pull/529
> > Signed-off-by: Kartik Kenchi <netliomax25@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

>
> > ---
> >  libsemanage/src/semanage_store.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanag=
e_store.c
> > index 0134aaa3..f14ebe97 100644
> > --- a/libsemanage/src/semanage_store.c
> > +++ b/libsemanage/src/semanage_store.c
> > @@ -2530,6 +2530,8 @@ static void semanage_fc_find_meta(semanage_file_c=
ontext_node_t *fc_node)
> >                         /* If an escape character is found,
> >                          *  skip the next character. */
> >                         c++;
> > +                       if (fc_node->path[c] =3D=3D '\0')
> > +                               return;
> >                         escape_chars++;
> >                         break;
> >                 }
> > --
> > 2.54.0
> >
