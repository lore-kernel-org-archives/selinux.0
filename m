Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDauI8GC"
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BEE10EF
	for <selinux@vger.kernel.org>; Fri,  8 Dec 2023 09:39:59 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50be10acaf9so2241655e87.1
        for <selinux@vger.kernel.org>; Fri, 08 Dec 2023 09:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702057198; x=1702661998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZgWwcqY7oTUmmQ75QV6/qNPwc46N14+T10pF/1j5EU=;
        b=aDauI8GCbV+b+5ReYrWiPEpzx+ZjDCwiGOXWGqjhrRm3F28r01ZijlfBRhx9wdy7z7
         fYig33XjwHithLLOeK8ORngMi0kfvu0bGlvvM0hgr4ayJ4PQhNXjx4mw09oSVNEvqQWF
         S8aRGmlRpn3m6q8jZEGNZo5XQPTdaQZXP+lAOFhFaLhsEklT5cv53w6yk0tuIyCbFyBm
         B/FO+jacdA783kXrUyhYvmC6O2Q6rtuF7dktor3Y84hu9vzd+3QpCcK4wSjh/4au31KR
         N2WupY28jaSq2GoQdeLBdBZlTjUljpY0SiEmHsyK8XhABxzFxIwE2qp5sxQhmRDLp9Rp
         aSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702057198; x=1702661998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZgWwcqY7oTUmmQ75QV6/qNPwc46N14+T10pF/1j5EU=;
        b=tcDFJUOJSbxlz+YZXrzMCaDw1y1VW5pO7NvJhXJmR0CmCarbLHQUv1FQFSpSoVC3sG
         e5mDHFJIj7eMxnAI23V5rYwLzPK86r8VWQJnrUmY2W1UzgGv4+yyz6gaXKbNRJA65+wq
         7Z/BLjGSJFBYrnPVXX1TSLnwyXBTlhDvBf5KGpjIWEM1YGua2QbdYfq8AypEsmAngYEA
         Gv/sP+AomaQEu8xf9VIYMeovW+Fe/+tBRx5PNiTnoNK2Wrli4XG+RwAfHQgR+zGh3In/
         2l02sBPHrnyQZY0QJysySdP7xZT2A3x3Uch25oOuDPJfHgRCjMbra7Yfqc396Qg/zHsw
         6Udw==
X-Gm-Message-State: AOJu0Yw8dH00dNK9SCMkvwojH1A0kO5PnkMiK65j0oCie2+Mzh+8j5p5
	cyH3BMuEepTZYY3zu/U1fdPOvohnnPskYYB7nJU=
X-Google-Smtp-Source: AGHT+IGYV3buF6GQJ1X53qKid15oM1iXBjI0srGJavFkyI+MEoe23VSQG2Foz4oZdiSP20L6YBwFKziOlYvSg42pM/s=
X-Received: by 2002:a05:6512:68c:b0:50b:f9b2:cfc with SMTP id
 t12-20020a056512068c00b0050bf9b20cfcmr348460lfe.30.1702057197050; Fri, 08 Dec
 2023 09:39:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207165319.63889-1-cgzones@googlemail.com> <CAEjxPJ4htnqzDyHFNR_aNJH-hrz_wbM=Z=NN7BjUQDrKBa8e9A@mail.gmail.com>
In-Reply-To: <CAEjxPJ4htnqzDyHFNR_aNJH-hrz_wbM=Z=NN7BjUQDrKBa8e9A@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 8 Dec 2023 12:39:45 -0500
Message-ID: <CAP+JOzRF-HcrVjihnngqXRbuPYTn2Ra8AU6swP4NXj7S7=n7Hw@mail.gmail.com>
Subject: Re: [RFC PATCH] libsepol: validate permission identifier length
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 11:06=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Dec 7, 2023 at 11:53=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Limit the maximum length of permission identifiers.  Otherwise
> > formatting an access vector might fail in the common used helper
> > sepol_av_to_string().
> >
> > The current longest permission within the Reference Policy is
> > x_application_data { paste_after_confirm } with a length of 19.
>
> Android has longer permission names. I'd rather just fix
> sepol_av_to_string() than impose some arbitrary limit here.
>

I agree.

Christian, something like your recent patch to avoid a fixed size
format buffer for xperms would be better.

Thanks for all your work.
Jim


> >
> > Reported-by: oss-fuzz (issue 64832)
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> > The oss-fuzz issue got closed by the latest fuzzer updates (due to
> > unrelated changes that invalid the current reproducer), but the issue i=
s
> > still valid.
> > ---
> >  libsepol/src/policydb_validate.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_v=
alidate.c
> > index bd8e9f8f..72681120 100644
> > --- a/libsepol/src/policydb_validate.c
> > +++ b/libsepol/src/policydb_validate.c
> > @@ -366,12 +366,30 @@ bad:
> >         return -1;
> >  }
> >
> > +static int validate_permission_wrapper(hashtab_key_t k, __attribute__(=
(unused)) hashtab_datum_t d, void *args)
> > +{
> > +       sepol_handle_t *handle =3D args;
> > +       const char *name =3D k;
> > +       size_t len =3D strlen(name);
> > +
> > +       if (len =3D=3D 0 || len >=3D 32)
> > +               goto bad;
> > +
> > +       return 0;
> > +
> > +bad:
> > +       ERR(handle, "Invalid permission");
> > +       return -1;
> > +}
> > +
> >  static int validate_common_datum(sepol_handle_t *handle, const common_=
datum_t *common, validate_t flavors[])
> >  {
> >         if (validate_value(common->s.value, &flavors[SYM_COMMONS]))
> >                 goto bad;
> >         if (common->permissions.table->nel =3D=3D 0 || common->permissi=
ons.nprim > PERM_SYMTAB_SIZE)
> >                 goto bad;
> > +       if (hashtab_map(common->permissions.table, validate_permission_=
wrapper, handle))
> > +               goto bad;
> >
> >         return 0;
> >
> > @@ -395,6 +413,8 @@ static int validate_class_datum(sepol_handle_t *han=
dle, const class_datum_t *cla
> >                 goto bad;
> >         if (class->permissions.nprim > PERM_SYMTAB_SIZE)
> >                 goto bad;
> > +       if (hashtab_map(class->permissions.table, validate_permission_w=
rapper, handle))
> > +               goto bad;
> >         if (validate_constraint_nodes(handle, class->permissions.nprim,=
 class->constraints, flavors))
> >                 goto bad;
> >         if (validate_constraint_nodes(handle, 0, class->validatetrans, =
flavors))
> > --
> > 2.43.0
> >
> >
>
