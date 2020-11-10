Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA475C388F7
	for <selinux@archiver.kernel.org>; Tue, 10 Nov 2020 06:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D5B720657
	for <selinux@archiver.kernel.org>; Tue, 10 Nov 2020 06:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KAO1PLj9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgKJGZo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Nov 2020 01:25:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51971 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726006AbgKJGZn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Nov 2020 01:25:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604989542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jBc6WZMXhxKflA4ndi2HHzAV3RSJ4cK+0bMCkSnDJuw=;
        b=KAO1PLj9to9ibZhjh316rd5mPxHlz9iny+BWUvo6LSJdUEOgCDsTWye5awH1JoWq9draFX
        5wjicGVHaL8ZlBr/gJr9TZHTH9db9iby2nHmj/DEx0MT9NHyCINx/DDwy79qArBpH/qrIw
        qnr6e3bkb1LbPGsTlqBy8oJH7IPwY0w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-jZx3QX9nPT--x9ljFmWtXg-1; Tue, 10 Nov 2020 01:25:39 -0500
X-MC-Unique: jZx3QX9nPT--x9ljFmWtXg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C8471006C98
        for <selinux@vger.kernel.org>; Tue, 10 Nov 2020 06:25:38 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.193.226])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CE0386EF68;
        Tue, 10 Nov 2020 06:25:37 +0000 (UTC)
Date:   Tue, 10 Nov 2020 07:25:35 +0100
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Vit Mojzis <vmojzis@redhat.com>
Subject: Re: [PATCH v2] libsemanage/genhomedircon: check usepasswd
Message-ID: <20201110062535.GA166769@localhost.localdomain>
References: <20201030123351.GA78496@localhost.localdomain>
 <20201030164217.1374255-1-vmojzis@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <20201030164217.1374255-1-vmojzis@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 05:42:17PM +0100, Vit Mojzis wrote:
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

Acked-by: Petr Lautrbach <plautrba@redhat.com>

Merged with slightly changed commit message, thanks!


> ---
> v2 - invert condition as suggested by plautrba
>=20
>  libsemanage/src/genhomedircon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedir=
con.c
> index d08c88de..18d3d99a 100644
> --- a/libsemanage/src/genhomedircon.c
> +++ b/libsemanage/src/genhomedircon.c
> @@ -1332,7 +1332,7 @@ static int write_context_file(genhomedircon_setting=
s_t * s, FILE * out)
>  			s->fallback->home =3D NULL;
>  		}
>  	}
> -	if (user_context_tpl || username_context_tpl) {
> +	if ((s->usepasswd) && (user_context_tpl || username_context_tpl)) {
>  		if (write_username_context(s, out, username_context_tpl,
>  					   s->fallback) !=3D STATUS_SUCCESS) {
>  			retval =3D STATUS_ERR;
> --=20
> 2.26.2
>=20

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl+qMlcACgkQviIJHj72
InVaNA//XsHTIUBkC+1luQ/BREJ7l8E99Bcl6YdcmXYIXEanXLpUOFeM3NU2amoU
7AaJokNqVf/6NgY90xg1LBuimoyj6ab4fWBGNUIfLvDHnG/GKrue1YriTGna/QQW
dEHN4xhmrIWEmJRRHPGGn8btN5NDGDiQSJ7iC2WjUNp9LQcKA1mgxRiTl77RZRnQ
VzWgwL3BZpoZrn5SnFQaDUgj3vU6QAf6TJ7aWcwihWyg/O3BZpGB2FUF5I7tOI5W
9y7Gjykxz/w+qxgQld0i8j0DKcua8joJ7pCxMFZ6632fZmBkj4qAfla0nULl18nH
D8rIqBgWWVwJYxQ+nCooiOCDhsOaFDgB5xxxjDQTTAupk9Dx/mm7c3RrCInn0M+2
THe5hRw4EoT7bnN4UtPg8aDZqf3Q7aCrLVIE3wldGirxgOd7zB221Lrtk9WDLKGN
Uio3lJbsE63s5IatZyE1M7zaA2DPlRA4XY8XZG3v1w48Mro5gaj++Zd3X5Ly+RWZ
Qgbraj1zUJ1AO73s7JEYbdRONlBnzPRRhEFFo96BUsljaYecL0PtYzWNt2Ym/gkv
PtiNb/jdq7bRFxGqbDTZ2hUlR6eiw9Jl2DiW3dW/TKYX3iNxz4zpq1t9Vool4nFt
7+BdZEEenMXBiezmq/PNRRDXfgl5upL1w3z36EejG7GYszw6phI=
=dVQU
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--

