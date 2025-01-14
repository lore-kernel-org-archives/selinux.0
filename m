Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BEF1C8776
	for <selinux@vger.kernel.org>; Tue, 14 Jan 2025 16:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736871121; cv=none; b=rSwAKElV8I2ELDtWSxee1UH+i1Taz/q/GSKS+S+lqkYo1f2zaAnZbXzEqi+5MKn0H5DVOj9TgN9Azu28LKKXHAW5jNVM5gGIsGJZ+Ct3SAVAK9iMIPJIispGa21/e48ZlVYcDBDNcz8QmiTZegR6DDPAx5bD0J061TT105O49s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736871121; c=relaxed/simple;
	bh=zikMH/eTS8xay4yLUSV87ydkyEwAsM250g8TvtV92nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oui689Xj3yGa/bqTR0J5bo/71IxFTpAajdJnw6lAA7SY+VC9LjP6P9o/ea5SA5VDduJyYkpSJTjx1CkcJR9Ittl+W8E9TE74Zs7USFvC267Wp6ncOiYhP0ne6Hp33j86HBdz5o6qzt7EENPL4NwnZWC2ivtJ6qostDBf4VtWl8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=DRXZMMP4; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DRXZMMP4"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e398484b60bso8621740276.1
        for <selinux@vger.kernel.org>; Tue, 14 Jan 2025 08:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1736871119; x=1737475919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SP1D2GoPIIstLujaPUBXWspOdF9qbnyZVJdJir9TELo=;
        b=DRXZMMP4n6meHnPiOa17fmFyHpyXbeugU5D+Ug7EaVccmQeXbIMIM/sITyJNmnurfZ
         TM71JxjHqUUY916PMUWZ3SOY51o+i1ZQseYBrgyJR2evWvlkWwFX5zHtL0FY0tm8jAB0
         Y06W2ffV+g/ZYNB+ZRKeBi6iN7MvMFdVaZ5aZ0IfuQ9aquc0+QC4TRYFiQGFOW5jwBZh
         88UVJfLWu6GXgZxO7OhpGF9VQUJ14FWsUabnimtQNA3pAEzWuGre+14iDNEFiZoMgxcF
         vngjHMGI9xs1jvrhKLU1t/jGdKjOn3MqXZPqx+T6bQxValbgXq3VYYnfqUGW/fdzQGHR
         MvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736871119; x=1737475919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SP1D2GoPIIstLujaPUBXWspOdF9qbnyZVJdJir9TELo=;
        b=JRGrrgGlULidWVAFNeRT+0geJAaVLgqvFSDHNYQHTDxtcnOU6yCFtgLA79OgAPpO6S
         clXZUaTnYUbRvSzKEBk7natPSNdndwLzZ6n7bgmuCKVgIQFunJi7YEO3amD88QCkYlCy
         swT56dWYsqCIHYpnEi7HLObjBdc2eBh6ZVYNKCeUGpsJVNyaX8DQG6d7ewGGQ1IYwPKN
         +hbIHW6aHST7SjLymuAfikK7Ld4V5AhXIyz4cGd0E2OPkyI2pRKcL8yz8HIjNt7MBR5D
         f/vPl/JZmSqW/LTctMoxA69DDkcqKHGgB0IcYxg5dDlZY5DjjfjEfet9QnW6Ga2+5GCd
         2+ow==
X-Gm-Message-State: AOJu0YwsMOoRAkANdiY0QmoTco5HcNCpiJ4gGvteVF9Ck9PX81r245JN
	h4je6gMj9R658C34kHLv4bE9AuP2qGDfobuo56PXMsNjF6/lS87CyxDqtMhYYcwT5KaRMngaWwt
	otUHv3kfMXFW6NUfIKPwlTt2zfOz4pJh/
X-Gm-Gg: ASbGnctOBU9GufD4YjydEikp5Cyyn2dJyW5cint60wK73g4tvtzqde8HAhY4pNPYE9I
	OVVsJQ5FPnJe6nuISjzPZvgm5ILH1R3DrZONv
