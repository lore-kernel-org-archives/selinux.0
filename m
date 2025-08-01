Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4EFC2C9
	for <selinux@vger.kernel.org>; Fri,  1 Aug 2025 19:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754076865; cv=none; b=KBl5bkEnoRvoPn12653vpwQ61QFInoyXwjXHemdgtTO6Ev9KYKD4EvoMov4+a3Ix6XBhFvkJGL/gM/7ZMiqzeayYS8rOD1Njh8qUfz/oxkvrV1agmdgvpJzfHFgZgRQVpI/S7WAHrVi54+Odbl+m59W3oN6ae73h9mjCJEAEESY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754076865; c=relaxed/simple;
	bh=Yo+AtylQDT0JLgim9NmlJsAv+upAo1u2tBziEo1iAKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qawsIFn6OXlTYb3DBUjwSLbSL3x7/ggfstn1DE2AROtc6vK8Ey9aVC39CccY/Cdqu7D4uk6/3qNeVyf8FJnUV31S/WjKOTLXCaxxonGi050oCEyN46FqMD5pqmyh3npHf7B3J9LDLCBjKbA+wcFPonCqBjt2DaPpT3GfQrsPHHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DorcDreE; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DorcDreE"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55b859545c3so2745752e87.0
        for <selinux@vger.kernel.org>; Fri, 01 Aug 2025 12:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754076861; x=1754681661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSa1RNfdLWUG80CIDj0SwE1p7d1bKZy9w1tm7wg2Lxs=;
        b=DorcDreEG6i8y5/0NZ4LHtq7Wz942Ku2ADELRLfZUPfxlsYPpnAuxhk+K0FlTxNy28
         X636tamhZUnUO4dOLZpCVoyy1uxToSUV60Nzw1VeZote7B0AyJxTx/cjaMr97Ii0T3bS
         M5lmcB6wnXh9XxqVeDss/DfGrBeDVtwFNO88aPkM/y6d6ySVF7/k4Z730LNbfzC6BiwX
         Fi2+LoramJVIXVxMe8f9+3iSm7DG1QXqnni7cByC/oO6xTZgfKp7MqODYLXRSOzVOvj3
         k/ibC/KoyQMtALY8aYxHIGbR+ud5m0BBiWrSLo8TSNrWYFgD6WNfWBiH2EZSs0xIh5GB
         cOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754076861; x=1754681661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VSa1RNfdLWUG80CIDj0SwE1p7d1bKZy9w1tm7wg2Lxs=;
        b=Sxk4REEbOgq1ceHzQJ0EQlmDJNmVppdZovRfZhqfzuNyKjfiZhlWHK52anoMHpnjqq
         GHc0rTFijpdzqcaAf47bPXVlJt1QNqkDkiRF8rtngi3Dydhx2dN+yohXTsrTfQxM1vSc
         RGSZVE2m2hMnue4wBhYMqpRjlXSN3lm+b5T6iFXxNHQRaKFjDqjsTf3dAjuvEWngGmCB
         gkB4wpEeL0iFwmhcx/1Se279xyMOx/rQIgXVP6gDncS+lc6jW3ancBogcJRLJXDWSAe0
         nhsbBkc7P7dWK/TatiL6goBuG8VjlUbUkOXGgJiS9mA1Wo9wRBx43Qcud/jPBufoX9qD
         S+8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXfmvYCDFo555vB9biKiH1N2ci5uQVVqtML7mpr+3/5mVWZEhnUtBoo+DCFKVfcfVkhwIV8el/f@vger.kernel.org
X-Gm-Message-State: AOJu0YwtuXp+qTnlsnBKzSkTUnyn9CHKIEjVo7G5DvMya5mNy514YgkP
	DLECS0Omod0k4v/DuxlNdbwlniNwhLqBWkFghKv1/o8pI475xkNWI2DCU38jzHnvfrIq8MnQy8g
	z6JcWLVllQTTanupsAh+WhF/ua9vtstY=
X-Gm-Gg: ASbGncv/b+7hKY4ZH2pCcD6802Xj02iKB07DWRw7RAs72vHV6e54sGj3Zy7IeLg4b2h
	1rbLVrZhWnDAivCh8aVX5RuWAWRdyKKz2E/6zJFwbn5wqpo8oamq8p14vFxECUhdkC81PN1lyCz
	KlG+fbuLzcI1JBgkVPmvkVyRmVATXv6z4KEdMf327aT2WR90pgnFJPR/03m7XJDxgTyq7ebBBqx
	Y2FO2CfXKY/p/gi
X-Google-Smtp-Source: AGHT+IHPqID/Pu5OHWKn5MMSTrB9LQFzR0Ig3oWU7hbtUxesbSQNq+W0G1ew2NqhxPoC+6tcecM+lFFheDSaLJyZoTs=
X-Received: by 2002:a05:6512:3c84:b0:55a:3358:a7ae with SMTP id
 2adb3069b0e04-55b88811a6amr2552148e87.0.1754076860974; Fri, 01 Aug 2025
 12:34:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801143300.1189741-1-nvraxn@gmail.com> <CAEjxPJ5RyF4ohqgrvCaPGJoEcXBCL3mY4U9CDhZEJfn3cNC_=Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ5RyF4ohqgrvCaPGJoEcXBCL3mY4U9CDhZEJfn3cNC_=Q@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Fri, 1 Aug 2025 14:34:10 -0500
