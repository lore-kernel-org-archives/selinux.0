Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXD5Cs3i"
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFBAD2
	for <selinux@vger.kernel.org>; Mon,  4 Dec 2023 10:20:06 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5cd81e76164so52708597b3.1
        for <selinux@vger.kernel.org>; Mon, 04 Dec 2023 10:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701714005; x=1702318805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0Z7dyf32+dxdF0n4IfDeA9DzaU8/5fvh6xVJVxK3oY=;
        b=XXD5Cs3iqdmBcmxin25Itt8PapWGhTxaBU1GA7zxiFRO9H87oSszOSsrV/0S4XB4yJ
         gAdlE5aWQCkmSslHNLmhsk7uxSxmo71bOUUpVJcxMqC3Lai94inwkhB8ZDhxnvwh3KXr
         LGEGLZPa2PzcXnlANbQCd/ItEbFndinSA3mXUXEm5vH5AvLFPOo1UGDW8g+aNJcDYKC2
         iB2C2dBh6aKvUiwi4qKOT+wrDmSOJrM2Oh/LzSoUECmGRTFBMiUlznTmIcMF4K61eT7z
         P2vb4C6XMAFU1jCnEiTgKj4Ufdr+3oUMHMx2k+80wuDBt0M49JJiquu9pDugasNtDoLO
         1Baw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701714005; x=1702318805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0Z7dyf32+dxdF0n4IfDeA9DzaU8/5fvh6xVJVxK3oY=;
        b=Re7t3VuZbQ8P71Cm5R5wjpzkOGRJ2+hSOCC604czH/31U9AAwhTDWufH5Oi4zsk15t
         Ni8FSarOT9y23OoAXD9Ghz1aHApv/SrCnWmKOWxoznH5sfGPtINOlc9Zfw4EnseUwdNr
         cLP/WvNlj+ShtApaBp6rNF3qOsVxBAg+2JJ+kvW5kq8/TlOQoOMhGmx1wOP6SiDi3tj6
         RTPX0CHmNZsDNPSzjCX3P7MjNDdgqTHI3Z58MBeLom7ukInXySxf+BgMeU0RUPb0PDM4
         8fad9kIrvDoah8UfqNDFDNYlop06wnS1IN5WPyl8NlUrj4CFnh4LdffDxlzTcKsSTJfH
         IpPQ==
X-Gm-Message-State: AOJu0YxAnx6LK0xekaviD1n7xPpQuMtUIB7ifhc608ePQdKmT5CSD7uW
	286EINaAuDTO9MaCXmYmut989K3PcP1XXwdOKaI=
X-Google-Smtp-Source: AGHT+IGr6FWafm9b8SqNEBV0M5JcGS1xYOzTzNl5YPVL5bSzeU8DBGv0gSk65wDb6dUKBbDFeChGvwqIqxpEf1UPSgs=
X-Received: by 2002:a81:d206:0:b0:5d7:6089:9617 with SMTP id
 x6-20020a81d206000000b005d760899617mr2836623ywi.24.1701714005239; Mon, 04 Dec
 2023 10:20:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <877cluszxo.fsf@redhat.com> <20231204164558.43667-1-lautrbach@redhat.com>
In-Reply-To: <20231204164558.43667-1-lautrbach@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 4 Dec 2023 13:19:52 -0500
Message-ID: <CAP+JOzSK+p9Fm49ApqA+_V2ro6DADJH9Y0onjwpX7W01+8mgOA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "libsepol/tests: rename bool indentifiers"
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 11:46=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> This reverts commit 893b50c6ce661f3ee339145e76a0bbfa199671c3.
>
> 61f21385004 ("libsepol: rename struct member") broke build of SETools:
>
> setools/policyrep.c: In function =E2=80=98__pyx_pf_7setools_9policyrep_23=
ConditionalExprIterator___next__=E2=80=99:
> setools/policyrep.c:27857:138: error: =E2=80=98cond_expr_t=E2=80=99 {aka =
=E2=80=98struct cond_expr=E2=80=99} has no member named =E2=80=98bool=E2=80=
=99; did you mean =E2=80=98boolean=E2=80=99?
> 27857 |     __pyx_t_3 =3D __pyx_f_7setools_9policyrep_13SELinuxPolicy_boo=
lean_value_to_datum(__pyx_v_self->__pyx_base.policy, (__pyx_v_self->curr->b=
ool - 1)); if (unlikely(PyErr_Occurred())) __PYX_ERR(1, 336, __pyx_L1_error=
)
>       |                                                                  =
                                                                        ^~~=
~
>       |
>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>

Also need to revert 513fc1570c16924080740b23fa34343ef64a90c0
Plus there is a couple of new uses in policy_validate.c and one in
checkpolicy/policy_define.c that need to be corrected.

Thanks,
Jim

