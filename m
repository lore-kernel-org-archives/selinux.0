Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A397C46D2A5
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 16:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784651813; cv=pass; b=F35Doq1NXA28anNQBTTf0CdilGmb04V8SiTVB9gZ+N+pTyFt92lwpaxct0v6r7xr4+Sl+38U+GmDD5612+k8Q27LZTtRANPOqo5IISw76nmOnBD2cEv8qGJD1O97h8l/kzGY6KI6zxfjte14QAmU22Gb2NVCJbixSKG0TNMluxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784651813; c=relaxed/simple;
	bh=k+rnNh4k9nnPwA2trn8Vhn7/U7IMjU1jsYsVzUf1w9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pfwtvS3mlChbUX3JzHdbvzgR3TD4T2rw8izGj+PLiolqHLzbxbQXYsizAFVBOL/MZGNmHcezJ6BJ3OKCTzEOqQTXXqoGqQJN5z1guoX13l7JIYQQl9F9shnN0tKK+yr+Gm7d2WMSwwVET+aLwIh1MWDdieofNHn5Z0MReoper9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrTuAwLg; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrTuAwLg"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c96c92c0980so5409014a12.3
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 09:36:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784651811; cv=none;
        d=google.com; s=arc-20260327;
        b=WEIHvwRLWHWraw4qfI7MlNJWOXxu2G7v+9iC2iVW877YHRIRzwhzB9XntUE59Etlks
         960BlgWFADkASwwyrW0Wb3xUZGrqYo7b9br/s1mSzgUPoTMXAQ0v/EDVjyC7y34dNJ/I
         deO1jeLLKtbmbSTVPbJKnSFTwJ8HQrc8FviV1G7I5Vqmgj1KxuB6c7jcbonVJs9gpFAi
         WLPmWehER4kRzrN0k0xt0zmBuABmBIOMYkfbO0QrNCyACc+q0r+U5B36vmMiOp+mQqVN
         8j5LUvhX/XI0x/0fxUqu+LHt3C2wxRUGSXnqemmFuw//ZPnXjFjIjApN2nZM3hyzDgpy
         pIsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x4Vcm5Byxd39U+h+a0TditSmP3afDO+9dfnVBnN2RTM=;
        fh=mMDxYY5wtlIekXoYIfjt6lvMWgTaMUwdwgsYDQ6qy3A=;
        b=Xwhiej1dnuf3nocxBSTqFWRgpkKggnsIy9QeL37eHFeAdv5sJ19cdyB+DeP6r3n7Fv
         YXoXSYWzUI7UCQHT7DlilyCp1ZPpypvEmJqtuOmB3jmalBuDi3NJwt/RIMwZ/SyQ7nC3
         OMYDZ9xIfq3AO+R/d4RXV3aoTVxKOR/pOYckwFx5gWLskQfM7xFCInGpg847YlDb1k/4
         HQq30MSZXMo9HCM0U2/OP3+EufDQ46FFIQcanJr6xac8XZJaYlGmlGuOK8YeQ1uMenOl
         4WSYZa5GB8bRt87QEgDwODFIjXh0nAHVACPkF/gmr/Tg7Qdg8CpZwQRaj95dbMOr5ahS
         bLNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784651811; x=1785256611; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x4Vcm5Byxd39U+h+a0TditSmP3afDO+9dfnVBnN2RTM=;
        b=WrTuAwLgZ6D7ZOHeC+uAEALeCL8CfrZ1Ls39zg+NDUcxa+hx7BsPOpytDgJl2QYLBu
         v0XUegjL7zSFY3+yl91SG3W3TcOcdFAdaeiODlGielr8ibdZ+WDSy9hFsDook8VHw9S2
         G4l8WEkF8WGVOGzIPp5g/5gFsUDdARu5J/F8m//4ydUKyxzyJehrLxnWOmk8BcLWHyuq
         xaTJUPclIS92+tmyMTT3KcSV0j2KyTSq60CIq1ORoNwEFJTrBydATlwUDTYJ/FYOjtEk
         Xs3Ix3GOgjRGyG4kIuzoM3TR+H7XPQRkdCVAJOfJ0EUsXA9LoeTzQDUw8IdWhR4PAlVE
         suig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784651811; x=1785256611;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x4Vcm5Byxd39U+h+a0TditSmP3afDO+9dfnVBnN2RTM=;
        b=M5C0fayde3zi6cHTzx3dRAVXych9SSifQAwsbixHCu6i8rh7Nm3kw16R2c1PQSjUWQ
         dfc1mfbMbx9B1A5Zp8KGE43qotQuDqyyzlBj2BYvy6EyXzzuVHf714Co6mdCTFExkGLk
         XMrSSc1LnBPcH6l4QzLuQfZANiqTctLNR7CWemxn8Zb2D+bCY3Jntgqc+lU/IeeYf/Cg
         Op1r5OLozOhbBlA8BQEb48DgILDqkRBOdXIL53yUfvhhXhcO9uDR2lYocAHDufSQmPPy
         S/SNMm0R7MXdZo54MKl37w8Wg1fhbtvp7Mat33nCrFs3Rdrdvu/x35l/Yg4X1HNIQT1C
         bPqA==
