Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FC8224F3
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 16:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676786; cv=pass; b=iRHkCLo9ImDJdKqnl6k8j1WUL8VL8+Icu60pAa5H/rJPmqO9VV5oB63Br21D/NKcTKdot8HD9VQHob722cmJK+NOi4SAW3wlrRe/YffDB69T02RPJn3+kB2Jv1zmDO/1iUVLG+rPX8Yj/ZqswIg6KfYfe/0vdbVxN4Qt60NToCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676786; c=relaxed/simple;
	bh=nH8CNsa44T3h529wryPUjhbZP1D9nTRyaIBw2kPdFNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uzrvW/KLCBtzSNnLb7kaXRK0NrOKiN85lUH+AMlu0JfQqBC5MpvVahRuQOMOBZjIJdRPmRXiZFtIiYIzN0U//9ZQZHXxaDObplsUeP19NFP1uiPXfnYQGP0p7GVpOaNy7Ut+EPim0EV29R+TNAOa61e40isMtqqn4j8LJbNtLTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RF3ivjU4; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RF3ivjU4"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bf1f074a12so21925685ad.0
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 09:26:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780676784; cv=none;
        d=google.com; s=arc-20240605;
        b=eeZYjFJovyooKQfij5xIiJF94lr87BNMZDazZ8D4C3U/w7KM6ZtxuGoYULl0a5XVxO
         BcJzQRNwwnwv0/lP97FSbToKGBxmd5dZRBARbtEy1toIjrIiTsNxpigheGaFLhJ6s1QS
         vFjIK9ogOWz/Mw3rSHr0/+mIB/xluz+Cv/YrZfSIXea2uEz4N6nUfqJ04i/1OAujVVXz
         uN5hrkgNlGZm5daid6pyMGE0JMEZTe/VKyIWXJ134bzTgd2f7Mejr3X5OTv9f2JmA5lT
         YYlRaxoVUADaIHTcc3ydRU0g1AYvAjEesAlyD9ZI0RXynz+yF31sGqfVM4P+YrWShTBh
         rkuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UZFmFSOMkwEz/eNttyo/rtklJxgbwqigCDpqba9UaH4=;
        fh=Zj1IMa/s0GDs2tXbiD0MgH3G+uXEgEZ586fq4Mmx8S4=;
        b=RYm9glCJuQSeMndwVryqSdkNKtlKpdxwJPPuoakdNgGL7KbOdnu/Fbaxs8eYV8xKQK
         tQtTTqnGA6XobXvqP6xpyGYqZZRt1mrIGzcXFcb4wbkxwh8zOCg+qpv75rM8znFSn7o0
         QRLRAo+qXkLm//8nxRyMtik9GHLcdZzi5NDEjSqN6TwtpmcJkNlcV2phlknQ8GRHVtZ+
         Lmieb8SWBFf3jn23Q49Z2ZennoaK0JdKrwgN6OWsqnUqdMKjqfoPm6bpSnxwIpvJMGB+
         7e4raD+HQpdDt6CSl2SE1lxhU0BijSOzvanZOiIDrrfaZK3LnihaNt7/WVDPquvmq0ri
         6vRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780676784; x=1781281584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZFmFSOMkwEz/eNttyo/rtklJxgbwqigCDpqba9UaH4=;
        b=RF3ivjU4Vp9+LhsyDYyJ/CvmUk/Vol0igCSeJIv2SmGX9ZUYqboYWnpm6z5n89PoSa
         QDt/eF5l7k05LStnX5ShIMfNyvOGd3MVyo+c390i1M4iJVi4dO9YbMcHN9xDeeKhmyfN
         0XEik09F+rV81riPnbkFa7RbGRLRVxO4wKcW6Qs5/nIUMfMOozLYmoOgVrxT1sC3Nkcs
         M5vQqlitJxL3DPS9KJJkMMZ1Qi29DiGqMKN2T5cSYk7ipkB2fdM8dk3Do6R/TOCZ8Xss
         L0JHnFWXtCMSGFT3LkkXBEOmntuWSrjufTyYIxujRY6QeQAH+MVR47Uwx1zs69eaesPi
         +kLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780676784; x=1781281584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UZFmFSOMkwEz/eNttyo/rtklJxgbwqigCDpqba9UaH4=;
        b=VCqcuA5cg8RYI3AQyQcEiTTHToI/+q76BzG7HKXf5uumOIVXy3uXuTsAVUV3F7eJ2x
         qHpdn+Kc6MoaK/7OWl+QoM2YdwSgp+LNl1bHz1SeLgWFd7XLkG3JhbPHcSEHX/FWumtz
         shJJxFPK/Yrq6/6VzH3EG5sdf6oM9104YbHfHmDtMsqN6BjMM1TIcJJy+QgornFK4f9i
         raBg3d1sItx1gUQTOqaBf2z+xMbK8+rlkqytV2Xb5aA4iS/0JviQwMUWgEeHhSzLrGiG
         1FJEOhmNANSGCd73e59lOlMrvsqa4vezEnO9G3o+xGNf/oPwUHkVsVmHCShjA93RCNI5
         NrGw==
