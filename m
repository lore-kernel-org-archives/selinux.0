Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3027A17B4E5
	for <selinux@vger.kernel.org>; Thu,  5 Sep 2024 19:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725563068; cv=none; b=lI3P5kPOmE58hc3O0PetpA0M+oZYRCb3htnc8D2Chcmu37MuDVytMyJMopHklqClcYBTXVI7w/YafSHKOR8cYbJdWsaoMj8mHTISxlov0ojc3eT5Oq9mOXn3W+ywfYzdeQJu1bXDtGudmM0xMycfTxC8Ehv6MyhpE6fLzW/f5Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725563068; c=relaxed/simple;
	bh=Ww4jU+EGv2RLdVhgfHY2aCRpIefizt/nhlZwyQx6228=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmBKyq30Wytpxy4TEiYlrl0r4b/CoGbUMdaMeWUq9g3Gpb0DJucW6b9wGIb9TXIqRbDovcOdCuc0ttVbdIjfRoVRkH+MhUk3zJ6zNn+P54Y6uX9gfEbuBH0p4yT5gw6lsA73SB4cyW1D5/efYjrcXDREnnzvQTfpz2DQNFs7LnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bceq/6Kd; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bceq/6Kd"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3df0fc40271so717535b6e.3
        for <selinux@vger.kernel.org>; Thu, 05 Sep 2024 12:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725563066; x=1726167866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UG+Q/TdhTW+vC4VgiLYQTGNt0clINN4hgkVhkqNA4II=;
        b=bceq/6Kdzbnl/r7idOCWCXOhY+QPwE5WMO+inM8n9bM8c+EcfR/hda0u/ZpE+th8fq
         BPJccociowJBHtYNswB4MI6ehoRwBLsr7MQxTAT/LIOwpp37zpbk2TGtSnT1REhO/QOg
         bjiC+Wir9JkVRd2FO9LrqCuMrfNzBy1ClNc7Owos5N9bqy2JafnD6xpX98rSkLnF8DZJ
         kr9kb/YAXVUq5lzPNZ+o5m7xGD4zwxGCseTpVPNiEJS4Y++oF0FUYG7vmBOtmb1l8195
         QMz8xds+sum4PkOsE55wR90fnxyJ2viWVsrqURi10L13SO7nXobB9P/OTeRaOftzzd1C
         09GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725563066; x=1726167866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UG+Q/TdhTW+vC4VgiLYQTGNt0clINN4hgkVhkqNA4II=;
        b=u485FomEAcT/9//gdG7oW7iWA5bKmtI6OaLn5Ll2vJDHhD3nAkMGPWz5FkdhI86Vwt
         in87f8fZYTcnh5uSPaQwrY1W6tsIlE0doQ1+igDjIDZW7N8lUB5GqG6jiSkh3KOE2NAn
         o+HJ6qvugYPdGZNhplrnoDhGCn2cXGjeS5hWIa/3ced3tYGfA/QH8rJ9mOLgrlBrp/oS
         Yw0ZnO9qmGDUNEE32/lUZYGApwp04TTv3sAn7vQ+I4k9/Wjz14p25shvM5i+/+p+P1Ul
         +DHucD4Syrnvq7fAUh9ocu55gOyuGN2C8SpFBcG5hIlxkk4xjWHC3C2XV5zam+IVfazS
         2OOA==
X-Forwarded-Encrypted: i=1; AJvYcCX3eZF+5WgrwN7Ys7OuaSsWiYy+FksCxXZnTc3pMyeYqpd+xA0FWe1hjeNzVEUcG8iW4KFtIdat@vger.kernel.org
X-Gm-Message-State: AOJu0YxdlqowRewXdx9BlFKujru755FGjamnBzQde5w1sBr2C/HACarz
	yC/W7hMvhvMiehQrsyNdz63QFyZ5BvKg0bJWxOEPRCgBF2sVeo1QifpYBG7CrO0cI8NM0q1iNmL
	pZVStGrZRwEa+VIuQuiy12BOgrgkemg==
