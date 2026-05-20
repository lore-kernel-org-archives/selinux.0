Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0823E95B8
	for <selinux@vger.kernel.org>; Wed, 20 May 2026 14:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288193; cv=pass; b=sj5QjVIP2xx7lZSjtaBrwoEKs8T9Gpsb3w/B0RjuY/rDU5YB1EUSgXTVbiqw19z/Qu1laZqUSd+tsJNZiShgkDnPkTZLZBVbgArbM2jQK9icr0trNfrAmaucSRY06EzKK3uOJpuSToNLaqIxZfQ0NptLIxFewswzu3FKl90krok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288193; c=relaxed/simple;
	bh=hA26oq+MV26avMg5eCcn7zRjFexhwLuQXfBgsDjiSCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jYTDuvpFdlEDqCjK0RCqLY2+gQy1wIHZr8uJpQ1Mxg5aSkAf2wf/nUa0/9IYKqCoKQJByctmclquXrR2IEqJz56T80UliDWy+2ueWZRmp0fM99lmAjErL26IWBllK33C4+kGQxaASpfFR/2aW77kjXPIzVL0wstOFPRe8jbMT/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NB0A4iGh; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NB0A4iGh"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a8891febd2so7079318e87.1
        for <selinux@vger.kernel.org>; Wed, 20 May 2026 07:43:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779288190; cv=none;
        d=google.com; s=arc-20240605;
        b=h6j515KH+AD2EkT5Y49n7HKEtfoNNxvKZ0plh2rj9xWmyl02sQMtwwi7JGQ0guVatQ
         MNDDbzHBzVbH9KB4wmmLICMVQF4Fv4QHn7GH7e8s6gqTZeb+EsA9MuCUWHXbkaxcAmRi
         4IAzbKzHsCl44KIniJCfa95Xh9bz3viPIXy3xLOyCLQ1wMKyzjTT9gDpW/KTrkGtt9Wc
         f5mwwyHjMAO0VqC0iQHfFqyykaWaVzC4Ul24w+FTVY5U6Ghz0B2YXzkHjcBdatQ2NM75
         X20QyagCDKxphX4HhxN9WWcdmDygPVH+e5B6LlzhRCpM7ZSR3JPg8tARK+GOP/FiSDfP
         h8ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nR5whNFX2DvaAjlj+0SC4RtfKlORzSqvLkcqYSJEFT4=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=HjC1zchLtgx66jYnNRxyvqzJryjX7ssp+ugpS46QcFUR9pnyuhVj+lygxYtsrI6Aka
         ZSxQx/UML+nyGAqn3xfS7eWrkWjiGyzTdjqZUtm8ppKC/2izLRRBEvSPYXfPYEUFwsLN
         tOjl89MaWClmJE7o1N+pusBCQp0CmIl+2Y2UeNyffVUJjc91fxLxTBueRBbkvl45T7vB
         pUEl+t6zkTrrm+Pw9WtzrwHmp86QmISEaTSD51aJ94Cs9ZSEM749j/Fz+WSWkfihsufx
         pn/TX3q5UYHKX7d4yZWIPp1MLKMr32KyQnDO5rom01+IweLeftCw2eaMDqVwABxSbxkt
         27NQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779288190; x=1779892990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nR5whNFX2DvaAjlj+0SC4RtfKlORzSqvLkcqYSJEFT4=;
        b=NB0A4iGhzy5GemMQhuoOMQyvkOJEPzBNjDsTyjy54sh6AXfD7seyYKHfnIkHKCvHaM
         oEPTA4V2GFHOVsAg3eWYjgy7Lt/DS4lRqxwUPokRYUfMUhJtLZM0byuxrcfNaUbXnedM
         TjCjdnRJWdn5GNAjtI0mqIwR6mYryBO56KspOQPlDIsS4nDOEc6QhO3Eq7WxhD9pNM/6
         vElyl8lwbJv4lAjW+rqaWdA0qrRVBWnYQ5o1YBgcq1s0DHo+FozUPyD56JwA+o31Gd+4
         GB/fSA2LkPm3AOP+taGQycq6lydDgWqDIzux9vBHWUfuyBi2IBrVItpljPpdIvWtimTP
         6lNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779288190; x=1779892990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nR5whNFX2DvaAjlj+0SC4RtfKlORzSqvLkcqYSJEFT4=;
        b=OXIkm23OECYeRr2o3mJy/pcAsru268YmdKnphE26omqIupvFSCLZwEYVu82QFJ5/sD
         IijyP4gjco71RFAgtJt2tL9n96MUR0Xcmve9DqW7Rs+FbOUX0LKlkiBBQ/tau5owy9v/
         QNYBStsFQHZN9PvSbkYnlev5gO3SPmHu+8W7LO4760O4UYh9L/vJxoXY445N+h0f+Y+H
         X8RFGVJcK++4hnWlh+X+BeMup3HgehUQvhSoU95BbDBI1ByZvju98kpymMLsS9hFFhKp
         awzhjIg/bgAGQG4ZW5+KeLqFV01mL2r+fBRVzPUU6jB25hCRpPhz0mXbTKC66T3RTNLL
         nAJg==
