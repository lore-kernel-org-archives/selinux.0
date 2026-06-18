Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4EE23D297
	for <selinux@vger.kernel.org>; Thu, 18 Jun 2026 16:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781801143; cv=pass; b=IhjFkd+Bq9VxjLeUQBLVLlbmnN2gRDOPZegC8DgQOjpHl16ZCUrUprK2W36jJBH2xCw7w7K8I8yDKETuv6xxDXgh5475OvxkSR/VQrPV5IPaI8AP/RCN45wB19RvNLDpG8WEDvqfFXlIN+JIY0GUuqqCixK5+CwhhattUpZs8Q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781801143; c=relaxed/simple;
	bh=e2rx1h5/PLi4bJSzoOjGrAv345SDuF7Q/b8zMyOG2dQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TOI2l0S1CKAHKd+gc6qrmaZFqPUNqJ6wWDG58dq45+1VBREcBu1oBbBzgaNDkqHmeBBliLW+mV+DEP6WYPTGh5R7GnK8N77w+S1ORbBxsXkOwf8UBJvsvXXExwCeY8plvZV9EB1i4z3TCe6mQJEkzW0SNgU46UwlfGGpyNZwlEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qv47bGwN; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qv47bGwN"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3967738c801so12982851fa.2
        for <selinux@vger.kernel.org>; Thu, 18 Jun 2026 09:45:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781801137; cv=none;
        d=google.com; s=arc-20240605;
        b=OXdcVuWmxjf1KKChOHwkdpJlL+CN1kbSGuGE1Px+kdvtyepyRXInnjpH+nIsyozxI8
         EZCTrY3MQjhRXL0vMmvuNBDDcj5j4kgdz6sE1+dMq7ELCUCmfk8GzfLDeJpmb6vcZqcK
         a9FWEZIDa7LhO/ZAcEg4pqiX/qbykHFYDyVBHL05ijmQNbuzxlbHAQ/PiRrU2foFcDbc
         AEtB/fNf7gHaWBcj2PfsPOuXmc2Q/8fKZSj8oex9f8aUbG3MBgzfn/6arrncqn80JcaB
         2vNk5EnOElcvQO5C2DJDqeK7qBOnXga12sPB09mbHjTM9/rUIWpPVIsH36Kt/wyyVF5C
         5agg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OtJN5PnocdcUC6n60UIKPvDmvexVoiki0W8Hc3/GV0E=;
        fh=nOcPTm+jzSpUJDDJhvsoEQt/GcMQFmPB1BDsWNtwPZ8=;
        b=MsgJ5KCbHZ38lG2a3Wc7N/cYWDi2iBifqNpMCJTjY6idv4UoGmkg3EAS4OOvAw4prH
         tziTxC00BRFzEw7vZunmJnc+/Eo23aiK4FIh5qnjIosi8kI5UnZnUIXKvpxRy6itjE2T
         a96G9gIqZ5b2FRZYCQ30SCMcc9Z0U/L+rVxxxmvN1Gpi/e//C6PQQ3rHOZwJMqZQTJ0Q
         iu8Lfg1pvtHgbbbNcEjK0CFfBnxAleIF8xQLGaNMXv/VQbxMCmv9ui6jt7czpduJGiu2
         FaZoA1jrOm1vv/HX+7em/TBLCJgU8+4ilxmQZyftqovJTYa6GqE9wAiTqb+oyGbhFVAd
         Hijg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781801137; x=1782405937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtJN5PnocdcUC6n60UIKPvDmvexVoiki0W8Hc3/GV0E=;
        b=qv47bGwND5i49QyjMR0BBSDeJhJvBES/MYtOYgtBW9ytk26DYpP+Kxxhu/gq+IyMAy
         idRvegmjklXuwNcKZOdXOjnxczuZND5r+2gr9DoRHCNsrT5Qgrg2R6v0i84Cyxhoc3CA
         4vHmeNe9gKeF3Qisvry5y22r7TJ98g67g8zy3QKmpi/IK4O/GU/VNPQevKRVpx2f+O4L
         Fwm/WMcY0P16Xo6KWtO+mkuAC/T7S8UUeDHcNMwGtrWrhORvURqN+DSEwj7YypkV0gPN
         SVl9TlqB+vOzotxIc44ktNZyYwIreTBzOGc2HX8711MOgGWFtaN71nxTq+PWTnCK9JVb
         oGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781801137; x=1782405937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OtJN5PnocdcUC6n60UIKPvDmvexVoiki0W8Hc3/GV0E=;
        b=MbSMewNQtEvHOifHb8d4cWgAaTGqaIAHo7AAr+wZsC0m2crNLZ8gBax7MINUhVvxtc
         YlosPD2F5tl0/zlnJ5MPJlrIyEjtAUKIS3Y9ODDGn0LYJ55mfNZ5BZCrQkgPIwyHOV5n
         Wpwi8qQvIUDZRfIFpnCeKiBLYY5KWbiJkOL0eo7JW7FtBKE5Xw7P1uZXDXj25GaHy4Mh
         mDH8wJhHwl9retFWpbdJWC5C+6v0L8i3yVkCQJ4qjHKQPC/faVokqT1FupvlEaKg8cEQ
         edsCmaKQON/XrlcEaNuVNCg9DoFhXUDw1SKd9Rw6krjTOTsClG9z/giaUCJCDYZlD6NI
         8VCg==
