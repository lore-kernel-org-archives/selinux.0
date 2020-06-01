Return-Path: <SRS0=O06S=7O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9500CC433DF
	for <selinux@archiver.kernel.org>; Mon,  1 Jun 2020 08:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70673206E2
	for <selinux@archiver.kernel.org>; Mon,  1 Jun 2020 08:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zoens6bE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgFAInQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 1 Jun 2020 04:43:16 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21570 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726142AbgFAInQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 1 Jun 2020 04:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591000994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0tYJwdayQ6HIrvQfOCNrs4ArprDEG/cND9ylxBQCGGc=;
        b=Zoens6bEAVeKQLIrfQpQg/npwIWZpHbv3yoEqZOQBLBBbZwQ50bCcmZlaluET5V76LxSb9
        JZFJ64FA7Ehla8Kp9IVoj2rbzKQQnspA2v4Z2Y7E21WWxzybqpvKYojilWCymABxtYrt8O
        PPcLXkmdUTxYJtsFyKeXcVJmS5FsEwE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-pGF_mUDEOJOlq-f4jwkXcw-1; Mon, 01 Jun 2020 04:43:10 -0400
X-MC-Unique: pGF_mUDEOJOlq-f4jwkXcw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3229A18A8220;
        Mon,  1 Jun 2020 08:43:09 +0000 (UTC)
Received: from workstation (unknown [10.40.194.171])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D2F08D01EB;
        Mon,  1 Jun 2020 08:43:07 +0000 (UTC)
Date:   Mon, 1 Jun 2020 10:43:04 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Topi Miettinen <toiwoton@gmail.com>
Subject: Re: [PATCH v3] secilc/docs: fix use of TMPDIR
Message-ID: <20200601084304.GA30453@workstation>
References: <20200515114111.11428-1-toiwoton@gmail.com>
 <20200515133540.GD255621@workstation>
 <CAEjxPJ6EQmzHqXWO02GzCwf-uLG1zePkkhgboAknqwxdxR04hQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ6EQmzHqXWO02GzCwf-uLG1zePkkhgboAknqwxdxR04hQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2020 at 09:03:44AM -0400, Stephen Smalley wrote:
> On Fri, May 15, 2020 at 9:36 AM Petr Lautrbach <plautrba@redhat.com> wrot=
e:
> >
> > On Fri, May 15, 2020 at 02:41:11PM +0300, Topi Miettinen wrote:
> > > Environment variable TMPDIR may be already set for the user building
> > > and this could be equal to $XDG_RUNTIME_DIR or /tmp which are existin=
g
> > > directories. Then when running 'make clean', there are unintended sid=
e
> > > effects:
> > >
> > > rm -rf /run/user/1000
> > > rm: cannot remove '/run/user/1000/dconf/user': Permission denied
> > > rm: cannot remove '/run/user/1000/systemd': Permission denied
> > > rm: cannot remove '/run/user/1000/gnupg': Permission denied
> > > rm: cannot remove '/run/user/1000/dbus-1': Is a directory
> > > rm: cannot remove '/run/user/1000/inaccessible': Permission denied
> > > make[1]: *** [Makefile:68: clean] Error 1
> > >
> > > Fix by always setting the variable.
> > >
> > > Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
> > > Suggested-by: Petr Lautrbach <plautrba@redhat.com>
> >
> > Acked-by: Petr Lautrbach <plautrba@redhat.com>
>=20
> Should I merge this or do you have it?
>=20

Applied.

Sorry for the delay.
--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl7Uv5EACgkQviIJHj72
InUmDxAAgEp/2BZOQRuau8bC5Fqe3VF1/QExzaMgT2DTDiQHAUF/o9JINzcj8Z23
1TXRQKSOu1BVaqUJlvrQ7Y4HJM85fzJchw90MUyfs16TomT3I4x32ejkxiR/bd0C
R6ZyuxXLcAyCa1SWdra/OWLoZ8vnZdArOJole24jkrHUYCwutNbaDX2fl0IsNa63
gdL7Svsmqu8FYYgl8p+ukS5xMFF3R8hpcsuTXl2Q7aVqbq6tlZuPqzfeZ0r0LedZ
ONe93r+RyrgG76F6wJmtmoqTQOhGW824y8m34yVy1xKLVUk5Br0T6CDCXl5HQW9K
bfMhekd6YsIGeCLEnAdAnED6Rhl4WQbZ3BFWDStIgBiNhd6jEtTYbr0iSytbk9O7
3XzgtZ9qG5SVDR2x72PYoaPF5A/hSQlWofWFVP9+4mnQy2fj8Nix3c4tVTzZp3WV
TDZyEGIYl4wANYzWgP/cF7HL+eqXI24HwkwCKeerALJI4tEzeTqI6mWxViI9NAs2
UkB/9p6zutggMX+z8hm8uQRt4xIomQYhrOjp7wO1Bek9U4Gt95TZ3LGZKV7n6OMh
/urMxza2FAKQDXx1mGdWvVKCpG2OhdGc/ZNtRDptiilc3TfXS7M/X5wZVYcU89oF
JZsSPTqzQgsKi6vG7VL75d07WCPIEPm9v94F0jP68Q7QqgdU8w8=
=uFO4
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--