X-Google-Smtp-Source: AGHT+IGm10yORNHQ9QivO1lf8RSQuUmNCRM1CKeu1AK8y3Prnb8bgmbOUefniNzkgd95Nt1+AFDge+McK5PfpcsYWoY=
X-Received: by 2002:a05:6902:13cb:b0:e3a:5820:feaf with SMTP id
 3f1490d57ef6-e5722ffcea6mr10724505276.43.1736871118845; Tue, 14 Jan 2025
 08:11:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241230140323.58852-1-cgoettsche@seltendoof.de> <CAP+JOzTgnFxVxbUiTTh9gxL4kvX8Mg0wF5BO7npBogjvSOmLwQ@mail.gmail.com>
In-Reply-To: <CAP+JOzTgnFxVxbUiTTh9gxL4kvX8Mg0wF5BO7npBogjvSOmLwQ@mail.gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Tue, 14 Jan 2025 17:11:47 +0100
X-Gm-Features: AbW1kvaCu5P1Va7LgoYgY8QMXd5qoC08yu5JFv_H0mSBlO1dsK-BGSMrmES5Ok0
Message-ID: <CAJ2a_DdmrhqBcMnhkoAQCyD9bg8GsifxyDWy98dN+4xrJSL41Q@mail.gmail.com>
Subject: Re: [PATCH] libselinux: avoid quadratic complexity for many regex
 specs validation
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 8 Jan 2025 at 22:51, James Carter <jwcart2@gmail.com> wrote:
>
> On Mon, Dec 30, 2024 at 9:03=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > In the degenerate case of many regular expression specifications in a
> > single node switch to a n*log(n) algorithm (with allocation) instead of
> > the default n^2 (without allocation) one.
> >
> > See 2c7b71db ("libselinux: performance optimization for duplicate detec=
tion")
> > for a predecessor.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  libselinux/src/label_file.c | 85 +++++++++++++++++++++++++++++++++++--
> >  1 file changed, 82 insertions(+), 3 deletions(-)
> >
> > diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> > index 56e20949..b1884e80 100644
> > --- a/libselinux/src/label_file.c
> > +++ b/libselinux/src/label_file.c
> > @@ -102,6 +102,38 @@ void sort_spec_node(struct spec_node *node, struct=
 spec_node *parent)
> >                 sort_spec_node(&node->children[i], node);
> >  }
> >
> > +static inline int compare_regex_spec(const void *p1, const void *p2)
> > +{
> > +       const struct regex_spec *r1 =3D p1;
> > +       const struct regex_spec *r2 =3D p2;
> > +       size_t regex_len1, regex_len2;
> > +       int ret;
> > +
> > +       /* Order from high prefix length to low */
> > +       ret =3D (r1->prefix_len < r2->prefix_len) - (r1->prefix_len > r=
2->prefix_len);
> > +       if (ret)
> > +               return ret;
> > +
> > +       /* Order from long total regex length to short */
> > +       regex_len1 =3D strlen(r1->regex_str);
> > +       regex_len2 =3D strlen(r2->regex_str);
> > +       ret =3D (regex_len1 < regex_len2) - (regex_len1 > regex_len2);
> > +       if (ret)
> > +               return ret;
> > +
> > +       /*
> > +        * Order for no-duplicates check.
> > +        * Use reverse alphabetically order to retain the Fedora orderi=
ng of
> > +        * `/usr/(.* /)?lib(/.*)?` before `/usr/(.* /)?bin(/.*)?`.
> > +        */
> > +       ret =3D strcmp(r1->regex_str, r2->regex_str);
> > +       if (ret)
> > +               return -ret;
> > +
> > +       /* Order wildcard mode (0) last */
> > +       return (r1->file_kind < r2->file_kind) - (r1->file_kind > r2->f=
ile_kind);
> > +}
> > +
>
> This function was just deleted when the fix was applied to restore
> regex spec ordering. I am a little worried about breaking that
> ordering again.

Only a temporary copied array is sorted, not the original data.

> I am also wondering if this is addressing an actual problem. A quick
> test on my system shows a max value for node->regex_specs_num of 347
> and only eight instances of it being more than 100.