X-Google-Smtp-Source: AGHT+IGr6gJtKfadCZM8QHwJvBk19jiSrFIcCYRoXEQOE/8CQpyi+KaWTnGvkLWu1IQ4fAi1LEQ59/LkgBqqbxk6jUA=
X-Received: by 2002:a05:6808:2022:b0:3e0:1222:b1b8 with SMTP id
 5614622812f47-3e02a031e36mr413030b6e.38.1725563066096; Thu, 05 Sep 2024
 12:04:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822003757.1998016-1-tweek@google.com> <CAEjxPJ48a4ZwN-w8UcsCohbG+Ht5kSxhprc0fy9qfuw89t2abQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ48a4ZwN-w8UcsCohbG+Ht5kSxhprc0fy9qfuw89t2abQ@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 5 Sep 2024 15:04:15 -0400
Message-ID: <CAP+JOzToWJ22XBaRmepi_n9OkS6U=+hHzK-j6Z76VZiomu=p4A@mail.gmail.com>
Subject: Re: [PATCH 1/3] libsepol: Rename ioctl xperms structures and functions
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, paul@paul-moore.com, 
	brambonne@google.com, jeffv@google.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 8:48=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Aug 21, 2024 at 8:38=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@goo=
gle.com> wrote:
> >
> > The ioctl extended permission structures and functions can be reused fo=
r
> > other extended permissions. Use the more generic term "xperm" instead o=
f
> > "ioctl".
> >
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>

These three patches have been merged.
Jim

