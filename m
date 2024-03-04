Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0F778B53
	for <selinux@vger.kernel.org>; Mon,  4 Mar 2024 19:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579968; cv=none; b=uoVQRwZEF5ENsfkw7Ay7QVmdNGSoHuNT4X/1nj3gJidmTCyinMExWFTx6YklhUYrw1sUCkpLlNpzVCp1/yTzmir1+Vj8hmOyv8XtUfqgSvKDbPJLHxmUIKuUOBcLcx5L4FWCPXaFLuSt0ADR9vdaqB311chn4FDvRhZS4sBbMeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579968; c=relaxed/simple;
	bh=fzadFf0YHXDj4uEoD50+m8cxKOkgEwBZe6qITGb0sMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ncJdnfS7sV0ZiNKmsekKirxCSOPnhYaqg7Apx0jy3u7gNWN/eD5gpoa2i74VDqSitFN1Vt+4Z0WagRq4pV2SgM96RqVXkdMbKW0BHPzeAAac4gF7ZSyqwL/GmloZsoq882kSuXnMhriPXdimHy5+Th1f00sthiF2uP+qf7jioMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahTnTc++; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahTnTc++"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7db1a2c1f96so1508503241.0
        for <selinux@vger.kernel.org>; Mon, 04 Mar 2024 11:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709579966; x=1710184766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8n9Px3AqjYRMkaZwnIE6vs8AYZhiKffNIRmLczTteMc=;
        b=ahTnTc++DXBJrcyYlVS9/jdqdSPgTHBKz4JXKy/6lZSeB7PtQNl6TfSnyMS6UMFjHF
         7gtIh1D7hdzBmXHXIDAK2DzKn1Ym9xRNTpsx4s+6s7N5Vfml3c6jysrJtOgyE48wFLoF
         VP5vB/ShEzpDs27tasBLFDjDrRD9EQTYsO3ryNKVNKOrzhW215VlZKtNJLayeV1V1u/C
         vBwWY9tfu4TtJ01RqVNhFG4UMwvKFH/0Qm+AXyuTMilfJ4mCE8BBOGdG2PK1+JdwOTtv
         2MoOvtg/VcF/oCS39n7GPoFxy6mdvs+vzKaow8cPUm3mGsuy1qt5w11YgYHZAL//YAiI
         ql1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709579966; x=1710184766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8n9Px3AqjYRMkaZwnIE6vs8AYZhiKffNIRmLczTteMc=;
        b=DYXnfdZ9Xbs/Kqvv4pP+y0qJiHU0ReNXzS2an0IlPqVC6AdTIknYTOY7EgW6dy+6kv
         68OjO/UL2sdIMFwmYmNcNpU5ZTv2/xLYqgnXqUrkmFiKqG+tRJPzvySuIoLd982fqil8
         UfDev8aYCJWJ86ZLh/X4hZNykE0eUeGYcsitewqGmoEzEuhB7E9ORV6v+uhFJqQtLEnQ
         lOPDYP4IuEkjoTWHhr3LH4gZe7aAm+lA4B3KvQ7kZJ/LxLrh4omHp9vFOlyUPFmUbJC1
         ILNcE/y7H+g924deZHxTRSvH2OsplRK5PH/yr8kqSMcT7RLKTkw3pUV/i7X8VLKqBKjm
         ZIKQ==
X-Gm-Message-State: AOJu0Yz4mgAEuwL4Ixw7RVuhFhVSA0uEthcOUk4E4KQrYnp7VCtQzKjP
	VzmaICvYbnxiA4Fgriqn3+NY92BDYHPXwfeHfwa2vcF5MuhmahFvipLcopr99eH/E6H3srgi1fl
	u1MdI3fvoTy5AbPZnYio/vrY5QB5v6L9L
X-Google-Smtp-Source: AGHT+IG0FJX+Ndc+gRBJv0lp6gysPTjQKK7d7MZ6NQ7xf61cBJIhEREXMvAgXpdwl1mVJGkksfNwwyMG8BHeLkogEp0=
X-Received: by 2002:a05:6102:2443:b0:470:7096:ad4f with SMTP id
 g3-20020a056102244300b004707096ad4fmr7577523vss.12.1709579965419; Mon, 04 Mar
 2024 11:19:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122135507.63506-1-cgzones@googlemail.com>
 <20240122135507.63506-8-cgzones@googlemail.com> <CAP+JOzRBz8nQ27QBuu=+=x-nUcvpq3SAAd7qH+tz2o+vyLOs8Q@mail.gmail.com>
In-Reply-To: <CAP+JOzRBz8nQ27QBuu=+=x-nUcvpq3SAAd7qH+tz2o+vyLOs8Q@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 4 Mar 2024 14:19:14 -0500
Message-ID: <CAP+JOzQY0GNthSPGSB7_HsY-cj272xbxJwtY9or88Q878P7Rvg@mail.gmail.com>
Subject: Re: [PATCH 08/15] checkpolicy: bail out on invalid role
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 3:36=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Jan 22, 2024 at 8:55=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Return early on invalid roles in user definition.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> >  checkpolicy/policy_define.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index 97582630..44236797 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -4244,7 +4244,7 @@ int define_user(void)
> >
> >         while ((id =3D queue_remove(id_queue))) {
> >                 if (set_user_roles(&usrdatum->roles, id))
> > -                       continue;
> > +                       return -1;
> >         }
> >
> >         if (mlspol) {
> > --
> > 2.43.0
> >
> >
