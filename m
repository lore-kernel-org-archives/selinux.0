Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8C548CC7
	for <selinux@vger.kernel.org>; Mon,  4 Mar 2024 19:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579780; cv=none; b=IyiycKyjHoQFk2quT50Z0Sx9wZ9naModnO/u10tYJFoaXa8NI/FVcPcOq9LWoyoi89SwjrX6zi/GreQplTgIlwFlkGZHOv6Sgk0s5/oDVg6LyNkxAQrtbWbAyWC09mpATRuYSXylq4ZndHXlwxag6KhzuMZCyJcSBS/bIUBE0/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579780; c=relaxed/simple;
	bh=2UkBvjLwdPBkw0QBNz2iOtY5RUOSNxyB4z9ZLdcpDGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uenxlojSokU26masFGFb9lx+AJkfecjI76gt+T7KRgYI2ToE6EBWUmvBYGNaFwRmW1QIE/z2wVGwD39df08oS/ZNgL2vrjysR4oNGa9N2BgR60KI5d4nhLhGz0ipKqPJ5ymltwwbeJRD6YvGhypn3yScwAW/rwNeQD80e2nTRPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3RTCZ2w; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3RTCZ2w"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c1f582673bso379663b6e.2
        for <selinux@vger.kernel.org>; Mon, 04 Mar 2024 11:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709579778; x=1710184578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnLkx+EhYso4VI1k2JYiXAD0e78KGw5qhrg2bFBSw1w=;
        b=m3RTCZ2wIhRfhXrXSl7wr06KV3KjlHZX3lViDBehdSz81/SpghtLkIpOpXaRrQ06Qh
         7nM0cORT+I9a76Un3i9oOZb34p/43hKmruInhUXU+GJnswoDPH6WpbNudzkXDPQAXwkG
         cUTO9DhT6qMUfQ695xBXJ9dYkKo5p62Hvz1raD0kVATxhxgQIMmOmBDVnUnQpo2uVLzT
         8WDotyyFamVAc48u79c8Yv15PEMiEjH/PCg3OABMJP6DCu0YVOx+BJsb8iB5gEThr5L/
         bkriHQwwJcFt/ybveIUcWD8y2vGSZg+JugeRjre10Z6cp3/XGxE2CySg98BIl7SPC45y
         wgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709579778; x=1710184578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YnLkx+EhYso4VI1k2JYiXAD0e78KGw5qhrg2bFBSw1w=;
        b=nhLxNuCbVNmGTksH5YR78CsWO64RAqHd9pc8/N4zaJYUTtpWiCSHTG5pgZ4i3RkLve
         ebirw+teHtTv1niAK04AzblA409jiPb0Cf5L2D3dsZVM61Pd9nQ3oKPXQlM5sPB8btNY
         3XWctU0TCbujB9ivSv4on31uOX3T68XHQl7TRiPxX2dpcRrS9FfMoL1nWhzqin0691M+
         Lb947fpsIvoTXhoyt2YW3DJdVAow33SYnkeFnlmecKv7fRmZJ0TCQqt6Vak9lw5xQFDg
         K20U3f5o6kCtJThuZDTedjS1SyLYwI3IX7STEwZ6dVrMSUy6JOrOMQoPKO8JuIjGfE9h
         mmBw==
X-Gm-Message-State: AOJu0Yz/xZTwlWVBUhV34gXQ1/zo+/ZUt6DLTJmiuhTrahHIwAZyj+Fc
	EK/s+6yUENS3UwXBJdkzClEQ3R6gmotqnLtHAvGqWXvvLN255wFky92Ot15V7Jjj/Ln8HedIHaE
	+24r07tIQkJxXMEeFqbfTuHkKPrXoKwvh
X-Google-Smtp-Source: AGHT+IFDvWl9NNapp8wbjA46bTXl4lBviqNnRMqDFilUSmPALefmBiXrTVwb65ebr/loruFgM7xhZdkBeQrhf8COIGU=
X-Received: by 2002:a05:6808:228b:b0:3c1:d337:84d6 with SMTP id
 bo11-20020a056808228b00b003c1d33784d6mr12229307oib.11.1709579778023; Mon, 04
 Mar 2024 11:16:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207150003.174701-1-vmojzis@redhat.com> <CAP+JOzTd1mwA+yy-cgfgMDGGLC-+Fzn4fLj9X+=GKOeyQUcwgQ@mail.gmail.com>