> > ---
> >  checkpolicy/policy_define.c | 72 ++++++++++++++++++-------------------
> >  1 file changed, 36 insertions(+), 36 deletions(-)
> >
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index 4931f23d..4f6b2266 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -1874,27 +1874,27 @@ avrule_t *define_cond_pol_list(avrule_t * avlis=
t, avrule_t * sl)
> >         return sl;
> >  }
> >
> > -typedef struct av_ioctl_range {
> > +typedef struct av_xperm_range {
> >         uint16_t low;
> >         uint16_t high;
> > -} av_ioctl_range_t;
> > +} av_xperm_range_t;
> >
> > -struct av_ioctl_range_list {
> > +struct av_xperm_range_list {
> >         uint8_t omit;
> > -       av_ioctl_range_t range;
> > -       struct av_ioctl_range_list *next;
> > +       av_xperm_range_t range;
> > +       struct av_xperm_range_list *next;
> >  };
> >
> > -static int avrule_sort_ioctls(struct av_ioctl_range_list **rangehead)
> > +static int avrule_sort_xperms(struct av_xperm_range_list **rangehead)
> >  {
> > -       struct av_ioctl_range_list *r, *r2, *sorted, *sortedhead =3D NU=
LL;
> > +       struct av_xperm_range_list *r, *r2, *sorted, *sortedhead =3D NU=
LL;
> >
> >         /* order list by range.low */
> >         for (r =3D *rangehead; r !=3D NULL; r =3D r->next) {
> > -               sorted =3D malloc(sizeof(struct av_ioctl_range_list));
> > +               sorted =3D malloc(sizeof(struct av_xperm_range_list));
> >                 if (sorted =3D=3D NULL)
> >                         goto error;
> > -               memcpy(sorted, r, sizeof(struct av_ioctl_range_list));
> > +               memcpy(sorted, r, sizeof(struct av_xperm_range_list));
> >                 sorted->next =3D NULL;
> >                 if (sortedhead =3D=3D NULL) {
> >                         sortedhead =3D sorted;
> > @@ -1933,9 +1933,9 @@ error:
> >         return -1;
> >  }
> >
> > -static void avrule_merge_ioctls(struct av_ioctl_range_list **rangehead=
)
> > +static void avrule_merge_xperms(struct av_xperm_range_list **rangehead=
)
> >  {
> > -       struct av_ioctl_range_list *r, *tmp;
> > +       struct av_xperm_range_list *r, *tmp;
> >         r =3D *rangehead;
> >         while (r !=3D NULL && r->next !=3D NULL) {
> >                 /* merge */
> > @@ -1952,15 +1952,15 @@ static void avrule_merge_ioctls(struct av_ioctl=
_range_list **rangehead)
> >         }
> >  }
> >
> > -static int avrule_read_ioctls(struct av_ioctl_range_list **rangehead)
> > +static int avrule_read_xperm_ranges(struct av_xperm_range_list **range=
head)
> >  {
> >         char *id;
> > -       struct av_ioctl_range_list *rnew, *r =3D NULL;
> > +       struct av_xperm_range_list *rnew, *r =3D NULL;
> >         uint8_t omit =3D 0;
> >
> >         *rangehead =3D NULL;
> >
> > -       /* read in all the ioctl commands */
> > +       /* read in all the ioctl/netlink commands */
> >         while ((id =3D queue_remove(id_queue))) {
> >                 if (strcmp(id,"~") =3D=3D 0) {
> >                         /* these are values to be omitted */
> > @@ -1979,7 +1979,7 @@ static int avrule_read_ioctls(struct av_ioctl_ran=
ge_list **rangehead)
> >                         free(id);
> >                 } else {
> >                         /* read in new low value */
> > -                       rnew =3D malloc(sizeof(struct av_ioctl_range_li=
st));
> > +                       rnew =3D malloc(sizeof(struct av_xperm_range_li=
st));
> >                         if (rnew =3D=3D NULL)
> >                                 goto error;
> >                         rnew->next =3D NULL;
> > @@ -2006,11 +2006,11 @@ error:
> >  }
> >
> >  /* flip to included ranges */
> > -static int avrule_omit_ioctls(struct av_ioctl_range_list **rangehead)
> > +static int avrule_omit_xperms(struct av_xperm_range_list **rangehead)
> >  {
> > -       struct av_ioctl_range_list *rnew, *r, *newhead, *r2;
> > +       struct av_xperm_range_list *rnew, *r, *newhead, *r2;
> >
> > -       rnew =3D calloc(1, sizeof(struct av_ioctl_range_list));
> > +       rnew =3D calloc(1, sizeof(struct av_xperm_range_list));
> >         if (!rnew)
> >                 goto error;
> >
> > @@ -2028,7 +2028,7 @@ static int avrule_omit_ioctls(struct av_ioctl_ran=
ge_list **rangehead)
> >
> >         while (r) {
> >                 r2->range.high =3D r->range.low - 1;
> > -               rnew =3D calloc(1, sizeof(struct av_ioctl_range_list));
> > +               rnew =3D calloc(1, sizeof(struct av_xperm_range_list));
> >                 if (!rnew)
> >                         goto error;
> >                 r2->next =3D rnew;
> > @@ -2054,26 +2054,26 @@ error:
> >         return -1;
> >  }
> >
> > -static int avrule_ioctl_ranges(struct av_ioctl_range_list **rangelist)
> > +static int avrule_xperm_ranges(struct av_xperm_range_list **rangelist)
> >  {
> > -       struct av_ioctl_range_list *rangehead;
> > +       struct av_xperm_range_list *rangehead;
> >         uint8_t omit;
> >
> >         /* read in ranges to include and omit */
> > -       if (avrule_read_ioctls(&rangehead))
> > +       if (avrule_read_xperm_ranges(&rangehead))
> >                 return -1;
> >         if (rangehead =3D=3D NULL) {
> > -               yyerror("error processing ioctl commands");
> > +               yyerror("error processing ioctl/netlink commands");
> >                 return -1;
> >         }
> >         omit =3D rangehead->omit;
> > -       /* sort and merge the input ioctls */
> > -       if (avrule_sort_ioctls(&rangehead))
> > +       /* sort and merge the input ranges */
> > +       if (avrule_sort_xperms(&rangehead))
> >                 return -1;
> > -       avrule_merge_ioctls(&rangehead);
> > +       avrule_merge_xperms(&rangehead);
> >         /* flip ranges if these are omitted */
> >         if (omit) {
> > -               if (avrule_omit_ioctls(&rangehead))
> > +               if (avrule_omit_xperms(&rangehead))
> >                         return -1;
> >         }
> >
> > @@ -2261,11 +2261,11 @@ static int avrule_xperms_used(const av_extended=
_perms_t *xperms)
> >  #define IOC_DRIV(x) ((x) >> 8)
> >  #define IOC_FUNC(x) ((x) & 0xff)
> >  #define IOC_CMD(driver, func) (((driver) << 8) + (func))
> > -static int avrule_ioctl_partialdriver(struct av_ioctl_range_list *rang=
elist,
> > +static int avrule_xperm_partialdriver(struct av_xperm_range_list *rang=
elist,
> >                                 av_extended_perms_t *complete_driver,
> >                                 av_extended_perms_t **extended_perms)
> >  {
> > -       struct av_ioctl_range_list *r;
> > +       struct av_xperm_range_list *r;
> >         av_extended_perms_t *xperms;
> >         uint8_t low, high;
> >
> > @@ -2300,10 +2300,10 @@ static int avrule_ioctl_partialdriver(struct av=
_ioctl_range_list *rangelist,
> >
> >  }
> >
> > -static int avrule_ioctl_completedriver(struct av_ioctl_range_list *ran=
gelist,
> > +static int avrule_ioctl_completedriver(struct av_xperm_range_list *ran=
gelist,
> >                         av_extended_perms_t **extended_perms)
> >  {
> > -       struct av_ioctl_range_list *r;
> > +       struct av_xperm_range_list *r;
> >         av_extended_perms_t *xperms;
> >         uint16_t low, high;
> >         xperms =3D calloc(1, sizeof(av_extended_perms_t));
> > @@ -2342,10 +2342,10 @@ static int avrule_ioctl_completedriver(struct a=
v_ioctl_range_list *rangelist,
> >         return 0;
> >  }
> >
> > -static int avrule_ioctl_func(struct av_ioctl_range_list *rangelist,
> > +static int avrule_ioctl_func(struct av_xperm_range_list *rangelist,
> >                 av_extended_perms_t **extended_perms, unsigned int driv=
er)
> >  {
> > -       struct av_ioctl_range_list *r;
> > +       struct av_xperm_range_list *r;
> >         av_extended_perms_t *xperms;
> >         uint16_t low, high;
> >
> > @@ -2457,13 +2457,13 @@ static int avrule_cpy(avrule_t *dest, const avr=
ule_t *src)
> >  static int define_te_avtab_ioctl(const avrule_t *avrule_template)
> >  {
> >         avrule_t *avrule;
> > -       struct av_ioctl_range_list *rangelist, *r;
> > +       struct av_xperm_range_list *rangelist, *r;
> >         av_extended_perms_t *complete_driver, *partial_driver, *xperms;
> >         unsigned int i;
> >
> >
> >         /* organize ioctl ranges */
> > -       if (avrule_ioctl_ranges(&rangelist))
> > +       if (avrule_xperm_ranges(&rangelist))
> >                 return -1;
> >
> >         /* create rule for ioctl driver types that are entirely enabled=
 */
> > @@ -2482,7 +2482,7 @@ static int define_te_avtab_ioctl(const avrule_t *=
avrule_template)
> >         }
> >
> >         /* flag ioctl driver codes that are partially enabled */
> > -       if (avrule_ioctl_partialdriver(rangelist, complete_driver, &par=
tial_driver))
> > +       if (avrule_xperm_partialdriver(rangelist, complete_driver, &par=
tial_driver))
> >                 return -1;
> >
> >         if (!partial_driver || !avrule_xperms_used(partial_driver))
> > --
> > 2.46.0.184.g6999bdac58-goog
> >
>
