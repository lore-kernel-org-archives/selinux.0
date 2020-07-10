Return-Path: <SRS0=ib1x=AV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E12C433E4
	for <selinux@archiver.kernel.org>; Fri, 10 Jul 2020 13:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBBE620767
	for <selinux@archiver.kernel.org>; Fri, 10 Jul 2020 13:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NKZGUAj9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgGJNq6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:46:58 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51415 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726867AbgGJNq6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jul 2020 09:46:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594388815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3plMDFhwkmmA1xvj0ueZU9rA196lvQcC0i0EOCBSzUw=;
        b=NKZGUAj92zw42IF2/HYBt4AwbnA5GsNosOkn7d9fXCGUJHIz5RM1XLd1SsimOBu8j427ME
        yEewW7kmIW8KFChdr+LPnPvPX43wgeHxJuBFvdte9yUwKk8Vsd8z+uy6PydDBhzMli0/0R
        E8VL8zVnZ75OaxDncV82zapLhXBpSEE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-amGzeRAuN_CXCcA7_YGeww-1; Fri, 10 Jul 2020 09:46:49 -0400
X-MC-Unique: amGzeRAuN_CXCcA7_YGeww-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1E68800FEB;
        Fri, 10 Jul 2020 13:46:48 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.193.251])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E66678A3F;
        Fri, 10 Jul 2020 13:46:47 +0000 (UTC)
Date:   Fri, 10 Jul 2020 15:46:44 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     bauen1 <j2468h@googlemail.com>
Subject: Re: [PATCH v2] Update the cil docs to match the current behaviour.
Message-ID: <20200710134644.GB1768200@localhost.localdomain>
References: <CAP+JOzTduRu0U7gdvCrxRqTW+VUWc_imaOc0ozXGYe_GpXM9Cw@mail.gmail.com>
 <2da3deec-0098-9847-7412-9d9654b6645f@gmail.com>
MIME-Version: 1.0
In-Reply-To: <2da3deec-0098-9847-7412-9d9654b6645f@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 09, 2020 at 10:36:36AM +0200, bauen1 wrote:
> Some features where dropped or change since the docs were last updated.
>=20
> Signed-off-by: Jonathan Hettwer <j2468h@gmail.com>

I think it should go to 3.1 release. But I have to confess myself not beein=
g
able to confirm  whether the change is correct.

If it's acked somebody else I could apply it and push to 3.1 release



