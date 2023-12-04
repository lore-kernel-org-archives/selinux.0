Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D5km1pCP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3175107
	for <selinux@vger.kernel.org>; Mon,  4 Dec 2023 10:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701715049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJeik/N+E4pWtfzXBbzu/neGo8MtRtInSjIR6TGHFTI=;
	b=D5km1pCPOhA6Rz4kvKFP+C/k/hyOTIPm/+1DzVZm2ZjfYdDFH+GVImbyvLcz5vTE9dzviy
	OfKNARA/7CcrLIJtDI7vBgLsryh+E8hkfXUfbJBkrgnxM2RjoZ7J+IcZFt+5iOFL04ul5y
	shGdmNIOo9ObMl35zCq1HHcBwSGmTms=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-GllCX5rDNgWH0BtVllKttQ-1; Mon, 04 Dec 2023 13:37:26 -0500
X-MC-Unique: GllCX5rDNgWH0BtVllKttQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8DA4B84ACA0;
	Mon,  4 Dec 2023 18:37:25 +0000 (UTC)
Received: from localhost (unknown [10.45.224.166])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4939B2026D68;
	Mon,  4 Dec 2023 18:37:25 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>, James
 Carter
 <jwcart2@gmail.com>, Chris PeBenito <pebenito@ieee.org>
Cc: selinux@vger.kernel.org, Chris PeBenito <chpebeni@linux.microsoft.com>
Subject: Re: [PATCH 1/2] Revert "libsepol/tests: rename bool indentifiers"
In-Reply-To: <CAJ2a_DcL-Dyby6rGjq23sDmdm+Mk2_KNvM0-iHq=paOQO0RHAQ@mail.gmail.com>
References: <877cluszxo.fsf@redhat.com>
 <20231204164558.43667-1-lautrbach@redhat.com>
 <CAP+JOzSK+p9Fm49ApqA+_V2ro6DADJH9Y0onjwpX7W01+8mgOA@mail.gmail.com>
 <CAJ2a_DcL-Dyby6rGjq23sDmdm+Mk2_KNvM0-iHq=paOQO0RHAQ@mail.gmail.com>
Date: Mon, 04 Dec 2023 19:37:24 +0100
Message-ID: <8734whu84b.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:

> On Mon, 4 Dec 2023 at 19:20, James Carter <jwcart2@gmail.com> wrote:
>>
>> On Mon, Dec 4, 2023 at 11:46=E2=80=AFAM Petr Lautrbach <lautrbach@redhat=
.com> wrote:
>> >
>> > This reverts commit 893b50c6ce661f3ee339145e76a0bbfa199671c3.
>> >
>> > 61f21385004 ("libsepol: rename struct member") broke build of SETools:
>> >
>> > setools/policyrep.c: In function =E2=80=98__pyx_pf_7setools_9policyrep=
_23ConditionalExprIterator___next__=E2=80=99:
>> > setools/policyrep.c:27857:138: error: =E2=80=98cond_expr_t=E2=80=99 {a=
ka =E2=80=98struct cond_expr=E2=80=99} has no member named =E2=80=98bool=E2=
=80=99; did you mean =E2=80=98boolean=E2=80=99?
>> > 27857 |     __pyx_t_3 =3D __pyx_f_7setools_9policyrep_13SELinuxPolicy_=
boolean_value_to_datum(__pyx_v_self->__pyx_base.policy, (__pyx_v_self->curr=
->bool - 1)); if (unlikely(PyErr_Occurred())) __PYX_ERR(1, 336, __pyx_L1_er=
ror)
>> >       |                                                               =
                                                                           =
^~~~
>> >       |
>> >
>> > Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
>>
>> Also need to revert 513fc1570c16924080740b23fa34343ef64a90c0
>> Plus there is a couple of new uses in policy_validate.c and one in
>> checkpolicy/policy_define.c that need to be corrected.
>>
>> Thanks,
>> Jim
>
> Could you consider https://github.com/SELinuxProject/setools/pull/113
> as an alternative?

Nice, thanks!

I need to test it, but it looks good.

For me, this is better solution than reverting all the patches.

But we need to release SETools together with SELinux userspace 3.6.

Chris, is it feasible to release SETools with the proposed change on
this Wednesday or a week later?

Petr



