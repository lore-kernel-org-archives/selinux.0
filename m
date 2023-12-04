Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHMUHiP3"
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E679EB0
	for <selinux@vger.kernel.org>; Mon,  4 Dec 2023 10:31:47 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6d87cf8a297so835169a34.2
        for <selinux@vger.kernel.org>; Mon, 04 Dec 2023 10:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701714707; x=1702319507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kZpiGcX1yYX+f5dCGUeL5KfDDGQynoSMaY9/7NCoxI=;
        b=JHMUHiP3L2eYHjoWUFaiIhhM5O2xsuP3yoBC8lqPwkSOqBJuBpexTjci8APbMZesAg
         SXXElMcxNjmc1T5znCQ41G6xeGrD1E4fJHHvw0vy0d0lAdALrEbZRDzW7vZm7JDF+UXX
         +qn31JfS/zCxyX96BDekiC+vhwoeYxxPUTVIO+j9cxFBEm7aznP/U+BotPRA/nhWFLh3
         Pd9yeTmsCq4KOBNsw777/san0KHGTRjRDjkvuGnmzVnMNpco3XP4RGZ6PNp5tmhNBpEO
         X4DPNZ3IfcMnit6gfZy5nhfkJKpcbIndGitaGuFFh2WNuEZbkhfeSuNJC8OUiGcrm4ZX
         kclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701714707; x=1702319507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7kZpiGcX1yYX+f5dCGUeL5KfDDGQynoSMaY9/7NCoxI=;
        b=FneIkR+S8jUJ5TfntySu1Rycl8ZExhkKcc8Go2+ywYgwn2PT6wL6HMzB2D4isAqatq
         aIFuJHhOMTXhc0NNFzvzpplxLTIeT2LoedYE3xez9E7KEUg4ibTRgiakEMgdGatwW6fL
         v0A9NdhAG5AMmmU5BTZp7Bi4+VGNz6PAXyCVCRpBhz0MhR/5ZSu1hcArQugneAwvet0f
         gMFSf/xxLh7puK7qFL4OVSt+MjRQEHgSYgoBNwfyrg/PxBEf5FPQWixSqv+Na3wongsC
         xMoh/yyPNjfhrpMpn92NV5t5/Cyr9cj0w8EZaq3RtFL7t+aUPPzo3K8YosY1xSoIhwnF
         2Iug==
X-Gm-Message-State: AOJu0Yy66KSuTb/gMBcLvp3FqQ0T64De6KIcpF4FJtr4WFxJHfYZmAsJ
	AyhS+43gI7hJ+B28wOsIYj/Y6QJgK9uXF90S4ka9ux22
X-Google-Smtp-Source: AGHT+IF+insmj5FZrY+zjyhl2lhX1cU3iLZTRMaPJTxOAGWcz51CQAg93bNEwq0LSIagc92v5FsW2kTIvCErWkDRZe8=
X-Received: by 2002:a05:6830:6504:b0:6d8:298e:e54b with SMTP id
 cm4-20020a056830650400b006d8298ee54bmr2746657otb.6.1701714707189; Mon, 04 Dec
 2023 10:31:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <877cluszxo.fsf@redhat.com> <20231204164558.43667-1-lautrbach@redhat.com>
 <CAP+JOzSK+p9Fm49ApqA+_V2ro6DADJH9Y0onjwpX7W01+8mgOA@mail.gmail.com> <CAJ2a_DcL-Dyby6rGjq23sDmdm+Mk2_KNvM0-iHq=paOQO0RHAQ@mail.gmail.com>
In-Reply-To: <CAJ2a_DcL-Dyby6rGjq23sDmdm+Mk2_KNvM0-iHq=paOQO0RHAQ@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 4 Dec 2023 13:31:34 -0500
Message-ID: <CAP+JOzS-WEGCWjZC_yRdYADhDGHgZBs3G19=2UuhCJgveJF8yQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "libsepol/tests: rename bool indentifiers"
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: Petr Lautrbach <lautrbach@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 1:24=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Mon, 4 Dec 2023 at 19:20, James Carter <jwcart2@gmail.com> wrote:
> >
> > On Mon, Dec 4, 2023 at 11:46=E2=80=AFAM Petr Lautrbach <lautrbach@redha=
t.com> wrote:
> > >
> > > This reverts commit 893b50c6ce661f3ee339145e76a0bbfa199671c3.
> > >
> > > 61f21385004 ("libsepol: rename struct member") broke build of SETools=
:
> > >
> > > setools/policyrep.c: In function =E2=80=98__pyx_pf_7setools_9policyre=
p_23ConditionalExprIterator___next__=E2=80=99:
> > > setools/policyrep.c:27857:138: error: =E2=80=98cond_expr_t=E2=80=99 {=
aka =E2=80=98struct cond_expr=E2=80=99} has no member named =E2=80=98bool=
=E2=80=99; did you mean =E2=80=98boolean=E2=80=99?
> > > 27857 |     __pyx_t_3 =3D __pyx_f_7setools_9policyrep_13SELinuxPolicy=
_boolean_value_to_datum(__pyx_v_self->__pyx_base.policy, (__pyx_v_self->cur=
r->bool - 1)); if (unlikely(PyErr_Occurred())) __PYX_ERR(1, 336, __pyx_L1_e=
rror)
> > >       |                                                              =
                                                                           =
 ^~~~
> > >       |
> > >
> > > Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
> >
> > Also need to revert 513fc1570c16924080740b23fa34343ef64a90c0
> > Plus there is a couple of new uses in policy_validate.c and one in
> > checkpolicy/policy_define.c that need to be corrected.
> >
> > Thanks,
> > Jim
>
> Could you consider https://github.com/SELinuxProject/setools/pull/113
> as an alternative?
>
Obviously, not reverting would be preferable if at all possible.
Jim

