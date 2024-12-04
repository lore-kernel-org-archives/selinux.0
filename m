Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0F1202F84
	for <selinux@vger.kernel.org>; Wed,  4 Dec 2024 14:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733322586; cv=none; b=HvWtApPSET3c4iCt/radDF5Hv2GZu1f0OPIs1iz4gEf22LWUtF0yPxq7T6MS9HekCI0WwHxViilipzlrrg18wXXQiHihRMmtxWIgUkn27EMxzpzNTFS+Um0OldPWgxACWe4vtQiQ+jKYDhH87FHgi/H5c9ro77DImRqaoqwoutE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733322586; c=relaxed/simple;
	bh=khRMM99mMcmf4HnRkQwAVYI+UOFpJpGuinc0g0asbGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NUCYQhuoy71MVJNADR6JbxN/amHtu0OBg2UbzWYwjMXZfHzEaI/pPRJ5k/tQj3kM24aa3+/AdkfeAsCxO7rOYSiCLb3zCbFciwOSN882sRPltnWx0EyK9460kmr0z7Qyw+eN/0vmTtJeDmvVlX7OBCy7V/MCseEmY5yIIyOi9gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUv45sV6; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUv45sV6"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3e916196023so3914532b6e.3
        for <selinux@vger.kernel.org>; Wed, 04 Dec 2024 06:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733322583; x=1733927383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYpmRQMbQPGCsMtHRx7AITZLzl1myya587f3Tm0Yq60=;
        b=DUv45sV6VdnqStgmeIEgAeTWOBuV1j0THXg0UTJD/pp/P75BBXAYSjPSIUm3ouo9Sw
         7LWpl9zfobCLSEl+Z5ydTS6TPEH/MtaORO1U31W4FGXjsVPF7fLhWo6qLCYmEPMawSwi
         NMslbBX4UwUB1SzSxI6jqk2tu1Z/GNkiWBoydCslJ2fOzbgR93UJH0LpRNy1JlA9AId5
         mZW+EchlBmCOfGVyWM3NHSRh3ex5q4RPQi9qYI0DReODpYim3And3SHtPHBSt4Rs+4ZN
         NBDJUxG0LLvmGT/4heVSGZ4KU0fvyPBYsnBEX8c/OVXi+eShUGVeKF3nYF8AXSu2pNEa
         UsVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733322583; x=1733927383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lYpmRQMbQPGCsMtHRx7AITZLzl1myya587f3Tm0Yq60=;
        b=gW7v1ikwqnp//Xva9NDiKShw7xkqbo6HMWpgjAa+3mZz9y7AlFIe7+VcC0h+si3xRm
         cypxPu8ajYDnS+j2PbJxi7xozjsb1bYuqPlR1XZepsh5e3ddd42paLwxVeO3x+3+Gco2
         kL1GgF2kngWSDkCrKKZnfYhqzkLuG/G+Xp0WZEs9L/qxxj2DCkfrKnWrHhI9hht3u/eZ
         3NPCZ+yh4XJ5lBS0pBKVkNAK5qwk6XbT00Nh+/2NdX2KEHkFDLV9BdL3pFpK0Ak2tgX+
         denVWBqTYl+VNhqdxaEo2CUJVcwGQMFSsx+sXXHLvnG9u1750foxkBqURxZd/41Tom2C
         VdZg==
X-Gm-Message-State: AOJu0YwO7lLVZokztOrhNH2DjBQ2dpwTmd0kcAXIALgoJ1opx1CL6LCV
	UwlGPlfsva2K6y35Cs8YxXuI4Uv3URIS+//eq1cOAhH/1j9ZadUeOuupm0vMXGJf/J5yHG4BgZ0
	SoAR+xEQOZMuZS4KooCLd5f8pbH+DSg==
X-Gm-Gg: ASbGncsYyPJ3y1HWEIdURMnhl1HQ6+zLRzKWQCe4Eww0zjphetuWF1qtUHMUs5fKwRu
	x43KAhu7Vcga9jo6AeU5q2YGLcyGQsqk=