X-Gm-Message-State: AOJu0YwgQRGfRJBJ41ovSGT9NzjNdAlctgsCwS27hRwIrDD/cCO/YIcd
	OgSM4rfDiAWHlUTFtQUH5i7qoz3qh45S8HrEzWR8Ku/fP8suWAru28JnxHbD6KUXrjtFmgvDilY
	2rsHzXSDCZhrjrfJgwN1B7vAe5piaKi4=
X-Gm-Gg: AfdE7ckCZOPayBYPY42cC5h6N/WCckZBRi22Yv+10N3NKsnuy9mWFrvj/c89p2hXxpf
	8sEaq4fWgNFbUdaY8VfThHocAbDjIUAYb4v01DYvAq/uLCokv3AfujLqb/ReB5B07RcETIB1AT2
	aOCXImFHNX0iEoQeR8kzMt6mlKvTtkPyi+mtONBP1R18TPtIAV0/y9ujIOhm+GB2ZOel0Ffdl3m
	Salu0aTpOP+OYMnZlOvMiIdeh9FnZcmqdSuH6Uzr95uwGxgOk1a+vGQawIxMQ==
X-Received: by 2002:a05:6a21:a382:b0:3c3:a17c:1f77 with SMTP id
 adf61e73a8af0-3c3ada7d283mr20231165637.51.1784651810840; Tue, 21 Jul 2026
 09:36:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721021127.1313453-1-tweek@google.com> <20260721021127.1313453-2-tweek@google.com>
 <CAEjxPJ6zcYW7_mGPhnTNV5oq-8uxsmDJxnXFoZjxyYYg7ce76A@mail.gmail.com>
