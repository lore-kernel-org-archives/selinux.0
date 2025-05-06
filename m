Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378A94B1E5C
	for <selinux@vger.kernel.org>; Tue,  6 May 2025 19:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560005; cv=none; b=OM0PCmtezxYTDEqPjxug+P7MrjYjgoAV5976YdCoXyTd19UzEynLUhUNuhjLsI0+JccQIkljNv6XnXQzJKIiq/VzwlOka2I7w76hWppZQpKAZZQbHV69FlMEPC4YoBu7BzpSwdUFYqRcQ5gqC44r5FPoLA/CtbQNCYyab0BCxB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560005; c=relaxed/simple;
	bh=ZhYii3plCOQZc5ILLMdQv5JgR9SuDI+RR/pYnoDgYzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJWWisMiZVcEEGunLKQt7pfqJi02BAaYSD7lmuxUNltLZeQQHac2ouzOpPrQh28oIl4+t9uZQHHOQ7gT+S7v+Xg11sho1RetTJRQaHS8H5UM++SaReJnNt0lJmEIBqAnsHgbdNZpdDe0ZHlzB+6O1WR5F6Lm7/zj9PeyO9xwSw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEpw6pRS; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEpw6pRS"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4c326617e6cso1619420137.1
        for <selinux@vger.kernel.org>; Tue, 06 May 2025 12:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746560003; x=1747164803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhy31NZH7IXq1bU3vVrMtNpmpVMe7K2//Q8yC97zDPA=;
        b=VEpw6pRSyJ96nltkaBD0scWGGuI+1PY5upqixyl7dBgCWnWyYNNAAdz/ilN9InhrNb
         ul7YbHeb5gnD+JvvQ3w8MfSjjsyIhPrFxaBrmV/NUkBCRtfvIkgKgkKdxLjLdiqd1/x/
         dxqBorbI7FE4VMu9K/hz6n9ttEcHG6xhqCM3gO4Jf1V7pxKty1t0nxn47hqZ/sqVzQhI
         ywdMhyLFKCegOtTPI3Dfj8gF/3NNmSnA40xUDaNkUAC52FKiq6aM0Tdi+7HNsY5UQGJy
         nqQTpBAdExJKXZ540AF6xSm83WaxI0CSSeHrVRlhEsJ0Xvuu72W4epvxPi2opoN+Yq5Q
         ttug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746560003; x=1747164803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vhy31NZH7IXq1bU3vVrMtNpmpVMe7K2//Q8yC97zDPA=;
        b=gpXoKJYpS4RgfrSLMNDocWiCTotlLM6QX7MbvXS3u5uEEnm+7Jnbw5jceYOTggGaFf
         eH/NPeoM/flUQ4XfXw6kLNftQhvYtsvsOl90zPXsgvedBKuPBcipZU/kZkzd//wWgvXt
         p29IiEJ2FsDImcUmIL04tqtz06GVZN1us6OpKyei+hCoQ/DvwWZ78JGbo93x48iuMnd0
         PCzdDs5dxiEcM1aWY7dds+Din9qa7yCEyPLORUvW3sBDsOAPmGx/ol1UhRVXveEownWr
         XJx9N9gyhM2Jwedj/uFxmKCPL0qYTxvBEpUHo2ieo35voc6QGJohaI7fTIIg/8QeGhgq
         eJeg==
X-Gm-Message-State: AOJu0YxyHiOJ1V5JzBvHAXCOXdUyoT7m43AMwBYKWESmSDrpipDl+Q9t
	MAf6bU+jJ++O78eAb3x4VcgADKv8GuBdRtS3/VQ150R7ic6S/sRGOy36S4qE9Xe+dSXSgyN0zm5
	cKTXzCoTgzfuv4zEY3jjhOYX6J189ew==
X-Gm-Gg: ASbGncv0FBhdQXWSoZMcvbFE44gIsqNVt5MkbDa3Qz3Q0W826JTKXwKaDdz++m/GNDR
	Mec15rHWYX5J3QdOJt0jtgbLWeuwtHPubWoRZcD4iR9PyAyjucCSseAc8w5pRJESH5LjKo2vrxd
	MGhJlZUZHN0ocvjG9Hcq0=
X-Google-Smtp-Source: AGHT+IHuWGLB1VRH0WYRcDK2ea7NiSnBeV7M7UkwpGjRVJO3lpY1TFSXWF9eLjp+3BjBy+f3G+lwaaVlZV78pgAC8Rs=
X-Received: by 2002:a05:6102:80a2:b0:4c1:9780:3830 with SMTP id
 ada2fe7eead31-4dc738d3f53mr773021137.23.1746560002950; Tue, 06 May 2025
 12:33:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP+JOzSG74saeVmTz5kdX_Lj3B+5BO-5MbKtxU7VLBOhp-h8Vw@mail.gmail.com>
 <20250425180925.241079-1-tristan.ross@midstall.com> <CAP+JOzSsZu-bepCMh1iqO9o4YJhLfevN28Bf2sLuCjOgjf4_UA@mail.gmail.com>