In-Reply-To: <CAP+JOzTd1mwA+yy-cgfgMDGGLC-+Fzn4fLj9X+=GKOeyQUcwgQ@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 4 Mar 2024 14:16:06 -0500
Message-ID: <CAP+JOzSfLEeV3OHAh8=dZM4vXqgQSOyTcyJjB2nFjMPp9F17Fw@mail.gmail.com>
Subject: Re: [PATCH] python/semanage: Do not sort local fcontext definitions
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 9:17=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Wed, Feb 7, 2024 at 10:11=E2=80=AFAM Vit Mojzis <vmojzis@redhat.com> w=
rote:
> >
> > Entries in file_contexts.local are processed from the most recent one t=
o
> > the oldest, with first match being used. Therefore it is important to
> > preserve their order when listing (semanage fcontext -lC) and exporting
> > (semanage export).
> >
> > Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> > Not sure if this is the best solution since the local file context
> > customizations are still sorted in the output of "semanage fcontext -l"=
.
> > Adding a new section for "Local file context changes" would make it
> > clear that such changes are treated differently, but it would make it
> > harder to find context definitions affecting specific path.
> > The most important part of this patch is the change to "customized"
> > since that stops "semanage export | semanage import" from reordering th=
e
> > local customizations.
> >
> > Note: The order of dictionary.keys() is only guaranteed in python 3.6+.
> >
> > Note2: The change to fcontextPage can only be seen when the user
> > disables ordering by "File specification" column, which is enabled by
> > defalut.
> >
> >  gui/fcontextPage.py         | 6 +++++-
> >  python/semanage/seobject.py | 9 +++++++--
> >  2 files changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/gui/fcontextPage.py b/gui/fcontextPage.py
> > index 767664f2..c88df580 100644
> > --- a/gui/fcontextPage.py
> > +++ b/gui/fcontextPage.py
> > @@ -133,7 +133,11 @@ class fcontextPage(semanagePage):
> >          self.fcontext =3D seobject.fcontextRecords()
> >          self.store.clear()
> >          fcon_dict =3D self.fcontext.get_all(self.local)
> > -        for k in sorted(fcon_dict.keys()):
> > +        if self.local:
> > +            fkeys =3D fcon_dict.keys()
> > +        else:
> > +            fkeys =3D sorted(fcon_dict.keys())
> > +        for k in fkeys:
> >              if not self.match(fcon_dict, k, filter):
> >                  continue
> >              iter =3D self.store.append()
> > diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> > index dfb15b1d..25ec4315 100644
> > --- a/python/semanage/seobject.py
> > +++ b/python/semanage/seobject.py
> > @@ -2735,7 +2735,7 @@ class fcontextRecords(semanageRecords):
> >      def customized(self):
> >          l =3D []
> >          fcon_dict =3D self.get_all(True)
> > -        for k in sorted(fcon_dict.keys()):
> > +        for k in fcon_dict.keys():
> >              if fcon_dict[k]:
> >                  if fcon_dict[k][3]:
> >                      l.append("-a -f %s -t %s -r '%s' '%s'" % (file_typ=
e_str_to_option[k[1]], fcon_dict[k][2], fcon_dict[k][3], k[0]))
> > @@ -2752,7 +2752,12 @@ class fcontextRecords(semanageRecords):
> >          if len(fcon_dict) !=3D 0:
> >              if heading:
> >                  print("%-50s %-18s %s\n" % (_("SELinux fcontext"), _("=
type"), _("Context")))
> > -            for k in sorted(fcon_dict.keys()):
> > +            # do not sort local customizations since they are evaluate=
d based on the order they where added in
> > +            if locallist:
> > +                fkeys =3D fcon_dict.keys()
> > +            else:
> > +                fkeys =3D sorted(fcon_dict.keys())
> > +            for k in fkeys:
> >                  if fcon_dict[k]:
> >                      if is_mls_enabled:
> >                          print("%-50s %-18s %s:%s:%s:%s " % (k[0], k[1]=
, fcon_dict[k][0], fcon_dict[k][1], fcon_dict[k][2], translate(fcon_dict[k]=
[3], False)))
> > --
> > 2.43.0
> >
> >
