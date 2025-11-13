Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD250199931
	for <selinux@vger.kernel.org>; Thu, 13 Nov 2025 00:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762994621; cv=none; b=Ojia1+fZGriADdGFlVOJ8nCieNhBrTiZx3ExSH/QKAKXPe2k4kNP6MAh8ndVv2GpPsOoYogZ1ziy2+nfoL1bJFw5JhHOLPUIJMV/GnPKC1wxl9HNht07fdLvyePBSZkPrHhOH4qAf5BIDnAyykjUwKLe2GwpJahulZ+d/R8ustw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762994621; c=relaxed/simple;
	bh=fpAXtI1PNi5xtUGy+9dcTRW3Xpxbbhz7K5FX1rcR/5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=moDKguZtOCOKM0IfzkNeLz/NlVdKMhg8zG1QnDkSAsNO0Wg1fXY6c/ewHwr7Usjv8BGRBW41hvj6VktMIbvmDFwxKk8XNxVRf2g8qwHJuDALxjVz3veygIL+FMiP5iGIY9tOs203zSgb8zFeNWwqdw9YMOEeZwCgRBiqN15w9kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4+UjJ55; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4+UjJ55"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5957ac0efc2so213317e87.1
        for <selinux@vger.kernel.org>; Wed, 12 Nov 2025 16:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762994618; x=1763599418; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnnz8NddVHsF4uuY9dDLvis0mFm5HAgiyp02x5fzh4w=;
        b=H4+UjJ55CkVOUeIB1A2eo2RiAop7eELkroKeV0piahNQ1YPgh6zJkuHdM80Jw29ZEc
         Eizk457RurTF+8XCZCrv3IpoNhBzCWIwWHk3Y09VTKcKk+L8wl8zJaO/PM61b9mK2rDf
         azjCQZevdOnOVJGA7tqNe0JxLMEv2V19jXTLhjZWhIczG4kyFf+iCiCQrizYkOYMp2//
         NBifqRNQidE8MSircKqAnoZEAfHrJ4zUfa1E4Vm2OlPhN0DAlTrJ0RteFQlOgAuAT5is
         kZq4rB8ZZUUxVd2A3rxXCrtxPXP59dNxM/OAmpkMJA14sT0rvCDZZuBCDyZoByi795rE
         jwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762994618; x=1763599418;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wnnz8NddVHsF4uuY9dDLvis0mFm5HAgiyp02x5fzh4w=;
        b=F2/nQxOLl41WtaNedwnBTJHrP0rzMu2dtIH3oIKXRCuhw2vjUJo5mb6A6P1izVu3sx
         ODFMfIkNbSlOX3RqiIA+PzuGnMlUxdP0QJqVZZUxeg4sUzFRd3EKF7ErsRWdaNQA5YSr
         jvpBdWfs8lRAHVcy8Uh/rNmE/7NQhXj5T7lhaAtNT9whc3P4vYcgaZrci70hGu6Fb5Cl
         dlZmh42b13md08CwLU7rfvx7+/T33kW3veGuNvk1r6K52l4qBicvx8+x1MJtg4eTZZgA
         XTZ/a7JVhLp1ZEDu1rMFAPZipJk0eS0iTrbxyCPkRtLutpBfw9qt+GltBRDKGwma118t
         swRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYjRst+67AAOib9Jk1F7lIlif/aXiDm3D4Hof8MG4/Q6i/n8ZYiHz0pXosUVYgNCOPzcXTSb5N@vger.kernel.org
X-Gm-Message-State: AOJu0YxU5k4AcOvSMh221C3d7RwdI4RwLPXkUg4oOz3V5B1aSqyfk1GU
	4Sam4LYKlemf0+CyvSAoc8GwVeC+OwkrWoZtLVi4N2Em0VPNnIIHNF+ktxALIcWYR2DZ2ampK0R
	WV9FHMkdDwu1jc6d39N2x9K5VmGlUthUC1g==
