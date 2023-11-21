Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0A4C61D92
	for <selinux@archiver.kernel.org>; Tue, 21 Nov 2023 14:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbjKUOJb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Nov 2023 09:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234076AbjKUOJa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Nov 2023 09:09:30 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F6710C8
        for <selinux@vger.kernel.org>; Tue, 21 Nov 2023 06:09:25 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507bd64814fso7855537e87.1
        for <selinux@vger.kernel.org>; Tue, 21 Nov 2023 06:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700575764; x=1701180564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+oTCmONU53Tiq0c22LiScTakm4TzFnX4WFZfz+sP6Ow=;
        b=RclaB7EEl1F8uoN8dfa6PEJHO16bVYduP9WLi+rlz7A2fGPB18d3eYZovhYcMvNO1q
         irp17BK27KYURmE1MKsDmIt/CNFj7cvCOHsNbQurlmMMzYTxCym2rjI5WrvX9lVEwUVh
         zwESYSNm9TLq+ngLnsOJezzAbofnelRmarX3LqHCNiKeDirTDo6NsUt0Xd4uXSPQhaEO
         VN4IWwNBA1Dm46lk5sEIiPFB2bfrDqAV6zn9zm8fQkjAWvFd9PQ7IjUWLq50501+cW67
         H3Dz9KzfMLjUpy2MNIoPK7Bfm6qJUZgAIKw3yYDXdcskI05uZm+L7hPJvmoTBnbt1JMI
         5dDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700575764; x=1701180564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+oTCmONU53Tiq0c22LiScTakm4TzFnX4WFZfz+sP6Ow=;
        b=Qq/7OAzS6FBl0I6EQnQzglH/0Lvt/NkMzcn8M3A4QVPgh2sghxEfVfHM6bEbTjj4ma
         GLVvIrRaG5zlSip0mLA2lVURtRtOrJJMY1UVjoe3ZP6yYVH8LB8SQdJvaocWUT7iIyJt
         4Aa+JeiTI7YOCzVK5DgTOE53TkIgd5tkvmNfsB+6uJZYYagytsjl+kOD1sjETDwLvBCo
         MAvG0ObmZOmpXReun9N1l+SCRbFTZdN9uBfqNhpDBB6iIBh7iiD7sQCbJ3wHkwsxlgYu
         62ljIhNHy3cLWByReVt3XI2yGmO3bbEH0bRt4dZUJd6/b5mhMiVZ56zjLE7MyfoFvbI6
         Y57w==
X-Gm-Message-State: AOJu0YyqHHqt4yXlF5ht6qJw+4Pvwc666gBGA2iFU5jnnai2QHNLU292
        OxIune9WAa20bzqFIfuls2jhJROlhlrVXNOFaZIc+6by
X-Google-Smtp-Source: AGHT+IH+KUf346krbOZd9vx4BlZpjXcHzjIZLGy5mHoZFRygYWqtXt9iFWu96eEiuEjzH8tD2wa9oAqKxMXLJ11MWA8=
X-Received: by 2002:a19:ae15:0:b0:509:8e7f:b46c with SMTP id
 f21-20020a19ae15000000b005098e7fb46cmr6940223lfc.56.1700575763813; Tue, 21
 Nov 2023 06:09:23 -0800 (PST)
MIME-Version: 1.0
References: <20231120154735.450915-1-cgzones@googlemail.com>
 <20231120154735.450915-2-cgzones@googlemail.com> <CAP+JOzRVwnMBHw6B8_0L-E7EJi5OobHBwLYYVhf5kTaB_1OA3Q@mail.gmail.com>
In-Reply-To: <CAP+JOzRVwnMBHw6B8_0L-E7EJi5OobHBwLYYVhf5kTaB_1OA3Q@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 21 Nov 2023 09:09:11 -0500
Message-ID: <CAP+JOzRhog1RompXD7RVDzViQ4wBz00pq=R-gsCZJWQ8RTsvow@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] libsepol: avoid fixed sized format buffer for xperms
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 20, 2023 at 1:12=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Nov 20, 2023 at 10:48=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > An extended access vector rule can consist of many individual ranges of
> > permissions.  Use a dynamically growing sized buffer for formatting suc=
h
> > rules instead of a static buffer to avoid write failures due to
> > truncations.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these two patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

