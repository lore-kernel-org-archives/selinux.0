Return-Path: <SRS0=yRyW=65=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6A7C433E0
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 11:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECD8D204EF
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 11:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bjHhu23J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgEOLaC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 May 2020 07:30:02 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54757 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725986AbgEOLaC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 May 2020 07:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589542200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5/scyYv+S3xiRMxe74ExI9EEb8Q/LWGc9NJMWIQGN6U=;
        b=bjHhu23JZB57+FM4LfpJZH1uZlsTryFMnK8opgboVs/p1xeL/Y5N9wo+n3WR6cQKcuYYp6
        wl+kc0hCPTCBh6e25aJf30VEotDSprAKlRhKmnYR0H96qx9cMxO1aMbnPk4KloU3pfNIfn
        iFi7M9IoD4Z+lvsT2Ks2EZbRbfW1gEs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-IprE5kIHM6GH8r5h3EuV4A-1; Fri, 15 May 2020 07:29:55 -0400
X-MC-Unique: IprE5kIHM6GH8r5h3EuV4A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 090E78005AD;
        Fri, 15 May 2020 11:29:54 +0000 (UTC)
Received: from workstation (unknown [10.40.194.255])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 37AB85D9D7;
        Fri, 15 May 2020 11:29:53 +0000 (UTC)
Date:   Fri, 15 May 2020 13:29:50 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: Re: [PATCH] secilc/docs: fix use of TMPDIR #240
Message-ID: <20200515112950.GB255621@workstation>
References: <20200515105105.10075-1-toiwoton@gmail.com>
 <20200515110900.GA255621@workstation>
 <c50a1736-0bfd-88c4-7b8f-cf4b29151941@gmail.com>
MIME-Version: 1.0
In-Reply-To: <c50a1736-0bfd-88c4-7b8f-cf4b29151941@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2020 at 02:19:37PM +0300, Topi Miettinen wrote:
> On 15.5.2020 14.09, Petr Lautrbach wrote:
> > On Fri, May 15, 2020 at 01:51:05PM +0300, Topi Miettinen wrote:
> > > Environment variable TMPDIR may be already set for the user building
> > > and this could be equal to $XDG_RUNTIME_DIR or /tmp which are existin=
g
> > > directories. Then when running 'make clean', there are unintended sid=
e
> > > effects:
> > >=20
> > > rm -rf /run/user/1000
> > > rm: cannot remove '/run/user/1000/dconf/user': Permission denied
> > > rm: cannot remove '/run/user/1000/systemd': Permission denied
> > > rm: cannot remove '/run/user/1000/gnupg': Permission denied
> > > rm: cannot remove '/run/user/1000/dbus-1': Is a directory
> > > rm: cannot remove '/run/user/1000/inaccessible': Permission denied
> > > make[1]: *** [Makefile:68: clean] Error 1
> > >=20
> > > Fix by using a different name.
> > >=20
> > > Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
> > > ---
> > >   secilc/docs/Makefile | 20 ++++++++++----------
> > >   1 file changed, 10 insertions(+), 10 deletions(-)
> > >=20
> > > diff --git a/secilc/docs/Makefile b/secilc/docs/Makefile
> > > index 6b07ce7f..90214e0d 100644
> > > --- a/secilc/docs/Makefile
> > > +++ b/secilc/docs/Makefile
> > > @@ -1,7 +1,7 @@
> > >   CWD ?=3D $(shell pwd)
> > >   HTMLDIR ?=3D $(CWD)/html
> > >   PDFDIR ?=3D $(CWD)/pdf
> > > -TMPDIR ?=3D $(CWD)/tmp
> > > +TMP_DIR ?=3D $(CWD)/tmp
> > >   TESTDIR ?=3D $(CWD)/../test
> >=20
> > Maybe it would be enough to drop `?=3D`:
> >=20
> > CWD =3D $(shell pwd)
> > HTMLDIR =3D $(CWD)/html
> > PDFDIR =3D $(CWD)/pdf
> > TMPDIR =3D $(CWD)/tmp
> > TESTDIR =3D $(CWD)/../test
>=20
> That could work, assuming that the higher level Makefiles or builders don=
't
> use the variables.

Higher level Makefiles don't use it. I'm not sure about builders but given =
that
this is a subdirectory of secilc and ../Makefile doesn't use I doubt that's=
 the
case - Fedora, Arch and Debian don't use it.

It would be broken by your change anyway as you renamed TMPDIR to TMP_DIR.

> Other approaches could be to rework build process to use 'mktemp -d' and
> immediately removing the temporary directory, or generating the temporary
> files with a prefix (%.md -> %.sedded) in the build directory.
>=20

Lets start with the simple step which fixes your problem, and if there's
demand to make it more robust, it can be enhanced later.


