Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEF5131736
	for <selinux@vger.kernel.org>; Thu, 25 Jan 2024 19:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706212677; cv=none; b=uQPPDn06l1Ccl+3nS1Hg6t18PZLzHWnd8WqlWSeH3AMgASRGHIb63ayF6qJ0nTagb8tkHZoQZS37EvMoiFteKKAZhMq6FLouEJkBDoP9W9Da8iKcEbWsI6q/SX5vxyafqicrN1D12l/yDmOG7wMSL1bj6F0hl1PahAv3YhHzkn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706212677; c=relaxed/simple;
	bh=xJkCJUf0KyRYkfT/04lH+/86EJdWLBY4pQ9uWvbw+bs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GtQx0K1Bv3kl9IO0qOZ7+HEEf1CcOSanjx/wq7t8Djtkq0Wt/gADOE1kC8p1cbBLH78XFLoLK7MwD4PyqXr74wd5Q+k19q3CBD86CTIJyZ83/5DQTonSeAydHkI+4jymvLFIEBz9BI2Pk6nb3FgiNXpZYvf+3ue6I21AaR8kKXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDoml5vO; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDoml5vO"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5100cb238bcso4832060e87.3
        for <selinux@vger.kernel.org>; Thu, 25 Jan 2024 11:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706212674; x=1706817474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfu8a8DzE0lArxss2evvPzhmOLmBqb+oBoOXDJiGljM=;
        b=hDoml5vO0ZXVsjFQsQMubGl9/jS1CghhwsGRL9vwVqqJgi4UJu2c0EQ1tGhx2MueJ/
         NU5/yafs74g9LihJakZU7OwGigt6gOC12BcUkLxZZGlOYsOjonvJmGSao83+Y+UO3Qwn
         +gkCFbVbCcCCTiD6dt1StzD1KgSJbNW93eYtQPmizuzeyf29lMiPgJBwRe75DjeBgzoR
         3VES97OH/JJ0pWbA5EVz+eFBpjuOdVAALW5JsD3oDKRQzR21FCMB8AkN0g04Xyzrp5wV
         x01+MfeOqYY2eGjWd55ee59mcofa118Pm53NTYJlxyZtDGc/hU/xx7WqQfG5TFE2JBXO
         E4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706212674; x=1706817474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rfu8a8DzE0lArxss2evvPzhmOLmBqb+oBoOXDJiGljM=;
        b=dNHijaObxBLuUSZYIZaoFUdg7aOD+h25ajJqchr+v8Z5r9SAE6Efv5f7SLhGsOiQd+
         eMDzRvxRL3f4FKl3c5DGIRHWthhnpZ4sFyUPdLwIL+novjRvU9PiyYy6nQshkXcdtz3R
         W4ybs0FtUsIZMfVeYCvoEFvPhej27zeFE3qXaNpRiPQekQp79rPyq26k04b7tA4LSGI9
         u7PK+p9gSPB2Jnd2AFyaJ1P5Krg/l5weUTJqzEOBZHMyVW7Otg+HDBIaVaAz0KRTBK0Y
         jyWuyzYNCX1Fmi/Ejv/Z3LAgXM4CsvaeTlyyvxxDDfYVKeih0+M88jyBh8JwiPFhvNdc
         olgw==
X-Gm-Message-State: AOJu0YywwR7u3k5cxhxb0r8EetI7rqJjC1w/sb7JAYFDbqVz+nHA2v+h
	05339gDWvesV68VoAE3nGeJccA1+GFv9XGab6iTV3ZGMmT8oimAx+G7cbpQENrPCvKIMWUsdZaT
	wW3m4cMPmm5KfVv8+FlXEAAHFi8s=
X-Google-Smtp-Source: AGHT+IE5+BMjMjIMzXDHU8mvKWzI8cZnEEKAGqidSLkzgCy3snRV8cT6p6f0DzC3vfz3igFprOJotU9gIHlyxDRIa14=
X-Received: by 2002:a05:6512:3e9:b0:510:1487:bcb with SMTP id
 n9-20020a05651203e900b0051014870bcbmr188961lfq.64.1706212674295; Thu, 25 Jan
 2024 11:57:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115133607.10783-1-cgzones@googlemail.com> <CAP+JOzR2ExEPR7U=PkKCzNVQ+w70oZYxD+21nz4u7p0AhH7hcw@mail.gmail.com>
In-Reply-To: <CAP+JOzR2ExEPR7U=PkKCzNVQ+w70oZYxD+21nz4u7p0AhH7hcw@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 25 Jan 2024 14:57:42 -0500
Message-ID: <CAP+JOzQaaQF7WcK-AkHKfb_1AfBKr3-Otxnybfp2HqvfAiOWmA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: use reentrant strtok_r(3)
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 12:35=E2=80=AFPM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Mon, Jan 15, 2024 at 8:45=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Use the reentrant version strtok_r(3) instead of strtok(3) to avoid
> > potential data races with concurrent threads.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libselinux/src/selinux_restorecon.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selin=
ux_restorecon.c
> > index 38f10f1c..acb729c8 100644
> > --- a/libselinux/src/selinux_restorecon.c
> > +++ b/libselinux/src/selinux_restorecon.c
> > @@ -243,7 +243,7 @@ static uint64_t exclude_non_seclabel_mounts(void)
> >         int index =3D 0, found =3D 0;
> >         uint64_t nfile =3D 0;
> >         char *mount_info[4];
> > -       char *buf =3D NULL, *item;
> > +       char *buf =3D NULL, *item, *saveptr;
> >
> >         /* Check to see if the kernel supports seclabel */
> >         if (uname(&uts) =3D=3D 0 && strverscmp(uts.release, "2.6.30") <=
 0)
> > @@ -258,13 +258,14 @@ static uint64_t exclude_non_seclabel_mounts(void)
> >         while (getline(&buf, &len, fp) !=3D -1) {
> >                 found =3D 0;
> >                 index =3D 0;
> > -               item =3D strtok(buf, " ");
> > +               saveptr =3D NULL;
> > +               item =3D strtok_r(buf, " ", &saveptr);
> >                 while (item !=3D NULL) {
> >                         mount_info[index] =3D item;
> >                         index++;
> >                         if (index =3D=3D 4)
> >                                 break;
> > -                       item =3D strtok(NULL, " ");
> > +                       item =3D strtok_r(NULL, " ", &saveptr);
> >                 }
> >                 if (index < 4) {
> >                         selinux_log(SELINUX_ERROR,
> > @@ -276,14 +277,15 @@ static uint64_t exclude_non_seclabel_mounts(void)
> >                 /* Remove pre-existing entry */
> >                 remove_exclude(mount_info[1]);
> >
> > -               item =3D strtok(mount_info[3], ",");
> > +               saveptr =3D NULL;
> > +               item =3D strtok_r(mount_info[3], ",", &saveptr);
> >                 while (item !=3D NULL) {
> >                         if (strcmp(item, "seclabel") =3D=3D 0) {
> >                                 found =3D 1;
> >                                 nfile +=3D file_system_count(mount_info=
[1]);
> >                                 break;
> >                         }
> > -                       item =3D strtok(NULL, ",");
> > +                       item =3D strtok_r(NULL, ",", &saveptr);
> >                 }
> >
> >                 /* Exclude mount points without the seclabel option */
> > --
> > 2.43.0
> >
> >