> ---
>=20
> Notes:
>     Updated to include additional fixes and a correct Signed-off-by line.
>=20
>  secilc/docs/cil_call_macro_statements.md | 6 ++++--
>  secilc/docs/cil_container_statements.md  | 2 +-
>  secilc/docs/cil_reference_guide.md       | 2 +-
>  secilc/docs/cil_user_statements.md       | 2 +-
>  4 files changed, 7 insertions(+), 5 deletions(-)
>=20
> diff --git a/secilc/docs/cil_call_macro_statements.md b/secilc/docs/cil_c=
all_macro_statements.md
> index 17c46ed9..98b70368 100644
> --- a/secilc/docs/cil_call_macro_statements.md
> +++ b/secilc/docs/cil_call_macro_statements.md
> @@ -44,7 +44,7 @@ macro
> =20
>  Declare a macro in the current namespace with its associated parameters.=
 The macro identifier is used by the [`call`](cil_call_macro_statements.md#=
call) statement to instantiate the macro and resolve any parameters. The ca=
ll statement may be within the body of a macro.
> =20
> -Note that when resolving macros the callers namespace is not checked, on=
ly the following places:
> +When resolving macros the following places are checked in this order:
> =20
>  -   Items defined inside the macro
> =20
> @@ -52,6 +52,8 @@ Note that when resolving macros the callers namespace i=
s not checked, only the f
> =20
>  -   Items defined in the same namespace of the macro
> =20
> +-   Items defined in the callers namespace
> +
>  -   Items defined in the global namespace
> =20
>  **Statement definition:**
> @@ -80,7 +82,7 @@ Note that when resolving macros the callers namespace i=
s not checked, only the f
>  <tr class=3D"odd">
>  <td align=3D"left"><p><code>param_type</code></p></td>
>  <td align=3D"left"><p>Zero or more parameters that are passed to the mac=
ro. The <code>param_type</code> is a keyword used to determine the declarat=
ion type (e.g. <code>type</code>, <code>class</code>, <code>categoryset</co=
de>).</p>
> -<p>The list of valid <code>param_type</code> entries are: <code>type</co=
de>, <code>typealias</code>, <code>role</code>, <code>user</code>, <code>se=
nsitivity</code>, <code>sensitivityalias</code>, <code>category</code>, <co=
de>categoryalias</code>, <code>categoryset</code> (named or anonymous), <co=
de>level</code> (named or anonymous), <code>levelrange</code> (named or ano=
nymous), <code>class</code>, <code>classpermission</code> (named or anonymo=
us), <code>ipaddr</code> (named or anonymous), <code>block</code>, <code>na=
me</code> (a string), <code>classmap</code></p></td>
> +<p>The list of valid <code>param_type</code> entries are: <code>type</co=
de>, <code>typealias</code>, <code>role</code>, <code>user</code>, <code>se=
nsitivity</code>, <code>sensitivityalias</code>, <code>category</code>, <co=
de>categoryalias</code>, <code>categoryset</code> (named or anonymous), <co=
de>level</code> (named or anonymous), <code>levelrange</code> (named or ano=
nymous), <code>class</code>, <code>classpermission</code> (named or anonymo=
us), <code>ipaddr</code> (named or anonymous), <code>name</code> (a string)=
, <code>classmap</code></p></td>
>  </tr>
>  <tr class=3D"even">
>  <td align=3D"left"><p><code>param_id</code></p></td>
> diff --git a/secilc/docs/cil_container_statements.md b/secilc/docs/cil_co=
ntainer_statements.md
> index a570cb23..58b3224d 100644
> --- a/secilc/docs/cil_container_statements.md
> +++ b/secilc/docs/cil_container_statements.md
> @@ -254,7 +254,7 @@ This example will instantiate the optional block `ext=
_gateway.move_file` into po
>  in
>  --
> =20
> -Allows the insertion of CIL statements into a named container ([`block`]=
(cil_container_statements.md#block), [`optional`](cil_container_statements.=
md#optional) or [`macro`](cil_call_macro_statements.md#macro)). This statem=
ent is not allowed in [`booleanif`](cil_conditional_statements.md#booleanif=
) or [`tunableif`](cil_conditional_statements.md#tunableif) statements.
> +Allows the insertion of CIL statements into a named container ([`block`]=
(cil_container_statements.md#block), [`optional`](cil_container_statements.=
md#optional) or [`macro`](cil_call_macro_statements.md#macro)). This statem=
ent is not allowed in [`booleanif`](cil_conditional_statements.md#booleanif=
) or [`tunableif`](cil_conditional_statements.md#tunableif) statements. Thi=
s only works for containers that aren't inherited using [`blockinherit`](ci=
l_conditional_statements.md#blockinherit).
> =20
>  **Statement definition:**
> =20
> diff --git a/secilc/docs/cil_reference_guide.md b/secilc/docs/cil_referen=
ce_guide.md
> index 1b1fccca..3e33c5f7 100644
> --- a/secilc/docs/cil_reference_guide.md
> +++ b/secilc/docs/cil_reference_guide.md
> @@ -176,7 +176,7 @@ Should the symbol not be prefixed with a dot, the cur=
rent namespace would be sea
>  Expressions
>  -----------
> =20
> -Expressions may occur in the following CIL statements: [`booleanif`](cil=
_conditional_statements.md#booleanif), [`tunableif`](cil_conditional_statem=
ents.md#tunableif), [`classpermissionset`](cil_class_and_permission_stateme=
nts.md#classpermissionset), [`typeattributeset`](cil_type_statements.md#typ=
eattributeset), [`roleattributeset`](cil_role_statements.md#roleattributese=
t), [`categoryset`](cil_mls_labeling_statements.md#categoryset), [`constrai=
n`](cil_constraint_statements.md#constrain), [`mlsconstrain`](cil_constrain=
t_statements.md#mlsconstrain), [`validatetrans`](cil_constraint_statements.=
md#validatetrans), [`validatetrans`](cil_constraint_statements.md#validatet=
rans)
> +Expressions may occur in the following CIL statements: [`booleanif`](cil=
_conditional_statements.md#booleanif), [`tunableif`](cil_conditional_statem=
ents.md#tunableif), [`classpermissionset`](cil_class_and_permission_stateme=
nts.md#classpermissionset), [`typeattributeset`](cil_type_statements.md#typ=
eattributeset), [`roleattributeset`](cil_role_statements.md#roleattributese=
t), [`categoryset`](cil_mls_labeling_statements.md#categoryset), [`constrai=
n`](cil_constraint_statements.md#constrain), [`mlsconstrain`](cil_constrain=
t_statements.md#mlsconstrain), [`validatetrans`](cil_constraint_statements.=
md#validatetrans), [`mlsvalidatetrans`](cil_constraint_statements.md#mlsval=
idatetrans)
> =20
>  CIL expressions use the [prefix](http://www.cs.man.ac.uk/~pjj/cs212/fix.=
html) or Polish notation and may be nested (note that the kernel policy lan=
guage uses postfix or reverse Polish notation). The syntax is as follows, w=
here the parenthesis are part of the syntax:
> =20
> diff --git a/secilc/docs/cil_user_statements.md b/secilc/docs/cil_user_st=
atements.md
> index bbd76eff..26e45510 100644
> --- a/secilc/docs/cil_user_statements.md
> +++ b/secilc/docs/cil_user_statements.md
> @@ -260,7 +260,7 @@ This example will associate `unconfined.user` with a =
named [`levelrange`](cil_ml
>      (categoryorder (c0 c1))
>      (sensitivity s0)
>      (sensitivity s1)
> -    (dominance (s0 s1))
> +    (sensitivityorder (s0 s1))
>      (sensitivitycategory s0 (c0 c1))
>      (level systemLow (s0))
>      (level systemHigh (s0 (c0 c1)))
> --=20
> 2.27.0
>=20

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl8IcTwACgkQviIJHj72
InX5iBAAh7AN/dawdV6jVi+xsHqP3TV+l8z/MF3y3sOQcCxLIsC5aiCKjMspm0vg
AtAcmTQoEw/eWJynlFxjvhdDmr/w6QGGKzJfR6Qw2Bwg5DDKxiZksU2ZGSm3vml7
5x0Ww8OnrfyI0K0pS/CwLvzGNOWjQ0rDhW7o7hDYvIzgtyElWY0Wx+Hxz8mUcbms
Cf8oW1jFeRckaFUXPqz2HEYtEPLGzzN3oF9SdmpTrcyfpXURnAq2JDoYzwMiwhCb
6ZCXXNq903w4KaxqtrvWTnYglKFYFxUqnlfBWzb2mPpUclAJp4bZT540+DOzOUqX
sPSze1gDS9N4mgfU5axVbi1iMKMBidJwLzZdeCbL0ExrElmjhk2vyGDMJUBHQm3n
t968FhuPNuC0XSxTiTluXOWHE8aETt+D0Nx3Ec1KrkfIYDY0CAwN1Uq3Ob/mpgpF
XluxnR2zBAKFHgpbRozQt5JPY0IlgKUPTYs/NlOIApMZLSkpCgsigdf67y3NqkAc
fUX0QqcNbXz358vZffPyaHNzt+a014QhqdIkrUTFPCal2Bmvq4+Jvr9jnlpt9iUD
qcZiRzf3DnIg+iQOT1B7eLnD3eLPK9+20j8O2QveUOlQSGW6olUXqTiTmoS+MDWX
Njuqw+Y9hUmwq2zHNIgDRTOvPXu6Bi9grENV8LI5TFcqZUCWVH0=
=tA+3
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--