> >
> > > ---
> > >  libsepol/tests/test-linker-cond-map.c | 24 ++++++++++++------------
> > >  1 file changed, 12 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/libsepol/tests/test-linker-cond-map.c b/libsepol/tests/t=
est-linker-cond-map.c
> > > index 142066669c0c..6ea0e4c2ac6b 100644
> > > --- a/libsepol/tests/test-linker-cond-map.c
> > > +++ b/libsepol/tests/test-linker-cond-map.c
> > > @@ -51,7 +51,7 @@
> > >   */
> > >
> > >  typedef struct test_cond_expr {
> > > -       const char *boolean;
> > > +       const char *bool;
> > >         uint32_t expr_type;
> > >  } test_cond_expr_t;
> > >
> > > @@ -69,18 +69,18 @@ static void test_cond_expr_mapping(policydb_t * p=
, avrule_decl_t * d, test_cond_
> > >                 CU_ASSERT_FATAL(expr !=3D NULL);
> > >
> > >                 CU_ASSERT(expr->expr_type =3D=3D bools[i].expr_type);
> > > -               if (bools[i].boolean) {
> > > -                       CU_ASSERT(strcmp(p->sym_val_to_name[SYM_BOOLS=
][expr->boolean - 1], bools[i].boolean) =3D=3D 0);
> > > +               if (bools[i].bool) {
> > > +                       CU_ASSERT(strcmp(p->sym_val_to_name[SYM_BOOLS=
][expr->boolean - 1], bools[i].bool) =3D=3D 0);
> > >                 }
> > >                 expr =3D expr->next;
> > >         }
> > >  }
> > >
> > > -static void test_bool_state(policydb_t * p, const char *boolean, int=
 state)
> > > +static void test_bool_state(policydb_t * p, const char *bool, int st=
ate)
> > >  {
> > >         cond_bool_datum_t *b;
> > >
> > > -       b =3D hashtab_search(p->p_bools.table, boolean);
> > > +       b =3D hashtab_search(p->p_bools.table, bool);
> > >         CU_ASSERT_FATAL(b !=3D NULL);
> > >         CU_ASSERT(b->state =3D=3D state);
> > >  }
> > > @@ -100,7 +100,7 @@ void base_cond_tests(policydb_t * base)
> > >         test_sym_presence(base, "g_b_bool_1", SYM_BOOLS, SCOPE_DECL, =
decls, 1);
> > >         test_bool_state(base, "g_b_bool_1", 0);
> > >         /* conditional expression mapped correctly */
> > > -       bools[0].boolean =3D "g_b_bool_1";
> > > +       bools[0].bool =3D "g_b_bool_1";
> > >         bools[0].expr_type =3D COND_BOOL;
> > >         test_cond_expr_mapping(base, d, bools, 1);
> > >
> > > @@ -110,7 +110,7 @@ void base_cond_tests(policydb_t * base)
> > >         test_sym_presence(base, "o1_b_bool_1", SYM_BOOLS, SCOPE_DECL,=
 decls, 1);
> > >         test_bool_state(base, "o1_b_bool_1", 1);
> > >         /* conditional expression mapped correctly */
> > > -       bools[0].boolean =3D "o1_b_bool_1";
> > > +       bools[0].bool =3D "o1_b_bool_1";
> > >         bools[0].expr_type =3D COND_BOOL;
> > >         test_cond_expr_mapping(base, d, bools, 1);
> > >
> > > @@ -128,7 +128,7 @@ void module_cond_tests(policydb_t * base)
> > >         test_sym_presence(base, "g_m1_bool_1", SYM_BOOLS, SCOPE_DECL,=
 decls, 1);
> > >         test_bool_state(base, "g_m1_bool_1", 1);
> > >         /* conditional expression mapped correctly */
> > > -       bools[0].boolean =3D "g_m1_bool_1";
> > > +       bools[0].bool =3D "g_m1_bool_1";
> > >         bools[0].expr_type =3D COND_BOOL;
> > >         test_cond_expr_mapping(base, d, bools, 1);
> > >
> > > @@ -138,7 +138,7 @@ void module_cond_tests(policydb_t * base)
> > >         test_sym_presence(base, "o1_m1_bool_1", SYM_BOOLS, SCOPE_DECL=
, decls, 1);
> > >         test_bool_state(base, "o1_m1_bool_1", 0);
> > >         /* conditional expression mapped correctly */
> > > -       bools[0].boolean =3D "o1_m1_bool_1";
> > > +       bools[0].bool =3D "o1_m1_bool_1";
> > >         bools[0].expr_type =3D COND_BOOL;
> > >         test_cond_expr_mapping(base, d, bools, 1);
> > >
> > > @@ -150,11 +150,11 @@ void module_cond_tests(policydb_t * base)
> > >         test_bool_state(base, "g_m2_bool_1", 1);
> > >         test_bool_state(base, "g_m2_bool_2", 0);
> > >         /* conditional expression mapped correctly */
> > > -       bools[0].boolean =3D "g_m2_bool_1";
> > > +       bools[0].bool =3D "g_m2_bool_1";
> > >         bools[0].expr_type =3D COND_BOOL;
> > > -       bools[1].boolean =3D "g_m2_bool_2";
> > > +       bools[1].bool =3D "g_m2_bool_2";
> > >         bools[1].expr_type =3D COND_BOOL;
> > > -       bools[2].boolean =3D NULL;
> > > +       bools[2].bool =3D NULL;
> > >         bools[2].expr_type =3D COND_AND;
> > >         test_cond_expr_mapping(base, d, bools, 3);
> > >  }
> > > --
> > > 2.41.0
> > >
> > >
> >
