Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7047317579
	for <selinux@vger.kernel.org>; Wed, 30 Oct 2024 13:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730294144; cv=none; b=oMmCgtUSfNti2kBIhZ7wtiVviTFqgfH59dAm9WnvtgXVkM7+ry7KxgAf8QqV393kXYWVqj/voDPcPq50jOe+WoxEzKiyVNS1wRvyZosL7Ixxcov4wVrgUimoGdxlhHdTGlm8fielAaIhPt4xL/pacb7i3ycn6baGC4Uo55KWE6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730294144; c=relaxed/simple;
	bh=3BNWa1JkMVMvdo/z0DWq7UuNGuVyY8LsK8OTcxj9Pjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XO2ui2OLkr3cF0j3f6QlaIuzfXSKr/fE5lGA0UU+O749MbjkNUDyPuIUpN9ms+9HKXTt7v57mwF0kreHQiEQ518fTvQ+wmgrK2WH0qvNXu2taVCE9EmQ+uukntdKUD47Iz4jHjvAZtByQXelvOxl6wFiG4JK8z/7jAV53lHEDRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYMvpckO; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYMvpckO"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5daa93677e1so3378335eaf.3
        for <selinux@vger.kernel.org>; Wed, 30 Oct 2024 06:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730294141; x=1730898941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIUXHE94ILi03gxLQ57pcXhRYdxwNX/bYLN0dXp5H8U=;
        b=LYMvpckOKs5kvnU8hG1znGoKv/bCTSasXS9B6264xlE+zpeQtWnE1JNd7wt9jg/NkW
         4qnP8sKLldzMSF/MUhbhGsy80rMhrcvByKHTANkx0+xmsIpHQWfiKr9t1a+nnk7nkjYf
         NHEelHOJEOn9BHWWaq379iXno/UTOTynU3VaXq5B5sbm6MuaKYeVh7Bfoj4tB6/FpOdd
         wnsE+33VW1u2KTMiWPcNYispaXk/SaG0KI/VAGgtw94M1hs5RIcVM4nZKot3AeYcAbJK
         KWm5W7nx86enEtJwllYces2jG0RZ6Q+x4Ppp6rFXSB2CLRRElH1oEE4ypkTSLkJjHv/a
         ktQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730294141; x=1730898941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vIUXHE94ILi03gxLQ57pcXhRYdxwNX/bYLN0dXp5H8U=;
        b=VhxrDSkbZ9m9sabdOjBSbQTeTx06MzUfEF3Q/dO/9mHeLWkVsPMO6LB2y153ejAcJ9
         /Rptn/0ucfO7I6t83NoETiKcNDglVmJkVK7At0AcnyYmfcB4Q0E6ElEDmue2O8qnYCzP
         q8F1wZE7aSVR+avgQXBG0P85zw/a+/WuBiYZcnwz0sZKcjgTru4JY7yZgMAS4HWBdrlu
         I8KlsTxQfmZUVkBmPSAS4iSsHbZ/NXrH3q8EkdFcBOpfykJVktRjjQyrP5Q/KzjCV+eN
         4B0lGu34sABwYdhI1kKMaGB8/hTbHmRzolDmtjYlHauRnaTOdNldUpxW9IJzt8xvjGWO
         wiyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsLCjumFtv944xhjDAAnKsFkHHf//eqUwYprLXlRiaRGInBmhtkmfPD8GrcKJsJTUlwJEdfdKg@vger.kernel.org
X-Gm-Message-State: AOJu0YxOt84dW6uoPkkTde7gmst9H5ylUFkIdumKU+GCSTAzXwwX4H0a
	QcBzPXv3R6B3zZI8FtNK4sZv5jcTojoNulX1Im3usHmhQ/a6k2Gb8ZTCPyd1DJui8GmgVGpOczZ
	HFAiP6Yu6vrGWkhJvhoYfukY375Y=
X-Google-Smtp-Source: AGHT+IGaqPPZR0xHbYe2ZOWg5xNesKI4UmO2JbEXSfdh/FJ0TF0nhYpNNk/x4Y7PDa+1nefzX1Rmv/9x4BR1G7NZ/9s=
X-Received: by 2002:a05:6359:4c8b:b0:1c3:7070:4442 with SMTP id
 e5c5f4694b2df-1c3f9e87977mr646042155d.12.1730294141423; Wed, 30 Oct 2024
 06:15:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021231201.2638151-1-tweek@google.com> <CAP+JOzRH5QNpPhyj4=ZAnC7_hdAazfCdFRd8_j5secuOxb2Aww@mail.gmail.com>
In-Reply-To: <CAP+JOzRH5QNpPhyj4=ZAnC7_hdAazfCdFRd8_j5secuOxb2Aww@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 30 Oct 2024 09:15:30 -0400
Message-ID: <CAP+JOzRaj0OeCYLcd00tF13aQha6hq_AQFzuxi81+K0GYtr=wg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Support nlmsg xperms in assertions
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: stephen.smalley.work@gmail.com, paul@paul-moore.com, brambonne@google.com, 
	jeffv@google.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 2:13=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Oct 21, 2024 at 7:12=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@goo=