In-Reply-To: <CAP+JOzSsZu-bepCMh1iqO9o4YJhLfevN28Bf2sLuCjOgjf4_UA@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 6 May 2025 15:33:10 -0400
X-Gm-Features: ATxdqUE_ewG9Wjy7l6bWEjo-3sMqEpYevT1Qx4x_4vldsU8KN75adBuJWMu1frY
Message-ID: <CAP+JOzTYBhCGR9cB1efCK3a4A7xa5L_zjY=z0CX3Bp_7h0fS1g@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsemanage: add semanage_handle_create_with_path
To: Tristan Ross <tristan.ross@midstall.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 11:18=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Fri, Apr 25, 2025 at 2:09=E2=80=AFPM Tristan Ross <tristan.ross@midsta=
ll.com> wrote:
> >
> > Adds "semanage_handle_create_with_path" to create an semanage handle
> > with a config file from a specific path. This is useful for baking
> > SELinux policy generation into a Nix derivation.
> >
> > Signed-off-by: Tristan Ross <tristan.ross@midstall.com>
>
> For these two patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

These two patches have been merged.
Thanks,
Jim

> > ---
> >  libsemanage/include/semanage/handle.h |  6 +++++-
> >  libsemanage/src/handle.c              | 26 +++++++++++++++++++-------
> >  libsemanage/src/libsemanage.map       |  4 ++++
> >  3 files changed, 28 insertions(+), 8 deletions(-)
> >
> > diff --git a/libsemanage/include/semanage/handle.h b/libsemanage/includ=
e/semanage/handle.h
> > index a5ea31de..601cd9ee 100644
> > --- a/libsemanage/include/semanage/handle.h
> > +++ b/libsemanage/include/semanage/handle.h
> > @@ -30,7 +30,11 @@
> >  struct semanage_handle;
> >  typedef struct semanage_handle semanage_handle_t;
> >
> > -/* Create and return a semanage handle.
> > +/* Create and return a semanage handle with a specific config path.
> > +   The handle is initially in the disconnected state. */
> > +semanage_handle_t *semanage_handle_create_with_path(const char *conf_n=
ame);
> > +
> > +/* Create and return a semanage handle with the default config path.
> >     The handle is initially in the disconnected state. */
> >  extern semanage_handle_t *semanage_handle_create(void);
> >
> > diff --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c
> > index faea0606..ca57702a 100644
> > --- a/libsemanage/src/handle.c
> > +++ b/libsemanage/src/handle.c
> > @@ -59,19 +59,14 @@ const char * semanage_root(void)
> >         return private_semanage_root;
> >  }
> >
> > -
> > -semanage_handle_t *semanage_handle_create(void)
> > +semanage_handle_t *semanage_handle_create_with_path(const char *conf_n=
ame)
> >  {
> >         semanage_handle_t *sh =3D NULL;
> > -       char *conf_name =3D NULL;
> >
> >         /* Allocate handle */
> >         if ((sh =3D calloc(1, sizeof(semanage_handle_t))) =3D=3D NULL)
> >                 goto err;
> >
> > -       if ((conf_name =3D semanage_conf_path()) =3D=3D NULL)
> > -               goto err;
> > -
> >         if ((sh->conf =3D semanage_conf_parse(conf_name)) =3D=3D NULL)
> >                 goto err;
> >
> > @@ -106,13 +101,30 @@ semanage_handle_t *semanage_handle_create(void)
> >         sh->msg_callback =3D semanage_msg_default_handler;
> >         sh->msg_callback_arg =3D NULL;
> >
> > +       return sh;
> > +
> > +      err:
> > +       semanage_handle_destroy(sh);
> > +       return NULL;
> > +}
> > +
> > +semanage_handle_t *semanage_handle_create(void)
> > +{
> > +       semanage_handle_t *sh =3D NULL;
> > +       char *conf_name =3D NULL;
> > +
> > +       if ((conf_name =3D semanage_conf_path()) =3D=3D NULL)
> > +               goto err;
> > +
> > +       if ((sh =3D semanage_handle_create_with_path(conf_name)) =3D=3D=
 NULL)
> > +               goto err;
> > +
> >         free(conf_name);
> >
> >         return sh;
> >
> >        err:
> >         free(conf_name);
> > -       semanage_handle_destroy(sh);
> >         return NULL;
> >  }
> >
> > diff --git a/libsemanage/src/libsemanage.map b/libsemanage/src/libseman=
age.map
> > index c8214b26..8d7d8b05 100644
> > --- a/libsemanage/src/libsemanage.map
> > +++ b/libsemanage/src/libsemanage.map
> > @@ -350,3 +350,7 @@ LIBSEMANAGE_3.4 {
> >      semanage_module_compute_checksum;
> >      semanage_set_check_ext_changes;
> >  } LIBSEMANAGE_1.1;
> > +
> > +LIBSEMANAGE_3.9 {
> > +    semanage_handle_create_with_path;
> > +} LIBSEMANAGE_3.4;
> > --
> > 2.47.2
> >
> >
