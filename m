Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459B6C4742C
	for <selinux@archiver.kernel.org>; Wed, 11 Nov 2020 10:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9FE520674
	for <selinux@archiver.kernel.org>; Wed, 11 Nov 2020 10:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EjmSipZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbgKKKHq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Nov 2020 05:07:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47912 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727000AbgKKKHp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Nov 2020 05:07:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605089263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lPDIqP+C3+iMEjnSZZm3a6SB/y/ZDkzavqY8qxEDeWs=;
        b=EjmSipZYfY01e6WDyvfbRoBprRZwbEHJKCVBaiv2osiAn6r3nEpn4G4FORyKeMVsZB4XW7
        CExCG2IJ0NZo4WB/0G9X03GGVfm52la2hoHkd6TbfCQKi0uKJWHSPnXw/wBJ/EadO/4izY
        5X57W6kaHvNUy8L8cbrAPid32uwwQ90=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515--ZFe0FaVPGOxdtWu2ObZgw-1; Wed, 11 Nov 2020 05:07:40 -0500
X-MC-Unique: -ZFe0FaVPGOxdtWu2ObZgw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80DC6186DD4C
        for <selinux@vger.kernel.org>; Wed, 11 Nov 2020 10:07:39 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.193.83])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D6BD5B4D6;
        Wed, 11 Nov 2020 10:07:38 +0000 (UTC)
Date:   Wed, 11 Nov 2020 11:07:35 +0100
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: [PATCH userspace] selinux(8): explain that runtime disable is
 deprecated
Message-ID: <20201111100735.GA213493@localhost.localdomain>
References: <20201111095134.481658-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <20201111095134.481658-1-omosnace@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2020 at 10:51:34AM +0100, Ondrej Mosnacek wrote:
> Update the main SELinux manpage to explain that runtime disable (i.e.
> disabling SELinux using SELINUX=3DDisabled) is deprecated and recommend
> disabling SELinux only via the kernel boot parameter.
>=20
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  libselinux/man/man8/selinux.8 | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
>=20
> diff --git a/libselinux/man/man8/selinux.8 b/libselinux/man/man8/selinux.8
> index 31364271..721a65f4 100644
> --- a/libselinux/man/man8/selinux.8
> +++ b/libselinux/man/man8/selinux.8
> @@ -19,12 +19,12 @@ enabled or disabled, and if enabled, whether SELinux =
operates in
>  permissive mode or enforcing mode.  The
>  .B SELINUX
>  variable may be set to
> -any one of disabled, permissive, or enforcing to select one of these
> -options.  The disabled option completely disables the SELinux kernel
> +any one of Disabled, Permissive, or Enforcing to select one of these

Is there a reson for these changes?
policycoreutils/man/man5/selinux_config.5 aka selinux_config(5) doesn't use
capitals:

    SELINUX =3D enforcing | permissive | disabled

> +options.  The Disabled option completely disables the SELinux kernel
>  and application code, leaving the system running without any SELinux
> -protection.  The permissive option enables the SELinux code, but
> +protection.  The Permissive option enables the SELinux code, but
>  causes it to operate in a mode where accesses that would be denied by
> -policy are permitted but audited.  The enforcing option enables the
> +policy are permitted but audited.  The Enforcing option enables the
>  SELinux code and causes it to enforce access denials as well as
>  auditing them.  Permissive mode may yield a different set of denials
>  than enforcing mode, both because enforcing mode will prevent an
> @@ -32,6 +32,24 @@ operation from proceeding past the first denial and be=
cause some
>  application code will fall back to a less privileged mode of operation
>  if denied access.
> =20
> +.B NOTE:
> +Disabling SELinux by setting
> +.B SELINUX=3DDisabled
> +in
> +.I /etc/selinux/config
> +is deprecated and depending on kernel version and configuration it might
> +not lead to SELinux being completely disabled.  Specifically, the
> +SELinux hooks will still be executed internally, but the SELinux policy
> +will not be loaded and no operation will be denied.  In such state, the
> +system will act as if SELinux was disabled, although some operations
> +might behave slightly differently.  To properly disable SELinux, it is
> +recommended to use the
> +.B selinux=3D0
> +kernel boot option instead.  In that case SELinux will be disabled
> +regardless of what is set in the
> +.I /etc/selinux/config
> +file.
> +
>  The
>  .I /etc/selinux/config
>  configuration file also controls what policy
> --=20
> 2.26.2
>=20

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl+rt+AACgkQviIJHj72
InWY0w/+ICtAYKI1stQDpa924ardmVd6afeE2WpppI9PPPqTFiKj8HT9DFiZc71V
QKWc13YDUJZ1s6NT14PPQRHs298JLJReo+q1QXVVa2xRXG8deI6QxFGeD4uJUu0z
xiOtWc11uU6oLgMR1JFKyK0D/v9Ny36C+4Q3+8chjCBMYCVjZkl8H83V+tqhptEa
neTdShlYHW5eSondrTv1NDA5xB1gwm/hRRTSr/ilJDbRBnUEmHfyVKScEVsSzViQ
NTWD2Me6F5UTql1Gj4nZkSxr2qV9c/UwlIWyxvmQRm7nLCAQkmVrUNXqDm6/HaPL
0xgNkkdexsiuUmlL0VNZeV+Bdk3olvC7/tv4qBpaWQJyNESlE1RJayaurMJV+5u3
H10z5EiAw9ULhEkNY5pF2RhZRwku5k+7YXa2o1ujxFWr4UgT2qqSIpBPpaUIW3s9
T1yN8PE0R8PHGOLFVQIYlJxFqSGUk3FjSxyblzbww0FLbzcKRt/eMAw6ISkXJIAy
HQ04yVXnrcTrEkTpVS8rNX02pO8Jc5Vh12NYtVAB7DhgQYfj0/YtFcZM8PdRqEav
5VsolPJKwLV7mvcgS0J0HNZ9NRRSyxRXgRl50QrC7sX8aSyVTsyQhJaeD1IgMMfh
0cHJ/g1WhlcqmAuXSW2T5p67zUUW6H17MBaNO2Z9R6pt466d1SQ=
=hhmH
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--

