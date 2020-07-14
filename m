Return-Path: <SRS0=WW+a=AZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1877C433E2
	for <selinux@archiver.kernel.org>; Tue, 14 Jul 2020 14:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAAA722515
	for <selinux@archiver.kernel.org>; Tue, 14 Jul 2020 14:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZeBg7Uwu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgGNOaL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Jul 2020 10:30:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60139 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725955AbgGNOaK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Jul 2020 10:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594737008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bPd/YhSPlgJcmwk22aO4u1YBWND2E0EYQ2NdPPJ440k=;
        b=ZeBg7UwuuX0jZlQztSjcbCusMgHYTD7ae9J6NIYni/Q7Ls5EoM6XpeHHUBrWPhBjfizZEE
        T2gF8HMA6mDLPLQeEufXvREqKL+AlNDHlV+vIzgiUFeKBrHIGszKraqsUU23kLRiqGbouf
        wF7Jq9o5Jj0IxLhstdEJzru/fK9yGsE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-hkVNl966OMGX37YqgR2XiQ-1; Tue, 14 Jul 2020 10:30:03 -0400
X-MC-Unique: hkVNl966OMGX37YqgR2XiQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D360B8027ED;
        Tue, 14 Jul 2020 14:30:01 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.114])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F1FC710AD;
        Tue, 14 Jul 2020 14:29:59 +0000 (UTC)
Date:   Tue, 14 Jul 2020 16:29:56 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     bauen1 <j2468h@googlemail.com>, James Carter <jwcart2@gmail.com>
Subject: Re: [PATCH v2] Update the cil docs to match the current behaviour.
Message-ID: <20200714142956.GA1983236@localhost.localdomain>
References: <CAP+JOzTduRu0U7gdvCrxRqTW+VUWc_imaOc0ozXGYe_GpXM9Cw@mail.gmail.com>
 <2da3deec-0098-9847-7412-9d9654b6645f@gmail.com>
 <CAP+JOzTTmMrU3EPkbMnfYwbd5uRVMr+b2xo704teO_Fcm6sytA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAP+JOzTTmMrU3EPkbMnfYwbd5uRVMr+b2xo704teO_Fcm6sytA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2020 at 12:17:49PM -0400, James Carter wrote:
> On Thu, Jul 9, 2020 at 4:37 AM bauen1 <j2468h@googlemail.com> wrote:
> >
> > Some features where dropped or change since the docs were last updated.
> >
> > Signed-off-by: Jonathan Hettwer <j2468h@gmail.com>
>=20
> Acked-by: James Carter <jwcart2@gmail.com>

I'd asked for that and then missed it, I'm sorry.

It's applied now. Thanks!