These two patches have been merged.
Thanks,
Jim

> > ---
> > v2:
> >    reset in_range on retry
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  checkpolicy/test/dismod.c     |  9 +++++-
> >  checkpolicy/test/dispol.c     | 10 +++++-
> >  libsepol/src/assertion.c      |  7 ++++-
> >  libsepol/src/kernel_to_conf.c |  9 +++---
> >  libsepol/src/util.c           | 57 +++++++++++++++++++++++------------
> >  5 files changed, 66 insertions(+), 26 deletions(-)
> >
> > diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
> > index fa7117f5..9f4a669b 100644
> > --- a/checkpolicy/test/dismod.c
> > +++ b/checkpolicy/test/dismod.c
> > @@ -347,6 +347,7 @@ static int display_avrule(avrule_t * avrule, policy=
db_t * policy,
> >                 display_id(policy, fp, SYM_TYPES, avrule->perms->data -=
 1, "");
> >         } else if (avrule->specified & AVRULE_XPERMS) {
> >                 avtab_extended_perms_t xperms;
> > +               char *perms;
> >                 int i;
> >
> >                 if (avrule->xperms->specified =3D=3D AVRULE_XPERMS_IOCT=
LFUNCTION)
> > @@ -362,7 +363,13 @@ static int display_avrule(avrule_t * avrule, polic=
ydb_t * policy,
> >                 for (i =3D 0; i < EXTENDED_PERMS_LEN; i++)
> >                         xperms.perms[i] =3D avrule->xperms->perms[i];
> >
> > -               fprintf(fp, "%s", sepol_extended_perms_to_string(&xperm=
s));
> > +               perms =3D sepol_extended_perms_to_string(&xperms);
> > +               if (!perms) {
> > +                       fprintf(fp, "     ERROR: failed to format xperm=
s\n");
> > +                       return -1;
> > +               }
> > +               fprintf(fp, "%s", perms);
> > +               free(perms);
> >         }
> >
> >         fprintf(fp, ";\n");
> > diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
> > index b567ce77..944ef7ec 100644
> > --- a/checkpolicy/test/dispol.c
> > +++ b/checkpolicy/test/dispol.c
> > @@ -196,6 +196,8 @@ static int render_av_rule(avtab_key_t * key, avtab_=
datum_t * datum, uint32_t wha
> >                         fprintf(fp, ";\n");
> >                 }
> >         } else if (key->specified & AVTAB_XPERMS) {
> > +               char *perms;
> > +
> >                 if (key->specified & AVTAB_XPERMS_ALLOWED)
> >                         fprintf(fp, "allowxperm ");
> >                 else if (key->specified & AVTAB_XPERMS_AUDITALLOW)
> > @@ -203,7 +205,13 @@ static int render_av_rule(avtab_key_t * key, avtab=
_datum_t * datum, uint32_t wha
> >                 else if (key->specified & AVTAB_XPERMS_DONTAUDIT)
> >                         fprintf(fp, "dontauditxperm ");
> >                 render_key(key, p, fp);
> > -               fprintf(fp, "%s;\n", sepol_extended_perms_to_string(dat=
um->xperms));
> > +               perms =3D sepol_extended_perms_to_string(datum->xperms)=
;
> > +               if (!perms) {
> > +                       fprintf(fp, "     ERROR: failed to format xperm=
s\n");
> > +                       return -1;
> > +               }
> > +               fprintf(fp, "%s;\n", perms);
> > +               free(perms);
> >         } else {
> >                 fprintf(fp, "     ERROR: no valid rule type specified\n=
");
> >                 return -1;
> > diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
> > index b6ac4cfe..6de7d031 100644
> > --- a/libsepol/src/assertion.c
> > +++ b/libsepol/src/assertion.c
> > @@ -178,15 +178,20 @@ static int report_assertion_extended_permissions(=
sepol_handle_t *handle,
> >                                 rc =3D check_extended_permissions(avrul=
e->xperms, xperms);
> >                                 /* failure on the extended permission c=
heck_extended_permissions */
> >                                 if (rc) {
> > +                                       char *permstring;
> > +
> >                                         extended_permissions_violated(&=
error, avrule->xperms, xperms);
> > +                                       permstring =3D sepol_extended_p=
erms_to_string(&error);
> > +
> >                                         ERR(handle, "neverallowxperm on=
 line %lu of %s (or line %lu of %s) violated by\n"
> >                                                         "allowxperm %s =
%s:%s %s;",
> >                                                         avrule->source_=
line, avrule->source_filename, avrule->line, policy_name(p),
> >                                                         p->p_type_val_t=
o_name[i],
> >                                                         p->p_type_val_t=
o_name[j],
> >                                                         p->p_class_val_=
to_name[curperm->tclass - 1],
> > -                                                       sepol_extended_=
perms_to_string(&error));
> > +                                                       permstring ?: "=
<format-failure>");
> >
> > +                                       free(permstring);
> >                                         errors++;
> >                                 }
> >                         }
> > diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_con=
f.c
> > index b0ae16d9..b5b530d6 100644
> > --- a/libsepol/src/kernel_to_conf.c
> > +++ b/libsepol/src/kernel_to_conf.c
> > @@ -1683,7 +1683,7 @@ static char *avtab_node_to_str(struct policydb *p=
db, avtab_key_t *key, avtab_dat
> >         uint32_t data =3D datum->data;
> >         type_datum_t *type;
> >         const char *flavor, *src, *tgt, *class, *perms, *new;
> > -       char *rule =3D NULL;
> > +       char *rule =3D NULL, *permstring;
> >
> >         switch (0xFFF & key->specified) {
> >         case AVTAB_ALLOWED:
> > @@ -1738,13 +1738,14 @@ static char *avtab_node_to_str(struct policydb =
*pdb, avtab_key_t *key, avtab_dat
> >                 rule =3D create_str("%s %s %s:%s { %s };", 5,
> >                                   flavor, src, tgt, class, perms+1);
> >         } else if (key->specified & AVTAB_XPERMS) {
> > -               perms =3D sepol_extended_perms_to_string(datum->xperms)=
;
> > -               if (perms =3D=3D NULL) {
> > +               permstring =3D sepol_extended_perms_to_string(datum->xp=
erms);
> > +               if (permstring =3D=3D NULL) {
> >                         ERR(NULL, "Failed to generate extended permissi=
on string");
> >                         goto exit;
> >                 }
> >
> > -               rule =3D create_str("%s %s %s:%s %s;", 5, flavor, src, =
tgt, class, perms);
> > +               rule =3D create_str("%s %s %s:%s %s;", 5, flavor, src, =
tgt, class, permstring);
> > +               free(permstring);
> >         } else {
> >                 new =3D pdb->p_type_val_to_name[data - 1];
> >
> > diff --git a/libsepol/src/util.c b/libsepol/src/util.c
> > index 0a2edc85..2f877920 100644
> > --- a/libsepol/src/util.c
> > +++ b/libsepol/src/util.c
> > @@ -132,21 +132,32 @@ char *sepol_extended_perms_to_string(avtab_extend=
ed_perms_t *xperms)
> >         uint16_t low_bit;
> >         uint16_t low_value;
> >         unsigned int bit;
> > -       unsigned int in_range =3D 0;
> > -       static char xpermsbuf[2048];
> > -       char *p;
> > -       int len, xpermslen =3D 0;
> > -       xpermsbuf[0] =3D '\0';
> > -       p =3D xpermsbuf;
> > +       unsigned int in_range;
> > +       char *buffer =3D NULL, *p;
> > +       int len;
> > +       size_t remaining, size =3D 128;
> >
> >         if ((xperms->specified !=3D AVTAB_XPERMS_IOCTLFUNCTION)
> >                 && (xperms->specified !=3D AVTAB_XPERMS_IOCTLDRIVER))
> >                 return NULL;
> >
> > -       len =3D snprintf(p, sizeof(xpermsbuf) - xpermslen, "ioctl { ");
> > +retry:
> > +       size *=3D 2;
> > +       if (size =3D=3D 0)
> > +               goto err;
> > +       p =3D realloc(buffer, size);
> > +       if (!p)
> > +               goto err;
> > +       buffer =3D p;
> > +       remaining =3D size;
> > +
> > +       len =3D snprintf(p, remaining, "ioctl { ");
> > +       if (len < 0 || (size_t)len >=3D remaining)
> > +               goto err;
> >         p +=3D len;
> > -       xpermslen +=3D len;
> > +       remaining -=3D len;
> >
> > +       in_range =3D 0;
> >         for (bit =3D 0; bit < sizeof(xperms->perms)*8; bit++) {
> >                 if (!xperm_test(bit, xperms->perms))
> >                         continue;
> > @@ -165,35 +176,43 @@ char *sepol_extended_perms_to_string(avtab_extend=
ed_perms_t *xperms)
> >                         value =3D xperms->driver<<8 | bit;
> >                         if (in_range) {
> >                                 low_value =3D xperms->driver<<8 | low_b=
it;
> > -                               len =3D snprintf(p, sizeof(xpermsbuf) -=
 xpermslen, "0x%hx-0x%hx ", low_value, value);
> > +                               len =3D snprintf(p, remaining, "0x%hx-0=
x%hx ", low_value, value);
> >                         } else {
> > -                               len =3D snprintf(p, sizeof(xpermsbuf) -=
 xpermslen, "0x%hx ", value);
> > +                               len =3D snprintf(p, remaining, "0x%hx "=
, value);
> >                         }
> >                 } else if (xperms->specified & AVTAB_XPERMS_IOCTLDRIVER=
) {
> >                         value =3D bit << 8;
> >                         if (in_range) {
> >                                 low_value =3D low_bit << 8;
> > -                               len =3D snprintf(p, sizeof(xpermsbuf) -=
 xpermslen, "0x%hx-0x%hx ", low_value, (uint16_t) (value|0xff));
> > +                               len =3D snprintf(p, remaining, "0x%hx-0=
x%hx ", low_value, (uint16_t) (value|0xff));
> >                         } else {
> > -                               len =3D snprintf(p, sizeof(xpermsbuf) -=
 xpermslen, "0x%hx-0x%hx ", value, (uint16_t) (value|0xff));
> > +                               len =3D snprintf(p, remaining, "0x%hx-0=
x%hx ", value, (uint16_t) (value|0xff));
> >                         }
> >
> >                 }
> >
> > -               if (len < 0 || (size_t) len >=3D (sizeof(xpermsbuf) - x=
permslen))
> > -                       return NULL;
> > +               if (len < 0)
> > +                       goto err;
> > +               if ((size_t) len >=3D remaining)
> > +                       goto retry;
> >
> >                 p +=3D len;
> > -               xpermslen +=3D len;
> > +               remaining -=3D len;
> >                 if (in_range)
> >                         in_range =3D 0;
> >         }
> >
> > -       len =3D snprintf(p, sizeof(xpermsbuf) - xpermslen, "}");
> > -       if (len < 0 || (size_t) len >=3D (sizeof(xpermsbuf) - xpermslen=
))
> > -               return NULL;
> > +       len =3D snprintf(p, remaining, "}");
> > +       if (len < 0)
> > +               goto err;
> > +       if ((size_t) len >=3D remaining)
> > +               goto retry;
> > +
> > +       return buffer;
> >
> > -       return xpermsbuf;
> > +err:
> > +       free(buffer);
> > +       return NULL;
> >  }
> >
> >  /*
> > --
> > 2.42.0
> >
