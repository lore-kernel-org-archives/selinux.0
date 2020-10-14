Return-Path: <SRS0=aJPZ=DV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F257C433E7
	for <selinux@archiver.kernel.org>; Wed, 14 Oct 2020 15:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EB9B2222E
	for <selinux@archiver.kernel.org>; Wed, 14 Oct 2020 15:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gJNg+NtK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgJNP6i (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Oct 2020 11:58:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28694 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727161AbgJNP6i (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Oct 2020 11:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602691116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pnj6/xO4Gw8z+yx101B53zs/pBXuA/uAv4YxB+KgRq8=;
        b=gJNg+NtKPncgkB2h6bCNcaDste2WJX1uLURC2ftiunsOJDWGZMI553YOtfoP21cmpLCJAd
        77JtbzYD0ZHzLX5nXPSrDsPAskj/baVO5obcdxJriWBu8HFOC5nCI/O3iSthS9+fvzT8e8
        4HwnjKMo7paotjmhtFUnd/EZRAkHgMw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-uG-J2QddPt2BWDyeMt8xEw-1; Wed, 14 Oct 2020 11:58:33 -0400
X-MC-Unique: uG-J2QddPt2BWDyeMt8xEw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDF1FD6880;
        Wed, 14 Oct 2020 15:58:32 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.92])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C9F345C22B;
        Wed, 14 Oct 2020 15:58:31 +0000 (UTC)
Date:   Wed, 14 Oct 2020 17:58:28 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: [PATCH 1/1] libselinux: convert matchpathcon to selabel_lookup()
Message-ID: <20201014155828.GB3669@localhost.localdomain>
References: <20201004140339.1896260-1-nicolas.iooss@m4x.org>
 <20201013144805.GC304424@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <20201013144805.GC304424@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=plautrba@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2020 at 04:48:05PM +0200, Petr Lautrbach wrote:
> On Sun, Oct 04, 2020 at 04:03:39PM +0200, Nicolas Iooss wrote:
> > Function matchpathcon() is deprecated in favor of selabel_lookup() but
> > program "matchpathcon" is much easier to use than "selabel_loopkup" to
> > find the file context which would be applied to some files and
> > directories.
> >=20
> > More precisely:
> >=20
> >     matchpathcon /path/to/my/file
> >=20
> > is easier to type and remember than:
> >=20
> >     selabel_lookup -b file -k /path/to/my/file
> >=20
> > It also allows performing multiple context searches in one command,
> > where selabel_lookup cannot use multiple -k options.
> >=20
> > Migrate matchpathcon to the preferred API.
> >=20
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>=20
>=20
> Thanks for this!
>=20
> Travis run https://travis-ci.org/github/bachradsusi/SELinuxProject-selinu=
x/builds/735357374
>=20
> Acked-by: Petr Lautrbach <plautrba@redhat.com>
>=20

It's merged now.

