Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF71619C552
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 13:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731333467; cv=none; b=uA3+/yaQW6V0//InNZdEweGt4fGlTUAcr3yUoblRCpRqbs+TduBWDvMrq9X8Whfun6ddLO/7Enukw49OWJdddCtjpCKFu7Rb7oacTHX17HM/HQutl+E2GMza3odT9/+gK4dXODlsOvdPlg3kAf3HtrK+9eKwiRTSB/8AvK2Ohg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731333467; c=relaxed/simple;
	bh=atAY5QT7nEc4c9OcLWIFcLCpW68hCJV0F88Anq/DykU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SVWYik98Pdv39u9FGoP4uCDEadmMzni4AgoYLn5UopD+mwZarClcoaSCDxp32VI76PpJRmAJrpO4J+Xb7/nBxQcCW85/R1QZPR1CK2ZpIi4NIV+CRsNJ7mA3rvHW96NTqYnRlfcEctcy9a9PZPDQAHK6zIu/fB6DeWv25cHKJUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=dt+B0huj; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dt+B0huj"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6e5b7cd1ef5so37954497b3.1
        for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 05:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1731333465; x=1731938265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJZMXc4A545eSsIiGQkBeSgal5DlvYN15avXbBNcRe4=;
        b=dt+B0hujn1jnuv4A7dab3E2NhsXDiOnqpXUK2bV4fIkUE+ZUD+hjFs0P2q3oXeptN5
         CdRSf8H0+qPIMszblp9JPYtlebkzoNywlVEKrxKqIknIxEhRVXEtg+wN9FKNKhOq8UGe
         AYGgd/ER5GfxUzjo8WahMXfX0tvf+tQ04CqWPe1e32HSlO9Jp+ShOM+FFKxf0ODzk3VX
         oIXoSugf2aRG/IltqueUYseLBLELdg+Gj0Oc37Om0vzLK33Fe2iNsYpJjMBj7k8FyKKQ
         qHXJ0Hf4RUsOWge7c9/iRYTOW7Gdm6HMPpOjrNwRjvUndYGEvBEDyj47h0M5Z7Rz7ux0
         of3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731333465; x=1731938265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJZMXc4A545eSsIiGQkBeSgal5DlvYN15avXbBNcRe4=;
        b=dyWnQv34p3Z602jsp6/+kBFkFfiaJ7pbDvEsum0P91HPMOTiS9QRjJi+DA+dEHWSVX
         iAtOM71ukWnVbonZrU65YZp269Pfsln34HmrfrXiKnTqlxqPCd96I7nq2CfMiVT/8rYa
         XDXKm98krhC/6rt0GkxmK+UmnRRBjw7oC2pGkykwXruvu3lJBmSNLPhvkKOQnfsmN2gQ
         LnyDJ170QqKy9IfHMyHov8fo5dVX6Ytfz0xCHUV3ffEbfrplETWwN3EbJrVRAE8R2Yuj
         g7soE8R1jsCF6BcGxY0aXzJ7vNFL4J9ZnF8h9IQAcE3wbGG/m8/6sNAMdaTwq4sBuS9/
         UdFA==
X-Gm-Message-State: AOJu0YxA1/MPl6bOihUKI6EY8AewUMxmxYgOiyAmML81mFuVXVQA+JVu
	QX01HZazCPZ7LjPKikVEIJ+5stSNoQnRuXZb+X1XMTnPoxsmnTmZPdcZlx/4xU+uviBJMHDHqXN
	htkUGM5pYA7PqaEXqtSJtneD7YGo=
X-Google-Smtp-Source: AGHT+IHLYRvXP8BJ91BWOWNyySM5dgoiEIn2zJsgkScH7r+8+mkWxewUEUD/85tA7Nvqzs3oQIfSzurPr7ZQgS7zeMw=
X-Received: by 2002:a05:690c:6206:b0:6dd:cdb9:cf2a with SMTP id
 00721157ae682-6eaddd86c7emr107361967b3.1.1731333464729; Mon, 11 Nov 2024
 05:57:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105183936.252530-1-cgoettsche@seltendoof.de>
 <20241105183936.252530-2-cgoettsche@seltendoof.de> <CAP+JOzQemwf6hor+=fRm7p9LLBy9znGob=6rSYVhs3tWbqgPoQ@mail.gmail.com>
