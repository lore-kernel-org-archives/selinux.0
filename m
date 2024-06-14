Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B1D19D896
	for <selinux@vger.kernel.org>; Fri, 14 Jun 2024 14:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374404; cv=none; b=cO9+igEGEjklzdiI1EC+HIoCcpeO893h86pQl2xpll5zCdyIVfZUgnOoynkTvlfz1Of1mNiB4kTP6Y5jZ/CQAnagXGjFuk9BIRtN/q0Qzk8BLGuO3m2Xa3NiixgBDfabUII5XchDDxzoV9hxs97PcazyihdStY4fae8GdCHRvDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374404; c=relaxed/simple;
	bh=Gz4DVkZDt3boPsSRd++NP+/LYbp9Ew0ynLWAhxM1Io8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FXT9Rm27IduY9KkDeZ4z0nyqXBjMJNhDcW5EHO/Oo3ljbLaqrFrdVnFJsC2NDw+2PLR2jJCoixatusY4Lg83AHmmA5H9tWaFr6rA8tQeaExwXDzXHDq28VQJrT0w9M03b1Bf2OHuiZ7WEN/Ir1XVUZrQJmtgY05SIpK/q6yTs5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=guiDQrlI; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guiDQrlI"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5bdbbc37664so111214eaf.2
        for <selinux@vger.kernel.org>; Fri, 14 Jun 2024 07:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718374402; x=1718979202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbaM8UDP9OpRhVguRLJrJ/fhq24AXh5UDv8PtbQLKzM=;
        b=guiDQrlIJm7q+PLQPue8Wq3QSiRI5qVaYzusjCS5Bo/jfFGcNdmSdkbd0HNjP5Ttrf
         BBJsuPDyHigJz7lxXB58CPuFrXeIPCCuB1QuIoApksHVMouvE1ofeNMietzmx8T/FcLd
         J1ZwSdYF2yukql37amnFtFVkRxmHTA9kQYI7j2Psunffd0FPYADVFnEatX9FL8GRPwn6
         OFph0W2x3Kh2NusHBZ0xiUbbhwTVdAUt3X/mmctWRCUUED/B62Zno33+lOLFFgHLrcRe
         Xk92Z5Pa5At4dLAz5f+gQTIPT+nGtvIskbuJCtEAOAb32sEkRGMR3/rOjJu2GYpLYvpa
         BcPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718374402; x=1718979202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbaM8UDP9OpRhVguRLJrJ/fhq24AXh5UDv8PtbQLKzM=;
        b=hTswPbCyMd0fizqrg7Rt5+D3M0UyGXyrpSA/D2IS8NcnuGOh+asz/POhe1L3c5gNgd
         FtAm6qMjCvLgwl7kLqa1VWAFIRW3tX0xxXRQM8RzAJbVqCHujkTmBKKawfTe/pUAIgq3
         L/P/6lukQ9QBcVyDWaCxDTFnSApQ0s2IC7Rlk3o8tm7YsHEHyvIp6OaKF68HCpzTdYH5
         bgosAHnPs+inhOV1YGRS/OkvzjEG97LVLEOAexep08HnnCw6K6ESkZkTNcPBQ2wibEtt
         rkxdoWx+5gst3+I4KANGLOM41d2//7YYw31YHcdAl2jG6ZA+g/C6EwpdUyvY1vt7qYDd
         6YyQ==
X-Gm-Message-State: AOJu0Yw/i1oqRXmsnZhveHWT70wBqkgJ5nUpJWyR2c6oJEoUg009Qhek
	QYbbWqlDQFgvpqiu03sLZh+mF1w0fPY1BPONTAP7lHlCYOJDWCnsl1M0S4X4kee58H6P/PTpGq7
	YS2RmsNNvdfEw1+BZXkH8llq4DuxVOw==
X-Google-Smtp-Source: AGHT+IEbsPJZ01fqI3CZ04xOsYsKU9JbSXg8bBWMh1VibAn11ZZS1/rhjvqtKrLIgA00Jbm7OYE5wiWHK4XVCeJC/no=
X-Received: by 2002:a05:6808:189c:b0:3d2:29d6:fe8e with SMTP id
 5614622812f47-3d24e8a6df6mr2744806b6e.8.1718374400431; Fri, 14 Jun 2024
 07:13:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608171838.136163-1-cgoettsche@seltendoof.de> <CAP+JOzQVALz=Mqk3+YND3bcKtNMCMt3Hmg7GfiGU378+xsDaiQ@mail.gmail.com>
In-Reply-To: <CAP+JOzQVALz=Mqk3+YND3bcKtNMCMt3Hmg7GfiGU378+xsDaiQ@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 14 Jun 2024 10:13:09 -0400
Message-ID: <CAP+JOzRvT+ND2wRF2aL5rsH-u-8FjBLQPHYtRdT_-PQ0aCN1Ew@mail.gmail.com>
Subject: Re: [PATCH] libsepol: validate attribute-type maps
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 11:33=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Sat, Jun 8, 2024 at 1:18=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Ensure the attribute-to-type maps contain no invalid entries, required
> > for generating typeattributeset statements when converting to CIL.
> >
> > Reported-by: oss-fuzz (issue 69283)
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsepol/src/policydb_validate.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_v=
alidate.c
> > index 84c1071c..9746f562 100644
> > --- a/libsepol/src/policydb_validate.c
> > +++ b/libsepol/src/policydb_validate.c
> > @@ -1654,6 +1654,26 @@ bad:
> >         return -1;
> >  }
> >
> > +static int validate_attrtype_map(sepol_handle_t *handle, const policyd=
b_t *p, validate_t flavors[])
> > +{
> > +       const ebitmap_t *maps =3D p->attr_type_map;
> > +       uint32_t i;
> > +
> > +       if (p->policy_type =3D=3D POLICY_KERN) {
> > +               for (i =3D 0; i < p->p_types.nprim; i++) {
> > +                       if (validate_ebitmap(&maps[i], &flavors[SYM_TYP=
ES]))
> > +                               goto bad;
> > +               }
> > +       } else if (maps)
> > +               goto bad;
> > +
> > +       return 0;
> > +
> > +bad:
> > +       ERR(handle, "Invalid attr type map");
> > +       return -1;
> > +}
> > +
> >  static int validate_properties(sepol_handle_t *handle, const policydb_=
t *p)
> >  {
> >         switch (p->policy_type) {
> > @@ -1790,6 +1810,9 @@ int policydb_validate(sepol_handle_t *handle, con=
st policydb_t *p)
> >         if (validate_typeattr_map(handle, p, flavors))
> >                 goto bad;
> >
> > +       if (validate_attrtype_map(handle, p, flavors))
> > +               goto bad;
> > +
> >         validate_array_destroy(flavors);
> >
> >         return 0;
> > --
> > 2.45.1
> >
> >