>=20
> > ---
> >  libselinux/utils/Makefile       |  2 -
> >  libselinux/utils/matchpathcon.c | 87 ++++++++++++++-------------------
> >  2 files changed, 38 insertions(+), 51 deletions(-)
> >=20
> > diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
> > index aa2d3e1b144f..b018a08acbe0 100644
> > --- a/libselinux/utils/Makefile
> > +++ b/libselinux/utils/Makefile
> > @@ -56,8 +56,6 @@ sefcontext_compile: LDLIBS +=3D $(PCRE_LDLIBS) ../src=
/libselinux.a -lsepol
> > =20
> >  sefcontext_compile: sefcontext_compile.o ../src/regex.o
> > =20
> > -matchpathcon: CFLAGS +=3D -Wno-deprecated-declarations
> > -
> >  all: $(TARGETS)
> > =20
> >  install: all
> > diff --git a/libselinux/utils/matchpathcon.c b/libselinux/utils/matchpa=
thcon.c
> > index cc018d213f4c..a07e160dee71 100644
> > --- a/libselinux/utils/matchpathcon.c
> > +++ b/libselinux/utils/matchpathcon.c
> > @@ -1,15 +1,14 @@
> > -#include <unistd.h>
> > -#include <stdio.h>
> > -#include <stdlib.h>
> > -#include <getopt.h>
> >  #include <errno.h>
> > -#include <string.h>
> > +#include <getopt.h>
> >  #include <limits.h>
> > -#include <sys/types.h>
> > -#include <sys/stat.h>
> > +#include <selinux/label.h>
> >  #include <selinux/selinux.h>
> > -#include <limits.h>
> > +#include <stdio.h>
> >  #include <stdlib.h>
> > +#include <string.h>
> > +#include <sys/stat.h>
> > +#include <sys/types.h>
> > +#include <unistd.h>
> > =20
> >  static __attribute__ ((__noreturn__)) void usage(const char *progname)
> >  {
> > @@ -19,15 +18,21 @@ static __attribute__ ((__noreturn__)) void usage(co=
nst char *progname)
> >  =09exit(1);
> >  }
> > =20
> > -static int printmatchpathcon(const char *path, int header, int mode)
> > +static int printmatchpathcon(struct selabel_handle *hnd, const char *p=
ath, int header, int mode, int notrans)
> >  {
> > -=09char *buf;
> > -=09int rc =3D matchpathcon(path, mode, &buf);
> > +=09char *buf =3D NULL;
> > +=09int rc;
> > +
> > +=09if (notrans) {
> > +=09=09rc =3D selabel_lookup_raw(hnd, &buf, path, mode);
> > +=09} else {
> > +=09=09rc =3D selabel_lookup(hnd, &buf, path, mode);
> > +=09}
> >  =09if (rc < 0) {
> >  =09=09if (errno =3D=3D ENOENT) {
> >  =09=09=09buf =3D strdup("<<none>>");
> >  =09=09} else {
> > -=09=09=09fprintf(stderr, "matchpathcon(%s) failed: %s\n", path,
> > +=09=09=09fprintf(stderr, "selabel_lookup(%s) failed: %s\n", path,
> >  =09=09=09=09strerror(errno));
> >  =09=09=09return 1;
> >  =09=09}
> > @@ -66,15 +71,14 @@ static mode_t string_to_mode(char *s)
> > =20
> >  int main(int argc, char **argv)
> >  {
> > -=09int i, init =3D 0, force_mode =3D 0;
> > +=09int i, force_mode =3D 0;
> >  =09int header =3D 1, opt;
> >  =09int verify =3D 0;
> >  =09int notrans =3D 0;
> >  =09int error =3D 0;
> >  =09int quiet =3D 0;
> > -
> > -=09fprintf(stderr,
> > -=09=09"Deprecated, use selabel_lookup\n");
> > +=09struct selabel_handle *hnd;
> > +=09struct selinux_opt options[SELABEL_NOPT] =3D {};
> > =20
> >  =09if (argc < 2)
> >  =09=09usage(argv[0]);
> > @@ -96,23 +100,10 @@ int main(int argc, char **argv)
> >  =09=09=09break;
> >  =09=09case 'N':
> >  =09=09=09notrans =3D 1;
> > -=09=09=09set_matchpathcon_flags(MATCHPATHCON_NOTRANS);
> >  =09=09=09break;
> >  =09=09case 'f':
> > -=09=09=09if (init) {
> > -=09=09=09=09fprintf(stderr,
> > -=09=09=09=09=09"%s:  -f and -p are exclusive\n",
> > -=09=09=09=09=09argv[0]);
> > -=09=09=09=09exit(1);
> > -=09=09=09}
> > -=09=09=09init =3D 1;
> > -=09=09=09if (matchpathcon_init(optarg)) {
> > -=09=09=09=09fprintf(stderr,
> > -=09=09=09=09=09"Error while processing %s:  %s\n",
> > -=09=09=09=09=09optarg,
> > -=09=09=09=09=09errno ? strerror(errno) : "invalid");
> > -=09=09=09=09exit(1);
> > -=09=09=09}
> > +=09=09=09options[SELABEL_OPT_PATH].type =3D SELABEL_OPT_PATH;
> > +=09=09=09options[SELABEL_OPT_PATH].value =3D optarg;
> >  =09=09=09break;
> >  =09=09case 'P':
> >  =09=09=09if (selinux_set_policy_root(optarg) < 0 ) {
> > @@ -124,20 +115,11 @@ int main(int argc, char **argv)
> >  =09=09=09}
> >  =09=09=09break;
> >  =09=09case 'p':
> > -=09=09=09if (init) {
> > -=09=09=09=09fprintf(stderr,
> > -=09=09=09=09=09"%s:  -f and -p are exclusive\n",
> > -=09=09=09=09=09argv[0]);
> > -=09=09=09=09exit(1);
> > -=09=09=09}
> > -=09=09=09init =3D 1;
> > -=09=09=09if (matchpathcon_init_prefix(NULL, optarg)) {
> > -=09=09=09=09fprintf(stderr,
> > -=09=09=09=09=09"Error while processing %s:  %s\n",
> > -=09=09=09=09=09optarg,
> > -=09=09=09=09=09errno ? strerror(errno) : "invalid");
> > -=09=09=09=09exit(1);
> > -=09=09=09}
> > +=09=09=09// This option has been deprecated since libselinux 2.5 (2016=
):
> > +=09=09=09// https://github.com/SELinuxProject/selinux/commit/26e05da0f=
c2d0a4bd274320968a88f8acbb3b6a6
> > +=09=09=09fprintf(stderr, "Warning: using %s -p is deprecated\n", argv[=
0]);
> > +=09=09=09options[SELABEL_OPT_SUBSET].type =3D SELABEL_OPT_SUBSET;
> > +=09=09=09options[SELABEL_OPT_SUBSET].value =3D optarg;
> >  =09=09=09break;
> >  =09=09case 'q':
> >  =09=09=09quiet =3D 1;
> > @@ -146,6 +128,13 @@ int main(int argc, char **argv)
> >  =09=09=09usage(argv[0]);
> >  =09=09}
> >  =09}
> > +=09hnd =3D selabel_open(SELABEL_CTX_FILE, options, SELABEL_NOPT);
> > +=09if (!hnd) {
> > +=09=09fprintf(stderr,
> > +=09=09=09"Error while opening file contexts database: %s\n",
> > +=09=09=09strerror(errno));
> > +=09=09return -1;
> > +=09}
> >  =09for (i =3D optind; i < argc; i++) {
> >  =09=09int rc, mode =3D 0;
> >  =09=09struct stat buf;
> > @@ -185,19 +174,19 @@ int main(int argc, char **argv)
> >  =09=09=09=09if (rc >=3D 0) {
> >  =09=09=09=09=09printf("%s has context %s, should be ",
> >  =09=09=09=09=09       path, con);
> > -=09=09=09=09=09printmatchpathcon(path, 0, mode);
> > +=09=09=09=09=09printmatchpathcon(hnd, path, 0, mode, notrans);
> >  =09=09=09=09=09freecon(con);
> >  =09=09=09=09} else {
> >  =09=09=09=09=09printf
> >  =09=09=09=09=09    ("actual context unknown: %s, should be ",
> >  =09=09=09=09=09     strerror(errno));
> > -=09=09=09=09=09printmatchpathcon(path, 0, mode);
> > +=09=09=09=09=09printmatchpathcon(hnd, path, 0, mode, notrans);
> >  =09=09=09=09}
> >  =09=09=09}
> >  =09=09} else {
> > -=09=09=09error |=3D printmatchpathcon(path, header, mode);
> > +=09=09=09error |=3D printmatchpathcon(hnd, path, header, mode, notrans=
);
> >  =09=09}
> >  =09}
> > -=09matchpathcon_fini();
> > +=09selabel_close(hnd);
> >  =09return error;
> >  }
> > --=20
> > 2.28.0
> >=20



