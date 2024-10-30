Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6312E47A73
	for <selinux@vger.kernel.org>; Wed, 30 Oct 2024 13:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730294202; cv=none; b=ciEbf0eQqeBD8L5odVhr2F+gM5urXkCZadw5A+JLO4Z6oGOdDaWt6PKFl+PVKfI/+BpCq5ogRFI3WYTJAstv6ni5pgmHRYt0pn4Aqn6pMEbHz/CfLnHmWiWDMp7AI8zXbU1V31JqPfk8JrlACkQt2T4duUlnxI6ufFH9f4Bpz9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730294202; c=relaxed/simple;
	bh=zBTPws07yMp660SgCdO0CGSgDTtPbANiVB8AT/HcJHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hGm8YdEaL1S+1jKQ2oGTzB5k03I1LVR2r9uELyAy+tJBkXs7AZUmn9CLAc+M2GA/HyopMYW1i1IhUkDonXKMe6zQQ7L/rKR0nD55I18Gpgf16OjP7aCv1CDcTPGfSXmJ/lfoPXkWtvjIZiDXc9G+E1RuS2CX8goFfy/wq1czOvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWQHV9pK; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWQHV9pK"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5ec1ee25504so2063873eaf.3
        for <selinux@vger.kernel.org>; Wed, 30 Oct 2024 06:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730294199; x=1730898999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQNp8GX2Dxvy2qRlc+6g4wKjE4k7k37V+o0Riz7MCCo=;
        b=mWQHV9pKqK5ChdTQNzUvfYjgM0LmJZYhX8ldVTbN+2AEdIFrCKV+OC3xRGY4nc2z/D
         o6AQyGzSHaLtX/WTOgHdJZZUpvp9rnDwqo368FWxYt1MQGuBWNxZ8BtR4Mp/KCM/xQb/
         dsAtmY0NZm45goFrPMLNEyOWbZ00MCRYT0FhSCvlcsk47tml4+5XbPyZMo93wY1Sojf9
         vydHFDUSSBBy41rbldYU6v+CgspG+w4wXiqerYUiJlTDj+EUv4iGMIXSxNAS+p168ma9
         pJN+myFAIlZZe/EomegiVNKodsd5BtPW9IY7EdZi4sO1mPvx5CjoZ1VKei89HixmT5je
         tOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730294199; x=1730898999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQNp8GX2Dxvy2qRlc+6g4wKjE4k7k37V+o0Riz7MCCo=;
        b=lOxQmXBSp4fYBgVTF83lYhKYLNaOjugxoTxlaSyVvEwMDrtYVQHw7mp25n64lw3Yk6
         RGfBaf19XVAqO/SchZJemCRu6xaq95f1kZ3bSDssyV2ZTIX2F1OTgn0VFAPntDsJ8Vef
         WtovPnVOKsxKaPvH1XM+CsksH4iH/V4Tp5SHuI7uIzRSCrL34vFZenFkxEhe6g15ulkL
         +YbtIwQUme0nq/8avTvAoT1p+9a7cT0uox+/VoOOdZzZMkx3GtmlUFXri2U0TLOKow6q
         Lq2h80HtKXpAtvlXLLqFdG5fXGeHj37XOSjm781StVyo/P1X2gAz18WSBPZM1r1yX3X9
         cdPA==
X-Gm-Message-State: AOJu0YzVB2onXTzCCYBvWPIfiYG/KWGBPm5Temt8/cJx1EPb9GJexoHq
	Llnoog0loS2gfVspTyiELDJ+7BbB6H6VUIGupTUbV9/Y8EvtfBZHftAlT+ryXe/ppWev0uSu04y
	GMm4zNdAQwDN40oKv44pPVwQdBaI=
X-Google-Smtp-Source: AGHT+IFanAm+5iFTfL36WmBdWxY5njtXNPZKz4rubf8QXkfRpRdMnA3htyjXFl3oBsl7zLROUT+3/su8tT89cFqXqNM=
X-Received: by 2002:a05:6358:61c6:b0:1c3:724e:f4cb with SMTP id
 e5c5f4694b2df-1c3f9f5bec3mr694685655d.22.1730294199423; Wed, 30 Oct 2024
 06:16:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025183207.1827274-1-vmojzis@redhat.com> <CAP+JOzS8PC_gzy73a-d5ZhvY7-weToXBTotm0HcmoBsEaKd0qA@mail.gmail.com>
In-Reply-To: <CAP+JOzS8PC_gzy73a-d5ZhvY7-weToXBTotm0HcmoBsEaKd0qA@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 30 Oct 2024 09:16:27 -0400
Message-ID: <CAP+JOzSX5EwpB7C1YNOonJ-+jVhcHWT8YsK2L1YHb3hSMBOhhQ@mail.gmail.com>
Subject: Re: [PATCH] libsemanage/direct_api: INTEGER_OVERFLOW read_len = read()
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 1:15=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Fri, Oct 25, 2024 at 2:32=E2=80=AFPM Vit Mojzis <vmojzis@redhat.com> w=
rote:
> >
> > The following statement is always true if read_len is unsigned:
> > (read_len =3D read(fd, data_read + data_read_len, max_len - data_read_l=
en)) > 0
> >
> > Fixes:
> >  Error: INTEGER_OVERFLOW (CWE-190): [#def19] [important]
> >  libsemanage-3.7/src/direct_api.c:598:2: tainted_data_return: Called fu=
nction "read(fd, data_read + data_read_len, max_len - data_read_len)", and =
a possible return value may be less than zero.
> >  libsemanage-3.7/src/direct_api.c:598:2: cast_underflow: An assign of a=
 possibly negative number to an unsigned type, which might trigger an under=
flow.
> >  libsemanage-3.7/src/direct_api.c:599:3: overflow: The expression "data=
_read_len +=3D read_len" is deemed underflowed because at least one of its =
arguments has underflowed.
> >  libsemanage-3.7/src/direct_api.c:598:2: overflow: The expression "max_=
len - data_read_len" is deemed underflowed because at least one of its argu=
ments has underflowed.
> >  libsemanage-3.7/src/direct_api.c:598:2: overflow_sink: "max_len - data=
_read_len", which might have underflowed, is passed to "read(fd, data_read =
+ data_read_len, max_len - data_read_len)". [Note: The source code implemen=
tation of the function has been overridden by a builtin model.]
> >  \#  596|       }
> >  \#  597|
> >  \#  598|->     while ((read_len =3D read(fd, data_read + data_read_len=
, max_len - data_read_len)) > 0) {
> >  \#  599|               data_read_len +=3D read_len;
> >  \#  600|               if (data_read_len =3D=3D max_len) {
> >
> > Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsemanage/src/direct_api.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.=
c
> > index d740070d..7631c7bf 100644
> > --- a/libsemanage/src/direct_api.c
> > +++ b/libsemanage/src/direct_api.c
> > @@ -582,7 +582,7 @@ cleanup:
> >  static int read_from_pipe_to_data(semanage_handle_t *sh, size_t initia=
l_len, int fd, char **out_data_read, size_t *out_read_len)
> >  {
> >         size_t max_len =3D initial_len;
> > -       size_t read_len =3D 0;
> > +       ssize_t read_len =3D 0;
> >         size_t data_read_len =3D 0;
> >         char *data_read =3D NULL;
> >
> > --
> > 2.47.0
> >
> >