In-Reply-To: <CAEjxPJ6zcYW7_mGPhnTNV5oq-8uxsmDJxnXFoZjxyYYg7ce76A@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 21 Jul 2026 12:36:39 -0400
X-Gm-Features: AUfX_mzveRVCBAdbc0ae0qUQIQDfGECglD2wpteojud1kv8qGD21CacknrYUecE
Message-ID: <CAEjxPJ7OXC8MjBN_o6jm9W6Ewm6u9gj+sxKfy_wYaxt1+qW6=Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] libselinux: support multiple contexts for the file backend
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: selinux@vger.kernel.org, James Carter <jwcart2@gmail.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 11:45=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Jul 20, 2026 at 10:11=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@go=
ogle.com> wrote:
> >
> > Update the file labeling backend to support specifying multiple
> > SELABEL_OPT_PATH options in selabel_open().
> >
> > All provided paths are stored in rec->spec_files and processed during
> > initialization. Derived files, such as substitutions (.subs, .subs_dist=
)
> > and auxiliary contexts (.homedirs, .local), continue to be based on the
> > first path (or default selinux_file_context_path()) when enabled.
> >
> > Duplicate checking logic is refactored into a helper function
> > report_dups(). A duplicate with the same specification result is not
> > fatal anymore, but a warning is still logged.
> >
> > Additionally, duplicate validation is moved after all files (including
> > .homedirs and .local) are loaded and sorted. For single file context se=
tups,
> > the only difference in behavior is that duplicate validation now extend=
s to
> > fc.homedirs and fc.local.
> >
> > A similar multiple files setup has been used in Android for 9+ years.
> >
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> > ---
> >  libselinux/src/label_file.c | 216 ++++++++++++++++++++++--------------
> >  1 file changed, 132 insertions(+), 84 deletions(-)
> >
> > diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> > index eb2e66da..902c9a25 100644
> > --- a/libselinux/src/label_file.c
> > +++ b/libselinux/src/label_file.c
> > @@ -1526,66 +1584,56 @@ static int init(struct selabel_handle *rec, con=
st struct selinux_opt *opts,
> >                                            &data->subs_num, &data->subs=
_alloc);
> >                 if (status)
> >                         goto finish;
> > -               path =3D selinux_file_context_path();
> > +               rec->spec_files[0] =3D strdup(selinux_file_context_path=
());
> > +               if (rec->spec_files[0] =3D=3D NULL)
> > +                       goto finish;
> >         } else {
> > -               snprintf(subs_file, sizeof(subs_file), "%s.subs_dist", =
path);
> > +               snprintf(subs_file, sizeof(subs_file), "%s.subs_dist",
> > +                        rec->spec_files[0]);
> >                 status =3D selabel_subs_init(subs_file, rec->digest,
> >                                            &data->dist_subs,
> >                                            &data->dist_subs_num,
> >                                            &data->dist_subs_alloc);
> >                 if (status)
> >                         goto finish;
> > -               snprintf(subs_file, sizeof(subs_file), "%s.subs", path)=
;
> > +               snprintf(subs_file, sizeof(subs_file), "%s.subs",
> > +                        rec->spec_files[0]);
> >                 status =3D selabel_subs_init(subs_file, rec->digest, &d=
ata->subs,
> >                                            &data->subs_num, &data->subs=
_alloc);
> >                 if (status)
> >                         goto finish;
> >         }
> > -
> >  #endif
> >
> > -       if (!path) {
> > -               errno =3D EINVAL;
> > -               goto finish;
> > -       }
> > -
> > -       rec->spec_files =3D calloc(1, sizeof(path));
> > -       if (!rec->spec_files)
> > -               goto finish;
> > -       rec->spec_files[0] =3D strdup(path);
> > -       if (!rec->spec_files[0])
> > -               goto finish;
> > -       rec->spec_files_len =3D 1;
> > -
> >         /*
> > -        * The do detailed validation of the input and fill the spec ar=
ray
> > +        * Process each input file.
> >          */
> > -       status =3D process_file(path, NULL, rec, prefix, rec->digest, 0=
);
> > -       if (status)
> > -               goto finish;
> > -
> > -       if (rec->validating) {
> > -               sort_specs(data);
> > -
> > -               status =3D nodups_spec_node(data->root, path);
> > +       for (i =3D 0; i < num_paths; i++) {
> > +               status =3D process_file(rec->spec_files[i], NULL, rec, =
prefix,
> > +                                     rec->digest, i);
>
> process_file() last argument is uint8_t; i and num_paths are size_t.
> Need to cap the max num_paths somewhere or change the type.
>
> >                 if (status)
> >                         goto finish;
> >         }
> >
> >         if (!baseonly) {
> > -               status =3D process_file(path, "homedirs", rec, prefix,
> > -                                     rec->digest, 1);
> > +               status =3D process_file(rec->spec_files[0], "homedirs",=
 rec,
> > +                                     prefix, rec->digest, num_paths + =
1);
>
> Ditto.

Also, could use num_paths here since i ends at num_paths - 1.

>
> >                 if (status && errno !=3D ENOENT)
> >                         goto finish;
> >
> > -               status =3D process_file(path, "local", rec, prefix, rec=
->digest,
> > -                                     2);
> > +               status =3D process_file(rec->spec_files[0], "local", re=
c, prefix,
> > +                                     rec->digest, num_paths + 2);
>
> Ditto

And this could be num_path + 1.
>
> >                 if (status && errno !=3D ENOENT)
> >                         goto finish;
> >         }
> >
> > -       if (!rec->validating || !baseonly)
> > -               sort_specs(data);
> > +       sort_specs(data);
> > +
> > +       if (rec->validating) {
> > +               status =3D nodups_spec_node(rec, data->root);
> > +               if (status)
> > +                       goto finish;
> > +       }
> >
> >         digest_gen_hash(rec->digest);
> >
> > --
> > 2.55.0.229.g6434b31f56-goog
> >