> > ---
> >
> > Notes:
> >     Updated to include additional fixes and a correct Signed-off-by lin=
e.
> >
> >  secilc/docs/cil_call_macro_statements.md | 6 ++++--
> >  secilc/docs/cil_container_statements.md  | 2 +-
> >  secilc/docs/cil_reference_guide.md       | 2 +-
> >  secilc/docs/cil_user_statements.md       | 2 +-
> >  4 files changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/secilc/docs/cil_call_macro_statements.md b/secilc/docs/cil=
_call_macro_statements.md
> > index 17c46ed9..98b70368 100644
> > --- a/secilc/docs/cil_call_macro_statements.md
> > +++ b/secilc/docs/cil_call_macro_statements.md
> > @@ -44,7 +44,7 @@ macro
> >
> >  Declare a macro in the current namespace with its associated parameter=
s. The macro identifier is used by the [`call`](cil_call_macro_statements.m=
d#call) statement to instantiate the macro and resolve any parameters. The =
call statement may be within the body of a macro.
> >
> > -Note that when resolving macros the callers namespace is not checked, =
only the following places:
> > +When resolving macros the following places are checked in this order:
> >
> >  -   Items defined inside the macro
> >
> > @@ -52,6 +52,8 @@ Note that when resolving macros the callers namespace=
 is not checked, only the f
> >
> >  -   Items defined in the same namespace of the macro
> >
> > +-   Items defined in the callers namespace
> > +
> >  -   Items defined in the global namespace
> >
> >  **Statement definition:**
> > @@ -80,7 +82,7 @@ Note that when resolving macros the callers namespace=
 is not checked, only the f
> >  <tr class=3D"odd">
> >  <td align=3D"left"><p><code>param_type</code></p></td>
> >  <td align=3D"left"><p>Zero or more parameters that are passed to the m=
acro. The <code>param_type</code> is a keyword used to determine the declar=
ation type (e.g. <code>type</code>, <code>class</code>, <code>categoryset</=
code>).</p>
> > -<p>The list of valid <code>param_type</code> entries are: <code>type</=
code>, <code>typealias</code>, <code>role</code>, <code>user</code>, <code>=
sensitivity</code>, <code>sensitivityalias</code>, <code>category</code>, <=
code>categoryalias</code>, <code>categoryset</code> (named or anonymous), <=
code>level</code> (named or anonymous), <code>levelrange</code> (named or a=
nonymous), <code>class</code>, <code>classpermission</code> (named or anony=
mous), <code>ipaddr</code> (named or anonymous), <code>block</code>, <code>=
name</code> (a string), <code>classmap</code></p></td>
> > +<p>The list of valid <code>param_type</code> entries are: <code>type</=
code>, <code>typealias</code>, <code>role</code>, <code>user</code>, <code>=
sensitivity</code>, <code>sensitivityalias</code>, <code>category</code>, <=
code>categoryalias</code>, <code>categoryset</code> (named or anonymous), <=
code>level</code> (named or anonymous), <code>levelrange</code> (named or a=
nonymous), <code>class</code>, <code>classpermission</code> (named or anony=
mous), <code>ipaddr</code> (named or anonymous), <code>name</code> (a strin=
g), <code>classmap</code></p></td>
> >  </tr>
> >  <tr class=3D"even">
> >  <td align=3D"left"><p><code>param_id</code></p></td>
> > diff --git a/secilc/docs/cil_container_statements.md b/secilc/docs/cil_=
container_statements.md
> > index a570cb23..58b3224d 100644
> > --- a/secilc/docs/cil_container_statements.md
> > +++ b/secilc/docs/cil_container_statements.md
> > @@ -254,7 +254,7 @@ This example will instantiate the optional block `e=
xt_gateway.move_file` into po
> >  in
> >  --
> >
> > -Allows the insertion of CIL statements into a named container ([`block=
`](cil_container_statements.md#block), [`optional`](cil_container_statement=
s.md#optional) or [`macro`](cil_call_macro_statements.md#macro)). This stat=
ement is not allowed in [`booleanif`](cil_conditional_statements.md#boolean=
if) or [`tunableif`](cil_conditional_statements.md#tunableif) statements.
> > +Allows the insertion of CIL statements into a named container ([`block=
`](cil_container_statements.md#block), [`optional`](cil_container_statement=
s.md#optional) or [`macro`](cil_call_macro_statements.md#macro)). This stat=
ement is not allowed in [`booleanif`](cil_conditional_statements.md#boolean=
if) or [`tunableif`](cil_conditional_statements.md#tunableif) statements. T=
his only works for containers that aren't inherited using [`blockinherit`](=
cil_conditional_statements.md#blockinherit).
> >
> >  **Statement definition:**
> >
> > diff --git a/secilc/docs/cil_reference_guide.md b/secilc/docs/cil_refer=
ence_guide.md
> > index 1b1fccca..3e33c5f7 100644
> > --- a/secilc/docs/cil_reference_guide.md
> > +++ b/secilc/docs/cil_reference_guide.md
> > @@ -176,7 +176,7 @@ Should the symbol not be prefixed with a dot, the c=
urrent namespace would be sea
> >  Expressions
> >  -----------
> >
> > -Expressions may occur in the following CIL statements: [`booleanif`](c=
il_conditional_statements.md#booleanif), [`tunableif`](cil_conditional_stat=
ements.md#tunableif), [`classpermissionset`](cil_class_and_permission_state=
ments.md#classpermissionset), [`typeattributeset`](cil_type_statements.md#t=
ypeattributeset), [`roleattributeset`](cil_role_statements.md#roleattribute=
set), [`categoryset`](cil_mls_labeling_statements.md#categoryset), [`constr=
ain`](cil_constraint_statements.md#constrain), [`mlsconstrain`](cil_constra=
int_statements.md#mlsconstrain), [`validatetrans`](cil_constraint_statement=
s.md#validatetrans), [`validatetrans`](cil_constraint_statements.md#validat=
etrans)
> > +Expressions may occur in the following CIL statements: [`booleanif`](c=
il_conditional_statements.md#booleanif), [`tunableif`](cil_conditional_stat=
ements.md#tunableif), [`classpermissionset`](cil_class_and_permission_state=
ments.md#classpermissionset), [`typeattributeset`](cil_type_statements.md#t=
ypeattributeset), [`roleattributeset`](cil_role_statements.md#roleattribute=
set), [`categoryset`](cil_mls_labeling_statements.md#categoryset), [`constr=
ain`](cil_constraint_statements.md#constrain), [`mlsconstrain`](cil_constra=
int_statements.md#mlsconstrain), [`validatetrans`](cil_constraint_statement=
s.md#validatetrans), [`mlsvalidatetrans`](cil_constraint_statements.md#mlsv=
alidatetrans)
> >
> >  CIL expressions use the [prefix](http://www.cs.man.ac.uk/~pjj/cs212/fi=
x.html) or Polish notation and may be nested (note that the kernel policy l=
anguage uses postfix or reverse Polish notation). The syntax is as follows,=
 where the parenthesis are part of the syntax:
> >
> > diff --git a/secilc/docs/cil_user_statements.md b/secilc/docs/cil_user_=
statements.md
> > index bbd76eff..26e45510 100644
> > --- a/secilc/docs/cil_user_statements.md
> > +++ b/secilc/docs/cil_user_statements.md
> > @@ -260,7 +260,7 @@ This example will associate `unconfined.user` with =
a named [`levelrange`](cil_ml
> >      (categoryorder (c0 c1))
> >      (sensitivity s0)
> >      (sensitivity s1)
> > -    (dominance (s0 s1))
> > +    (sensitivityorder (s0 s1))
> >      (sensitivitycategory s0 (c0 c1))
> >      (level systemLow (s0))
> >      (level systemHigh (s0 (c0 c1)))
> > --
> > 2.27.0
> >
>=20

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl8NwV0ACgkQviIJHj72
InVTiw/+J11yta2VL6WVxBPHvimuPFimcpZHoZE8cEv82Joiv6vLv+72NkZiS1za
y55dqMconV+rH/5Y1bgEwGUm6vus8NcDFjJZ+YgYTjXw6otiXGhIRuCphWeAN41+
grp5sipkdKg9lJRjP6DsM59ZNoydlENZejIqZdchq8Ob7smOEZoViiNWOKI1jRhD
fYUuzp67x4T0ZckN4VnehjhZPpE8F+YcSjJy8tMGj7PTxQLi/YD4Cj40W5oHYPvg
4j/yJ4zKwxRgG/75aix9kHxYBJyHcXy3gaO2sczk6JUc88lZNWQDmLvhTqNbZknA
JCXgmdSezWhc4AHpeVPKWBKjEHqDCdvl8DmfuDpAbFAMxJ4bsdIO1FR6qR5n328S
zHsV8tuhDn/B6apxgSlv1PLp+OJhdgMg9lW32d+Dkm6DeNJHYqsuGaH1C0e0XoLq
ZLY2sFLqqPnELcxVpNKTVIM+40LqP1IE9fz9y/2t3n/vuYERSUreSI2p+eA9KKCU
EaHUU0sKlwvZkruWFt1xE0j2YS0xicbUq9BOz9m6r2b4Jkt9WUWhm1gDqG6I6Eed
/g4LRYe66xKESNs3LV4j6ogZowFARrjVOwYKhBe5TGrDXNIUY9ZodJrfmTdkDJOu
598FkeLtLFFbYS3S5JSGUfH+BB772QTuaKFgeIQadeU4J/Z+TuA=
=Sjy7
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--

