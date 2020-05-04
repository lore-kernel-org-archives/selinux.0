Return-Path: <SRS0=mV6Z=6S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337E5C47257
	for <selinux@archiver.kernel.org>; Mon,  4 May 2020 08:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E67F206D7
	for <selinux@archiver.kernel.org>; Mon,  4 May 2020 08:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U6LW+w4F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgEDIsu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 May 2020 04:48:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29349 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725928AbgEDIsu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 May 2020 04:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588582129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i1XwO3bgvTl26PbTwostijr5gFFJoi1cGTVZulmdJg0=;
        b=U6LW+w4F8bSoUFOjydAlvBfF88y0em1P7qZDjEQm9oaFYFmIIC3F2z0PCbJZD8WgOBTZy9
        Dqso+tm06mHZQVoYaUgfpjhI4JeVWriAt7Et/At9DDUvQCmi82TkHHhwSXOWPpFZO1YGKZ
        nORtaVou6C0AKVxsviYycAr3Zc7Ae2M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-u2zHtMvSOuGFg_MIwMx2Cw-1; Mon, 04 May 2020 04:48:45 -0400
X-MC-Unique: u2zHtMvSOuGFg_MIwMx2Cw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFC48EC1BE;
        Mon,  4 May 2020 08:48:44 +0000 (UTC)
Received: from workstation (unknown [10.40.193.225])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D5F6499CF;
        Mon,  4 May 2020 08:48:42 +0000 (UTC)
Date:   Mon, 4 May 2020 10:48:38 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        James Carter <jwcart2@gmail.com>
Subject: Re: [PATCH] libsepol/tests: drop ncurses dependency
Message-ID: <20200504084838.GC245818@workstation>
References: <20200501092330.1129016-1-nicolas.iooss@m4x.org>
 <CAP+JOzS7cBr2ANcKoYa-x_C-LHMWoXB2oLbdtfAyYPr4vWT-Tg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAP+JOzS7cBr2ANcKoYa-x_C-LHMWoXB2oLbdtfAyYPr4vWT-Tg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wxDdMuZNg1r63Hyj"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--wxDdMuZNg1r63Hyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 01, 2020 at 09:58:12AM -0400, James Carter wrote:
> On Fri, May 1, 2020 at 5:25 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrot=
e:
> >
> > ncurses library is not used anywhere.
> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>=20
> Acked-by: James Carter <jwcart2@gmail.com>

Applied.

>=20
> > ---
> >  .travis.yml             | 1 -
> >  libsepol/tests/Makefile | 2 +-
> >  2 files changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/.travis.yml b/.travis.yml
> > index 918958acfc80..4361d26cbb83 100644
> > --- a/.travis.yml
> > +++ b/.travis.yml
> > @@ -53,7 +53,6 @@ addons:
> >      - libcap-ng-dev # This package is not whitelisted for the containe=
r infrastructure (https://github.com/travis-ci/apt-package-whitelist/issues=
/1096)
> >      - libcunit1-dev
> >      - libdbus-glib-1-dev
> > -    - libncurses5-dev
> >      - libpcre3-dev
> >      - patch
> >      - python3-dev
> > diff --git a/libsepol/tests/Makefile b/libsepol/tests/Makefile
> > index e7e305e8150b..fc9bd1a303be 100644
> > --- a/libsepol/tests/Makefile
> > +++ b/libsepol/tests/Makefile
> > @@ -32,7 +32,7 @@ all: $(EXE) $(policies)
> >  policies: $(policies)
> >
> >  $(EXE): $(objs) $(parserobjs) $(LIBSEPOL)
> > -       $(CC) $(LDFLAGS) $(objs) $(parserobjs) -lcunit -lcurses $(LIBSE=
POL) -o $@
> > +       $(CC) $(LDFLAGS) $(objs) $(parserobjs) -lcunit $(LIBSEPOL) -o $=
@
> >
> >  %.conf.std: $(m4support) %.conf
> >         $(M4) $(M4PARAMS) $^ > $@
> > --
> > 2.26.2
> >
>=20

--=20
()  ascii ribbon campaign - against html e-mail=20
/\  www.asciiribbon.org   - against proprietary attachments

--wxDdMuZNg1r63Hyj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl6v1uAACgkQviIJHj72
InUeJA/+Nx0L7mSJ8BESgCQePjkIEk5oi7vQ6x4G3LFRU3xC+KlUVcY+9LenNnr8
4inCO7z9sF3gcjDK8Txjt8Q5y+SOXInnwHjpWfW147YCbIuSyht0v+NYf+9/ka7e
Kh0rHjm4ATUUtfjv/rKT4sERE5yiF7Va4nmHCbHpD9YprzMMDDMjVOv1m7hnEPxV
7U7eqZ5yI7TsDYhoLaP+VZ+nk4JD07ttf0aSGn3RAyhjXz9QGMle415nM87HuSoK
28xNHOTUy0KW5YLx8T2CjtchBHk0S2PdKbm+kN9XNcxG9xl/htCK0PiJyoKATaGT
XT+03m/1UFmod2wmbxvynmPnm32TzF62+SaMhs+7PXGEsovoT1oRDDHhtHEojnFt
rTNTxmdyJvg/obK2fNEzGwihoBOJ9dpkH+OIYNUwosJxvpHMc+cSUtbACbLG8ZUn
9Tu3msb/pNFRacpiGnVpPp6tmyWMdo+twnAaRn6zxdRl58It82au5PgyHVjINipY
1Aqn9BIe/LizTZgXCPDkmFZObJM21U6nYv2bocCLGS7V6OjEBmgS/iWyo7FQ8m9X
UXFbnper34EVV+6GTysWTBTsJabMc1YqAZGJy14pZwNqJE16SsKpp9Mb1F2KURah
f9r2nXjBNVBnlkdH0GF1j6pbSWaaURVXqtWU8oRR4K8pfOde2M8=
=CpST
-----END PGP SIGNATURE-----

--wxDdMuZNg1r63Hyj--

