Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGa4hbCp"
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4ACB7
	for <selinux@vger.kernel.org>; Tue, 12 Dec 2023 08:44:39 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50bf1e32571so6915830e87.2
        for <selinux@vger.kernel.org>; Tue, 12 Dec 2023 08:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702399477; x=1703004277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/KrYrimbyGF5vammuZ7o8SqsZvp6JpwFZA9bLS1rBQk=;
        b=QGa4hbCpK7zyBdSgtnJBBeQwKIAF0JZ6Bz8DwyoY4VIMfhSA+9I9/kslGauagIS0jQ
         G+soZ48NmLreaMOJ23cwj43rxlKcF5qs257X4Q3TqWVnWCuslxMbiXtc6b7Q4IcBhe6X
         N7KlO5vHMOpvyKzTW4c/v1cT7DMRhCT/8MoxjqgIHk9bGR1jZDLgLCl+Akzt6ISnB8HJ
         15a6zIbmeYiKhE0YsPXVpojOY566CGKFV45Pz6pvz+vR+8l5V486Waoytjy01os4Tu7u
         hpQBYIq5tJlqwWvPrECvvcHVuVfMS0n87HKKsuLDq3JUaVDWDvpBX45Z0RhWABbp/qLn
         P2og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702399477; x=1703004277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/KrYrimbyGF5vammuZ7o8SqsZvp6JpwFZA9bLS1rBQk=;
        b=TThLqcQsmNiFX/wSL3sTnd87gQrXSt1NsDEkbxuv5h0h7o++A1s0dD0n+aOIDL/u5p
         vHICdBSQ09l1Hmp4eyN9kyo1sFIMLm/Q9z95nl72mYFKbg19957ODJpXfq+AZYN5iaz7
         TPOq741CBG309LdGqe48IlLLW2PxrvN9m+OLhV8AVTsZiIaLKV0TgnS21HFyUKxqeNP2
         wh1vYxhgJ6ao2KCB1F/Zrk/4o1K6V0Ee6U4ZsuWZXsSs0v6nNH+NQESByfob33P8DRkX
         fyrfV3nnRKyK1KxE6qYYgVVSN5Ik1+ajJzI6Zigx9sh89LulQkRCkD+I0p1FkErYDsCj
         Owpw==
X-Gm-Message-State: AOJu0YwXSRlRoQkhuACGLtSNpV84OTK98WopVi6+PQVl/+ZLfvSFbLj+
	sKKQ8jASiR3L5P4D5vQ4icRZ4sqIXA1b439vFPxTvI+n
X-Google-Smtp-Source: AGHT+IE6aCu4dvR9QWp/x/bS27cNkCcRq6xtNAc7bRL4xKxvqv0QsvpiOG+WU3oJaeKG72jmWCZOKtvilmkbIvbFgc8=
X-Received: by 2002:a05:6512:e9f:b0:50b:d764:8816 with SMTP id
 bi31-20020a0565120e9f00b0050bd7648816mr4122137lfb.98.1702399477449; Tue, 12
 Dec 2023 08:44:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211145544.125635-1-cgzones@googlemail.com> <CAP+JOzS9u-M2jRkUV0kTQeh-wLuz1YxANbD9iEFWA1WNxLnaRw@mail.gmail.com>
In-Reply-To: <CAP+JOzS9u-M2jRkUV0kTQeh-wLuz1YxANbD9iEFWA1WNxLnaRw@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 12 Dec 2023 11:44:26 -0500
Message-ID: <CAP+JOzSvt6hKU884yhu1oSnzSkB8Zx5RkuF5E6OEUi6oWn9ARA@mail.gmail.com>
Subject: Re: [PATCH] libsepol: validate empty common classes in scope indices
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 1:48=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Dec 11, 2023 at 9:55=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Validate no common classes inside scope indices are defined.
> >
> > Reported-by: oss-fuzz (issue 64849)
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> > This probably also resolves issue 64854, which I could not reproduce
> > locally.
> >
> > Supersedes https://patchwork.kernel.org/project/selinux/patch/202312081=
51831.48343-1-cgzones@googlemail.com/
> > ---
> >  libsepol/src/policydb_validate.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_v=
alidate.c
> > index bd8e9f8f..d86f885e 100644
> > --- a/libsepol/src/policydb_validate.c
> > +++ b/libsepol/src/policydb_validate.c
> > @@ -1344,6 +1344,8 @@ bad:
> >
> >  static int validate_scope_index(sepol_handle_t *handle, const scope_in=
dex_t *scope_index, validate_t flavors[])
> >  {
> > +       if (!ebitmap_is_empty(&scope_index->scope[SYM_COMMONS]))
> > +               goto bad;
> >         if (validate_ebitmap(&scope_index->p_classes_scope, &flavors[SY=
M_CLASSES]))
> >                 goto bad;
> >         if (validate_ebitmap(&scope_index->p_roles_scope, &flavors[SYM_=
ROLES]))
> > --
> > 2.43.0
> >
> >
