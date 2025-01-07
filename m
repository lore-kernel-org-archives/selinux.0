Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EEA1F237E
	for <selinux@vger.kernel.org>; Tue,  7 Jan 2025 15:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736262476; cv=none; b=Epa7Fiwhpn8V9Lm2ufAF/eZkfgHou4fxFTASnd/SYW7Tgmz5HYUwYmQ9j7hzI2XXqiW2RipsbIW6ZYu/I/Rgm9/Ix4COj0b7D4nd8OF6ORrmqZK9H8fXag8Lup9h/WLSxJgvxwL5QwxIc0ceVxms8DmtM704D/+MDSqCN7gfsiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736262476; c=relaxed/simple;
	bh=yqwlEcOHutBULI60YWMVnCxRv3RJdq+xMngJhlSx/jQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fJfaknB3DKS2VYZ0lO07wocfDwNdF4lkzItcxYex0LvFH3Jv2gTIt62EWFduB8q0r08+PFtf8E1WgMXEu4jYQFlR4NBECPSdp3DwrIf0ZxENJAygimQnFoa3Y0QYZeksTJG1NtUEdHtwyHDtsvuPdhugQ5AbOvDLF2zoSJBD+0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=aH0cILfk; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="aH0cILfk"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e549be93d5eso6356759276.1
        for <selinux@vger.kernel.org>; Tue, 07 Jan 2025 07:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1736262472; x=1736867272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNEZ+oQ1CmOA8uLsAYsFpP7pUalKhyCRsuFAppTytpw=;
        b=aH0cILfkjcGJYsvb0c1QEd99sK6EQi9QdBppvpj9MknN6INwkIRr2REdVe9NscGpQx
         lliT85Dg2l2CtaAEO1Ig+w+vhupOZNZ1HRfOvEkeQr27F2vpK0cpYGBUVknhdKADC2C6
         yv3Cs0z4RnXmFPkdn+1syLZiFnIIOnQDVGfnFL9LFJEGBb8Ba4gGjbSUVAPnWkkcl+B2
         1E4d9A52m5kDCcvOmJGGaZU1qxfHmefke36DIchs+nM4weur4u3kzYnXrOrRxogPmudE
         gOZk3QkZ+VuAroMxwX8xNPUFHdF494vArETUP8tPA6kXo7nd66Jn94qasqpNViX8LU0W
         xR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736262472; x=1736867272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cNEZ+oQ1CmOA8uLsAYsFpP7pUalKhyCRsuFAppTytpw=;
        b=w9qsU9ZNkrQjQGQAQ3mn/FmOnVEL0zXarCiAa7bJbxvwbiHFZyNDfwhKFXE7nrgPXJ
         B8REZujy9UYISVbTYzahbg4zC9InuwTgLPqrPoKJmnl5Zvy6kelq0yQOaKOnI7QMNE2l
         TcSEux92gmDrVykaavga961dUD1SxUJlEP/VjxoJ6/0eChHoUQ6khnsg2hsoWH6Kxj8L
         r+UZxitfruZRkZ9DAjndEfASVHGqssThUN+jKdFCWVqLA0JRW9116yE65ObPspuG4/ME
         7KjuOV8XXT89A0Nv1RVOv8YDP7akf2OOjLD/EMbg3hleRu25prNPSyKEwUT11Yd6mnA3
         M4DA==
X-Gm-Message-State: AOJu0YylSVXxWOG5caGiUnCAeWLsiV1HONYhsfoS/BWFgAmf2LbGaniM
	H4N9Cs631dJ/R950p0qvBSLe8ytCYyTcOywufoqyP3b3zIp0/0UpMNweSlyYEIr5m77umxScDgK
	MXoTBuJmDxhaClIAeTPGhft4OOZoQ7p0a4xQ=
X-Gm-Gg: ASbGnctbWvmWl0nHVeNgwg5f1Rj7155tcSzLZSJs7/ifRGqL8Fkzli/SUqItleD2QER
	MhgPDG8YRnS3vhw1L3WvJIDhas2KJwa9IWWMl
