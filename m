Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B52D19A296
	for <selinux@vger.kernel.org>; Mon, 17 Jun 2024 18:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647369; cv=none; b=DFnBCZGxyQJxtt5iczwlLnbBhcvldOgHldX1B1ZLKxdiz/j1ofE3lLggWSLLH312GwQ1gBWOYcV/o3ZsEBUC6zBhcyyCcXwfLo/pHE7CNZ7Jbn2fSlKZ4hDsqMOFgQlYhHBipnfGVwb8O6YIY+RV8tTUST7ytCia6x5EnrqcuzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647369; c=relaxed/simple;
	bh=QVy89VHB8BdlB/j9XBqvQV4IrdCt6UcLYdzO5mNI8rQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EflARN08oxgNuu3lahCH0grtbtISYBp9PXxnkK4RnKzHY8pCHOsROQ4QxdjRS7l2NiQaayDn4PZlDZDJi+r7ySIyZr1kBZo3XlZ8lxytQmnF9T+qE6yIWPKJoBSq9c2tQ6+jlQE6z3UNPC3j4bLiXORN0d6uankJrdY8yqIuTto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vcf0OeHH; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vcf0OeHH"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3d24724514eso2745655b6e.0
        for <selinux@vger.kernel.org>; Mon, 17 Jun 2024 11:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718647367; x=1719252167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/we7fKHi/+/c+dG1KHfMpJPBaa8hX5m33WOT/XKjs1o=;
        b=Vcf0OeHHqjxEziKOB8gEDpi9WPC+uhBvubcIpyyULPkJ9YdgTlBIb4sPwL4vI84z37
         P0JtJPGu03jkZKBHeQqUIRgj9ZwhPXax5VXuoBZVhfToReHfC1bgB+SXvB/hPHcf7PHf
         ArWBzYc3FNkAALNPRSQGuf2sLvOGv7373f30FQos1eM1UPt6vPzHcn3c3/CqUWER0fFu
         UoP6uKxCTZe6EYNOFLevBXBbjVtVo9zY1auVKlOExsXiCqGt91zA/o1kNBHRQxc83yKx
         8pEqpyxZ5RsQPukxYzLFBSH6Wp4nfOM4r2ICSN6/N6VOhHBsrjDfGm9VngKC9oQjCuJ9
         4QXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718647367; x=1719252167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/we7fKHi/+/c+dG1KHfMpJPBaa8hX5m33WOT/XKjs1o=;
        b=mAnhwO/C7iAvlggp2sFeJPxSD6+quIX2t8otZft2JDi+rLggF5oBwIFj+lotfM/Chw
         o3IqZmkfvFerUKLxwsWL42G8ui8ULzXHCYUgbafm68m0CXLAxBKkxvSo3jauiC5OW/qO
         PRFIm4++P+qV6t8MJT2cJAx2ov5mc7RkZNrqWyAydVvQs3VT81eZmPcdtopf7DSuIXJt
         wqqpdKkU8ia8mjkbAeuh2hQGucC+Hs4evo4NwJe5MtRw3hddpOsqpphL1UW/iPov9YqC
         i/fiB1iUKJP2RM7wpzVtQH1ergxNOoqVclHcTHDWNJytGCY5HXDAFlZ9qJkwgHksZKU3
         GHHw==
X-Gm-Message-State: AOJu0YxStLvj4/Z7Lp4wBtBLqGg+cU2AH6u7Qx0Tw80ALYLN450UY0TE
	FWnOtE0FEC7a8CozGqNB6L2CMP8lotfRK+RHN/wztQrEJWWEwHGvJIjZJ9AbzGHffd1pEtARCr8
	MKH2RFhMyb1Wn0O3F/aV9T14PZ8rBcXI/
X-Google-Smtp-Source: AGHT+IHKvYmeN39va1ou3qKcezzKC0TDxUtL4H+ukfBVIa6/6Er7laxOfIZReDUxdRaC6Mc1WyfllCjQF5bEAsNlewM=
X-Received: by 2002:a05:6808:201d:b0:3d4:3d71:1783 with SMTP id
 5614622812f47-3d43d711854mr2276632b6e.33.1718647366894; Mon, 17 Jun 2024
 11:02:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240615132525.36358-1-cgoettsche@seltendoof.de>
 <CAJ2a_Dfbh9JTDQfSHV=0HAcP7QnuNqLquhwuLc2TWhTGN9Dhpw@mail.gmail.com> <33ac8211c1bb038e8ed535e83937f01d@seltendoof.de>
In-Reply-To: <33ac8211c1bb038e8ed535e83937f01d@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 17 Jun 2024 14:02:35 -0400
Message-ID: <CAP+JOzSgo_762PHU5-Vfa1N4hHYpwzuRO5dcAX4giFo_MhLXeg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: check scope permissions refer to valid class
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
Cc: selinux@vger.kernel.org, cgzones@googlemail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 16, 2024 at 2:44=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Validate that the permission maps in the scope index refer to a valid
> > class datum.  Otherwise since commit 52e5c306 ("libsepol: move
> > unchanged
> > data out of loop") this can lead to a NULL dereference in the class
> > existence check during linking.
> >
> > Reported-by: oss-fuzz (issue 69655)
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  libsepol/src/policydb_validate.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/libsepol/src/policydb_validate.c
> > b/libsepol/src/policydb_validate.c
> > index 9746f562..0216410c 100644
> > --- a/libsepol/src/policydb_validate.c
> > +++ b/libsepol/src/policydb_validate.c
> > @@ -1467,6 +1467,8 @@ bad:
> >
> >  static int validate_scope_index(sepol_handle_t *handle, const
> > scope_index_t *scope_index, validate_t flavors[])
> >  {
> > +       uint32_t i;
> > +
> >         if (!ebitmap_is_empty(&scope_index->scope[SYM_COMMONS]))
> >                 goto bad;
> >         if (validate_ebitmap(&scope_index->p_classes_scope,
> > &flavors[SYM_CLASSES]))
> > @@ -1483,8 +1485,10 @@ static int validate_scope_index(sepol_handle_t
> > *handle, const scope_index_t *sco
> >                 goto bad;
> >         if (validate_ebitmap(&scope_index->p_cat_scope,
> > &flavors[SYM_CATS]))
> >                 goto bad;
> > -       if (scope_index->class_perms_len > flavors[SYM_CLASSES].nprim)
>
> Since classes should not have gaps, this could be a simple off-by-one,
> cause class_perms_len is 0-based while nprim is 1-based. So
>
>      scope_index->class_perms_len >=3D flavors[SYM_CLASSES].nprim
>
> might suffice, but I am unable to test currently though.
>

I did some testing and the above does not suffice. In the fuzzer
testcase, nprim =3D 32 and class_perms_len =3D 1, but
p_class_val_to_name[0] is NULL.
The patch you sent works.
Thanks,
Jim


> > -               goto bad;
> > +
> > +       for (i =3D 0; i < scope_index->class_perms_len; i++)
> > +               if (validate_value(i + 1, &flavors[SYM_CLASSES]))
> > +                       goto bad;
> >
> >         return 0;
>
