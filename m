Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2499173
	for <selinux@vger.kernel.org>; Tue, 30 Jul 2024 13:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722346783; cv=none; b=eN9/Ynd/KbD2IXGA0Vi7cmT4ZWikHQdCQ8b8xeIk1h9arpE5n0fbrDpiuq3d+Fzhre9RayCG5DTjK2Cqj5rhgkNCyy/EvA+uPWzRoG+TX3Dj9Nr173JddY9cwNZEpKFp6yEym1MFgSuPfTaDTSSSgIStE5wyAuQVGrWZXb24gww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722346783; c=relaxed/simple;
	bh=cDgmmS00DaYpQTVQ2vvoGrKaC48aShaeFYxAUlbh8ls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sdIQVxrTmjDvSLSt1AP+mQRq4YFmYYfgLeZZcPtBgmt3cFFkAcGrRHCEdiNiNEMUPQvsO/wWOoMTjZyFFUzfl3ayC8omtvrqhFKwmNdPkFN2APWvXao5Zowc/6UBV8/uhArKGA///04qQNlijGkzmo+4hkKlOqhKbTBTzFnZRRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbE2ehvI; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbE2ehvI"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-821eab936d6so1043057241.3
        for <selinux@vger.kernel.org>; Tue, 30 Jul 2024 06:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722346780; x=1722951580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DB0uxfix+N0i/HCWNjD+q4XLqPa+B8/2TCSTPsudbaw=;
        b=JbE2ehvI0xDDsf0MeUhqYxzudlh2fukG7/oTYjCWw8gmYKxRb4bQjHnPjSEExjtQ0T
         IknI3rKwVKkzEOmDwXTo+WUTKZzfvWTFL++Ku57Pvh1hblj4IfJxKXxmFzhywZxTg+DO
         d5F7xS4uKorzhuRC0yEeJTX7DXyolM92Q0/jL93VtxYs2JyNNPYYzo9r3labq+IEBRuC
         SzRZJx/kP1xj65LTp3Fr6E/68Aacpc2cscF8WdvMxLUhAnD0GROXeKH3CYWRDcV/3XAl
         kMYXit/ianrnQKAy4/A3wk8ypAnM3x2vm10Obt0TOebcIm43Sk+AmNQpTuNlughAH7Hq
         69cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722346780; x=1722951580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DB0uxfix+N0i/HCWNjD+q4XLqPa+B8/2TCSTPsudbaw=;
        b=DvwLXh7KboXQ3iTZc4wVxrGiZ2fqHOA2fLbodkH9iY1Nb3MiSoJHhn3w2lWg4ivqtN
         zDph4k6nHTgOyAMyTF1hSvaN4+pBV+gD2w4mhem4OWq40fqH9TEmFEnSLCkmadPtbHj7
         iudrmRzAWK37gQcvo++8ayEMPvH0W4zx2StjTUXECXJAKLWMvKQGNhfLt4NiITcsQe/j
         l5uwkbSzfbnYiqNNdhqpaWw7DTeJkfvMNtN6zPW9e9R6STu2THV9clqXkpktr/zscoq0
         8pxbMkEYZVR7HvNF079qQc5F2dkGlstWOLt6a7WpGx0QURnW2oVsf34E89bzFKnBIzuz
         m/cg==
X-Forwarded-Encrypted: i=1; AJvYcCXuG6UosvhoReZrSeLhTIgPkEXu31gBmrsYy+UazYzeGvDSsPVcVmZRRs5DZJvmfRSILboqBMn9j3G0VwjSNJcZ4MX2axzbug==
X-Gm-Message-State: AOJu0YyYJiG4Hp2Kj4giYj3pjzmOqiCOF0nUcGSHaQUYX+ATXCpA11bC
	dgi9nOJoyaPbVYLzFfWoTzvww0G1ZvvelwRtqncNNkXgdrSUj8B3ZnWIEbchEwRC9Ej+5Fc6jTd
	2t2ipqHHK3BXKDH9SMJ40XBLvt+w=
X-Google-Smtp-Source: AGHT+IEHTW/K0mjsY65KO24PYuFpfamzycH1iPDlNVmSm7KkeBB7RUP4eHglr4yZvz9/dO4o1BULH2qkWYABOWOm3b0=
X-Received: by 2002:a05:6102:5125:b0:492:9927:a5c6 with SMTP id
 ada2fe7eead31-493faa86d6fmr13420598137.12.1722346780555; Tue, 30 Jul 2024
 06:39:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701182732.85548-1-jwcart2@gmail.com> <CAJ2a_DevjOD55nbGxqjEPx+Z6q4bpXWZDVu15-4iAV0_mQgpzQ@mail.gmail.com>
 <CAEjxPJ7HyFpPQapVcfkpKGgRa-ZbSzQjwuo76_3eoGarRyOqgw@mail.gmail.com>
In-Reply-To: <CAEjxPJ7HyFpPQapVcfkpKGgRa-ZbSzQjwuo76_3eoGarRyOqgw@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 30 Jul 2024 09:42:18 -0400
Message-ID: <CAP+JOzSOKdsn3tWUvGpR6C6ecEG7U891c20mF8MHjtpuqxLjyw@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Fix integer comparison issues when compiling
 for 32-bit
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 7:58=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Sun, Jul 7, 2024 at 3:00=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > On Mon, 1 Jul 2024 at 20:27, James Carter <jwcart2@gmail.com> wrote:
> > >
> > > Trying to compile libselinux for 32-bit produces the following error:
> > >
> > > selinux_restorecon.c:1194:31: error: comparison of integer expression=
s of different signedness: =E2=80=98__fsword_t=E2=80=99 {aka =E2=80=98int=
=E2=80=99} and =E2=80=98unsigned int=E2=80=99 [-Werror=3Dsign-compare]
> > >  1194 |         if (state.sfsb.f_type =3D=3D RAMFS_MAGIC || state.sfs=
b.f_type =3D=3D TMPFS_MAGIC ||
> > >       |                               ^~
> > >
> > > Since RAMFS_MAGIC =3D 0x858458f6 =3D=3D 2240043254, which > 2^31, but=
 < 2^32,
> > > cast both as uint32_t for the comparison.
> >
> > LGTM.
> > Reviewed-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Do you have a reproducer for this? Building with -m32 didn't seem to
> trigger the error for me on 64-bit Fedora.

Building the SELinux userspace with:
DESTDIR=3D~/local make clean distclean; clear; CPPFLAGS+=3D"-g -m32"
DESTDIR=3D~/local make install install-pywrap
gives me the error.

Jim