X-Google-Smtp-Source: AGHT+IFJ2UfbyffwPA+kKXLURAsZe1mwWq6+XWGVU1iZKDojRhYUmL25YYign6n8xRXadaqDsb5+p/esaruumIhpQB0=
X-Received: by 2002:a05:690c:7406:b0:6f2:955a:d25 with SMTP id
 00721157ae682-6f3f81103dbmr435787267b3.10.1736262471862; Tue, 07 Jan 2025
 07:07:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241230135114.41947-1-cgoettsche@seltendoof.de> <CAP+JOzQBAMW3zi18Txb+RWavJKZkGxGFGDguC+SxBvcnXaR4bQ@mail.gmail.com>
In-Reply-To: <CAP+JOzQBAMW3zi18Txb+RWavJKZkGxGFGDguC+SxBvcnXaR4bQ@mail.gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Tue, 7 Jan 2025 16:07:41 +0100
Message-ID: <CAJ2a_DdNg3+z_qrabieKq+s6eJ-SSLhFTwQCZ8fwvpJoXTqgng@mail.gmail.com>
Subject: Re: [PATCH] libselinux: update max node depth
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 7 Jan 2025 at 15:46, James Carter <jwcart2@gmail.com> wrote:
>
> On Mon, Dec 30, 2024 at 8:51=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Bump the maximum specification node depth from 3 to 4 based on updated
> > benchmark on Fedora 41:
> >
>
> I am not sure I understand these numbers.
>
> >     Benchmark 1: /tmp/destdir3/sbin/restorecon -vRn /
> >       Time (mean =C2=B1 =CF=83):      1.397 s =C2=B1  0.018 s    [User:=
 0.755 s, System: 0.641 s]
> >       Range (min =E2=80=A6 max):    1.353 s =E2=80=A6  1.419 s    20 ru=
ns
> >
> Is this for depth 3?

Yes, I should have made this more clear.

> >     Benchmark 1: /tmp/destdir4/sbin/restorecon -vRn /
> >       Time (mean =C2=B1 =CF=83):      1.376 s =C2=B1  0.021 s    [User:=
 0.737 s, System: 0.637 s]
> >       Range (min =E2=80=A6 max):    1.348 s =E2=80=A6  1.414 s    20 ru=
ns
> >
> Depth 4?
>
> >     Benchmark 1: /tmp/destdir5/sbin/restorecon -vRn /
> >       Time (mean =C2=B1 =CF=83):      1.389 s =C2=B1  0.021 s    [User:=
 0.748 s, System: 0.640 s]
> >       Range (min =E2=80=A6 max):    1.351 s =E2=80=A6  1.420 s    20 ru=
ns
> Depth 5?
>
> I see the comment below talks about more memory, how much more memory
> is required for a depth of 4?

The maximum memory usage for `selabel_lookup -b file -k /usr/bin/bash`
for all three depths is in the range 3800-4000kB, with depth 5
occasionally being at 4060kB.

>
> Thanks,
> Jim
>
> > ---
> >  libselinux/src/label_file.h | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> > index 597b756e..41b2a939 100644
> > --- a/libselinux/src/label_file.h
> > +++ b/libselinux/src/label_file.h
> > @@ -105,10 +105,10 @@ struct literal_spec {
> >   * Max depth of specification nodes
> >   *
> >   * Measure before changing:
> > - *   - 2  leads to slower lookup
> > - *   - >4 require more memory (and allocations) for no performance gai=
n
> > + *   <  leads to slower lookup
> > + *   >  require more memory (and allocations) for no performance gain
> >   */
> > -#define SPEC_NODE_MAX_DEPTH 3
> > +#define SPEC_NODE_MAX_DEPTH 4
> >
> >  /* A specification node */
> >  struct spec_node {
> > --
> > 2.45.2
> >
> >