> ---
>  libsepol/tests/test-linker-cond-map.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/libsepol/tests/test-linker-cond-map.c b/libsepol/tests/test-=
linker-cond-map.c
> index 142066669c0c..6ea0e4c2ac6b 100644
> --- a/libsepol/tests/test-linker-cond-map.c
> +++ b/libsepol/tests/test-linker-cond-map.c
> @@ -51,7 +51,7 @@
>   */
>
>  typedef struct test_cond_expr {
> -       const char *boolean;
> +       const char *bool;
>         uint32_t expr_type;
>  } test_cond_expr_t;
>
> @@ -69,18 +69,18 @@ static void test_cond_expr_mapping(policydb_t * p, av=
rule_decl_t * d, test_cond_
>                 CU_ASSERT_FATAL(expr !=3D NULL);
>
>                 CU_ASSERT(expr->expr_type =3D=3D bools[i].expr_type);
> -               if (bools[i].boolean) {
> -                       CU_ASSERT(strcmp(p->sym_val_to_name[SYM_BOOLS][ex=
pr->boolean - 1], bools[i].boolean) =3D=3D 0);
> +               if (bools[i].bool) {
> +                       CU_ASSERT(strcmp(p->sym_val_to_name[SYM_BOOLS][ex=
pr->boolean - 1], bools[i].bool) =3D=3D 0);
>                 }
>                 expr =3D expr->next;
>         }
>  }
>
> -static void test_bool_state(policydb_t * p, const char *boolean, int sta=
te)
> +static void test_bool_state(policydb_t * p, const char *bool, int state)
>  {
>         cond_bool_datum_t *b;
>
> -       b =3D hashtab_search(p->p_bools.table, boolean);
> +       b =3D hashtab_search(p->p_bools.table, bool);
>         CU_ASSERT_FATAL(b !=3D NULL);
>         CU_ASSERT(b->state =3D=3D state);
>  }
> @@ -100,7 +100,7 @@ void base_cond_tests(policydb_t * base)
>         test_sym_presence(base, "g_b_bool_1", SYM_BOOLS, SCOPE_DECL, decl=
s, 1);
>         test_bool_state(base, "g_b_bool_1", 0);
>         /* conditional expression mapped correctly */
> -       bools[0].boolean =3D "g_b_bool_1";
> +       bools[0].bool =3D "g_b_bool_1";
>         bools[0].expr_type =3D COND_BOOL;
>         test_cond_expr_mapping(base, d, bools, 1);
>
> @@ -110,7 +110,7 @@ void base_cond_tests(policydb_t * base)
>         test_sym_presence(base, "o1_b_bool_1", SYM_BOOLS, SCOPE_DECL, dec=
ls, 1);
>         test_bool_state(base, "o1_b_bool_1", 1);
>         /* conditional expression mapped correctly */
> -       bools[0].boolean =3D "o1_b_bool_1";
> +       bools[0].bool =3D "o1_b_bool_1";
>         bools[0].expr_type =3D COND_BOOL;
>         test_cond_expr_mapping(base, d, bools, 1);
>
> @@ -128,7 +128,7 @@ void module_cond_tests(policydb_t * base)
>         test_sym_presence(base, "g_m1_bool_1", SYM_BOOLS, SCOPE_DECL, dec=
ls, 1);
>         test_bool_state(base, "g_m1_bool_1", 1);
>         /* conditional expression mapped correctly */
> -       bools[0].boolean =3D "g_m1_bool_1";
> +       bools[0].bool =3D "g_m1_bool_1";
>         bools[0].expr_type =3D COND_BOOL;
>         test_cond_expr_mapping(base, d, bools, 1);
>
> @@ -138,7 +138,7 @@ void module_cond_tests(policydb_t * base)
>         test_sym_presence(base, "o1_m1_bool_1", SYM_BOOLS, SCOPE_DECL, de=
cls, 1);
>         test_bool_state(base, "o1_m1_bool_1", 0);
>         /* conditional expression mapped correctly */
> -       bools[0].boolean =3D "o1_m1_bool_1";
> +       bools[0].bool =3D "o1_m1_bool_1";
>         bools[0].expr_type =3D COND_BOOL;
>         test_cond_expr_mapping(base, d, bools, 1);
>
> @@ -150,11 +150,11 @@ void module_cond_tests(policydb_t * base)
>         test_bool_state(base, "g_m2_bool_1", 1);
>         test_bool_state(base, "g_m2_bool_2", 0);
>         /* conditional expression mapped correctly */
> -       bools[0].boolean =3D "g_m2_bool_1";
> +       bools[0].bool =3D "g_m2_bool_1";
>         bools[0].expr_type =3D COND_BOOL;
> -       bools[1].boolean =3D "g_m2_bool_2";
> +       bools[1].bool =3D "g_m2_bool_2";
>         bools[1].expr_type =3D COND_BOOL;
> -       bools[2].boolean =3D NULL;
> +       bools[2].bool =3D NULL;
>         bools[2].expr_type =3D COND_AND;
>         test_cond_expr_mapping(base, d, bools, 3);
>  }
> --
> 2.41.0
>
>