>>
>> > ---
>> >  libsepol/tests/test-linker-cond-map.c | 24 ++++++++++++------------
>> >  1 file changed, 12 insertions(+), 12 deletions(-)
>> >
>> > diff --git a/libsepol/tests/test-linker-cond-map.c b/libsepol/tests/te=
st-linker-cond-map.c
>> > index 142066669c0c..6ea0e4c2ac6b 100644
>> > --- a/libsepol/tests/test-linker-cond-map.c
>> > +++ b/libsepol/tests/test-linker-cond-map.c
>> > @@ -51,7 +51,7 @@
>> >   */
>> >
>> >  typedef struct test_cond_expr {
>> > -       const char *boolean;
>> > +       const char *bool;
>> >         uint32_t expr_type;
>> >  } test_cond_expr_t;
>> >
>> > @@ -69,18 +69,18 @@ static void test_cond_expr_mapping(policydb_t * p,=
 avrule_decl_t * d, test_cond_
>> >                 CU_ASSERT_FATAL(expr !=3D NULL);
>> >
>> >                 CU_ASSERT(expr->expr_type =3D=3D bools[i].expr_type);
>> > -               if (bools[i].boolean) {
>> > -                       CU_ASSERT(strcmp(p->sym_val_to_name[SYM_BOOLS]=
[expr->boolean - 1], bools[i].boolean) =3D=3D 0);
>> > +               if (bools[i].bool) {
>> > +                       CU_ASSERT(strcmp(p->sym_val_to_name[SYM_BOOLS]=
[expr->boolean - 1], bools[i].bool) =3D=3D 0);
>> >                 }
>> >                 expr =3D expr->next;
>> >         }
>> >  }
>> >
>> > -static void test_bool_state(policydb_t * p, const char *boolean, int =
state)
>> > +static void test_bool_state(policydb_t * p, const char *bool, int sta=
te)
>> >  {
>> >         cond_bool_datum_t *b;
>> >
>> > -       b =3D hashtab_search(p->p_bools.table, boolean);
>> > +       b =3D hashtab_search(p->p_bools.table, bool);
>> >         CU_ASSERT_FATAL(b !=3D NULL);
>> >         CU_ASSERT(b->state =3D=3D state);
>> >  }
>> > @@ -100,7 +100,7 @@ void base_cond_tests(policydb_t * base)
>> >         test_sym_presence(base, "g_b_bool_1", SYM_BOOLS, SCOPE_DECL, d=
ecls, 1);
>> >         test_bool_state(base, "g_b_bool_1", 0);
>> >         /* conditional expression mapped correctly */
>> > -       bools[0].boolean =3D "g_b_bool_1";
>> > +       bools[0].bool =3D "g_b_bool_1";
>> >         bools[0].expr_type =3D COND_BOOL;
>> >         test_cond_expr_mapping(base, d, bools, 1);
>> >
>> > @@ -110,7 +110,7 @@ void base_cond_tests(policydb_t * base)
>> >         test_sym_presence(base, "o1_b_bool_1", SYM_BOOLS, SCOPE_DECL, =
decls, 1);
>> >         test_bool_state(base, "o1_b_bool_1", 1);
>> >         /* conditional expression mapped correctly */
>> > -       bools[0].boolean =3D "o1_b_bool_1";
>> > +       bools[0].bool =3D "o1_b_bool_1";
>> >         bools[0].expr_type =3D COND_BOOL;
>> >         test_cond_expr_mapping(base, d, bools, 1);
>> >
>> > @@ -128,7 +128,7 @@ void module_cond_tests(policydb_t * base)
>> >         test_sym_presence(base, "g_m1_bool_1", SYM_BOOLS, SCOPE_DECL, =
decls, 1);
>> >         test_bool_state(base, "g_m1_bool_1", 1);
>> >         /* conditional expression mapped correctly */
>> > -       bools[0].boolean =3D "g_m1_bool_1";
>> > +       bools[0].bool =3D "g_m1_bool_1";
>> >         bools[0].expr_type =3D COND_BOOL;
>> >         test_cond_expr_mapping(base, d, bools, 1);
>> >
>> > @@ -138,7 +138,7 @@ void module_cond_tests(policydb_t * base)
>> >         test_sym_presence(base, "o1_m1_bool_1", SYM_BOOLS, SCOPE_DECL,=
 decls, 1);
>> >         test_bool_state(base, "o1_m1_bool_1", 0);
>> >         /* conditional expression mapped correctly */
>> > -       bools[0].boolean =3D "o1_m1_bool_1";
>> > +       bools[0].bool =3D "o1_m1_bool_1";
>> >         bools[0].expr_type =3D COND_BOOL;
>> >         test_cond_expr_mapping(base, d, bools, 1);
>> >
>> > @@ -150,11 +150,11 @@ void module_cond_tests(policydb_t * base)
>> >         test_bool_state(base, "g_m2_bool_1", 1);
>> >         test_bool_state(base, "g_m2_bool_2", 0);
>> >         /* conditional expression mapped correctly */
>> > -       bools[0].boolean =3D "g_m2_bool_1";
>> > +       bools[0].bool =3D "g_m2_bool_1";
>> >         bools[0].expr_type =3D COND_BOOL;
>> > -       bools[1].boolean =3D "g_m2_bool_2";
>> > +       bools[1].bool =3D "g_m2_bool_2";
>> >         bools[1].expr_type =3D COND_BOOL;
>> > -       bools[2].boolean =3D NULL;
>> > +       bools[2].bool =3D NULL;
>> >         bools[2].expr_type =3D COND_AND;
>> >         test_cond_expr_mapping(base, d, bools, 3);
>> >  }
>> > --
>> > 2.41.0
>> >
>> >
>>