X-Gm-Features: Ac12FXxfXJ9c26BS0dw0IIofI-tvz_RYaKmNQaBZXJ4ZBxmRvBnwkdiMEheEA4o
Message-ID: <CAFftDdr26=4fijzkgo0BsRgOyGgTyopVuddG39An=1Z_D2seqA@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: refactor semanage_user_roles
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Rahul Sandhu <nvraxn@gmail.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 1:27=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Aug 1, 2025 at 10:33=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> w=
rote:
> >
> > Reduce the levels of nesting by early returning on errors.
> >
> > Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
> > ---
> >  libsemanage/src/seusers_local.c | 76 +++++++++++++++++++--------------
> >  1 file changed, 45 insertions(+), 31 deletions(-)
> >
> > diff --git a/libsemanage/src/seusers_local.c b/libsemanage/src/seusers_=
local.c
> > index eb3f82bc..282d56fa 100644
> > --- a/libsemanage/src/seusers_local.c
> > +++ b/libsemanage/src/seusers_local.c
> > @@ -18,39 +18,53 @@ typedef struct semanage_seuser record_t;
> >  #include "string.h"
> >  #include <stdlib.h>
> >
> > -static char *semanage_user_roles(semanage_handle_t * handle, const cha=
r *sename) {
> > +static char *semanage_user_roles(semanage_handle_t * handle, const cha=
r * sename) {
> >         char *roles =3D NULL;
> > -       unsigned int num_roles;
> > -       size_t i;
> > -       size_t size =3D 0;
> > -       const char **roles_arr;
> > +       const char **roles_arr =3D NULL;
> >         semanage_user_key_t *key =3D NULL;
> > -       semanage_user_t * user;
> > -       if (semanage_user_key_create(handle, sename, &key) >=3D 0) {
> > -               if (semanage_user_query(handle, key, &user) >=3D 0) {
> > -                       if (semanage_user_get_roles(handle,
> > -                                                   user,
> > -                                                   &roles_arr,
> > -                                                   &num_roles) >=3D 0)=
 {
> > -                               for (i =3D 0; i<num_roles; i++) {
> > -                                       size +=3D (strlen(roles_arr[i])=
 + 1);
> > -                               }
> > -                               if (num_roles =3D=3D 0) {
> > -                                       roles =3D strdup("");
> > -                               } else {
> > -                                       roles =3D malloc(size);
> > -                                       if (roles) {
> > -                                               strcpy(roles,roles_arr[=
0]);
> > -                                               for (i =3D 1; i<num_rol=
es; i++) {
> > -                                                       strcat(roles,",=
");
> > -                                                       strcat(roles,ro=
les_arr[i]);
> > -                                               }
> > -                                       }
> > -                               }
> > -                               free(roles_arr);
> > -                       }
> > -                       semanage_user_free(user);
> > -               }
> > +       semanage_user_t *user =3D NULL;
> > +
> > +       if (semanage_user_key_create(handle, sename, &key) < 0) {
> > +               goto cleanup;
> > +       }
>
> Here and below, no need for { } around a single statement body.
>
> > +
> > +       if (semanage_user_query(handle, key, &user) < 0) {
> > +               goto cleanup;
> > +       }
> > +
> > +       unsigned int num_roles =3D 0;
> > +       if (semanage_user_get_roles(handle, user, &roles_arr, &num_role=
s) < 0) {
> > +               goto cleanup;
> > +       }
> > +
> > +       if (num_roles =3D=3D 0) {
> > +               roles =3D strdup("");
> > +               goto cleanup;
> > +       }
> > +
> > +       size_t size =3D 0;
> > +       for (size_t i =3D 0; i < num_roles; i++) {
> > +               size +=3D (strlen(roles_arr[i]) + 1);
> > +       }
> > +
> > +       roles =3D malloc(size);
> > +       if (!roles) {
> > +               goto cleanup;
> > +       }
> > +
> > +       strcpy(roles, roles_arr[0]);
> > +
> > +       for (size_t i =3D 1; i < num_roles; i++) {
> > +               strcat(roles, ",");
> > +               strcat(roles, roles_arr[i]);
> > +       }
> > +
> > +cleanup:
> > +       free(roles_arr);
> > +       if (user) {
> > +               semanage_user_free(user);
> > +       }
>
> Here and below, looks like it is valid to call with a NULL user/key so
> no need to test for non-NULL.

IIUC, there are also jumps to the cleanup label where variable user
could be uninitialized as well, so we need user initialized to NULL.

>
> > +       if (key) {
> >                 semanage_user_key_free(key);
> >         }
> >         return roles;
> > --
> > 2.50.1
> >
> >
>
