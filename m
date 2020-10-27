Return-Path: <SRS0=znNI=EC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A8AC6369E
	for <selinux@archiver.kernel.org>; Tue, 27 Oct 2020 17:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F80120878
	for <selinux@archiver.kernel.org>; Tue, 27 Oct 2020 17:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N3IQnhL6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1820547AbgJ0Rfo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 27 Oct 2020 13:35:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54408 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1820363AbgJ0RfJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 27 Oct 2020 13:35:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603820106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R69SJGIXnOeBCOVhN+4wi5M85z31iRyaPMTE0OqoIM0=;
        b=N3IQnhL6Jpbz002bBbpCNMZo7V64h7eF3o/OEwnB9iwfrcGWS8vEqrOmakC/cRPLTZISrG
        zpH0FuDZRfqLqmoHPjFZ79pXMW09GV5J9Lk+bZl1rz/n+pZMB9qM1nCTZ5Ux68h9ETbsR9
        93Q0Bk9bddfpT1wZgESn4ILibbur4oU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-TiYr4IK4NtSUSVdihDejlA-1; Tue, 27 Oct 2020 13:35:02 -0400
X-MC-Unique: TiYr4IK4NtSUSVdihDejlA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C28D88C8AC2
        for <selinux@vger.kernel.org>; Tue, 27 Oct 2020 17:35:01 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.193.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B49E160C11;
        Tue, 27 Oct 2020 17:35:00 +0000 (UTC)
Date:   Tue, 27 Oct 2020 18:34:57 +0100
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Vit Mojzis <vmojzis@redhat.com>
Subject: Re: [PATCH] libsemanage/genhomedircon: check usepasswd in add_user
Message-ID: <20201027173457.GC25212@localhost.localdomain>
References: <20201027165343.764095-1-vmojzis@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
Content-Disposition: inline
In-Reply-To: <20201027165343.764095-1-vmojzis@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2020 at 05:53:43PM +0100, Vit Mojzis wrote:
> Only add user homedir context entry when usepasswd =3D True
>=20
> Resolves:
> \#cat /etc/selinux/semanage.conf | grep usepasswd
> usepasswd=3DFalse
> \#useradd -Z unconfined_u -d /tmp test
> \#matchpathcon /tmp
> /tmp	unconfined_u:object_r:user_home_dir_t:s0

It should be enough to indent lines with few spaces, e.g.

Resolves:
    # grep usepasswd /etc/selinux/semanage.conf
    usepasswd=3DFalse
    # useradd -Z unconfined_u -d /tmp test
    # matchpathcon /tmp
    /tmp	unconfined_u:object_r:user_home_dir_t:s0


Also please provide Signed-off-by: see
https://github.com/SELinuxProject/selinux/blob/master/CONTRIBUTING.md


> ---
>  libsemanage/src/genhomedircon.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedir=
con.c
> index d08c88de..19dfb7b0 100644
> --- a/libsemanage/src/genhomedircon.c
> +++ b/libsemanage/src/genhomedircon.c
> @@ -966,6 +966,9 @@ static int add_user(genhomedircon_settings_t * s,
>  		}
>  	}
> =20
> +	if (!(s->usepasswd))
> +		return STATUS_SUCCESS;
> +
>  	int retval =3D STATUS_ERR;
> =20
>  	char *rbuf =3D NULL;
> --=20
> 2.25.4
>=20

--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl+YWjsACgkQviIJHj72
InWhIw//eHbDeTElVxMVFcJ4rbX8poaRWbTHpSElw8G34INL/Q6f6ZJr0l/2j1QJ
1rRxxtqf4CsOtQhSDLfCCIj9kBKK9qBcWS7V970bxiKdlAVcTlr31ewbRej9EYII
xCUOlq0WjyVZWiVKf/wuWKo+JU52UWccs58UeE6qHfWVdYA809x0TgKl2FprmfOR
GzHZzlsccFnqPCGAuDsJhlA64QfqCg/MI83lr15w5JukdJgckxbzsBi21nrUlPYd
xgZs7Fo90pspFjY5RpSXXVbguO+Q/C6uH8ARnCYr/792SWRRwMzEimdnwVW1B+ib
WxOAI1htqAySaFMBYRnRmJ2T8T6bQyk+Xk6uHthPSp+sTJCgC6Tjyq2exXhMXAbb
YTYhFhGAJgMTU9HFiVEDoxbp/bBQpIMTOvD5SJmSeCg2m7mgQ45eCMkn98ImGO3l
sSQF7P68bzzj67E2eiN1Iuls+9/5Bd9Z5NXbmrYeS9GqJxlA+bpEQNolZKzBWZl6
7rGyOb2Q8jGQ3c97/LtUrw3Wk52tlWPau0nvsfGBWCdcfr5dFUiUNKAxcudfg0SH
kUs+YhfUMhwRNskZrG38cF1O8OLl8P9jXPYxCRn8qzLh5f8ZQu3rzNT0FdeU/oCR
FgBvhQ4XrK9hIjlQppAE7prhQPWg9epqKYaWQTeKMo0cLufKg5w=
=mKF2
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--

