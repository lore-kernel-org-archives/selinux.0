Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9316B2576
	for <selinux@vger.kernel.org>; Thu, 31 Jul 2025 14:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753971427; cv=none; b=bH8NDGSX0Tlbhi6EO6ziAw71q20AznJauEdfCegOoNk6T+Sh4suQJCXdkvExPARGCaBAo0B2UGXNLQ6a8xQ+D/aUwk5PeBShLpjoXsyiM1SvbvnscWZqcIuDvLIY5aplqJlmC3qIDe50TDt/aO8K+kBb1v3XpdhK41hocWDWwlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753971427; c=relaxed/simple;
	bh=+Iz3AEfS76Te6ka6v/APu7RBq8koIri5yaZDG3SgYXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iphd5pK09xc2b7yJ7Z9sO7rY761N2bMccZoD39DoiGDRe8jVWEBKraRz0NOPYdY/seNn/nejBKuFKkqrPWAB9EFfP+HfrPFpiGfY073inSaP4wbQBAyZi5pOBfzAD1WNYdg9sjGGsRFKf+9Tr6NLuvp6PHCGI6ZB3HVyHKTBYrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVjaqhJU; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVjaqhJU"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-31eb75f4ce1so904486a91.3
        for <selinux@vger.kernel.org>; Thu, 31 Jul 2025 07:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753971425; x=1754576225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWcNWzeS8iWxUpxwHCrb6Q13zBjYPVADrgEuLkydMR4=;
        b=EVjaqhJUJhG9Id7KQVnGNuZJhXfRMV0mcsHZsJNBcI6XMAPgGTeLSym67mvSPJABE9
         gJteGTgLHe2qskDSmypAwiAf+9KGgDEl9vJ8M+6jXJx4Gm0IMKdhjwwzGdps5tFu/Ytr
         uXP1ESO/KvdoOZSotB+oIOai8d2FN9ld8fDzYJgCW9pnNav/dCL+noYY0W02/3BgnMuR
         8vVcs6xzOJ7MmM8m+JFYL2GbKrEZl7QNdAZeUt+5Ag8uKAVuu57kmKnizW0wy0sh4MSr
         QB7J3ItT8jsTQt3ZrK8Uu4ueREax1SURByh45Z1wl/IFYKW1bJJiFoiMfrBO1wAaGFrd
         RzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753971425; x=1754576225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWcNWzeS8iWxUpxwHCrb6Q13zBjYPVADrgEuLkydMR4=;
        b=EM1ZiwatlJW2eOmAVYgP6R9/BKCO3viqYaMO68ZfNH2RfY3Hf3rfxG3nieKp7ZCu5o
         Ir/gm43LgBn/Nip6Iqyyiqp4gb8BmfMi8bmEGlNF9LIWXNPp8D0THkOi43l4+9xHdIGF
         G1vSww3a1pndA7iYQFsvbYj3tUa4lxPDuyAsaDDhYukL16RpguFFKtwSQOR7mVNOL3K8
         JOJwUwCDQtFni650JMfL+3VEIzmFwcSdfq7PCQHEGiXxTQoMmDorI35kijdjxk/Kq0uA
         6AV7Ok6QKp9GbEWEOeeCTp5Kuu6AsA4VH8iNIpEbN8VKIK8e3nt8GU+HfnAdupm4uvPq
         MyCw==
X-Gm-Message-State: AOJu0YwNkkIyYw2WuAJ3NDehZDx8zaCGIkHHN3UO90mQsluJX/flF081
	4YrO6enCnHAzZEyWTd7iGNCbTrfuq2LzHmh+JspMbbwH4tCPuwc9uFb4NscnAVpcUhjC9BYNd2L
	tBbIoKzmMOS62BaL9GnmKoJ4UWMoBGEw=
X-Gm-Gg: ASbGncsGpFZaVsRBGewO4cUHUy+e5fPvPkkrQ4jkk42iyurOZuwCI8gHHm7MRwMZflj
	GfrXeXmG95LL4WHk7lUA37faBKx9JCeV4m7gsx+c0yjpV1hI+EycNcUDVoN/oKEsVG9oaATInGj
	RWiAna1W654IjHG6nl+AvPhf78b2vxQabV4i5F/8htCvEtqTqunRvbihptdLJ4nvdhKJg3JW+tA
	wZBWe4=
