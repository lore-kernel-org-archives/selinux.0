Return-Path: <SRS0=fYOO=63=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E12EC433E0
	for <selinux@archiver.kernel.org>; Wed, 13 May 2020 15:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 198DB205ED
	for <selinux@archiver.kernel.org>; Wed, 13 May 2020 15:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GOEAK+eO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgEMPOL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 May 2020 11:14:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49133 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728692AbgEMPOL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 May 2020 11:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589382850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1/dD9xyZ3uS23BUxj2zJ154uvIyv2UpRh+wIbNHLHiU=;
        b=GOEAK+eOiUV8Uq4uS2l0eCo06b5nEox8qbh1JjE90fk2b8Q+uKNgTCpFvEJBPdyadcxUlQ
        FyZZFGof6iR4sp8WPlbDQJ7llwLtlMlaMYpUseX8Hel0bvvNqzS+lf9n27HP0VwpJ9Yfs5
        HWsWPgsDTbEIqOdMYZFOdjP6JHQK05Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-IL07HdsvMuK3Xy8lNIsHwg-1; Wed, 13 May 2020 11:14:05 -0400
X-MC-Unique: IL07HdsvMuK3Xy8lNIsHwg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8EDA803CB8;
        Wed, 13 May 2020 15:13:33 +0000 (UTC)
Received: from workstation (unknown [10.40.192.247])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BA81960F8D;
        Wed, 13 May 2020 15:13:32 +0000 (UTC)
Date:   Wed, 13 May 2020 17:13:30 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        William Roberts <william.c.roberts@intel.com>
Subject: Re: [PATCH] python/sepolicy: silence new flake8 warnings
Message-ID: <20200513151330.GA184355@workstation>
References: <20200512192957.112866-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
In-Reply-To: <20200512192957.112866-1-nicolas.iooss@m4x.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2020 at 09:29:57PM +0200, Nicolas Iooss wrote:
> pyflakes 2.2.0 improved the way format strings are analyzed, which
> triggers new warnings in flake8:
>=20
>     python/sepolicy/sepolicy/manpage.py:1046:23: F999 '...' % ... has
>     unused named argument(s): type
>=20
>     python/sepolicy/sepolicy/manpage.py:1225:23: F999 '...' % ... has
>     unused named argument(s): user
>=20
> Remove the unused arguments in order to silence these warnings.
>=20
> This fixes failures in Travis-CI such as
> https://travis-ci.org/github/SELinuxProject/selinux/jobs/686230518#L5153
>=20
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> Acked-by: William Roberts <william.c.roberts@intel.com>

Applied.


> ---
>  python/sepolicy/sepolicy/manpage.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/python/sepolicy/sepolicy/manpage.py b/python/sepolicy/sepoli=
cy/manpage.py
> index 442608191cc8..3e8a3be907e3 100755
> --- a/python/sepolicy/sepolicy/manpage.py
> +++ b/python/sepolicy/sepolicy/manpage.py
> @@ -1074,7 +1074,7 @@ If you wanted to change the default user mapping to=
 use the %(user)s_u user, you
> =20
>  .B semanage login -m -s %(user)s_u __default__
> =20
> -""" % {'desc': self.desc, 'type': self.type, 'user': self.domainname, 'r=
ange': self._get_users_range()})
> +""" % {'desc': self.desc, 'user': self.domainname, 'range': self._get_us=
ers_range()})
> =20
>          if "login_userdomain" in self.attributes and "login_userdomain" =
in self.all_attributes:
>              self.fd.write("""
> @@ -1245,7 +1245,7 @@ Execute the following to see the types that the SEL=
inux user %(type)s can execut
> =20
>  .B $ sesearch -A -s %(type)s -c process -p transition
> =20
> -""" % {'user': self.domainname, 'type': self.type})
> +""" % {'type': self.type})
> =20
>      def _role_header(self):
>          self.fd.write('.TH  "%(user)s_selinux"  "8"  "%(user)s" "mgrepl@=
redhat.com" "%(user)s SELinux Policy documentation"'

--=20
()  ascii ribbon campaign - against html e-mail=20
/\  www.asciiribbon.org   - against proprietary attachments

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl68DpMACgkQviIJHj72
InUeFw//UlsOMcepwyH11nwjOlTc0MLM5ELX7Wpm5AtixPHzz/tCxKsPz9+l+/Ji
6iJA7fuTCNKcI8XYiu/2qu+1JvhCA52qeIVM5PnMolHW13B8SX336asfro4gdJCF
py8f7UN3SjyLq9NbPKDjKhSBKL1VcKApCajbGdKfHrMXxndglVrKi8UeJsWzqRBH
qJtcdZMJOudWhCE8bb69wfCIFag7hoTClcJ8HirQHRYqeMmmIL7HeeX5xiKDWepZ
fmh8wRto3gcKq0wNndQo9YJp2f1TUz88yyslU++1JKNLVbRkq4aiVuMLc19GnFIA
OL0bDgv94ZJ8j5LU+fCzQx7KwymNhX8tJf7vPpdEA3mHkuTbjVi6W3C5ogqNsif3
voKiCSiH7BjCJclGekMclqV1RI1ZOafrb9PYpvvsY4kEFj8f/wlZ0OCe9Gbp7vJU
thKsQS4mYfxARvycBDmRg7hF2UQvLUdjez6brRm0pU2iuwZbUcuv+jA62HQ0rei4
OlkISXEDhyT+HTv92n8jmqM7+2EOZ1+DV273bcxMLwS6fqg+gxrE60IAFHF28ICv
kQskIABtscJg5iYkU3kP5XFhYB8ulco+pSSVr7sydIYeBZE+kj+jaA2DtyUy+AJe
WnhBjYO9DufrZ5LShL3oRkWtoZIje35+kX8LMdEbOyo7XOsfnzA=
=++lY
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--

