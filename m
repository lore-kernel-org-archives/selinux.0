Return-Path: <SRS0=Gc5K=6Z=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9964FC47255
	for <selinux@archiver.kernel.org>; Mon, 11 May 2020 07:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 709FD2080C
	for <selinux@archiver.kernel.org>; Mon, 11 May 2020 07:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eSHPVUpP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgEKHT5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 May 2020 03:19:57 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31520 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725854AbgEKHT4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 May 2020 03:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589181595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EEMHk+RzzjLhBKGw8Zhiqd5dO9UrPuua6E/LlsOOJhU=;
        b=eSHPVUpPpOy2Nv6e6KBZVxr5VrjQTKhSwN8DkYAVhC54KN+JNZqC6aNtLH5drcAz07qmhK
        c8sLtpHg/3A1zPZPJ1o/rpSnJQrTws2YG1z4FeYf7pzHcqlePdfw+zH13orNq3QpF1Tq/K
        ZjqNDazRwQa6GpHtIrDIg5cnGMlucu8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-WE7Oux7kOjGUZ_qOoqWCIg-1; Mon, 11 May 2020 03:19:51 -0400
X-MC-Unique: WE7Oux7kOjGUZ_qOoqWCIg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 114BE18B6324;
        Mon, 11 May 2020 07:19:50 +0000 (UTC)
Received: from workstation (unknown [10.40.194.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A14A60CD1;
        Mon, 11 May 2020 07:19:49 +0000 (UTC)
Date:   Mon, 11 May 2020 09:19:46 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dac.override@gmail.com>
Subject: Re: [PATCH v2] mcstrans: start early and stop late
Message-ID: <20200511071946.GA3435@workstation>
References: <20191211134423.2357254-1-dac.override@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20191211134423.2357254-1-dac.override@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2019 at 02:44:23PM +0100, Dominick Grift wrote:
> It stopped too early, exposing a bug in sudo selinux_restore_tty():
>=20
> SELINUX_ERR op=3Dsetxattr invalid_context=3D"wheel.id:wheel.role:users.te=
rminals.pty.pty_file:SystemLow"
> avc:  denied  { mac_admin } for  pid=3D859 comm=3D"sudo" capability=3D33 =
scontext=3Dwheel.id:wheel.role:sudo.wheel.subj:s0 tcontext=3Dwheel.id:wheel=
.role:sudo.wheel.subj:s0 tclass=3Dcapability2 permissive=3D0
>=20
> If we want to be able to reference human readable contexts in SELinuxCont=
ext=3D and nspawn -Z and -L then we need mcstrans ASAP
>=20
> v2: stop late, but do stop
> Signed-off-by: Dominick Grift <dac.override@gmail.com>

I've asked for review one of Fedora systemd maintainers and he's fine with =
this
change. He even suggested to follow udev and to drop 'Conflicts=3Dshutdown.=
target'
and let mstrans to be stopped by a signal when everything else is stopped a=
s it
was in your first version.

I'm fine with both versions.

Acked-by: Petr Lautrbach <plautrba@redhat.com>



> ---
>  mcstrans/src/mcstrans.service | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/mcstrans/src/mcstrans.service b/mcstrans/src/mcstrans.servic=
e
> index 09529432..c13cd09a 100644
> --- a/mcstrans/src/mcstrans.service
> +++ b/mcstrans/src/mcstrans.service
> @@ -2,6 +2,9 @@
>  Description=3DTranslates SELinux MCS/MLS labels to human readable form
>  Documentation=3Dman:mcstransd(8)
>  ConditionSecurity=3Dselinux
> +DefaultDependencies=3Dno
> +Before=3Dshutdown.target sysinit.target
> +Conflicts=3Dshutdown.target
> =20
>  [Service]
>  ExecStart=3D/sbin/mcstransd -f


--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl64/IwACgkQviIJHj72
InUxjxAAoywL85tk3VBoGVA+8DObeqyTQEP2a9RfCRw1kFwHIw/PVaBjbCuaOsE9
e5SJGxDw7dcx+YFbcLTBXsAtXmvIrvskOACk5FgLxMoLBdM5YPfmyFh8vIm4Jt0n
aYi2WrSG3NHI08nJQ11UG4K3Wr6ZmjQZSVE4SKxDula42wWb/j2mUR5PltJQxg/C
rgpj8utxzeo1A/t7ls8LYCwa/tr9LHJHhDd1IbpWd5wnR5hd2e9Q6WCPOgHbXiqT
Kuky9kRhAibtaH3/zqojjuLZEzS9h9MuGhFbiywLoaJung/usYuPmCcpS60WLADU
koW11ncXJCfwuiEEO48LRGXdMfxaU8w1Jp+pjGFphHWgTeDS62ZZDWygjT1Qn0Vb
xEP9UtlmnG6mv0WpQDWymOfqmSO1HGJrlDZ7r1SF9PpR0H2BeujA42pvvszmuafq
mO/iHUTb8s6X7VTN8FS5aqAxIOE4VMR4mfQC/9tdB+oBR0deFxC+lgiYzYK4Q2vT
M+Ek0G9kuIrIXQy79As8HzUtjFq/RUSUaa9hSADgXwNkTWWGqeY1H4697FOp/xEI
Wgm+2Vkg5E8mi/o8SzRUZAc/MshWXTnFUwvRmHAovne7dMhnKx+Jf5FzyArduW4D
k2VuvjEFmfFhWv6YW0tb18p0F44slCAlr4eiiRzZQeOVnQ8dan8=
=UhYU
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--

