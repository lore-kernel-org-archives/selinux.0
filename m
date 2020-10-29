Return-Path: <SRS0=BfnB=EE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1124AC55178
	for <selinux@archiver.kernel.org>; Thu, 29 Oct 2020 10:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 719D520728
	for <selinux@archiver.kernel.org>; Thu, 29 Oct 2020 10:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mn3zjYZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgJ2KsM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Oct 2020 06:48:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27282 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726433AbgJ2KsL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Oct 2020 06:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603968490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C9+1sTJj6NZw6P5zFYgtod7iX0Zz2Td0l6CydGjR+QU=;
        b=Mn3zjYZrq8FDS8ggtTc34RkJ6iwp2tRjUwicazzUkjZMA1+QqjLFrn38Vd2hBiFNahAkYP
        6ZJFQNp4Pmsgjz7R0+/Hdl8A48zaCu+icBDtVywgVcUQGRjb7rJxpFnoYGVi5z99qzfomI
        F5gbuOFqom5k90f8hoErR5GwoIgN2Pk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-k4hhaR2cOnqPg9s8H1HoyQ-1; Thu, 29 Oct 2020 06:48:08 -0400
X-MC-Unique: k4hhaR2cOnqPg9s8H1HoyQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77A8CAF9A0
        for <selinux@vger.kernel.org>; Thu, 29 Oct 2020 10:48:07 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.193.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 31C44756A6;
        Thu, 29 Oct 2020 10:48:05 +0000 (UTC)
Date:   Thu, 29 Oct 2020 11:48:02 +0100
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Vit Mojzis <vmojzis@redhat.com>
Subject: Re: [PATCH] libsemanage/genhomedircon: check usepasswd in add_user
Message-ID: <20201029104802.GA52464@localhost.localdomain>
References: <20201027173457.GC25212@localhost.localdomain>
 <20201027174539.769006-1-vmojzis@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <20201027174539.769006-1-vmojzis@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2020 at 06:45:39PM +0100, Vit Mojzis wrote:
> Only add user homedir context entry when usepasswd =3D True
>=20
> Resolves:
>   #cat /etc/selinux/semanage.conf | grep usepasswd
>   usepasswd=3DFalse
>   #useradd -Z unconfined_u -d /tmp test
>   #matchpathcon /tmp
>   /tmp	unconfined_u:object_r:user_home_dir_t:s0
>=20
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
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
>

add_user() seems to be too deep. Would it make sense to (s->usepasswd) in
write_context_file() as part of a condition on line 1338:

	if (user_context_tpl || username_context_tpl) {

?

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl+andsACgkQviIJHj72
InXhkQ/+MoiorYG8NoNcQKsuIz1GvGwHLZ+pWot/1P39dzqmZlZP/sGWEirYftQ7
xLhAI/OfbytxX4wFmwGLlhi3u6RW+UV48YjaOOJFNIVrrLT/KGJWrTFG6e8X5HKl
JXFlRMXzvP3Lnz3LUkwrzQEIpFJgHXDdjA3G8gfTpzoeV3oV1bxMfpfNobaPoGAu
mcR6ToIc/0nOI8+Zf+DbY7g+aV6Abs+OooSB59VZg8x0PktUZz/ZzCw1nomj7rA3
SQTsJN48y8ox8Zahv0nT7HX8YC1zpxFrqRUbKaHn5gk2zQnCCUvo+iCmxupxr5tA
OhgeR1HZScplyidiPWx1pyk1rSXu5Znyp5Ly/gK7OirkEMv9jDsz4l0GfjA/g8/v
M5m8VzsDM2oTmjZry/ssy/e8F4HvVH7lcy6/16XhqPZJGQIGVSSUOPoMAdTLaSIH
04nP7KGwek3COdkFLIcLK/5qdZzlZjaDe9FyFyYvJLJeBVLYbGXeFZSQ0Yrt2trt
IidbrhRQja7WrQHSJzLP2pizw/EWift9x3Ur/5FWvjC8/cF96/NDSvaRu/jADndy
YSlZgYYg6lF4y6GrihO4wtSH13397S/DJkX0IaKPcjvEysFJc6moCeCs4qWR4qKE
piW6v2/hWeao1/Vwo1bPG5yoQzqhuW+W1xCH1WgwsPEP0w9eMTY=
=SPw2
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--