--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl+HIB4ACgkQviIJHj72
InWrIBAAxlNbJSFPxCuZwIcz+TqeUuZ+HqZLPHA3QsB4/EdvudBDmmxllCFKcPxo
lCTWYDMFIPNLGTpvJ0K8gBh4Jd8q5qxAyti9rTS8MDyUrPA7aT8UlJ/UN9llx0rQ
BTSamsPc/rgoMQSyFm3UVk1jkL4jiBGMdkVrr3xfbKXjAxYPPDgi1YBMvHsbXd33
Eh61wrQpehhT09lkWp2bNfgaPp+hrrcmzJpVaW1lFG0CQ8F+vomwItSeiQ2ZFZwc
DrecVVCC6WzCe1Hr2L2+/X+qd7kMygcsk6sPpCIH89bIPqx9HCNFkyXRse2RXOTD
iU4MruXaYOItPPWRI7z72DzlRxlVCPvl/etd9HVCCJfQAxzvb2BYPbeyV834SkQz
2a0tnq9E2Gvm7lWKgAI+qzgmxZMQdTL3gzmScUa/MbGsgpxtAq7kVBtK7v3SpnYe
Xk8LI9VQICd4MzgoxRQzlIHJeFz4dXzp9gZuJkit/kLgfY+M0MbpvKY0eRFuy7II
9/525h4l95K6GhSRWYD5EbV/8x+o7H/dkG5eWXGaUbAsx6rz6JAHTeiyW822+1x0
5F+dmJMGWIEiWslsgsTu4e20cvvw+pUZycqY/s6L8DXjnPEdu6ptzmD1jFzSHqS+
+JtPWHGmxLsDYCE0cz9baR/Glfh3IPGWytZoTL6hNHjvIXIsx3M=
=+Kxj
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--

