Return-Path: <SRS0=yRyW=65=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9FBC433DF
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 11:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6980B206B6
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 11:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GoNf9G38"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgEOLJL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 May 2020 07:09:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37713 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725986AbgEOLJK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 May 2020 07:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589540948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xCWQOkvYoEBApR3T3aDyLT2MoX4F3n81KXvIGmG48VM=;
        b=GoNf9G38a31QCvdO9gp7TdZQmZITkfbCIQFIjFmyWMTv7kCPYHkST4SOjC/U4DpYuGnpvm
        I+KY+j7IuUWweSkxasoDgeOg2kzIi/PS89MMkuBahsNkElXo3NaRde+8c69U5zW7RG8yRA
        7k9yc8qccs6YLrzqfzM0lrn0pvNimxw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-ij5aCL_EPp-zBI_FYPmFmA-1; Fri, 15 May 2020 07:09:05 -0400
X-MC-Unique: ij5aCL_EPp-zBI_FYPmFmA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68C2F100CC85;
        Fri, 15 May 2020 11:09:04 +0000 (UTC)
Received: from workstation (unknown [10.40.194.255])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A7B110016E8;
        Fri, 15 May 2020 11:09:03 +0000 (UTC)
Date:   Fri, 15 May 2020 13:09:00 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: Re: [PATCH] secilc/docs: fix use of TMPDIR #240
Message-ID: <20200515110900.GA255621@workstation>
References: <20200515105105.10075-1-toiwoton@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200515105105.10075-1-toiwoton@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2020 at 01:51:05PM +0300, Topi Miettinen wrote:
> Environment variable TMPDIR may be already set for the user building
> and this could be equal to $XDG_RUNTIME_DIR or /tmp which are existing
> directories. Then when running 'make clean', there are unintended side
> effects:
>=20
> rm -rf /run/user/1000
> rm: cannot remove '/run/user/1000/dconf/user': Permission denied
> rm: cannot remove '/run/user/1000/systemd': Permission denied
> rm: cannot remove '/run/user/1000/gnupg': Permission denied
> rm: cannot remove '/run/user/1000/dbus-1': Is a directory
> rm: cannot remove '/run/user/1000/inaccessible': Permission denied
> make[1]: *** [Makefile:68: clean] Error 1
>=20
> Fix by using a different name.
>=20
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
> ---
>  secilc/docs/Makefile | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/secilc/docs/Makefile b/secilc/docs/Makefile
> index 6b07ce7f..90214e0d 100644
> --- a/secilc/docs/Makefile
> +++ b/secilc/docs/Makefile
> @@ -1,7 +1,7 @@
>  CWD ?=3D $(shell pwd)
>  HTMLDIR ?=3D $(CWD)/html
>  PDFDIR ?=3D $(CWD)/pdf
> -TMPDIR ?=3D $(CWD)/tmp
> +TMP_DIR ?=3D $(CWD)/tmp
>  TESTDIR ?=3D $(CWD)/../test

Maybe it would be enough to drop `?=3D`:

CWD =3D $(shell pwd)
HTMLDIR =3D $(CWD)/html
PDFDIR =3D $(CWD)/pdf
TMPDIR =3D $(CWD)/tmp
TESTDIR =3D $(CWD)/../test



