Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9941A76BE
	for <selinux@vger.kernel.org>; Tue, 30 Jul 2024 17:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360007; cv=none; b=ubt+sKfZ9mQq623dR1R6m6XEuXEggOSEXiYC5v0cd9eY3uKLgB6a+DZyl869UasGiW1HsRcR2OojbZr5slHx1fZyI1VJIAxE6qyiaeUM+Wl8Q4v/pbczD6Mr3hYmO3vzdkrzOVBij2bgY15V/7KhvTce+RiwSqLCCWqowwLdyNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360007; c=relaxed/simple;
	bh=zG2budlZ+NOg7vG+HMRAIrnpwZRDEP21cpXzJ+Lna3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i1LHV2ofzrSeFFU0hqq9Lp+3u/qBrvBaaj95a0wXDObVh/rX0EBVHfdeIWjUFlPMiGtxONbBRasuPjFXE6aMcaa2CuPJM4OexB8gY3b9DLhATQwlMOgOcHlX45Yh0IxQ/DazsCuEHv4cEz+ioHqfnfPdeu5I5+knHJUpbG3iOWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQ4HYQtf; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQ4HYQtf"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2cb576db1c5so2969482a91.1
        for <selinux@vger.kernel.org>; Tue, 30 Jul 2024 10:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722360006; x=1722964806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQjCGNFO9TBezbTlI+vz74mROZS6dr3GS6SN1aHy9uM=;
        b=RQ4HYQtfLdEq3U3OSVYOVS6Lugdvs3TEE+0SuFB5YeHRmnYiRzMFBGzVQ8zF4EQoDb
         +BVsYxO8bZZzTbr+4js45d/UroD6LotsGWYhEkxbToRzRMeaZNzN6R5Bu+e+9HCZ0ine
         tvLkVpBeuMrGrCWUDdWdKYvAmTFJBXPOnrG4nQAYsWwDkAM7IYsNsaUWYSqbNSoR64hv
         78ueUo+cQ04Ue//GKNJdHbrkRPgx01pDvt+y9ngwWXqpvIG4AdBP1cUVU3a+q42Xcvjx
         fLJOE37Hqsc+rbeQu3sSV2587TS49+zSIPJqLXD2G0+clOUNkdoAfpecoBwdskgOqb/5
         k1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722360006; x=1722964806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WQjCGNFO9TBezbTlI+vz74mROZS6dr3GS6SN1aHy9uM=;
        b=iXmKMfcFfO63IqO9LTKkPCmUGNTUYeSG9faOdMIIAsVdXUCXBhCW51EJtGlbEunl0L
         2a/19nW/Xjymo2z2EfHZvJ+BMNG5X7EPI/Ml9KdBjrN8Cnjtmu2pg2YU9WsJCDDkdej1
         YQSfhq/O5OTMBYseSGoUEuhK9tK6+pX/LdqCc+NNR9j4+Ko9i4L1m1YBUEsiAN5GryFB
         AIaYuxa+5D39X1n9HXj0bIQRLp/oT/l6nlA83nj28wzdK6jw93shHPSvNgvao2pVMiIJ
         MRKZzGJzTCeFCdjQmpHBvveYwC2klGg6wX1RsZIWxoT5tv/RAbyPrPEQgubmwhwk12m8
         aa3Q==
X-Gm-Message-State: AOJu0YwhT0b8YAMQu2flkKMIVv35r2+zSD9EpY3Wxm2JP0OOxL4zO7bd
	bhwDrxuw18DsjNqKjowYeefU7E/rM0Ffm9lh58nQwW7cfi0mog5q8hM8qN3NQN2/FgGKMwCL97a
	Spo3RCFe7+/Y8ZbhntMp7tdK3f8YERg==
X-Google-Smtp-Source: AGHT+IFUO41EyAzac+Van5EcdeF7OncdQcl5R5D75BxzQNMto2Vx4WqGCuDBrLT91yyY4WPyMZN35rQexG2fgzmc560=
X-Received: by 2002:a17:90a:d146:b0:2ca:1c9e:e012 with SMTP id
 98e67ed59e1d1-2cf7e09cda9mr10101442a91.6.1722360005501; Tue, 30 Jul 2024
 10:20:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701182732.85548-1-jwcart2@gmail.com> <CAEjxPJ6BZoNhswFc7ERnBykTfQr_AeMphGUKny5X94J+TDSZRQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ6BZoNhswFc7ERnBykTfQr_AeMphGUKny5X94J+TDSZRQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 30 Jul 2024 13:19:54 -0400
Message-ID: <CAEjxPJ5HNW=WKMg9E6qhCbNP8bZZvUa6aHBhfHVtfJgH25UhxA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Fix integer comparison issues when compiling
 for 32-bit
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 11:01=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Jul 1, 2024 at 2:27=E2=80=AFPM James Carter <jwcart2@gmail.com> w=
rote:
> >
> > Trying to compile libselinux for 32-bit produces the following error:
> >
> > selinux_restorecon.c:1194:31: error: comparison of integer expressions =
of different signedness: =E2=80=98__fsword_t=E2=80=99 {aka =E2=80=98int=E2=
=80=99} and =E2=80=98unsigned int=E2=80=99 [-Werror=3Dsign-compare]
> >  1194 |         if (state.sfsb.f_type =3D=3D RAMFS_MAGIC || state.sfsb.=
f_type =3D=3D TMPFS_MAGIC ||
> >       |                               ^~
> >
> > Since RAMFS_MAGIC =3D 0x858458f6 =3D=3D 2240043254, which > 2^31, but <=
 2^32,
> > cast both as uint32_t for the comparison.
> >
> > Reported-by: Daniel Schepler
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Applied.
