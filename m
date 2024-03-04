Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C08278B53
	for <selinux@vger.kernel.org>; Mon,  4 Mar 2024 19:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579904; cv=none; b=qeRjdmup6bfaPe1WDhyMP8Q9Qxg9HdKofe9NwwPdgx8LHZ/hglE15xm216QP0vKskRJvbZPsle36jgkQTrCMZWE68dQFco06QRFmJtV38WCCoLSDeIdJwrQM3bRSKCmkzxDJuqfsLsEqvs94W6YQ3hHq6l6i5mPJ8EKu1tcGJfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579904; c=relaxed/simple;
	bh=r+KJaOWDMo5NqSELoaQ/QbtLkLrVYzBQnqhYBoFxYZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=btpZ27FhnJ0ref78P34QEzMN8pFfy/AB2PLxI/8dTTL0mfTHVDHNXZ6bGCX9F5YesNuFYsvLAVsvuubENoWWzmAOHNoo47G7duawVK4GiPTto2m5RwiYoOQb3i569aeDICa7EI79pFJ1ujp4BGcOVeK2d7CRrfDaTUVzpUDpvi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V15rQG79; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V15rQG79"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-472640aba12so1038132137.2
        for <selinux@vger.kernel.org>; Mon, 04 Mar 2024 11:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709579902; x=1710184702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWlSwcBARmOYRzOVys6YPJPMXUyk6lSryzPwD7yywbw=;
        b=V15rQG79Qtjb6OgmClzDtpKbd+47S+aPif09onenTwFD11SGQcVqkQPTfhtFnDJ3Ow
         2Yp/8E/kJSVZhx963655JI8igWP10JWMnPybN4/g/9jGhWuVGOe34XVeSXlL53Ijc0eO
         2+Glh948fgglHHw3CGs4germVxBegkAsLtaJd2juBR8mDy1CeMzJQTZt02d0a9mi2P3p
         ZusW4Ms2dlEXSgonIL/jDptASN/jftwgpvz7EmU4BwXhhqLiwx93+uHkbUdtaVPnANuq
         y5JgpZI4EYuG7XihSVy/QC4PQYrUqnRQS+Co5W4liFod5GfqIxJAe2LhsVGEHjXjsK+d
         j5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709579902; x=1710184702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWlSwcBARmOYRzOVys6YPJPMXUyk6lSryzPwD7yywbw=;
        b=le9JGRteFEFKMfETVmjJ2jqLA98O7a7uDkM7romoUEYcOw5R2FAIPG/v5B7eoMT3Ra
         sfkvIrbIrwshBsQrrBqDDmbUBuRKcbNzvtPW72S00JkHQVVx9feIPkLy4huZOpPZOOBq
         L+9eeldzBClxoh7GXzjxrK1QfcMvvpfrdt+kj63JMPeAPNPncKkTd1YTDogHdsL9hBOw
         tsjvpGgYQXhz9kG2en89ZengsG0ME2NCoVGTb3LpeiGdL6IlNMgHIm3zKCtWdyY1bpZ4
         jLw7/+hELVmaN/5NsKKCJNo29NkE5E1MAt9CzJcW7EyhVwE1EIs1NQNyWsyjbhIWItFm
         nIAQ==
X-Gm-Message-State: AOJu0Yym1yy0flApvGKAs7RIr7vbymEiOfNqI1je+zd5rshpylhU2BjI
	sEt2qtj9TouY//ao/o7S1nxZvCsMQ3mey0xKVlTXp2IVDZvmgRHCgp50AyvAnLVkU4jipDqkYYx
	4AtNkXjYbA9ce3NhDSE+eQzqNavRQuTYx
X-Google-Smtp-Source: AGHT+IHbbD3KnjY4RTzHBpfAJ+tkBBg+ptOCigIGmdoN6oTA2HcuUAOudnljQd3QHXarwGGHRUBHkvKmDB4S4FwB494=
X-Received: by 2002:a05:6102:49a:b0:472:65e5:3da8 with SMTP id
 n26-20020a056102049a00b0047265e53da8mr6464482vsa.35.1709579902309; Mon, 04
 Mar 2024 11:18:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122135507.63506-1-cgzones@googlemail.com>
 <20240122135507.63506-5-cgzones@googlemail.com> <CAP+JOzTOeH8uB2V9+zt1i44QeCg7VaqWM8eHiBtzuunLxgaqew@mail.gmail.com>
In-Reply-To: <CAP+JOzTOeH8uB2V9+zt1i44QeCg7VaqWM8eHiBtzuunLxgaqew@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 4 Mar 2024 14:18:11 -0500
Message-ID: <CAP+JOzSdmmRLYN2qX48_7QJN555+JWE+WwphD1=9-V-z+d5Vcw@mail.gmail.com>
Subject: Re: [PATCH 05/15] checkpolicy: check allocation and free memory on
 error at type definition
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 3:35=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Jan 22, 2024 at 9:37=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> >  checkpolicy/policy_define.c | 23 +++++++++++++++++------
> >  1 file changed, 17 insertions(+), 6 deletions(-)
> >
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index 053156df..ec19da9d 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -1399,7 +1399,7 @@ int define_typeattribute(void)
> >         return 0;
> >  }
> >
> > -static int define_typebounds_helper(char *bounds_id, char *type_id)
> > +static int define_typebounds_helper(const char *bounds_id, const char =
*type_id)
> >  {
> >         type_datum_t *bounds, *type;
> >
> > @@ -1482,15 +1482,26 @@ int define_type(int alias)
> >                  * old name based hierarchy.
> >                  */
> >                 if ((id =3D queue_remove(id_queue))) {
> > -                       char *bounds, *delim;
> > +                       const char *delim;
> > +
> > +                       if ((delim =3D strrchr(id, '.'))) {
> > +                               int ret;
> > +                               char *bounds =3D strdup(id);
> > +                               if (!bounds) {
> > +                                       yyerror("out of memory");
> > +                                       free(id);
> > +                                       return -1;
> > +                               }
> >
> > -                       if ((delim =3D strrchr(id, '.'))
> > -                           && (bounds =3D strdup(id))) {
> >                                 bounds[(size_t)(delim - id)] =3D '\0';
> >
> > -                               if (define_typebounds_helper(bounds, id=
))
> > -                                       return -1;
> > +                               ret =3D define_typebounds_helper(bounds=
, id);
> >                                 free(bounds);
> > +                               if (ret) {
> > +                                       free(id);
> > +                                       return -1;
> > +                               }
> > +
> >                         }
> >                         free(id);
> >                 }
> > --
> > 2.43.0
> >
> >
