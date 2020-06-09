Return-Path: <SRS0=Yf2H=7W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B53C433DF
	for <selinux@archiver.kernel.org>; Tue,  9 Jun 2020 18:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 938B120734
	for <selinux@archiver.kernel.org>; Tue,  9 Jun 2020 18:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="He44Zpw2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387972AbgFISDx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:03:53 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46378 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732532AbgFISDv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Jun 2020 14:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591725829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=auOGa7BAxFhLWiIU2ihOLomRY2ps4ZVkjVG0QN7Avvw=;
        b=He44Zpw2Qj9oN70IU3U949bekLKwwvhs0WXhh1iTOphlR/ITyRc5ilYXwJxryzGuHv4XAo
        qLt4UhUMH7d4r4Pv6ESfsQq4vf8C+hIkmxal3uf6amUKnV1HqgUIg56FYcQZfu4Sagk5Ab
        dHt4HvCiu11Vwiqy+0B3EWzE3YTxJZs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-DqM8BfNYPnmYBwUvQpaMXQ-1; Tue, 09 Jun 2020 14:03:42 -0400
X-MC-Unique: DqM8BfNYPnmYBwUvQpaMXQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE398835B40;
        Tue,  9 Jun 2020 18:03:41 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8011E5C48E;
        Tue,  9 Jun 2020 18:03:40 +0000 (UTC)
Date:   Tue, 9 Jun 2020 20:03:37 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Cristian Ariza <cariza@collaborative.li>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: No window opening when running sandbox -S
Message-ID: <20200609180337.GB139421@localhost.localdomain>
References: <20200609170747.GA139421@localhost.localdomain>
 <7dd7daa7-217a-fc99-f7d7-d1c629f7c592@collaborative.li>
MIME-Version: 1.0
In-Reply-To: <7dd7daa7-217a-fc99-f7d7-d1c629f7c592@collaborative.li>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2020 at 06:17:40PM +0100, Cristian Ariza wrote:
> On 09/06/2020 18:07, Petr Lautrbach wrote:
> > Do you use X session or Wayland?
>=20
> I've been doing tests now on [Xorg + XFCE] and [Wayland + Gnome]. What I
> could see is:
>=20
> * Gnome: -S doesn't work, -X firefox seems fine
> * XFCE: -S works perfectly, -X firefox doesn't always work and I haven't
> really found what changes between when it works and when it doesn't.
>=20
>=20
> > Btw few years ago I wrote support for bubblewrap in sandbox so it's use=
s it
> > instead of seunshare [1] but I haven't finished it and sent for review.
> >=20
> > https://github.com/bachradsusi/SELinuxProject-selinux/commit/5158ea1f55=
2fc098647d4c503f646bdcb6d0737f
>=20
> What benefits would bublewrap provide?
>=20

I don't know. It should provide everything `sandbox` needs, and it's used i=
n other projects while `seunshare` seems to be
written just for `sandbox`.




--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl7fzvIACgkQviIJHj72
InWPEg/+IERZNqX0HzqKlmt8RSDpH82dN388NYFIThLt9aDoEm2DR3XrP45G3PJp
Stc4WNs50+eSKFND5diRs58Ya7Q3dHG1uT4xy1+Ahm6SiY7O/kUznXdQAxKagf1c
ZoXviWeSA9IuJ2y1C8AxC0xujPYZ6ozW8ON8OQGRqQIdXBX7oToinK03sygm2nYW
p++J7qNODGeJJnMTjLGVoyGFS5rk8FpxLoeyRTvrqUGXkTdCa1Xi6RD7fSx7MG2Z
zjnfQh51pEcdqcd/vFL9prIB2BauBI4IXFj6nH6gltpjZ5SmaXMp/09Vu0eoYtEs
ertx4U32NAP8wqqji9f1FIdrBdI3D8WWcI4h4riKcVeOTzfMpSKzCQoHhTjAEXUH
48FJa0iBn+NFmVEuaNxGmZTPQh/sX5w9dGIuXWO4AoaV+XG4vsOMvhE6P5GuV5Lb
1DKSqfx5dikSLrulEF0VpMhHPF5oUUWcoc3YJnI1Tsy1E1GyXrERGHYke4E/EXku
CXT4jXRPr8dmkg4BCLYljZmzsD8kf32mI8QnP+LINX8Dkw19bYIrcsuy1nfNObM2
Ek/uv0c625N7yxgEUqcgiH0XOE8NX+hM93I1lAywN9Gy4R6I2jk5pqd3fseHUzQ/
xCeDNGIvBivqCJ3mYBhLNnpU3ZKbIhrFtXb8d39ojnqaVdOYVGk=
=tUix
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--