In-Reply-To: <CAP+JOzQemwf6hor+=fRm7p9LLBy9znGob=6rSYVhs3tWbqgPoQ@mail.gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Mon, 11 Nov 2024 14:57:34 +0100
Message-ID: <CAJ2a_DdjOwceWnnQju3xGpgg38RqxACYkA5oBCQzvAvSxk9gcA@mail.gmail.com>
Subject: Re: [PATCH 2/2] libselinux: avoid dynamic allocation in openattr()
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Nov 2024 at 22:42, James Carter <jwcart2@gmail.com> wrote:
>
> On Tue, Nov 5, 2024 at 1:46=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > openattr() supplies the simplementation for the getcon(3) interface
>
> implementation

Tkanks, I'll fix in v2.

> > family.  Use a short local buffer instead of descend into memory
>
> "Use a short local buffer instead of dynamic memory allocation"?

Dito

> > allocation.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  libselinux/src/procattr.c | 24 ++++++++++++------------
> >  1 file changed, 12 insertions(+), 12 deletions(-)
> >
> > diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
> > index ddcc7f8d..ee1f48af 100644
> > --- a/libselinux/src/procattr.c
> > +++ b/libselinux/src/procattr.c
> > @@ -86,32 +86,32 @@ static void init_procattr(void)
> >  static int openattr(pid_t pid, const char *attr, int flags)
> >  {
> >         int fd, rc;
> > -       char *path;
> > +       char path[56];  /* must hold "/proc/self/task/%d/attr/sockcreat=
e" */
>
> Why 56? I understand that sockcreate is the largest attr, but it looks
> to me like you are giving way more space than is needed for the pid. I
> am just curious. Maybe I am missing something.

My calculation was:
  32 character for the length of "/proc/self/task//attr/sockcreate"
  +1 for NUL terminator
  +20 for the unlikely case of pid_t being ULONG_MAX or LONG_MIN
  round to next multiple of 8

> Thanks,
> Jim
>
>
> >         pid_t tid;
> >
> >         if (pid > 0) {
> > -               rc =3D asprintf(&path, "/proc/%d/attr/%s", pid, attr);
> > +               rc =3D snprintf(path, sizeof(path), "/proc/%d/attr/%s",=
 pid, attr);
> >         } else if (pid =3D=3D 0) {
> > -               rc =3D asprintf(&path, "/proc/thread-self/attr/%s", att=
r);
> > -               if (rc < 0)
> > +               rc =3D snprintf(path, sizeof(path), "/proc/thread-self/=
attr/%s", attr);
> > +               if (rc < 0 || (size_t)rc >=3D sizeof(path)) {
> > +                       errno =3D EOVERFLOW;
> >                         return -1;
> > +               }
> >                 fd =3D open(path, flags | O_CLOEXEC);
> >                 if (fd >=3D 0 || errno !=3D ENOENT)
> > -                       goto out;
> > -               free(path);
> > +                       return fd;
> >                 tid =3D selinux_gettid();
> > -               rc =3D asprintf(&path, "/proc/self/task/%d/attr/%s", ti=
d, attr);
> > +               rc =3D snprintf(path, sizeof(path), "/proc/self/task/%d=
/attr/%s", tid, attr);
> >         } else {
> >                 errno =3D EINVAL;
> >                 return -1;
> >         }
> > -       if (rc < 0)
> > +       if (rc < 0 || (size_t)rc >=3D sizeof(path)) {
> > +               errno =3D EOVERFLOW;
> >                 return -1;
> > +       }
> >
> > -       fd =3D open(path, flags | O_CLOEXEC);
> > -out:
> > -       free(path);
> > -       return fd;
> > +       return open(path, flags | O_CLOEXEC);
> >  }
> >
> >  static int getprocattrcon_raw(char **context, pid_t pid, const char *a=
ttr,
> > --
> > 2.45.2
> >
> >