X-Gm-Gg: ASbGncuuT1SbvBGEyAwzykQFzz2PK3nQs9zeC/g9B4aURrArZvTEkJp2dgVs1QPWwQ2
	NygRxj4+4Pmz7/96IK0Z5/kRvvKP7jEcrhq4dwdUS+8t1aZGZ9bB2UtXVPpuQpVMTr3tlfX3Y7D
	BiQkPXTFDL1yaNf5XMds+MzCeC8rMIQZBDmdf3WGJQfGglxvQdNQoGfl+A7jUFodlzFfZNxHKah
	H+tcVuaHoUMLjkW0yEt3s11Wr47il5NOQcp5a/V8/Aoxe6wHk8w9ZNAgBgsHL57fveLChaJ
X-Google-Smtp-Source: AGHT+IE0/3o7wy6GbLPkvIketjV4Lnezu1T42ujc4BYk7m/qBFlXKDVds4YQmW3eC/A3HElxXfvYrSkF0BCv+BLf+NE=
X-Received: by 2002:a05:6512:3c96:b0:594:2cdf:1941 with SMTP id
 2adb3069b0e04-59576e17a9amr1982097e87.31.1762994617619; Wed, 12 Nov 2025
 16:43:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110180935.202229-1-vmojzis@redhat.com> <CAFftDdpQM3mgBsR9A1F=ybfqU7Wwp0gbKbvYjTc-Bdz1fatPYQ@mail.gmail.com>
 <CAFftDdoSdF2NYRichwF2pfNdriChOf7ob+N+CN7OjWZafLwGaA@mail.gmail.com>
 <0d41ceb7-5173-4360-a746-c258e86089e8@linux.microsoft.com> <CAFftDdoTR5ae1qORSjPuOj5ea1O15qtgrRiadhTp2HMh926swg@mail.gmail.com>
In-Reply-To: <CAFftDdoTR5ae1qORSjPuOj5ea1O15qtgrRiadhTp2HMh926swg@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Wed, 12 Nov 2025 18:43:26 -0600
X-Gm-Features: AWmQ_bk8MWauuQKxQKzeFhqhFPNHNC7lM9WhlB2qF6O9QFcE_nG_FFtxX2p3MnE
Message-ID: <CAFftDdp3ZChoaVF-5FN=O=b09Hv6VSXAUzRQ0muW0NParjZBhA@mail.gmail.com>
Subject: Re: [PATCH] restorecon: Add option to count number of relabeled files
To: Daniel Burgener <dburgener@linux.microsoft.com>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 10:34=E2=80=AFAM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> <snip>
> > >> I'm no longer an SELinux maintainer, so don't let my nack stop anyon=
e.
> >
> > We have a need for a similar use case in terms of ensuring that
> > restorecon actually performed relabeling, but I agree that I don't thin=
k
> > this patch as is would meet our needs.
> >
> > One thing that might make the patch more usable and address these
> > comments would be to instead pass the expected number of relabels as an
> > argument to restorecon and then return success if the relabel count =3D=
=3D
> > the expected count.  That avoids all the problems around exit code
> > handling while still verifying the count.
> >
> > The other problem though is that in the presence of globbing it's not
> > clear that getting the expected number of files relabeled means that yo=
u
> > actually relabeled the files you expected to.  But I guess the answer t=
o
> > that is just "don't use the count feature with globbing".  Even without
> > globbing though, if you don't relabel all the files, you don't know
> > which one you skipped without extra handling, which seems like you
> > really don't need to know the number relabeled as much as whether it wa=
s
> > the number you expected, which seems like a point in favor of "pass the
> > expected count".
> >
>

Sorry I accidentally sent this only to Daniel, adding back the list.

With -v doesn't restorecon show what would be changed? Perhaps it
would be better
to add an option that produces some standard formatting for an audit
trail and that output
could include various statistics. Then folks could parse those
records. I see -p does some form
of progress/status meter as well, for whatever that is worth.

<snip>