gle.com> wrote:
> >
> > commit ba7945a250c added support for nlmsg extended permissions in the
> > policy. The assertion validation was not updated which lead to false
> > positives when evaluated. The optimization update was also missing. Add
> > support for the new extended permission for optimization and assertions=
.
> >
> > Fixes: ba7945a250c0794837f94ee1fb124426166bbc6e
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsepol/src/assertion.c | 16 ++++++++++++++--
> >  libsepol/src/optimize.c  |  5 +++++
> >  2 files changed, 19 insertions(+), 2 deletions(-)
> >
> > diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
> > index 3076babe..5e129883 100644
> > --- a/libsepol/src/assertion.c
> > +++ b/libsepol/src/assertion.c
> > @@ -110,6 +110,10 @@ static int check_extended_permissions(av_extended_=
perms_t *neverallow, avtab_ext
> >         } else if ((neverallow->specified =3D=3D AVRULE_XPERMS_IOCTLDRI=
VER)
> >                         && (allow->specified =3D=3D AVTAB_XPERMS_IOCTLD=
RIVER)) {
> >                 rc =3D extended_permissions_and(neverallow->perms, allo=
w->perms);
> > +       } else if ((neverallow->specified =3D=3D AVRULE_XPERMS_NLMSG)
> > +                       && (allow->specified =3D=3D AVTAB_XPERMS_NLMSG)=
) {
> > +               if (neverallow->driver =3D=3D allow->driver)
> > +                       rc =3D extended_permissions_and(neverallow->per=
ms, allow->perms);
> >         }
> >
> >         return rc;
> > @@ -142,6 +146,12 @@ static void extended_permissions_violated(avtab_ex=
tended_perms_t *result,
> >                 result->specified =3D AVTAB_XPERMS_IOCTLDRIVER;
> >                 for (i =3D 0; i < EXTENDED_PERMS_LEN; i++)
> >                         result->perms[i] =3D neverallow->perms[i] & all=
ow->perms[i];
> > +       } else if ((neverallow->specified =3D=3D AVRULE_XPERMS_NLMSG)
> > +                       && (allow->specified =3D=3D AVTAB_XPERMS_NLMSG)=
) {
> > +               result->specified =3D AVTAB_XPERMS_NLMSG;
> > +               result->driver =3D allow->driver;
> > +               for (i =3D 0; i < EXTENDED_PERMS_LEN; i++)
> > +                       result->perms[i] =3D neverallow->perms[i] & all=
ow->perms[i];
> >         }
> >  }
> >
> > @@ -176,7 +186,8 @@ static int report_assertion_extended_permissions(se=
pol_handle_t *handle,
> >                              node =3D avtab_search_node_next(node, tmp_=
key.specified)) {
> >                                 xperms =3D node->datum.xperms;
> >                                 if ((xperms->specified !=3D AVTAB_XPERM=
S_IOCTLFUNCTION)
> > -                                               && (xperms->specified !=
=3D AVTAB_XPERMS_IOCTLDRIVER))
> > +                                               && (xperms->specified !=
=3D AVTAB_XPERMS_IOCTLDRIVER)
> > +                                               && (xperms->specified !=
=3D AVTAB_XPERMS_NLMSG))
> >                                         continue;
> >                                 found_xperm =3D 1;
> >                                 rc =3D check_extended_permissions(avrul=
e->xperms, xperms);
> > @@ -376,7 +387,8 @@ static int check_assertion_extended_permissions_avt=
ab(avrule_t *avrule, avtab_t
> >                                 xperms =3D node->datum.xperms;
> >
> >                                 if ((xperms->specified !=3D AVTAB_XPERM=
S_IOCTLFUNCTION)
> > -                                               && (xperms->specified !=
=3D AVTAB_XPERMS_IOCTLDRIVER))
> > +                                               && (xperms->specified !=
=3D AVTAB_XPERMS_IOCTLDRIVER)
> > +                                               && (xperms->specified !=
=3D AVTAB_XPERMS_NLMSG))
> >                                         continue;
> >                                 rc =3D check_extended_permissions(never=
allow_xperms, xperms);
> >                                 if (rc)
> > diff --git a/libsepol/src/optimize.c b/libsepol/src/optimize.c
> > index a38025ec..8a0b70fe 100644
> > --- a/libsepol/src/optimize.c
> > +++ b/libsepol/src/optimize.c
> > @@ -189,6 +189,11 @@ static int process_avtab_datum(uint16_t specified,
> >
> >                         if (x2->specified =3D=3D AVTAB_XPERMS_IOCTLDRIV=
ER)
> >                                 return process_xperms(x1->perms, x2->pe=
rms);
> > +               } else if (x1->specified =3D=3D AVTAB_XPERMS_NLMSG
> > +                               && x2->specified =3D=3D AVTAB_XPERMS_NL=
MSG) {
> > +                       if (x1->driver !=3D x2->driver)
> > +                               return 0;
> > +                       return process_xperms(x1->perms, x2->perms);
> >                 }
> >                 return 0;
> >         }
> > --
> > 2.47.0.105.g07ac214952-goog
> >
> >
