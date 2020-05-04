Return-Path: <SRS0=mV6Z=6S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AC6C3A5A9
	for <selinux@archiver.kernel.org>; Mon,  4 May 2020 08:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A329F206B9
	for <selinux@archiver.kernel.org>; Mon,  4 May 2020 08:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WiqNUAV0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgEDIlp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 May 2020 04:41:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33539 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726351AbgEDIlp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 May 2020 04:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588581703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FfIvT+DY3Wx3kg61fi9zh79r48I9jYo0lZqCLfkXYo0=;
        b=WiqNUAV0TPysGuuVlKXGp9Q1zmW96VGNxtdDmemd5wDBR5xnl/NfqTuYpNywCP5FG510XV
        fvRpZ4L63iEYjcHljZK7yXISnpWIHdEf34oHyXVBZnu7xr6/FnBTtAfxtuMchcftk4ihmM
        oGXoEKmWC5zViiNernyGi5zvVGn18wY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-vzzR3CIuNFuoll1uzwxQwA-1; Mon, 04 May 2020 04:41:41 -0400
X-MC-Unique: vzzR3CIuNFuoll1uzwxQwA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7AD1100A614;
        Mon,  4 May 2020 08:41:40 +0000 (UTC)
Received: from workstation (unknown [10.40.193.225])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FCF219C58;
        Mon,  4 May 2020 08:41:38 +0000 (UTC)
Date:   Mon, 4 May 2020 10:41:35 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: Re: [PATCH v2] libselinux: mount selinuxfs noexec and nosuid
Message-ID: <20200504084135.GA246062@workstation>
References: <20200428111142.6072-1-toiwoton@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200428111142.6072-1-toiwoton@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2020 at 02:11:42PM +0300, Topi Miettinen wrote:
> Mount selinuxfs with mount flags noexec and nosuid. It's not likely
> that this has any effect, but it's visually more pleasing.
>=20
> Option nodev can't be used because of /sys/fs/selinux/null device,
> which is used by Android.
>=20
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Applied.

> ---
>  libselinux/src/load_policy.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
> index fa1a3bf1..2aea826f 100644
> --- a/libselinux/src/load_policy.c
> +++ b/libselinux/src/load_policy.c
> @@ -279,7 +279,8 @@ int selinux_init_load_policy(int *enforce)
>  =09const char *mntpoint =3D NULL;
>  =09/* First make sure /sys is mounted */
>  =09if (mount("sysfs", "/sys", "sysfs", 0, 0) =3D=3D 0 || errno =3D=3D EB=
USY) {
> -=09=09if (mount(SELINUXFS, SELINUXMNT, SELINUXFS, 0, 0) =3D=3D 0 || errn=
o =3D=3D EBUSY) {
> +=09=09/* MS_NODEV can't be set because of /sys/fs/selinux/null device, u=
sed by Android */
> +=09=09if (mount(SELINUXFS, SELINUXMNT, SELINUXFS, MS_NOEXEC | MS_NOSUID,=
 0) =3D=3D 0 || errno =3D=3D EBUSY) {
>  =09=09=09mntpoint =3D SELINUXMNT;
>  =09=09} else {
>  =09=09=09/* check old mountpoint */


--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl6v1TgACgkQviIJHj72
InUFqQ//UYP0huLj0USmWq+Vcb8YPhwVuLRHcisL21emi5xlwswbnwZYRW1Mq2lg
1K50+FddXTKLXVlJ6DuGCYHHwXVMuzQjax3dxKYTF7Mkbcxp8P0RuNiW1zh7Ciow
FHbrGhyIiVOHYciN0Dqqxbyn1l3kqGzT0roFPOxhLRX61FZUm1jIqZcKVSOUwNaA
TtvQqX+QOv+SUJluihiqCaVXoYPo7z+yslqaE0Xf6PuUPRfj//Enm7MqlzA+w8ng
oTpcf5ncYdn8/Kb50hiTQD+SLfhIoQbahn/Y4rIhACaJ7dG2zgFO2GsLGi4BOG2B
DZEKfJDXcubZXlu/Cbu/kAnVpDaTJm8vyN/fgLbbD6OWazxejMXhLWhdHZjdrlpv
RS/jgK/WOLUxl9g0Qt9bkr7sTpzwehFQhEmmLsiVJPI68HIFr9mywdjV8vQg4CeY
inj0aFzZA9hB0kUTSXxql+kzHzGKgeH1gl8RCLS5m/rdXqIqAkxrevNentxvt5xc
MPcIgn1DImjd1JxCE0KnRzZIR1SDwEsbjWY2k8FF0VMZADT+pDEF0zlk7vNq1nAg
UikFzsBZSwqXoG7RUtqvIEIxSDpClFALqHlzTvV8GirZ4Hm5DmYMFQCxoaxQF3fw
7OaQKkruL56zgXgPcL3P4cDUZHcVHsDqjzQjN0BLe3EFFK5Fysc=
=iSVH
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--