X-Gm-Message-State: AOJu0YyXmJPu19qR9KII8PmeA/ecNcxazeFIUuoYibZ4Myet6rdUe96j
	pX0FaqFw++r//WhTbCnX/znW3pwJFHhEdjS3gEcr/u1ukg6Zr2kFxLDhlzae54mn/8zhBir9bbM
	T3THOBqOz6tMHWp1+bMxZINUL1ze96e5omg==
X-Gm-Gg: Acq92OH2I12Hq0kFlwdGtXU0zVjsWyyFcJhg7YVHt+/aNSM/Cj3pmNwAk755KGdPFUy
	HO04mQhRoPV1RoPb58vW+DZVhtxuV+08s9173X8LpwVzw/4/eN5C+KIphwKsfzqP1mupkiiD9X0
	/cmPTfcUnn31UTnVj1cP6ZK3p7EZYD5sSbVyKceM1t/RnAXrUX5kvJVD30i/CgBq8JVeZQoXy7B
	sYBDy984x2HnzphXMgOt++7srcZ93xHSn7yecS6Br6sfTGthYILVVCCGMrGRWURU1nPIxKjFwtU
	4dsl
X-Received: by 2002:a05:6512:39cb:b0:5a8:d1ef:caad with SMTP id
 2adb3069b0e04-5aa0e733fb7mr7083457e87.4.1779288190249; Wed, 20 May 2026
 07:43:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507162107.70210-1-kalevi@kolttonen.fi> <CAP+JOzQjauSGvLamzAaX7jkUDHR3s_5zYuDTrGR_wOTasxy5Qg@mail.gmail.com>
In-Reply-To: <CAP+JOzQjauSGvLamzAaX7jkUDHR3s_5zYuDTrGR_wOTasxy5Qg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 20 May 2026 10:42:58 -0400
X-Gm-Features: AVHnY4JOkbZdQU5nj0uk_Xkhz3MMoYxY5ggWzAjkR7iv-ryr8NRg62_Pz9pj23E
Message-ID: <CAP+JOzSyc7dOid15BP1zwu=HT2Gv2kfKnGeCuSNEY_giQzFwag@mail.gmail.com>
Subject: Re: [PATCH] libselinux: remove useless assignment and test
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 3:37=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Thu, May 7, 2026 at 12:27=E2=80=AFPM Kalevi Kolttonen <kalevi@kolttone=
n.fi> wrote:
> >
> > Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libselinux/src/label_support.c | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> >
> > diff --git a/libselinux/src/label_support.c b/libselinux/src/label_supp=
ort.c
> > index 57e191c8..3cfd92ed 100644
> > --- a/libselinux/src/label_support.c
> > +++ b/libselinux/src/label_support.c
> > @@ -190,13 +190,11 @@ int  digest_add_specfile(struct selabel_digest *d=
igest, FILE *fp,
> >                                             1, buf_len, fp) !=3D buf_le=
n)
> >                         return -1;
> >
> > -       } else if (from_addr) {
> > -               tmp_buf =3D memcpy(digest->hashbuf +
> > -                                   (digest->hashbuf_size - buf_len),
> > -                                   from_addr, buf_len);
> > -               if (!tmp_buf)
> > -                       return -1;
> > -       }
> > +       } else if (from_addr)
> > +               memcpy(digest->hashbuf +
> > +                           (digest->hashbuf_size - buf_len),
> > +                           from_addr, buf_len);
> > +
> >         /* Now add path to list */
> >         digest->specfile_list[digest->specfile_cnt] =3D strdup(path);
> >         if (!digest->specfile_list[digest->specfile_cnt])
> > --
> > 2.54.0
> >
> >
