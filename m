Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="P+jtzKTo"
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7842172A
	for <selinux@vger.kernel.org>; Mon,  4 Dec 2023 10:24:45 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-4b2cfa42e16so512114e0c.3
        for <selinux@vger.kernel.org>; Mon, 04 Dec 2023 10:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1701714285; x=1702319085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZ7tJdlI/70JKLn0IdP/cM6gMyuHpmM4YLV1InhPfKA=;
        b=P+jtzKToIHq/V5jF0roIS1H2eGNWcPdHCLo3UoP8TfgTJJzDvont1DRIxUnkfuEwaZ
         PaJvobSvq/8p1ao8IW6kl7Huroj2bdzrc9s9KRsTZYFrowsykBR9e9vPAeGmBKgUYRmI
         8Do8ay7DWnrO6J6KBLE6fPGO8A6fFmZ8hpIRppdSQdKsvXfB9GILqj8KmJqRXwQVPqLW
         eAhHzUw5MkA7aR6xVyOybiYJTdeaFJOHS9Np3nZwu2BrlZTjp3p9+VfbTGXcB/+ZQ6tT
         RaLLBnQFSO6WcGx87R0y+Wd2YMv3S406qHGX45GEevuKWklboxYLMDDQUnPfdY3XYM8t
         s2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701714285; x=1702319085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZ7tJdlI/70JKLn0IdP/cM6gMyuHpmM4YLV1InhPfKA=;
        b=tJFIlqPh0eLsilx8shd6Wz8NruUHLyJrxdeoRIaK4j7vJ534TLKTY5zI7rnVxnC1Q/
         hZMAxXmNQx8MDQ6qN/hXy0jEGQ6VIWcm8n6DfiylZ1ZmL0RiGqwc7PaSxyVWB1qnrfE6
         T+388FGRpZnpTRir42OIVppT36b9+iOULZHSRrOx5OlrgFZmrLHdghBoiQECNWU7nwYk
         oJ//tQh4aaVWgC1jpmQaQii4F+d9FvlaOlr21Vx1gLHLr3vIqpKA3VhWelD3QqIyTFqu
         mxP02/Dn07xE14P8YEs8/4T0DogzgjhowULhulpCJL8biGIUdwoQaYXt9+7d2Bqib+8T
         hvMg==
X-Gm-Message-State: AOJu0YyzulZFkyuHFvg7EJG3Lc1YLjDXbcH0Ntr8r2kM5ObUq4obFcwk
	W5I3XWF7v1lp1p6ZHmEP5ZQRk8noyJehtrfMlPk=
X-Google-Smtp-Source: AGHT+IFV3BD/qIAXRCdmPIWKOSw+jkaPbOYCwM5I/SFHaQSl8mSkhqBr4ZGrmDIAemBNTakc50wMyGtdo3rH2u5sV/4=
X-Received: by 2002:a05:6122:8c6:b0:4b2:c554:fbb4 with SMTP id
 6-20020a05612208c600b004b2c554fbb4mr2747645vkg.22.1701714284904; Mon, 04 Dec
 2023 10:24:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <877cluszxo.fsf@redhat.com> <20231204164558.43667-1-lautrbach@redhat.com>
 <CAP+JOzSK+p9Fm49ApqA+_V2ro6DADJH9Y0onjwpX7W01+8mgOA@mail.gmail.com>
In-Reply-To: <CAP+JOzSK+p9Fm49ApqA+_V2ro6DADJH9Y0onjwpX7W01+8mgOA@mail.gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Mon, 4 Dec 2023 19:24:34 +0100
Message-ID: <CAJ2a_DcL-Dyby6rGjq23sDmdm+Mk2_KNvM0-iHq=paOQO0RHAQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "libsepol/tests: rename bool indentifiers"
To: James Carter <jwcart2@gmail.com>
Cc: Petr Lautrbach <lautrbach@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 4 Dec 2023 at 19:20, James Carter <jwcart2@gmail.com> wrote:
>
> On Mon, Dec 4, 2023 at 11:46=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.=
com> wrote:
> >
> > This reverts commit 893b50c6ce661f3ee339145e76a0bbfa199671c3.
> >
> > 61f21385004 ("libsepol: rename struct member") broke build of SETools:
> >
> > setools/policyrep.c: In function =E2=80=98__pyx_pf_7setools_9policyrep_=
23ConditionalExprIterator___next__=E2=80=99:
> > setools/policyrep.c:27857:138: error: =E2=80=98cond_expr_t=E2=80=99 {ak=
a =E2=80=98struct cond_expr=E2=80=99} has no member named =E2=80=98bool=E2=
=80=99; did you mean =E2=80=98boolean=E2=80=99?
> > 27857 |     __pyx_t_3 =3D __pyx_f_7setools_9policyrep_13SELinuxPolicy_b=
oolean_value_to_datum(__pyx_v_self->__pyx_base.policy, (__pyx_v_self->curr-=
>bool - 1)); if (unlikely(PyErr_Occurred())) __PYX_ERR(1, 336, __pyx_L1_err=
or)
> >       |                                                                =
                                                                          ^=
~~~
> >       |
> >
> > Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
>
> Also need to revert 513fc1570c16924080740b23fa34343ef64a90c0
> Plus there is a couple of new uses in policy_validate.c and one in
> checkpolicy/policy_define.c that need to be corrected.
>
> Thanks,
> Jim

Could you consider https://github.com/SELinuxProject/setools/pull/113
as an alternative?

