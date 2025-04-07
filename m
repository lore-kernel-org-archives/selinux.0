Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5389721146F
	for <selinux@vger.kernel.org>; Mon,  7 Apr 2025 18:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049131; cv=none; b=aDTddzh1GtpdBzdCoqQWsYQ/HnwYj8fUgbHOQJ3UF1Mktcl6rUrAuvVb/k9jRUoH1j6Y89c7ETkOjaMqZ3lRxw8/LAyRf1CjifashY/bqEx3UgypgQjXy0pee2M2rDfZM/DsR8wQy4AgfZcZMvGXV57Fi5AQn/g62I7sX7U/ATc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049131; c=relaxed/simple;
	bh=DY5sqDA36rY+5zr7ioaiambHmHiwn9Gwv0I04MUHsdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=djTGSDFhzlBttH+mgUmQDKsicULg7A9+zUc/jYlcFwkUrSglKwe9X6XhaQpjbinrZMyGrkOe2IkS4neVzjW8qanXJM3H9aHyYs9mdDjbEQReNBnImv8mPrYKI+MhGjPAn5XoRr5iLjjobJUGtHakvmHUMyf3YFVAm2VlXcvsr04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bweHE6hJ; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bweHE6hJ"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c592764e24so509677585a.0
        for <selinux@vger.kernel.org>; Mon, 07 Apr 2025 11:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744049129; x=1744653929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+W8R4M9AFXhZ2rOxupNVqNnNJpVoXf/SztwyfyOLlk=;
        b=bweHE6hJik8RkGUjZfg07aWJOkL37YPo4M4IrIRoZ+y4ox/DuotOUVJgKzlWa8uyA0
         x6OH6HusqC9h+G32cmZ4aR0v/60TeYz9lST9617Ha4PLJAlzar3TiKDIm/VtIpto+jdN
         9NwBd0LXEQ1EqW00xdyg0+pJfTvyy97aEtH3/csznXX3I1QElgymBfbbgoqfGcjqjq6R
         9aX9gHOlXo/HRKGGlxuXFuwv930bt+G6jg9/41A9Z1QjrS5kkE2jKNHVl9jmmY1ItT9z
         8yh/xLvmXQLlKqgpzlwBPGZyuZcSEJh7wsyuwecCDdFHdMj4saOe8cUMGhpb9jwuxnu6
         GL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744049129; x=1744653929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+W8R4M9AFXhZ2rOxupNVqNnNJpVoXf/SztwyfyOLlk=;
        b=DQgy0sY0MWGfpkCbfNcO4+OxQTfyr/ckCBn7eqqF7QZj07y+ap2g/JBo9DUcasg3HQ
         leIp5RwnspoXTu2Yxd7cFd+f/1aTOYYpPqbUjfWYELL2tobyfBLwFIgYta+LpPGdyiJP
         V5mM5jnxnL+xyPgAf2pH/wGH+bG7kYA9F6ynfceEx4KSao4ZMQBTQ0IS/EI+8iQCZe1+
         fKBZg2yygCBf0mDz5JjG1enENSFka4JF45Ws4IL5NwCOX3ceXhlJ3NHUs3DHHrM3tyDx
         Zxwl4kzvOuo9zpvRlsC3n1Ozyhy65GhsH24fzYVnPqSWcTr40XKKUnztJDSBii7lo6Zy
         lPAg==
X-Gm-Message-State: AOJu0YxCbakYPXQYyByg1pS5NXYlJ1IXb/kYklEHEhbn1Fc0EbFpahfJ
	OwgYod/GZ76EQqUp3x3cPvVmFoacZuP1HuFMCMem87slsYdF8ZLwbLCVhvET99oWnfgw2/UY6de
	6TJE3rA8XXLGwQufsVgSQXjAU+Ek=
X-Gm-Gg: ASbGncvDOfej1f57lX/bxlDw/v+LkPvMn5oTnDgQJUppBOY4PBTpeo/iDr8hRu+SllM
	94E63AnNQ5V7nL2kTJp2MPggdfwuc/sZ3bIN5BQz09eCHHumuGz7q6Y9lDrsUJSQPsAp9lcisFa
	xhn/nhjXAVTV8DA9KOPWiOsyguLQuDsIzebg==
X-Google-Smtp-Source: AGHT+IFPbPijqmLqszaC+RxiwS0V1OIABbDommPfxy4OnjoqVpAFKc+84kOl6MSDhofSvWUCl2SQtiTVCN5aPlEfalY=
X-Received: by 2002:a05:620a:1a97:b0:7c2:3f1f:1a15 with SMTP id
 af79cd13be357-7c79406989dmr69704185a.8.1744049128906; Mon, 07 Apr 2025
 11:05:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213022205.972878-1-tweek@google.com> <CAP+JOzQkPPZtzNHSY2L8Quw8btoYLEJ83t1=WT37vBDyhG0J3w@mail.gmail.com>
In-Reply-To: <CAP+JOzQkPPZtzNHSY2L8Quw8btoYLEJ83t1=WT37vBDyhG0J3w@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 7 Apr 2025 14:05:18 -0400
X-Gm-Features: ATxdqUHAXSD5DH9l2pjRheyoQGoy6ngigS02JAZLZwiiyr_zuBeUADt2LDBHt-Q
Message-ID: <CAP+JOzTQCDSQF76vu+Ve4gp4nGRPbL_T+VLzoZwvwvP4JHwsBA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: warn on identical duplicate properties
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 2:10=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Wed, Feb 12, 2025 at 9:22=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@goo=
gle.com> wrote:
> >
> > Instead of raising an error in case of matching duplicates, only report
> > the issue as a warning. This matches the downstream (AOSP) behaviour fo=
r
> > Android.
> >
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libselinux/src/label_backends_android.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/libselinux/src/label_backends_android.c b/libselinux/src/l=
abel_backends_android.c
> > index cbe932ae..cf4f5cbf 100644
> > --- a/libselinux/src/label_backends_android.c
> > +++ b/libselinux/src/label_backends_android.c
> > @@ -58,10 +58,10 @@ static int nodups_specs(struct saved_data *data, co=
nst char *path)
> >                 for (jj =3D ii + 1; jj < data->nspec; jj++) {
> >                         if (!strcmp(spec_arr[jj].property_key,
> >                                             curr_spec->property_key)) {
> > -                               rc =3D -1;
> > -                               errno =3D EINVAL;
> >                                 if (strcmp(spec_arr[jj].lr.ctx_raw,
> >                                                     curr_spec->lr.ctx_r=
aw)) {
> > +                                       rc =3D -1;
> > +                                       errno =3D EINVAL;
> >                                         selinux_log
> >                                                 (SELINUX_ERROR,
> >                                                  "%s: Multiple differen=
t specifications for %s  (%s and %s).\n",
> > @@ -70,7 +70,7 @@ static int nodups_specs(struct saved_data *data, cons=
t char *path)
> >                                                  curr_spec->lr.ctx_raw)=
;
> >                                 } else {
> >                                         selinux_log
> > -                                               (SELINUX_ERROR,
> > +                                               (SELINUX_WARNING,
> >                                                  "%s: Multiple same spe=
cifications for %s.\n",
> >                                                  path, curr_spec->prope=
rty_key);
> >                                 }
> > --
> > 2.48.1.502.g6dc24dfdaf-goog
> >
> >