X-Google-Smtp-Source: AGHT+IEh84gfH9Dg9jqbcsoaq1bgOpCpWkI5jnXcDC0XCoAerycav7PE8U8sc8nPdJo7Hra76bDspE/dTgGF/Z8l0og=
X-Received: by 2002:a17:90b:380a:b0:31f:28ae:8709 with SMTP id
 98e67ed59e1d1-31f5ddb096cmr12273118a91.8.1753971424330; Thu, 31 Jul 2025
 07:17:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250727154422.732647-1-nvraxn@gmail.com> <20250727155530.733633-1-nvraxn@gmail.com>
 <CAEjxPJ54SJLsdzygZiCc8L4vfwdFPJ5mpLzjXvDZ_aJCcp=EXw@mail.gmail.com>
In-Reply-To: <CAEjxPJ54SJLsdzygZiCc8L4vfwdFPJ5mpLzjXvDZ_aJCcp=EXw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 31 Jul 2025 10:16:53 -0400
X-Gm-Features: Ac12FXzgMmjl_8n3TPMwhYEBZz2SNQrRZG-2SX2ZnnEogdUlXBemB5150Kj9U4I
Message-ID: <CAEjxPJ6-h=YkfE6O1EnNcWHPANCfio2yJnFrt-QXJwaZ9Kx2Gg@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: remove out2 labels
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 10:51=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Sun, Jul 27, 2025 at 11:55=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> =
wrote:
> >
> > The out2 label previously only existed such that free(buf) isn't called
> > if malloc(3) fails to allocate buf. However, posix says[1] that calling
> > free(3) with a nullptr is valid:
> >
> > > If ptr is a null pointer, no action shall occur.
> >
> > Hence, remove the extra labels to simplify the logic.
> >
> > [1] https://pubs.opengroup.org/onlinepubs/009604499/functions/free.html
> >
> > Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, applied.