>  # All the markdown files that make up the guide:
> @@ -26,7 +26,7 @@ FILE_LIST ?=3D cil_introduction.md \
>  =09cil_infiniband_statements.md \
>  =09cil_xen_statements.md
> =20
> -PANDOC_FILE_LIST =3D $(addprefix $(TMPDIR)/,$(FILE_LIST))
> +PANDOC_FILE_LIST =3D $(addprefix $(TMP_DIR)/,$(FILE_LIST))
> =20
>  PDF_OUT=3DCIL_Reference_Guide.pdf
>  HTML_OUT=3DCIL_Reference_Guide.html
> @@ -40,29 +40,29 @@ endif
> =20
>  all: html pdf
> =20
> -$(TMPDIR):
> -=09mkdir -p $(TMPDIR)
> +$(TMP_DIR):
> +=09mkdir -p $(TMP_DIR)
> =20
> -$(TMPDIR)/%.md: %.md | $(TMPDIR)
> -=09cp -f $< $(TMPDIR)/
> +$(TMP_DIR)/%.md: %.md | $(TMP_DIR)
> +=09cp -f $< $(TMP_DIR)/
>  =09@# Substitute markdown links for conversion into PDF links
>  =09$(SED) -i -re 's:(\[`[^`]*`\])\([^#]*([^\)]):\1\(\2:g' $@
> =20
> -$(TMPDIR)/policy.cil: $(TESTDIR)/policy.cil
> +$(TMP_DIR)/policy.cil: $(TESTDIR)/policy.cil
>  =09cp -f $< $@
>  =09@# add a title for the TOC to policy.cil. This is needed to play nice=
ly with the PDF conversion.
>  =09$(SED) -i '1i Example Policy\n=3D=3D=3D=3D=3D=3D=3D=3D=3D\n```' $@
>  =09echo '```' >> $@
> =20
> -html: $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil
> +html: $(PANDOC_FILE_LIST) $(TMP_DIR)/policy.cil
>  =09mkdir -p $(HTMLDIR)
>  =09$(PANDOC) -t html $^ -o $(HTMLDIR)/$(HTML_OUT)
> =20
> -pdf: $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil
> +pdf: $(PANDOC_FILE_LIST) $(TMP_DIR)/policy.cil
>  =09mkdir -p $(PDFDIR)
>  =09$(PANDOC) --standalone --toc $^ -o $(PDFDIR)/$(PDF_OUT)
> =20
>  clean:
>  =09rm -rf $(HTMLDIR)
>  =09rm -rf $(PDFDIR)
> -=09rm -rf $(TMPDIR)
> +=09rm -rf $(TMP_DIR)
> --=20
> 2.26.2
>=20

--=20
()  ascii ribbon campaign - against html e-mail=20
/\  www.asciiribbon.org   - against proprietary attachments

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl6+eEYACgkQviIJHj72
InVnaQ//Q5C/y5b4TuNHr+i/ykxBABND1twIlTEhDdFdsFC1/76byv8XewaLelCd
KZjrtdYB7GgqsGwcaoHqwALg/0GbX5NJIzT8/ucxNMO8UZCvEutm/Jja+e6JYJcK
DLw0cwm7Pq3JMlNcutLXwVVySoobo/+pdxxripLp84rWE5mimoOMiD9Xg66yoyt1
V2zzOYO8ZoBr5/x8i7cO49tvX2O19AxQp5nfAJcLsgoWA1yu16+aE8SMQA/Nz8i7
qa6AW/sQ5SEJZO3jFQ+0Fmo+9+o2iWmDOCUp+wJpk7iJTgN7aqUn0+an1PoI7VQp
3o3C5Pm7ZNgA9lNvttBhZ0ESQbERnfQzF1sne5iRw86YudqocsG0H4YdE0wA0gV4
UPhM6jD35Yr90/o5ufZGZ3RmP4RaGl2H9Vhyxo8qNrH3Df0kywXiNK7kAj13FVwP
C36HGhbDIFR098683LbUPcBentVQhtGIBxSEa25VgtjQKQfS62VxYeri6GaSTUDn
+xROMIZ6wnGoNzUwtBviIeO0qQvIeyRlJCTQOoE3o/O3Zs9yvo2OJzwvdwrxqC18
/tpRCwo0/3Qfr1NLJmbsZnMb8xFkmBd7MTjXKw6L0yc143tEqvSLQXUezDnwj74k
hubAX9wK8fnKlOKVJqBdvt3eQNwzFkZukxx+YGTYvgwcxkrvIjA=
=LCCn
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--