>
> > ---
> >  libsepol/tests/test-linker-cond-map.c | 24 ++++++++++++------------
> >  1 file changed, 12 insertions(+), 12 deletions(-)
> >
> > diff --git a/libsepol/tests/test-linker-cond-map.c b/libsepol/tests/tes=
t-linker-cond-map.c
> > index 142066669c0c..6ea0e4c2ac6b 100644
> > --- a/libsepol/tests/test-linker-cond-map.c
> > +++ b/libsepol/tests/test-linker-cond-map.c
> > @@ -51,7 +51,7 @@
> >   */
> >
> >  typedef struct test_cond_expr {
> > -       const char *boolean;
> > +       const char *bool;
> >         uint32_t expr_type;
> >  } test_cond_expr_t;
> >
> > @@ -69,18 +69,18 @@ static void test_cond_expr_mapping(policydb_t * p, =
avrule_decl_t * d, test_cond_
> >                 CU_ASSERT_FATAL(expr !=3D NULL);
> >
> >                 CU_ASSERT(expr->expr_type =3D=3D bools[i].expr_type);
> > -               if (bools[i].boolean) {
> > -                       CU_ASSERT(strcmp(p->sym_val_to_name[SYM_BOOLS][=
expr->boolean - 1], bools[i].boolean) =3D=3D 0);
> > +               if (bools[i].bool) {
> > +                       CU_ASSERT(strcmp(p->sym_val_to_name[SYM_BOOLS][=
expr->boolean - 1], bools[i].bool) =3D=3D 0);
> >                 }
> >                 expr =3D expr->next;
> >         }
> >  }
> >
> > -static void test_bool_state(policydb_t * p, const char *boolean, int s=
tate)
> > +static void test_bool_state(policydb_t * p, const char *bool, int stat=
e)
> >  {
> >         cond_bool_datum_t *b;
> >
> > -       b =3D hashtab_search(p->p_bools.table, boolean);
> > +       b =3D hashtab_search(p->p_bools.table, bool);
> >         CU_ASSERT_FATAL(b !=3D NULL);
> >         CU_ASSERT(b->state =3D=3D state);
> >  }
> > @@ -100,7 +100,7 @@ void base_cond_tests(policydb_t * base)
> >         test_sym_presence(base, "g_b_bool_1", SYM_BOOLS, SCOPE_DECL, de=
cls, 1);
> >         test_bool_state(base, "g_b_bool_1", 0);
> >         /* conditional expression mapped correctly */
> > -       bools[0].boolean =3D "g_b_bool_1";
> > +       bools[0].bool =3D "g_b_bool_1";
> >         bools[0].expr_type =3D COND_BOOL;
> >         test_cond_expr_mapping(base, d, bools, 1);
> >
> > @@ -110,7 +110,7 @@ void base_cond_tests(policydb_t * base)
> >         test_sym_presence(base, "o1_b_bool_1", SYM_BOOLS, SCOPE_DECL, d=
ecls, 1);
> >         test_bool_state(base, "o1_b_bool_1", 1);
> >         /* conditional expression mapped correctly */
> > -       bools[0].boolean =3D "o1_b_bool_1";
> > +       bools[0].bool =3D "o1_b_bool_1";
> >         bools[0].expr_type =3D COND_BOOL;
> >         test_cond_expr_mapping(base, d, bools, 1);
> >
> > @@ -128,7 +128,7 @@ void module_cond_tests(policydb_t * base)
> >         test_sym_presence(base, "g_m1_bool_1", SYM_BOOLS, SCOPE_DECL, d=
ecls, 1);
> >         test_bool_state(base, "g_m1_bool_1", 1);
> >         /* conditional expression mapped correctly */
> > -       bools[0].boolean =3D "g_m1_bool_1";
> > +       bools[0].bool =3D "g_m1_bool_1";
> >         bools[0].expr_type =3D COND_BOOL;
> >         test_cond_expr_mapping(base, d, bools, 1);
> >
> > @@ -138,7 +138,7 @@ void module_cond_tests(policydb_t * base)
> >         test_sym_presence(base, "o1_m1_bool_1", SYM_BOOLS, SCOPE_DECL, =
decls, 1);
> >         test_bool_state(base, "o1_m1_bool_1", 0);
> >         /* conditional expression mapped correctly */
> > -       bools[0].boolean =3D "o1_m1_bool_1";
> > +       bools[0].bool =3D "o1_m1_bool_1";
> >         bools[0].expr_type =3D COND_BOOL;
> >         test_cond_expr_mapping(base, d, bools, 1);
> >
> > @@ -150,11 +150,11 @@ void module_cond_tests(policydb_t * base)
> >         test_bool_state(base, "g_m2_bool_1", 1);
> >         test_bool_state(base, "g_m2_bool_2", 0);
> >         /* conditional expression mapped correctly */
> > -       bools[0].boolean =3D "g_m2_bool_1";
> > +       bools[0].bool =3D "g_m2_bool_1";
> >         bools[0].expr_type =3D COND_BOOL;
> > -       bools[1].boolean =3D "g_m2_bool_2";
> > +       bools[1].bool =3D "g_m2_bool_2";
> >         bools[1].expr_type =3D COND_BOOL;
> > -       bools[2].boolean =3D NULL;
> > +       bools[2].bool =3D NULL;
> >         bools[2].expr_type =3D COND_AND;
> >         test_cond_expr_mapping(base, d, bools, 3);
> >  }
> > --
> > 2.41.0
> >
> >
>