>
> > ---
> >  libselinux/src/canonicalize_context.c |  9 ++++-----
> >  libselinux/src/compute_av.c           | 11 +++++------
> >  libselinux/src/compute_create.c       | 13 ++++++-------
> >  libselinux/src/compute_member.c       | 11 +++++------
> >  libselinux/src/compute_relabel.c      | 11 +++++------
> >  libselinux/src/compute_user.c         | 15 +++++++--------
> >  libselinux/src/get_initial_context.c  |  7 +++----
> >  libselinux/src/procattr.c             |  9 ++++-----
> >  8 files changed, 39 insertions(+), 47 deletions(-)
> >
> > diff --git a/libselinux/src/canonicalize_context.c b/libselinux/src/can=
onicalize_context.c
> > index 6af8491d..d9f0beb4 100644
> > --- a/libselinux/src/canonicalize_context.c
> > +++ b/libselinux/src/canonicalize_context.c
> > @@ -36,12 +36,12 @@ int security_canonicalize_context_raw(const char * =
con,
> >         if (strlcpy(buf, con, size) >=3D size) {
> >                 errno =3D EOVERFLOW;
> >                 ret =3D -1;
> > -               goto out2;
> > +               goto out;
> >         }
> >
> >         ret =3D write(fd, buf, strlen(buf) + 1);
> >         if (ret < 0)
> > -               goto out2;
> > +               goto out;
> >
> >         memset(buf, 0, size);
> >         ret =3D read(fd, buf, size - 1);
> > @@ -54,12 +54,11 @@ int security_canonicalize_context_raw(const char * =
con,
> >         *canoncon =3D strdup(buf);
> >         if (!(*canoncon)) {
> >                 ret =3D -1;
> > -               goto out2;
> > +               goto out;
> >         }
> >         ret =3D 0;
> > -      out2:
> > -       free(buf);
> >        out:
> > +       free(buf);
> >         close(fd);
> >         return ret;
> >  }
> > diff --git a/libselinux/src/compute_av.c b/libselinux/src/compute_av.c
> > index 354a19e1..bd31279f 100644
> > --- a/libselinux/src/compute_av.c
> > +++ b/libselinux/src/compute_av.c
> > @@ -46,17 +46,17 @@ int security_compute_av_flags_raw(const char * scon=
,
> >         if (ret < 0 || (size_t)ret >=3D len) {
> >                 errno =3D EOVERFLOW;
> >                 ret =3D -1;
> > -               goto out2;
> > +               goto out;
> >         }
> >
> >         ret =3D write(fd, buf, strlen(buf));
> >         if (ret < 0)
> > -               goto out2;
> > +               goto out;
> >
> >         memset(buf, 0, len);
> >         ret =3D read(fd, buf, len - 1);
> >         if (ret < 0)
> > -               goto out2;
> > +               goto out;
> >
> >         ret =3D sscanf(buf, "%x %x %x %x %u %x",
> >                      &avd->allowed, &avd->decided,
> > @@ -64,7 +64,7 @@ int security_compute_av_flags_raw(const char * scon,
> >                      &avd->seqno, &avd->flags);
> >         if (ret < 5) {
> >                 ret =3D -1;
> > -               goto out2;
> > +               goto out;
> >         } else if (ret < 6)
> >                 avd->flags =3D 0;
> >
> > @@ -79,9 +79,8 @@ int security_compute_av_flags_raw(const char * scon,
> >                 map_decision(tclass, avd);
> >
> >         ret =3D 0;
> > -      out2:
> > -       free(buf);
> >        out:
> > +       free(buf);
> >         close(fd);
> >         return ret;
> >  }
> > diff --git a/libselinux/src/compute_create.c b/libselinux/src/compute_c=
reate.c
> > index ff8553bc..b0c6ea34 100644
> > --- a/libselinux/src/compute_create.c
> > +++ b/libselinux/src/compute_create.c
> > @@ -81,34 +81,33 @@ int security_compute_create_name_raw(const char * s=
con,
> >         if (len < 0 || (size_t)len >=3D size) {
> >                 errno =3D EOVERFLOW;
> >                 ret =3D -1;
> > -               goto out2;
> > +               goto out;
> >         }
> >
> >         if (objname &&
> >             object_name_encode(objname, buf + len, size - len) < 0) {
> >                 errno =3D ENAMETOOLONG;
> >                 ret =3D -1;
> > -               goto out2;
> > +               goto out;
> >         }
> >
> >         ret =3D write(fd, buf, strlen(buf));
> >         if (ret < 0)
> > -               goto out2;
> > +               goto out;
> >
> >         memset(buf, 0, size);
> >         ret =3D read(fd, buf, size - 1);
> >         if (ret < 0)
> > -               goto out2;
> > +               goto out;
> >
> >         *newcon =3D strdup(buf);
> >         if (!(*newcon)) {
> >                 ret =3D -1;
> > -               goto out2;
> > +               goto out;
> >         }
> >         ret =3D 0;
> > -      out2:
> > -       free(buf);
> >        out:
> > +       free(buf);
> >         close(fd);
> >         return ret;
> >  }
> > diff --git a/libselinux/src/compute_member.c b/libselinux/src/compute_m=
ember.c
> > index 53d2f559..ebe33264 100644
> > --- a/libselinux/src/compute_member.c
> > +++ b/libselinux/src/compute_member.c
> > @@ -41,27 +41,26 @@ int security_compute_member_raw(const char * scon,
> >         if (ret < 0 || (size_t)ret >=3D size) {
> >                 errno =3D EOVERFLOW;
> >                 ret =3D -1;
> > -               goto out2;
> > +               goto out;
> >         }
> >
> >         ret =3D write(fd, buf, strlen(buf));
> >         if (ret < 0)
> > -               goto out2;
> > +               goto out;
> >
> >         memset(buf, 0, size);
> >         ret =3D read(fd, buf, size - 1);
> >         if (ret < 0)
> > -               goto out2;
> > +               goto out;
> >
> >         *newcon =3D strdup(buf);
> >         if (!(*newcon)) {
> >                 ret =3D -1;
> > -               goto out2;
> > +               goto out;
> >         }
> >         ret =3D 0;
> > -      out2:
> > -       free(buf);
> >        out:
> > +       free(buf);
> >         close(fd);
> >         return ret;
> >  }
> > diff --git a/libselinux/src/compute_relabel.c b/libselinux/src/compute_=
relabel.c
> > index 9c0a2304..b2c1520e 100644
> > --- a/libselinux/src/compute_relabel.c
> > +++ b/libselinux/src/compute_relabel.c
> > @@ -41,27 +41,26 @@ int security_compute_relabel_raw(const char * scon,
> >         if (ret < 0 || (size_t)ret >=3D size) {
> >                 errno =3D EOVERFLOW;
> >                 ret =3D -1;
> > -               goto out2;
> > +               goto out;
> >         }
> >
> >         ret =3D write(fd, buf, strlen(buf));
> >         if (ret < 0)
> > -               goto out2;
> > +               goto out;
> >
> >         memset(buf, 0, size);
> >         ret =3D read(fd, buf, size - 1);
> >         if (ret < 0)
> > -               goto out2;
> > +               goto out;
> >
> >         *newcon =3D strdup(buf);
> >         if (!*newcon) {
> >                 ret =3D -1;
> > -               goto out2;
> > +               goto out;
> >         }
> >         ret =3D 0;
> > -      out2:
> > -       free(buf);
> >        out:
> > +       free(buf);
> >         close(fd);
> >         return ret;
> >  }
> > diff --git a/libselinux/src/compute_user.c b/libselinux/src/compute_use=
r.c
> > index d4387aed..584219c7 100644
> > --- a/libselinux/src/compute_user.c
> > +++ b/libselinux/src/compute_user.c
> > @@ -43,27 +43,27 @@ int security_compute_user_raw(const char * scon,
> >         if (ret < 0 || (size_t)ret >=3D size) {
> >                 errno =3D EOVERFLOW;
> >                 ret =3D -1;
> > -               goto out2;
> > +               goto out;
> >         }
> >
> >         ret =3D write(fd, buf, strlen(buf));
> >         if (ret < 0)
> > -               goto out2;
> > +               goto out;
> >
> >         memset(buf, 0, size);
> >         ret =3D read(fd, buf, size - 1);
> >         if (ret < 0)
> > -               goto out2;
> > +               goto out;
> >
> >         if (sscanf(buf, "%u", &nel) !=3D 1) {
> >                 ret =3D -1;
> > -               goto out2;
> > +               goto out;
> >         }
> >
> >         ary =3D malloc((nel + 1) * sizeof(char *));
> >         if (!ary) {
> >                 ret =3D -1;
> > -               goto out2;
> > +               goto out;
> >         }
> >
> >         ptr =3D buf + strlen(buf) + 1;
> > @@ -72,16 +72,15 @@ int security_compute_user_raw(const char * scon,
> >                 if (!ary[i]) {
> >                         freeconary(ary);
> >                         ret =3D -1;
> > -                       goto out2;
> > +                       goto out;
> >                 }
> >                 ptr +=3D strlen(ptr) + 1;
> >         }
> >         ary[nel] =3D NULL;
> >         *con =3D ary;
> >         ret =3D 0;
> > -      out2:
> > -       free(buf);
> >        out:
> > +       free(buf);
> >         close(fd);
> >         return ret;
> >  }
> > diff --git a/libselinux/src/get_initial_context.c b/libselinux/src/get_=
initial_context.c
> > index fb774c82..badcda9f 100644
> > --- a/libselinux/src/get_initial_context.c
> > +++ b/libselinux/src/get_initial_context.c
> > @@ -46,17 +46,16 @@ int security_get_initial_context_raw(const char * n=
ame, char ** con)
> >         }
> >         ret =3D read(fd, buf, size - 1);
> >         if (ret < 0)
> > -               goto out2;
> > +               goto out;
> >
> >         *con =3D strdup(buf);
> >         if (!(*con)) {
> >                 ret =3D -1;
> > -               goto out2;
> > +               goto out;
> >         }
> >         ret =3D 0;
> > -      out2:
> > -       free(buf);
> >        out:
> > +       free(buf);
> >         close(fd);
> >         return ret;
> >  }
> > diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
> > index aa16c934..f8e8f191 100644
> > --- a/libselinux/src/procattr.c
> > +++ b/libselinux/src/procattr.c
> > @@ -153,22 +153,21 @@ static int getprocattrcon_raw(char **context, pid=
_t pid, const char *attr,
> >                 ret =3D read(fd, buf, size - 1);
> >         } while (ret < 0 && errno =3D=3D EINTR);
> >         if (ret < 0)
> > -               goto out2;
> > +               goto out;
> >
> >         if (ret =3D=3D 0) {
> >                 *context =3D NULL;
> > -               goto out2;
> > +               goto out;
> >         }
> >
> >         *context =3D strdup(buf);
> >         if (!(*context)) {
> >                 ret =3D -1;
> > -               goto out2;
> > +               goto out;
> >         }
> >         ret =3D 0;
> > -      out2:
> > -       free(buf);
> >        out:
> > +       free(buf);
> >         errno_hold =3D errno;
> >         close(fd);
> >         errno =3D errno_hold;
> > --
> > 2.50.1
> >
> >