X-Google-Smtp-Source: AGHT+IFU5xUQdtwzcfhHn8Uf2nAykxvyerblFVcXCOREsKpna79U/+ot98NSsotZ/R2KCDFlOgwjk0PrpERtMG4xFRY=
X-Received: by 2002:a05:6358:d38c:b0:1b8:341d:36a1 with SMTP id
 e5c5f4694b2df-1caeaa8a82fmr559834355d.2.1733322583337; Wed, 04 Dec 2024
 06:29:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120115951.42445-1-cgoettsche@seltendoof.de> <CAP+JOzSY4U+LJmP1reVw=mse7eG897=oj79gDp6XvRCxmFpS-g@mail.gmail.com>
In-Reply-To: <CAP+JOzSY4U+LJmP1reVw=mse7eG897=oj79gDp6XvRCxmFpS-g@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 4 Dec 2024 09:29:32 -0500
Message-ID: <CAP+JOzQx9qqFQz+RWqGcGm4QgxydyqZ_jwcFz=C4Y3HXZECF3g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] libselinux: make use of calloc(3)
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 4:02=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Wed, Nov 20, 2024 at 7:00=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Use calloc(3) instead of calling malloc(3) plus a call to memset(3) or
> > manual zero'ing.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these three patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

These three patches have been merged.
Thanks,
Jim