True, but I tried to avoid reports like this one:
https://lore.kernel.org/selinux/20230209114253.120485-1-wanghuizhao1@huawei=
.com/

>
> Thanks,
> Jim
>
> >  /*
> >   * Warn about duplicate specifications.
> >   */
> > @@ -143,10 +175,18 @@ static int nodups_spec_node(const struct spec_nod=
e *node, const char *path)
> >         }
> >
> >         if (node->regex_specs_num > 1) {
> > -               for (uint32_t i =3D 0; i < node->regex_specs_num - 1; i=
++) {
> > -                       for (uint32_t j =3D i; j < node->regex_specs_nu=
m - 1; j++) {
> > +               if (node->regex_specs_num > 512) {
> > +                       uint32_t num =3D node->regex_specs_num;
> > +                       struct regex_spec *copy =3D malloc(num * sizeof=
(struct regex_spec));
> > +                       if (!copy)
> > +                               goto default_algo;
> > +
> > +                       memcpy(copy, node->regex_specs, num * sizeof(st=
ruct regex_spec));
> > +                       qsort(copy, num, sizeof(struct regex_spec), com=
pare_regex_spec);
> > +
> > +                       for (uint32_t i =3D 0; i < node->regex_specs_nu=
m - 1; i++) {
> >                                 const struct regex_spec *node1 =3D &nod=
e->regex_specs[i];
> > -                               const struct regex_spec *node2 =3D &nod=
e->regex_specs[j + 1];
> > +                               const struct regex_spec *node2 =3D &nod=
e->regex_specs[i + 1];

This should be `&copy[i]` and `&copy[i + 1]` instead of `
&node->regex_specs[i]` and `&node->regex_specs[i + 1]`.

> >
> >                                 if (node1->prefix_len !=3D node2->prefi=
x_len)
> >                                         continue;
> > @@ -177,6 +217,45 @@ static int nodups_spec_node(const struct spec_node=
 *node, const char *path)
> >                                                         node1->regex_st=
r);
> >                                 }
> >                         }
> > +
> > +                       free(copy);
> > +               } else {
> > +                       default_algo:
> > +                       for (uint32_t i =3D 0; i < node->regex_specs_nu=
m - 1; i++) {
> > +                               for (uint32_t j =3D i; j < node->regex_=
specs_num - 1; j++) {
> > +                                       const struct regex_spec *node1 =
=3D &node->regex_specs[i];
> > +                                       const struct regex_spec *node2 =
=3D &node->regex_specs[j + 1];
> > +
> > +                                       if (node1->prefix_len !=3D node=
2->prefix_len)
> > +                                               continue;
> > +
> > +                                       if (strcmp(node1->regex_str, no=
de2->regex_str) !=3D 0)
> > +                                               continue;
> > +
> > +                                       if (node1->file_kind !=3D LABEL=
_FILE_KIND_ALL && node2->file_kind !=3D LABEL_FILE_KIND_ALL && node1->file_=
kind !=3D node2->file_kind)
> > +                                               continue;
> > +
> > +                                       rc =3D -1;
> > +                                       errno =3D EINVAL;
> > +                                       if (strcmp(node1->lr.ctx_raw, n=
ode2->lr.ctx_raw) !=3D 0) {
> > +                                               COMPAT_LOG
> > +                                                       (SELINUX_ERROR,
> > +                                                               "%s: Mu=
ltiple different specifications for %s %s  (%s and %s).\n",
> > +                                                               path,
> > +                                                               file_ki=
nd_to_string(node1->file_kind),
> > +                                                               node1->=
regex_str,
> > +                                                               node1->=
lr.ctx_raw,
> > +                                                               node2->=
lr.ctx_raw);
> > +                                       } else {
> > +                                               COMPAT_LOG
> > +                                                       (SELINUX_ERROR,
> > +                                                               "%s: Mu=
ltiple same specifications for %s %s.\n",
> > +                                                               path,
> > +                                                               file_ki=
nd_to_string(node1->file_kind),
> > +                                                               node1->=
regex_str);
> > +                                       }
> > +                               }
> > +                       }
> >                 }
> >         }
> >
> > --
> > 2.45.2
> >
> >
