Return-Path: <SRS0=fYOO=63=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAD4C433E0
	for <selinux@archiver.kernel.org>; Wed, 13 May 2020 15:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B2F5207D0
	for <selinux@archiver.kernel.org>; Wed, 13 May 2020 15:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IA+TncYo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731083AbgEMPML (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 May 2020 11:12:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38440 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729179AbgEMPMK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 May 2020 11:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589382729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pLdTCK0u/O2IN4Ne69byvNHDBM7UYu41201Grw/iPvY=;
        b=IA+TncYotFznaix60SHpMmSq+v1STRl7278LLTyimaaWt88n3JxYmlBB7y4cbaRilHUOaJ
        CrTtvtnJdAXJvCcnePQ4TTzyvxrMZH6LTrpDeoZOHpZkvn2cXyRdz8jWZTy0YdS94INXfQ
        YIbJk7l1vpTl0OkbD/M5MqBQELiG5f4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-1OXQjKHaNlSJ1Lmb3oJlsw-1; Wed, 13 May 2020 11:12:07 -0400
X-MC-Unique: 1OXQjKHaNlSJ1Lmb3oJlsw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29DCB8014C0;
        Wed, 13 May 2020 15:12:06 +0000 (UTC)
Received: from workstation (unknown [10.40.192.247])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FE9460CD1;
        Wed, 13 May 2020 15:12:04 +0000 (UTC)
Date:   Wed, 13 May 2020 17:12:02 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux <selinux@vger.kernel.org>
Cc:     bauen1 <j2468h@googlemail.com>,
        William Roberts <william.c.roberts@intel.com>
Subject: Re: [PATCH] mcstransd: fix memory leak in new_context_str
Message-ID: <20200513151202.GA184264@workstation>
References: <6f2dc066-1f5b-1ea8-be48-73ae2b977b44@gmail.com>
MIME-Version: 1.0
In-Reply-To: <6f2dc066-1f5b-1ea8-be48-73ae2b977b44@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2020 at 07:52:54PM +0200, bauen1 wrote:
> The return value of context_new needs to be free with context_free.
>=20
> Signed-off-by: bauen1 <j2468h@gmail.com>
> Acked-by: William Roberts <william.c.roberts@intel.com>

Applied.

> ---
>  mcstrans/src/mcstrans.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
> index 96bdbdff..2116b161 100644
> --- a/mcstrans/src/mcstrans.c
> +++ b/mcstrans/src/mcstrans.c
> @@ -919,6 +919,7 @@ new_context_str(const security_context_t incon, const=
 char *range) {
>  =09}
>  =09context_range_set(con, range);
>  =09rcon =3D strdup(context_str(con));
> +=09context_free(con);
>  =09if (!rcon) {
>  =09=09goto exit;
>  =09}

--=20
()  ascii ribbon campaign - against html e-mail=20
/\  www.asciiribbon.org   - against proprietary attachments

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl68DjwACgkQviIJHj72
InUb7hAAuv+Em/Iw7ogIC+zuSyZ32Q0vcUPcR/8HdtMNKxJ2Ad9qbTb4O+si92g0
WWOHwdajocyJMbwu3ZFRJgk325RsIzTiwfZG3axuw7UUPHHgfymKGO6GnjNTdwF7
rEPmJ09kFki5CZX35MfA5bD9R+wtNCFFz1+H9M7nYPHuLedsQ5Q2jf53g4/AH5ec
b5CxfW07DKqGUg3K4yYBI092tXbwtbvGvWgGLPClh0U5/MJHeXZnlYZ3R8aSm0zT
ZzhtJlYtfxRXwnZ/Fg0shpvWED3J1cyKVgaF8IxgD44s6/6Ujv/JMRfo7hPAk+sx
2CTBOiQwVCDckhvESktyw8ExectSKMV07xaa7kqdFZ7mavmsSlKORs+OC/8XIT/r
9vydYnfmLx9yhQA4pNqYyTQg5P1TW+QLecLRMxR8PTyiylYAoAygntxxQ9CcNM95
tyJn1N3wh6oTqqFV18qOYUeYEvjl+bUjyPzABb2ILfuL2PppXJhZXL11pASGwWg4
oK7icRn44PHIPbQ4GfJXlY6CNk2rg4kbyBEwDQMpNI3DbrJhNziKsabEYrKP5QCN
CkunfFHYf+RtRT67Ywv3BLF7c3z3mUO79qHjHBpQV2spyEAFoVH/5srQ9A6Ge75R
q+gy88/PRbnaLLPF2ErsaG3zAdUopQIs8qSNw1Q9LjShBrwxVao=
=ekpk
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--