X-Gm-Message-State: AOJu0YweKxQ3drqdjKXf03mpRmU6bb2iHiiTVa9t/q+xK0770PStRbOG
	o8t6VZBx4Wbq7AqnfQ6W4VcFNOxFV5VE4Wcb8bEumbTndln7vDWc7zJ4MNBl9hkD6IKZMvrJhjE
	478M/aiQjOLQxP8DvYagbuGx0E7NqABc=
X-Gm-Gg: AfdE7cnRjmmY8T5ybllBcvV8bnLSZK6ErQnLGu4GbRlWaDqVW/Kfi4/mVlOET+O6TNQ
	fqLxfrdEmJF3ZHsbXE6LHhEz3+486ul3oXmiFQiTfXIrTNTdJpxXOkNcasTqCee6nl62XBYqpWt
	LbI5cvoiVGC98V3CX8EJtzipUUOBGcsREY+EGAq3EL9SVziJYQ0MvHj2ZY2d7h8WNFsY8nS1US8
	7TtmEu/LXZgKAJRhN2HI1KHNfVrWGrapK+BCcvsxCdPUUUWbiFNUKW9aCQ1K4IhT5D+1Q==
X-Received: by 2002:a2e:8051:0:b0:399:87c9:4571 with SMTP id
 38308e7fff4ca-3998a2ff4cfmr559461fa.16.1781801136760; Thu, 18 Jun 2026
 09:45:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617195645.96604-1-jwcart2@gmail.com> <20260617195645.96604-2-jwcart2@gmail.com>
 <CAEjxPJ5f7PLSN=ORTBVGeJZ242sUecddHXbue1_CHDXSznWf_g@mail.gmail.com>
In-Reply-To: <CAEjxPJ5f7PLSN=ORTBVGeJZ242sUecddHXbue1_CHDXSznWf_g@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 18 Jun 2026 12:45:25 -0400
X-Gm-Features: AVVi8Cej3iBbY-bib0S3RIoQ3BTWeW6ycNsqEia3jp3CetOm8q2ylkdfCBWlTaM
Message-ID: <CAP+JOzRt4kmggrCaFLLRP2Qy8Jjt90nNnuLDtGAsG1JRRL9vzg@mail.gmail.com>
Subject: Re: [PATCH 2/4 v2] libsemanage: Add checks when growing lists to
 prevent wrapping
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 4:08=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Jun 17, 2026 at 3:57=E2=80=AFPM James Carter <jwcart2@gmail.com> =
wrote:
> >
> > A common idiom to grow a list or buffer is to use "len *=3D 2", but
> > it is possible for the multiplication to wrap on overflow. This
> > would result in the new len being smaller than the old len and
> > could lead to problems.
> >
> > Add checks to prevent doing the multiplication if it would wrap.
> > The multiplication can always be done if len <=3D MAX / 2 and
> > should not be done if len > MAX / 2.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Could also use __builtin_mul_overflow() used elsewhere, but
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>

That is a good suggestion. I am going to use the
__builtin_mul_overflow family of functions.

Thanks,
Jim

> > ---
> >  libsemanage/src/direct_api.c    |  6 +++++-
> >  libsemanage/src/genhomedircon.c | 10 +++++-----
> >  2 files changed, 10 insertions(+), 6 deletions(-)
> >
> > diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.=
c
> > index 9572dbf0..54803515 100644
> > --- a/libsemanage/src/direct_api.c
> > +++ b/libsemanage/src/direct_api.c
> > @@ -588,7 +588,11 @@ static int read_from_pipe_to_data(semanage_handle_=
t *sh, size_t initial_len,
> >                 data_read_len +=3D read_len;
> >                 if (data_read_len =3D=3D max_len) {
> >                         char *tmp;
> > -
> > +                       if (max_len > SIZE_MAX / 2) {
> > +                               ERR(sh, "Too much data");
> > +                               free(data_read);
> > +                               return -1;
> > +                       }
> >                         max_len *=3D 2;
> >                         tmp =3D realloc(data_read, max_len);
> >                         if (tmp =3D=3D NULL) {
> > diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomed=
ircon.c
> > index ce7ea167..8dc2cb56 100644
> > --- a/libsemanage/src/genhomedircon.c
> > +++ b/libsemanage/src/genhomedircon.c
> > @@ -1090,7 +1090,7 @@ retry:
> >                 goto cleanup;
> >
> >         retval =3D getpwnam_r(name, &pwstorage, rbuf, rbuflen, &pwent);
> > -       if (retval =3D=3D ERANGE && rbuflen < LONG_MAX / 2) {
> > +       if (retval =3D=3D ERANGE && rbuflen <=3D LONG_MAX / 2) {
> >                 free(rbuf);
> >                 rbuflen *=3D 2;
> >                 goto retry;
> > @@ -1171,11 +1171,11 @@ static int get_group_users(genhomedircon_settin=
gs_t *s,
> >                                     &group)) !=3D 0 &&
> >                errno =3D=3D ERANGE) {
> >                 char *new_grbuf;
> > -               grbuflen *=3D 2;
> > -               if (grbuflen < 0)
> > -                       /* the member list could exceed 2Gb on a system=
 with a 32-bit CPU (where
> > -                        * sizeof(long) =3D 4) - if this ever happened,=
 the loop would become infinite. */
> > +               if (grbuflen > LONG_MAX / 2) {
> > +                       ERR(s->h_semanage, "Member list too long");
> >                         goto cleanup;
> > +               }
> > +               grbuflen *=3D 2;
> >                 new_grbuf =3D realloc(grbuf, grbuflen);
> >                 if (new_grbuf =3D=3D NULL)
> >                         goto cleanup;
> > --
> > 2.54.0
> >
> >
