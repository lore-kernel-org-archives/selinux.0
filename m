Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B49F208A5
	for <selinux@vger.kernel.org>; Mon, 18 Nov 2024 20:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731960993; cv=none; b=YBpSTS/b+9mH3rxYthZ5V7+NA0YiUNChJnKGrOWdBng7MvCVpSamF3jDv/+8VGSNmCy3CjIU+1CCsRXvltf9xb5IWjO9CswVVL295qYctwP3fJjuImryc5EY605dGq28iQlDUYbknEvNIWI7OsFJmedy7ayI+cHa14nDlK53IeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731960993; c=relaxed/simple;
	bh=kC1JSK3G5LTPEt5qz3yNJDeIAXoPeMeEzdV56pw9xeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LCM2xTZBC+Bcrp7rNS2N2iGLabchidimkLna7cTLcrpkVo6c6Dpom8be0jCL6pAQNzHYbGk8UTk3ElqP8wL8q97h6DbzFjXf/Ou4BhELnA+M69Hr/y6OWmEHRObEPIkQfXaPQ9iunQ4WdDFJUc5dU/DWwQJzCwnHH9N/ZGRVGf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpaGk7EM; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpaGk7EM"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b35b1ca0c2so446035585a.0
        for <selinux@vger.kernel.org>; Mon, 18 Nov 2024 12:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731960990; x=1732565790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npBZRTuDq/X8XddjGCBT/PSHdVIEfBa1toAvLw4QL2k=;
        b=mpaGk7EMuEmGnljVsFL242uKSdvqRrbgrokV6td9V3bBLveOMKnopG9OxzAW26SsMw
         x6PwGBp6+H/4gtjJ6Ogx8ChUhbjuo81pj5+OzUC6NHE1pSPA5AjHZdsTcHrOUj33/IbM
         VXGZwdLlHoLZiK+n4FZiCHJgMl23UBaH6V2qf5IfxsvZEr9yhwuDb0uF0JwMmQe0v7Ae
         I8JusScDTkq+nHR5m5Tu/qXLJVzD4LbctuVoWDjBu/HKXvmTW7ra2g4vAKmnk8wCmwyr
         CyV469AhRnjysOfnXTdSHSbQQX2d+DZfUmnrN8k6gtCp0hQmKBX0m+DH3R3Bztwm8yaY
         7dhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731960990; x=1732565790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npBZRTuDq/X8XddjGCBT/PSHdVIEfBa1toAvLw4QL2k=;
        b=k+kzkZ9LZBNVZMd1p4ex0OLH/KJqIW5gam1jDwbt12U+wvIoqwxLG3Bsd8iJR/h2gf
         ZyXLBl6nr8igUJIrUsy5jAD37vBDmzqaJZyqRIKmgBFLW5mL0KP7RQ7MWkQ+fyH7vsmW
         hLeo8K0lnYItzoCusL+CaBBa5kvgkeh79NVB7/ZadYm+z/hfstFtWlvkc0BH19j0nX+q
         HPXgDdMKusG59IvxqMcXQXd/JNjTMsjTg0mgpNblAXetZ8+z+GUO1OCFGodZeaFEE00K
         lYPdkB+dh9OFP+9N6F6kZDsMPKgfL3n/XCnRf37Hz7lcbr295YoBNzNQYsGmTzFYicxl
         oPVA==
X-Gm-Message-State: AOJu0YybCvDyQcOJZiHT1PaOAtBSq+o6rV7yGFWOn2eTQBTDcg+2gmKY
	qEA9lTe+R1lRzgyYU2/uMGiR7CIlYiO6WS73GK3W4AX3HYi4GrV4iE6ksPSuYgufDeESmUugSLh
	gaFPYN8ox2NxRVAg6Cx4yaxAYCLk=
X-Google-Smtp-Source: AGHT+IFoIUEHA5krpLxDbbyIEd+A6uJ6m5GmcMSut/BOhXVrumcO3ISHtpFkmWE8SU9auki+LIxSX/Pa5oZgY3hSpQ8=
X-Received: by 2002:a05:620a:248d:b0:7b1:4762:8a with SMTP id
 af79cd13be357-7b37aa04b66mr113888685a.3.1731960990532; Mon, 18 Nov 2024
 12:16:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111123304.651436-1-lautrbach@redhat.com> <CAP+JOzSv0o57nSWavdsvK3AYekh+Ct82HhgyLPiewEOmGg_5xw@mail.gmail.com>
In-Reply-To: <CAP+JOzSv0o57nSWavdsvK3AYekh+Ct82HhgyLPiewEOmGg_5xw@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 18 Nov 2024 15:16:19 -0500
Message-ID: <CAP+JOzTwk+xrJPMReCWjis6cnBjrV84Moo=6NXHyDGuE0BbYhQ@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: open lock_file with O_RDWR
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 9:16=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Nov 11, 2024 at 7:33=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.=
com> wrote:
> >
> > man 2 flock:
> >     Since Linux 2.6.12, NFS clients support flock() locks by emulating
> >     them as fcntl(2) byte-range locks on the entire file.  This means
> >     that fcntl(2) and  flock()  locks  do  interact with one another
> >     over NFS.  It also means that in order to place an exclusive lock,
> >     the file must be opened for writing.
> >
> > Fixes:
> >     # semanage fcontext -d -e /home /tmp/testdir
> >     libsemanage.semanage_get_lock: Error obtaining direct transaction l=
ock at /var/lib/selinux/targeted/semanage.trans.LOCK. (Bad file descriptor)=
.
> >     OSError: Bad file descriptor
> >
> > Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsemanage/src/semanage_store.c | 14 ++++++--------
> >  1 file changed, 6 insertions(+), 8 deletions(-)
> >
> > diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanag=
e_store.c
> > index 0ac2e5b2ad39..c26f5667b3cd 100644
> > --- a/libsemanage/src/semanage_store.c
> > +++ b/libsemanage/src/semanage_store.c
> > @@ -1899,14 +1899,12 @@ static int semanage_get_lock(semanage_handle_t =
* sh,
> >         struct timeval origtime, curtime;
> >         int got_lock =3D 0;
> >
> > -       if ((fd =3D open(lock_file, O_RDONLY)) =3D=3D -1) {
> > -               if ((fd =3D
> > -                    open(lock_file, O_RDWR | O_CREAT | O_TRUNC,
> > -                         S_IRUSR | S_IWUSR)) =3D=3D -1) {
> > -                       ERR(sh, "Could not open direct %s at %s.", lock=
_name,
> > -                           lock_file);
> > -                       return -1;
> > -               }
> > +       if ((fd =3D
> > +            open(lock_file, O_RDWR | O_CREAT | O_TRUNC,
> > +                 S_IRUSR | S_IWUSR)) =3D=3D -1) {
> > +               ERR(sh, "Could not open direct %s at %s.", lock_name,
> > +                   lock_file);
> > +               return -1;
> >         }
> >         if (fcntl(fd, F_SETFD, FD_CLOEXEC) < 0) {
> >                 ERR(sh, "Could not set close-on-exec for %s at %s.", lo=
ck_name,
> > --
> > 2.47.0
> >
> >
