Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31331178CEC
	for <selinux@vger.kernel.org>; Fri, 21 Jun 2024 18:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718993299; cv=none; b=SRFUdsVYM0M/B5i0Qyq2sjaEt3c5mVizDmW6gCsg4ZhPRSAMglDcTlTZsisbaFX5Ft5Kl0CvV/Xish5p16NgdYMwWqJC3t4wb7ogjaZbpBo7t6L724N0DcjqSZ0vzZCoEKwqxB77N06naYziW57/+svaDXt2RLkhKGsx4PFbE1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718993299; c=relaxed/simple;
	bh=RhvtxCco65CBs6j5Mc7g81pWOD1vUDp1uEzP2aI+OOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LdBCN4wTp0Oxlx79RYw+AMpvGuRmsQpNw3rxRA8HReyDZiA9G+jKOl8xWZSgBrtBcSQESzvCzx+sR/Rvg7X9pT1QrfB1tAB9AL1i7Ay18LPK132iGEk+jOJ+ZCzi6HrzaAsaGZKdomEdoOFQFRwyCOeojiy7JOVw8WR7f3Gh/0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlsf9yFc; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlsf9yFc"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-48c384ed600so1132568137.0
        for <selinux@vger.kernel.org>; Fri, 21 Jun 2024 11:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718993297; x=1719598097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=doXE9wf/eHPeP15uHoD8IpNsD1iiqsK8skiB0JP+mLA=;
        b=jlsf9yFcnl/JX2wLa1HHi4MU1tBw5NvyU+aD+7AE8Z6ngauydaneo38MbpfNAvkobo
         dKIFmw3aXK8hfwp7MKiApjblEd/TLHpNDw5gQhLm7pCi+a481SNP2FJGBhWIBFKA/oUK
         xs9WKa2RotdTKEyqqMQXwWLtDRnEF9H9/2e0Vnen8lidGrLj3us1GRt9+pEUJrxBHNP4
         4mGM8UmTsgInwxCKh1qfYr0q3/5H5QtKRkKmnFafhg9KckAmzSyg+G5HdRvEKcl1XdFK
         UhiL3TUySO4T58pZp67u571XWBidltekilKWSHf5pUkn4kLWWbOJmR1wXZ0nUaugC7w0
         giyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718993297; x=1719598097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=doXE9wf/eHPeP15uHoD8IpNsD1iiqsK8skiB0JP+mLA=;
        b=hmFGYc1t/hOugQFGhJ6ruLVnsz7LMX7hCK65SZNehLyXBdLASFtI7+7N3qs9ki94Em
         YCjYDXIKLu73wtHW4GYRClp72qwPw3uuyaC6fcGBNH93lMOHNULmEVGQBGJKm+jSXxKl
         ZAARCJiTVRPF5dv+jtHCpLWpdj6+9LIJOVLx3aWNNsM00pE83QyMMUF14M9I8Ik5Owdf
         y6m4MhvbCASpYvw1LKyzB4N0OteZ7i05q62m09oIMJ8po3h9YLrqUitYbQavSzyWxYGN
         Gga8+XA7Q7ZyyrJ7/hdtb8B0gsfc77DSjoo1RGB/BQdc8yC3k3Whz8jQ6FtkMcYRXiAo
         ta9Q==
X-Gm-Message-State: AOJu0YzIr0GlP3qwf7qYphkot7rq6a4UwmDqEI3JHvROoOdkjB/x8t7N
	QvuHFywddK80g5apRSSlo/DKham4pPOvMM3Q3o4JB7RK2IqL8tXbTOXguIu+fCZ3IJIKixjg3r9
	E2+HEHi42/r+NUGL1XRFx4CCPbDE=
X-Google-Smtp-Source: AGHT+IF/v3kJXtycwaO+1o0b2lTP5JpdV9/C1JrHSrSWs//tkiR/ZWQqY6oPdWZ6Fi0n94oOhNJL0tpp7sT3FmS+6ko=
X-Received: by 2002:a67:f809:0:b0:48f:12e5:bd8a with SMTP id
 ada2fe7eead31-48f43e3eb7dmr797539137.12.1718993296984; Fri, 21 Jun 2024
 11:08:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240615132525.36358-1-cgoettsche@seltendoof.de> <CAP+JOzQcApAE4xmcYSeGcmxUVhuPmF9sn12zARY+J3JCqN+5gQ@mail.gmail.com>
In-Reply-To: <CAP+JOzQcApAE4xmcYSeGcmxUVhuPmF9sn12zARY+J3JCqN+5gQ@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 21 Jun 2024 14:08:05 -0400
Message-ID: <CAP+JOzR2z3Dct97EQAi6PKQjjCGA-uRyUnF8oEE5zGKD+ztS1w@mail.gmail.com>
Subject: Re: [PATCH] libsepol: check scope permissions refer to valid class
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 1:55=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Sat, Jun 15, 2024 at 9:25=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Validate that the permission maps in the scope index refer to a valid
> > class datum.  Otherwise since commit 52e5c306 ("libsepol: move unchange=
d
> > data out of loop") this can lead to a NULL dereference in the class
> > existence check during linking.
> >
> > Reported-by: oss-fuzz (issue 69655)
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsepol/src/policydb_validate.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_v=
alidate.c
> > index 9746f562..0216410c 100644
> > --- a/libsepol/src/policydb_validate.c
> > +++ b/libsepol/src/policydb_validate.c
> > @@ -1467,6 +1467,8 @@ bad:
> >
> >  static int validate_scope_index(sepol_handle_t *handle, const scope_in=
dex_t *scope_index, validate_t flavors[])
> >  {
> > +       uint32_t i;
> > +
> >         if (!ebitmap_is_empty(&scope_index->scope[SYM_COMMONS]))
> >                 goto bad;
> >         if (validate_ebitmap(&scope_index->p_classes_scope, &flavors[SY=
M_CLASSES]))
> > @@ -1483,8 +1485,10 @@ static int validate_scope_index(sepol_handle_t *=
handle, const scope_index_t *sco
> >                 goto bad;
> >         if (validate_ebitmap(&scope_index->p_cat_scope, &flavors[SYM_CA=
TS]))
> >                 goto bad;
> > -       if (scope_index->class_perms_len > flavors[SYM_CLASSES].nprim)
> > -               goto bad;
> > +
> > +       for (i =3D 0; i < scope_index->class_perms_len; i++)
> > +               if (validate_value(i + 1, &flavors[SYM_CLASSES]))
> > +                       goto bad;
> >
> >         return 0;
> >
> > --
> > 2.45.1
> >
> >
