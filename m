Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728CB152780
	for <selinux@vger.kernel.org>; Tue, 30 Apr 2024 14:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714487711; cv=none; b=MJw3t+Pe02TSscvXJnDWX4nLd7nCBgQF+NonAtVOf2vPAD4PuSgapj3JP60IUiKDAMtceuPDKJtSxxM6bLLhH1LfccvGY+SiIPTE8dttGBF9uXROprTcCa791r0lYjNZOUAAkrm6ew/KV9ZFyfVIFwCl7J22nyR9VDD52bky7Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714487711; c=relaxed/simple;
	bh=YL6koUX0BdlS1hncc5D1mQT/A6cPkKriaeDk3Rr0i7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eqqy0tiheeHg79mDsE3/BzL7nt7wJU5kUSH5qsfKk07iwgXDHMB9DaMNg4l4fhj/cRZY7dlqNs8rxQN0soV1v4zTiODbn7BVlLl1IyHEH7xPtyLfJEEQ0DVCEsB4yxA2aIM5KPBB1Y73dLTEhWzfvZGnY0qZHe/MP47i/L8ZOlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=P+2TpgMm; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="P+2TpgMm"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dcc71031680so5673410276.2
        for <selinux@vger.kernel.org>; Tue, 30 Apr 2024 07:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1714487708; x=1715092508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kd/v48658EeV5QYtcovKLT+8sAJ3pHzW3fp3ptN4Y8c=;
        b=P+2TpgMmCPzrMcZlyPhrNGGiSClfN5Dys7T2JuJ177roZhr0a5BCE7R9QTrg9/OR91
         +op8eVUC/JXlp9joHmV8XoVy1FS1k2wsof6YlgR0+kqjS2XonTGMUdPY6W7JdjVqICkb
         pvB+fiHxTq29x5YhJNE4NJGlxe2ruc9WdR3CoghYjXNffTGqGOJwvzxU0qaYIFAHZ+GX
         ddpO+/k7AEGlJzhoAV2iqvPa6rE8SFxoxSSUx2rI+gJA8fKkNJEvzD8JVo9EfNogpqla
         cPfU1WSSr0iHfwNWcoHlBQtdxUz12/YtCfV9OBsoZVkeCBtATHgDRi556jgZKJuiZMRs
         cQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714487708; x=1715092508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kd/v48658EeV5QYtcovKLT+8sAJ3pHzW3fp3ptN4Y8c=;
        b=UGRPzyIOFksqBhNSgWfWxW/YpBi4dHrli7WhUjKODxoITm4H7gVXhs+fa4LYfCASQx
         ICb7nS9t96Cuh3vMNBit9L14vKZQiycgsvkIo7aHExkUIZhhI/j78ilBBQ0yAp1Y6RN6
         CSKz9wkV6qD69jH0NXJPQ+QDlk94uQK9JjmE0M9eVy6J3slQDhbARZ0KL3h7r0s7dyYj
         0VFqu6vS8a9xtAcDnFSQfDu/xdUJEqYYerr4bjIbLJU/3WZ6A+iIZT9SzvTSfLBaL9GV
         zDyreF/TJ8q1e19/951N379SRoAEi/4x70kt4pcHKllSlCfubS9qVS8f6tCH94eSeZ6w
         vqTQ==
X-Gm-Message-State: AOJu0Ywl2LfIWg9rZGqjbADOZPRIt8l+BCDMXfp4YsOS4Zq93zH1e9LQ
	aplHM8ab17OciKW1TNGMDor2rN2A10fluyVJf1h9Dim/5OO4vlIiv9+U7WwI2okmXpbyrYIsHp6
	W5QFdomuKLHhW3Dbx8Ge28gL/ftc=
X-Google-Smtp-Source: AGHT+IHbPCnDHHKtw4tGbtVVvEESEb3dNBXt+nnjuA97xWo1JqG9tMIm4OqvADSdWstfvEfkDNzlZi6fcqg6ekiMlms=
X-Received: by 2002:a25:ac02:0:b0:de6:d19:837a with SMTP id
 w2-20020a25ac02000000b00de60d19837amr3520039ybi.34.1714487708045; Tue, 30 Apr
 2024 07:35:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429163901.65239-1-cgoettsche@seltendoof.de> <CAFftDdqRZcQm4kW8+pAOYQDQ46Ze9Q0zzpqsKYi9KNz-1wduTw@mail.gmail.com>
In-Reply-To: <CAFftDdqRZcQm4kW8+pAOYQDQ46Ze9Q0zzpqsKYi9KNz-1wduTw@mail.gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Tue, 30 Apr 2024 16:34:57 +0200
Message-ID: <CAJ2a_Dcy-WHrV5FY3FHLTFBuJErKhwfyFc2R4CjZsO2PHYJ77Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] libselinux: free empty scandir(3) result
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Apr 2024 at 22:35, William Roberts <bill.c.roberts@gmail.com> wr=
ote:
>
> On Mon, Apr 29, 2024 at 11:39=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > In case scandir(3) finds no entries still free the returned result to
> > avoid leaking it.
> >
> > Also do not override errno in case of a failure.
> >
> > Reported.by: Cppcheck
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  libselinux/src/booleans.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
> > index c557df65..1ede8e2d 100644
> > --- a/libselinux/src/booleans.c
> > +++ b/libselinux/src/booleans.c
> > @@ -53,7 +53,11 @@ int security_get_boolean_names(char ***names, int *l=
en)
> >
> >         snprintf(path, sizeof path, "%s%s", selinux_mnt, SELINUX_BOOL_D=
IR);
> >         *len =3D scandir(path, &namelist, &filename_select, alphasort);
> > -       if (*len <=3D 0) {
> > +       if (*len < 0) {
> > +               return -1;
> > +       }
> > +       if (*len =3D=3D 0) {
>
> Changing this will allow scandir to fail and it continue, what's the poin=
t?

What do you mean by "continue"?
The function will still return -1 with errno set if scandir(3) returns
<=3D 0, like it does currently.
But currently if scandir() returns 0, we currently leak the pointer to
the empty array.

>
> > +               free(namelist);
> >                 errno =3D ENOENT;
> >                 return -1;
> >         }
> > --
> > 2.43.0
> >
> >