X-Gm-Message-State: AOJu0YwMXf0ho2tJeoCcZ5oBDwFvDo9AxZYIiTlX3P5fp1ZKlws6nd9Y
	qf4Uxjx+QvkYkyadjqk/tFOk8NkWh83Kde3/lOMKDATxQH5LI1exxg/6GKTc9RCYZgoPSAqqJVI
	rr/MfQIJgPv1N+zAzS8EXIEBFRUiAs0g=
X-Gm-Gg: Acq92OFz7f8AvMF2/nLxonnqR9ePU0ZV9WqeGx4Stis9zCRWQFyi+Y14rB+3nRfULyH
	ycLLnFSQqsgBHp2P+ZpVpFsKsStW86Urxwt5p/NMxbmCpcevwQ4qEpJaVnrpy3ru3gMzxS8Vchj
	DgqTG2QEV0MDAMHPVK+QAgsnXgyDj6+xRe8jrYcrdXBQ/xrKK5A1HcKHLmyJl92v7DvydQD7IWa
	/bWPYxVp9jWCPRq/fgFJvufVCKePXnf3rj8kM3Wi9OPuYOjer0QT4W7RY42NxamhSvT/xflgrAv
	5/KttoZ0vFyGE5x4uQ==
X-Received: by 2002:a17:902:bd0a:b0:2bf:2e93:c624 with SMTP id
 d9443c01a7336-2c1e85aad5emr34088585ad.27.1780676783785; Fri, 05 Jun 2026
 09:26:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604174247.263844-1-stephen.smalley.work@gmail.com> <CAP+JOzSC0qStowRwpy1DjpOKGi1iu7WeGr2ksYYFYDyw_7f-Fw@mail.gmail.com>
In-Reply-To: <CAP+JOzSC0qStowRwpy1DjpOKGi1iu7WeGr2ksYYFYDyw_7f-Fw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 12:26:12 -0400
X-Gm-Features: AVHnY4LQnl1mMUPSxXrqVF6cS68LF73Cc78hVQEAfJ1qJ80yrmiNP5ozprwCdJ0
Message-ID: <CAEjxPJ4zJSuQYyOnuC=Q5cY3hanZTFB5-DYnrP0zizjrYOZ=Sw@mail.gmail.com>
Subject: Re: [PATCH] libselinux: label: ensure specfile_list is NULL-terminated
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 10:40=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Thu, Jun 4, 2026 at 1:43=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > selabel_digest_fini() walks the specfile_list until it reaches
> > a NULL; we therefore need to ensure that there is always
> > an extra NULL slot at the end.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.

>
> > ---
> >  libselinux/src/label.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libselinux/src/label.c b/libselinux/src/label.c
> > index dcbd60ab..1ccd1abe 100644
> > --- a/libselinux/src/label.c
> > +++ b/libselinux/src/label.c
> > @@ -70,7 +70,7 @@ selabel_is_digest_set(const struct selinux_opt *opts,=
 unsigned n)
> >                                 goto err;
> >
> >                         digest->specfile_list =3D
> > -                               calloc(DIGEST_FILES_MAX, sizeof(char *)=
);
> > +                               calloc(DIGEST_FILES_MAX + 1, sizeof(cha=
r *));
> >                         if (!digest->specfile_list)
> >                                 goto err;
> >
> > --
> > 2.54.0
> >