> > ---
> >  libselinux/src/fgetfilecon.c         | 3 +--
> >  libselinux/src/get_context_list.c    | 3 +--
> >  libselinux/src/get_initial_context.c | 3 +--
> >  libselinux/src/getfilecon.c          | 3 +--
> >  libselinux/src/getpeercon.c          | 3 +--
> >  libselinux/src/label_media.c         | 6 ++----
> >  libselinux/src/label_x.c             | 6 ++----
> >  libselinux/src/lgetfilecon.c         | 3 +--
> >  libselinux/src/matchpathcon.c        | 3 +--
> >  libselinux/src/procattr.c            | 3 +--
> >  libselinux/src/setrans_client.c      | 5 ++---
> >  11 files changed, 14 insertions(+), 27 deletions(-)
> >
> > diff --git a/libselinux/src/fgetfilecon.c b/libselinux/src/fgetfilecon.=
c
> > index d7051171..782861ed 100644
> > --- a/libselinux/src/fgetfilecon.c
> > +++ b/libselinux/src/fgetfilecon.c
> > @@ -39,10 +39,9 @@ int fgetfilecon_raw(int fd, char ** context)
> >         ssize_t ret;
> >
> >         size =3D INITCONTEXTLEN + 1;
> > -       buf =3D malloc(size);
> > +       buf =3D calloc(1, size);
> >         if (!buf)
> >                 return -1;
> > -       memset(buf, 0, size);
> >
> >         ret =3D fgetxattr_wrapper(fd, XATTR_NAME_SELINUX, buf, size - 1=
);
> >         if (ret < 0 && errno =3D=3D ERANGE) {
> > diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_con=
text_list.c
> > index 222b54c1..8d5ee6fb 100644
> > --- a/libselinux/src/get_context_list.c
> > +++ b/libselinux/src/get_context_list.c
> > @@ -481,12 +481,11 @@ int get_ordered_context_list(const char *user,
> >            the "failsafe" context to at least permit root login
> >            for emergency recovery if possible. */
> >         freeconary(reachable);
> > -       reachable =3D malloc(2 * sizeof(char *));
> > +       reachable =3D calloc(2, sizeof(char *));
> >         if (!reachable) {
> >                 rc =3D -1;
> >                 goto out;
> >         }
> > -       reachable[0] =3D reachable[1] =3D 0;
> >         rc =3D get_failsafe_context(user, &reachable[0]);
> >         if (rc < 0) {
> >                 freeconary(reachable);
> > diff --git a/libselinux/src/get_initial_context.c b/libselinux/src/get_=
initial_context.c
> > index 0f25ba3f..fb774c82 100644
> > --- a/libselinux/src/get_initial_context.c
> > +++ b/libselinux/src/get_initial_context.c
> > @@ -39,12 +39,11 @@ int security_get_initial_context_raw(const char * n=
ame, char ** con)
> >                 return -1;
> >
> >         size =3D selinux_page_size;
> > -       buf =3D malloc(size);
> > +       buf =3D calloc(1, size);
> >         if (!buf) {
> >                 ret =3D -1;
> >                 goto out;
> >         }
> > -       memset(buf, 0, size);
> >         ret =3D read(fd, buf, size - 1);
> >         if (ret < 0)
> >                 goto out2;
> > diff --git a/libselinux/src/getfilecon.c b/libselinux/src/getfilecon.c
> > index 4bee3137..31c9f0de 100644
> > --- a/libselinux/src/getfilecon.c
> > +++ b/libselinux/src/getfilecon.c
> > @@ -14,10 +14,9 @@ int getfilecon_raw(const char *path, char ** context=
)
> >         ssize_t ret;
> >
> >         size =3D INITCONTEXTLEN + 1;
> > -       buf =3D malloc(size);
> > +       buf =3D calloc(1, size);
> >         if (!buf)
> >                 return -1;
> > -       memset(buf, 0, size);
> >
> >         ret =3D getxattr(path, XATTR_NAME_SELINUX, buf, size - 1);
> >         if (ret < 0 && errno =3D=3D ERANGE) {
> > diff --git a/libselinux/src/getpeercon.c b/libselinux/src/getpeercon.c
> > index a9dca73e..c7abd886 100644
> > --- a/libselinux/src/getpeercon.c
> > +++ b/libselinux/src/getpeercon.c
> > @@ -18,10 +18,9 @@ int getpeercon_raw(int fd, char ** context)
> >         ssize_t ret;
> >
> >         size =3D INITCONTEXTLEN + 1;
> > -       buf =3D malloc(size);
> > +       buf =3D calloc(1, size);
> >         if (!buf)
> >                 return -1;
> > -       memset(buf, 0, size);
> >
> >         ret =3D getsockopt(fd, SOL_SOCKET, SO_PEERSEC, buf, &size);
> >         if (ret < 0 && errno =3D=3D ERANGE) {
> > diff --git a/libselinux/src/label_media.c b/libselinux/src/label_media.=
c
> > index 0510b5b1..be3df388 100644
> > --- a/libselinux/src/label_media.c
> > +++ b/libselinux/src/label_media.c
> > @@ -134,10 +134,9 @@ static int init(struct selabel_handle *rec, const =
struct selinux_opt *opts,
> >                                 status =3D 0;
> >                                 goto finish;
> >                         }
> > -                       data->spec_arr =3D malloc(sizeof(spec_t)*data->=
nspec);
> > +                       data->spec_arr =3D calloc(data->nspec, sizeof(s=
pec_t));
> >                         if (data->spec_arr =3D=3D NULL)
> >                                 goto finish;
> > -                       memset(data->spec_arr, 0, sizeof(spec_t)*data->=
nspec);
> >                         maxnspec =3D data->nspec;
> >
> >                         status =3D fseek(fp, 0L, SEEK_SET);
> > @@ -230,10 +229,9 @@ int selabel_media_init(struct selabel_handle *rec,
> >  {
> >         struct saved_data *data;
> >
> > -       data =3D (struct saved_data *)malloc(sizeof(*data));
> > +       data =3D (struct saved_data *)calloc(1, sizeof(*data));
> >         if (!data)
> >                 return -1;
> > -       memset(data, 0, sizeof(*data));
> >
> >         rec->data =3D data;
> >         rec->func_close =3D &close;
> > diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
> > index 1a5b9268..5b0e4063 100644
> > --- a/libselinux/src/label_x.c
> > +++ b/libselinux/src/label_x.c
> > @@ -161,10 +161,9 @@ static int init(struct selabel_handle *rec, const =
struct selinux_opt *opts,
> >                                 status =3D 0;
> >                                 goto finish;
> >                         }
> > -                       data->spec_arr =3D malloc(sizeof(spec_t)*data->=
nspec);
> > +                       data->spec_arr =3D calloc(data->nspec, sizeof(s=
pec_t));
> >                         if (data->spec_arr =3D=3D NULL)
> >                                 goto finish;
> > -                       memset(data->spec_arr, 0, sizeof(spec_t)*data->=
nspec);
> >                         maxnspec =3D data->nspec;
> >
> >                         status =3D fseek(fp, 0L, SEEK_SET);
> > @@ -255,10 +254,9 @@ int selabel_x_init(struct selabel_handle *rec, con=
st struct selinux_opt *opts,
> >  {
> >         struct saved_data *data;
> >
> > -       data =3D (struct saved_data *)malloc(sizeof(*data));
> > +       data =3D (struct saved_data *)calloc(1, sizeof(*data));
> >         if (!data)
> >                 return -1;
> > -       memset(data, 0, sizeof(*data));
> >
> >         rec->data =3D data;
> >         rec->func_close =3D &close;
> > diff --git a/libselinux/src/lgetfilecon.c b/libselinux/src/lgetfilecon.=
c
> > index d1fb821b..f0a3aa1a 100644
> > --- a/libselinux/src/lgetfilecon.c
> > +++ b/libselinux/src/lgetfilecon.c
> > @@ -14,10 +14,9 @@ int lgetfilecon_raw(const char *path, char ** contex=
t)
> >         ssize_t ret;
> >
> >         size =3D INITCONTEXTLEN + 1;
> > -       buf =3D malloc(size);
> > +       buf =3D calloc(1, size);
> >         if (!buf)
> >                 return -1;
> > -       memset(buf, 0, size);
> >
> >         ret =3D lgetxattr(path, XATTR_NAME_SELINUX, buf, size - 1);
> >         if (ret < 0 && errno =3D=3D ERANGE) {
> > diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathco=
n.c
> > index 967520e4..dbc11ee1 100644
> > --- a/libselinux/src/matchpathcon.c
> > +++ b/libselinux/src/matchpathcon.c
> > @@ -202,10 +202,9 @@ int matchpathcon_filespec_add(ino_t ino, int speci=
nd, const char *file)
> >         struct stat sb;
> >
> >         if (!fl_head) {
> > -               fl_head =3D malloc(sizeof(file_spec_t) * HASH_BUCKETS);
> > +               fl_head =3D calloc(HASH_BUCKETS, sizeof(file_spec_t));
> >                 if (!fl_head)
> >                         goto oom;
> > -               memset(fl_head, 0, sizeof(file_spec_t) * HASH_BUCKETS);
> >         }
> >
> >         h =3D (ino + (ino >> HASH_BITS)) & HASH_MASK;
> > diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
> > index b7a93a2b..ddcc7f8d 100644
> > --- a/libselinux/src/procattr.c
> > +++ b/libselinux/src/procattr.c
> > @@ -139,12 +139,11 @@ static int getprocattrcon_raw(char **context, pid=
_t pid, const char *attr,
> >                 return -1;
> >
> >         size =3D selinux_page_size;
> > -       buf =3D malloc(size);
> > +       buf =3D calloc(1, size);
> >         if (!buf) {
> >                 ret =3D -1;
> >                 goto out;
> >         }
> > -       memset(buf, 0, size);
> >
> >         do {
> >                 ret =3D read(fd, buf, size - 1);
> > diff --git a/libselinux/src/setrans_client.c b/libselinux/src/setrans_c=
lient.c
> > index d7dbc0ca..45cbe5c1 100644
> > --- a/libselinux/src/setrans_client.c
> > +++ b/libselinux/src/setrans_client.c
> > @@ -173,11 +173,10 @@ receive_response(int fd, uint32_t function, char =
**outdata, int32_t * ret_val)
> >                 return -1;
> >         }
> >
> > -       data =3D malloc(data_size);
> > +       /* coveriety doesn't realize that data will be initialized in r=
eadv */
> > +       data =3D calloc(1, data_size);
> >         if (!data)
> >                 return -1;
> > -       /* coveriety doesn't realize that data will be initialized in r=
eadv */
> > -       memset(data, 0, data_size);
> >
> >         resp_data.iov_base =3D data;
> >         resp_data.iov_len =3D data_size;
> > --
> > 2.45.2
> >
> >