>
> >=20
> >=20
> >=20
> > >   # All the markdown files that make up the guide:
> > > @@ -26,7 +26,7 @@ FILE_LIST ?=3D cil_introduction.md \
> > >   =09cil_infiniband_statements.md \
> > >   =09cil_xen_statements.md
> > > -PANDOC_FILE_LIST =3D $(addprefix $(TMPDIR)/,$(FILE_LIST))
> > > +PANDOC_FILE_LIST =3D $(addprefix $(TMP_DIR)/,$(FILE_LIST))
> > >   PDF_OUT=3DCIL_Reference_Guide.pdf
> > >   HTML_OUT=3DCIL_Reference_Guide.html
> > > @@ -40,29 +40,29 @@ endif
> > >   all: html pdf
> > > -$(TMPDIR):
> > > -=09mkdir -p $(TMPDIR)
> > > +$(TMP_DIR):
> > > +=09mkdir -p $(TMP_DIR)
> > > -$(TMPDIR)/%.md: %.md | $(TMPDIR)
> > > -=09cp -f $< $(TMPDIR)/
> > > +$(TMP_DIR)/%.md: %.md | $(TMP_DIR)
> > > +=09cp -f $< $(TMP_DIR)/
> > >   =09@# Substitute markdown links for conversion into PDF links
> > >   =09$(SED) -i -re 's:(\[`[^`]*`\])\([^#]*([^\)]):\1\(\2:g' $@
> > > -$(TMPDIR)/policy.cil: $(TESTDIR)/policy.cil
> > > +$(TMP_DIR)/policy.cil: $(TESTDIR)/policy.cil
> > >   =09cp -f $< $@
> > >   =09@# add a title for the TOC to policy.cil. This is needed to play=
 nicely with the PDF conversion.
> > >   =09$(SED) -i '1i Example Policy\n=3D=3D=3D=3D=3D=3D=3D=3D=3D\n```' =
$@
> > >   =09echo '```' >> $@
> > > -html: $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil
> > > +html: $(PANDOC_FILE_LIST) $(TMP_DIR)/policy.cil
> > >   =09mkdir -p $(HTMLDIR)
> > >   =09$(PANDOC) -t html $^ -o $(HTMLDIR)/$(HTML_OUT)
> > > -pdf: $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil
> > > +pdf: $(PANDOC_FILE_LIST) $(TMP_DIR)/policy.cil
> > >   =09mkdir -p $(PDFDIR)
> > >   =09$(PANDOC) --standalone --toc $^ -o $(PDFDIR)/$(PDF_OUT)
> > >   clean:
> > >   =09rm -rf $(HTMLDIR)
> > >   =09rm -rf $(PDFDIR)
> > > -=09rm -rf $(TMPDIR)
> > > +=09rm -rf $(TMP_DIR)
> > > --=20
> > > 2.26.2
> > >=20
> >=20
>=20

--=20
()  ascii ribbon campaign - against html e-mail=20
/\  www.asciiribbon.org   - against proprietary attachments

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl6+fSgACgkQviIJHj72
InXUfA//Qj2ayJ/Dt76TRnTxe4D26d+prFjKqJKBR2IgISQvvPqgISIbIRTHZJto
dHaVl7i59ncmcIRj4CcaQzSGC8xqVoiR+dknSEh1GnAX1rj+HaT4WOlxVc43jB1e
Il/bcHNsWIXyYfx/blYRX/JRN4U3HrU7ksCIEWsAkJBgPMZm7ZRnCd//BOSwm6xm
F5PvIc+k6OPbD24/Foo08KUM/c1SHCpXJqtYcblBwYXyK/2KRcn8AZJ9vgfZkBZY
12hUU60JjeGRfGioCudCbGilMBDyMQHqUSX8h2jatBtaei8nlGTjnYXn81I8NT1w
/z3pd0zpsPMoKnsgVMf2vEoYGjVduLcz7rvNDTly7ldSGGMQxqIiyCzVgwH1C6Cj
yht3OorBoFDOZQK7Ek0C3k+2gTonMMYk9LlB0xbrX8/X8mm1oNueQzD5cCxy8xFT
uAjORw/rkeEwbJ/KdgM3MXJOOKs0e8ra4Es3xGVwIdhmrkrRUMTYOtRKX2+qedks
d5kwxB8ZxEKhEVtzX4ySd3KdNcpEg1pz8OAMb3ZxNZxXYdA70+d7lgPhLLBqDrKK
sMq2hEbS6GL8/zh36EryZcmfZW1DPi+Fi1sSJsae1uNjWFyWyyhd08tmn1jziiGt
AIYKWeCIkEUz1HbEe1X/UYOez5NSQn1J3I4+sFRAiap6Bl90HEw=
=8OM5
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--

