Return-Path: <SRS0=8qmv=EF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B732FC4363A
	for <selinux@archiver.kernel.org>; Fri, 30 Oct 2020 12:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FB132087E
	for <selinux@archiver.kernel.org>; Fri, 30 Oct 2020 12:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WKevvFKW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgJ3MeA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Oct 2020 08:34:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53379 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726277AbgJ3Md7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Oct 2020 08:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604061238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c6ijKIov5o9OCKF7sPaB4OuciAQ82QkJcgGprDVBRTQ=;
        b=WKevvFKWa1zHUs1cEqwXeQQN3vZMRrdEMD0J0FDp9vW46Ls2PbQaQhjfG0HphTgJvIIXJx
        gIXO2tXnxPyvKTCA5zv9IcBUQuMxpHcOyUI3LKSnJ8mT23x3c+BVZVBsI8s2lo/DR7m9jB
        3PLn7JIZgLx46MkcyaMgQTywykhX1hI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-EsoK7KgqO4C1fmh-NHaV0w-1; Fri, 30 Oct 2020 08:33:55 -0400
X-MC-Unique: EsoK7KgqO4C1fmh-NHaV0w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC1A0CFF28
        for <selinux@vger.kernel.org>; Fri, 30 Oct 2020 12:33:54 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.193.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D1DC155761;
        Fri, 30 Oct 2020 12:33:53 +0000 (UTC)
Date:   Fri, 30 Oct 2020 13:33:51 +0100
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Vit Mojzis <vmojzis@redhat.com>
Subject: Re: [PATCH] libsemanage/genhomedircon: check usepasswd
Message-ID: <20201030123351.GA78496@localhost.localdomain>
References: <20201029104802.GA52464@localhost.localdomain>
 <20201029172845.1321021-1-vmojzis@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <20201029172845.1321021-1-vmojzis@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2020 at 06:28:45PM +0100, Vit Mojzis wrote:
> Only add user homedir contexts when usepasswd =3D True
>=20
> Resolves:
>    #cat /etc/selinux/semanage.conf | grep usepasswd
>    usepasswd=3DFalse
>    #useradd -Z unconfined_u -d /tmp test
>    #matchpathcon /tmp
>    /tmp	unconfined_u:object_r:user_home_dir_t:s0
>=20
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>  libsemanage/src/genhomedircon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedir=
con.c
> index d08c88de..fc75fa8c 100644
> --- a/libsemanage/src/genhomedircon.c
> +++ b/libsemanage/src/genhomedircon.c
> @@ -1332,7 +1332,7 @@ static int write_context_file(genhomedircon_setting=
s_t * s, FILE * out)
>  			s->fallback->home =3D NULL;
>  		}
>  	}
> -	if (user_context_tpl || username_context_tpl) {
> +	if (!(s->usepasswd) && (user_context_tpl || username_context_tpl)) {

I guess this condition is reversed - we want to write user contexts when us=
epasswd is True


>  		if (write_username_context(s, out, username_context_tpl,
>  					   s->fallback) !=3D STATUS_SUCCESS) {
>  			retval =3D STATUS_ERR;
> --=20
> 2.26.2
>=20

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl+cCCgACgkQviIJHj72
InVFBQ/6A/CjcDf4IpUGSuR7FiSCyXcIXjtQhDboyneTCwAMBnSD+9uYgAeY2DsI
jYkHnnGPAy4/NAUSpDzVOsq5CcJQo2TtkgLau4sIvPDoIsY3pyJ+sTycVntdXpCF
omQofB91fIMZ04vBmPVyoKN0aIadNDAU9ovsAgm6WJCyIAifC354f9Ble5g6DVf7
RlwgSuQAmYf5+2VwuZ1me6ueVmRW5QgPEOGZgdr/PqoxpOXRBpy2ytchzk1famZ8
+uZmFyzUGlrVQB4RfD6d2HMXIQFzK5aJXDTSt+lKV+DVPoB8IGdEwN+pF29XRgOw
vv1chSpe+kz4nMPvO8Gc29bix/WNcDzkn4xkdN1gkcccFzCniv04L612U80B/7Gc
zH1zbY9FzL/8w/+3aoWBN2+RWQv2qzAxgdV9G6P8d3tadnMbGM9czL3wrSGK5G0p
3JByVecowpWR5bW9Lf3rYSmWKP4J01VU/UuX+91F4N2e0JDg8LbVZM0OmwXfrBsG
nfrLABAMM/T/49LHikO8e/YFVGqDA31D/jsZ+wqExlBuANbTtUu7hXtvhshQ0iOG
cg4OxdsXycVHNqBmddVA9VPRx6FQ1ml9Q5CuzREwh6FP8MVgspkdlODwqQDAWqmF
NDKlevgJvaYCpLcwMhmhAkyLNOBi+neU7f0eRT2xHpCVPEylUI0=
=ttd8
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--

