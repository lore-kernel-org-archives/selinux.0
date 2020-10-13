Return-Path: <SRS0=hBaa=DU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177E4C433DF
	for <selinux@archiver.kernel.org>; Tue, 13 Oct 2020 14:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A15502488E
	for <selinux@archiver.kernel.org>; Tue, 13 Oct 2020 14:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PZo8nyKh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbgJMOsT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Oct 2020 10:48:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42554 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730236AbgJMOsT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 13 Oct 2020 10:48:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602600496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KIq+Wis/wjuEYHAkJ4YD1OHzq12Ul+nbKhTaF3p05lw=;
        b=PZo8nyKh4e05JyZAJSC2Jc3qK1FzmXAb3Nmbx09TUJftjIujfKi6kqhAwTp21XSnCj3mtL
        UiP2YicQ3EsEF6zT0EzCwi2tciCsBwFQh8SYl7mf4LzoX/q7foAzIc52Sw6G3RgnxNt1je
        MLSbh2fgOorLPYyTVVy4j/KcPUzCvvU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-mf-2_q8AOZS0UhrL5wQ8hg-1; Tue, 13 Oct 2020 10:48:11 -0400
X-MC-Unique: mf-2_q8AOZS0UhrL5wQ8hg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 057701018F65;
        Tue, 13 Oct 2020 14:48:10 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.195.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A364F76649;
        Tue, 13 Oct 2020 14:48:08 +0000 (UTC)
Date:   Tue, 13 Oct 2020 16:48:05 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: [PATCH 1/1] libselinux: convert matchpathcon to selabel_lookup()
Message-ID: <20201013144805.GC304424@localhost.localdomain>
References: <20201004140339.1896260-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
In-Reply-To: <20201004140339.1896260-1-nicolas.iooss@m4x.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=plautrba@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DSayHWYpDlRfCAAQ"
Content-Disposition: inline
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--DSayHWYpDlRfCAAQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 04, 2020 at 04:03:39PM +0200, Nicolas Iooss wrote:
> Function matchpathcon() is deprecated in favor of selabel_lookup() but
> program "matchpathcon" is much easier to use than "selabel_loopkup" to
> find the file context which would be applied to some files and
> directories.
>=20
> More precisely:
>=20
>     matchpathcon /path/to/my/file
>=20
> is easier to type and remember than:
>=20
>     selabel_lookup -b file -k /path/to/my/file
>=20
> It also allows performing multiple context searches in one command,
> where selabel_lookup cannot use multiple -k options.
>=20
> Migrate matchpathcon to the preferred API.
>=20
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>


Thanks for this!

Travis run https://travis-ci.org/github/bachradsusi/SELinuxProject-selinux/=
builds/735357374

Acked-by: Petr Lautrbach <plautrba@redhat.com>



> ---
>  libselinux/utils/Makefile       |  2 -
>  libselinux/utils/matchpathcon.c | 87 ++++++++++++++-------------------
>  2 files changed, 38 insertions(+), 51 deletions(-)
>=20
> diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
> index aa2d3e1b144f..b018a08acbe0 100644
> --- a/libselinux/utils/Makefile
> +++ b/libselinux/utils/Makefile
> @@ -56,8 +56,6 @@ sefcontext_compile: LDLIBS +=3D $(PCRE_LDLIBS) ../src/l=
ibselinux.a -lsepol
> =20
>  sefcontext_compile: sefcontext_compile.o ../src/regex.o
> =20
> -matchpathcon: CFLAGS +=3D -Wno-deprecated-declarations
> -
>  all: $(TARGETS)
> =20
>  install: all
> diff --git a/libselinux/utils/matchpathcon.c b/libselinux/utils/matchpath=
con.c
> index cc018d213f4c..a07e160dee71 100644
> --- a/libselinux/utils/matchpathcon.c
> +++ b/libselinux/utils/matchpathcon.c
> @@ -1,15 +1,14 @@
> -#include <unistd.h>
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <getopt.h>
>  #include <errno.h>
> -#include <string.h>
> +#include <getopt.h>
>  #include <limits.h>
> -#include <sys/types.h>
> -#include <sys/stat.h>
> +#include <selinux/label.h>
>  #include <selinux/selinux.h>
> -#include <limits.h>
> +#include <stdio.h>
>  #include <stdlib.h>
> +#include <string.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> =20
>  static __attribute__ ((__noreturn__)) void usage(const char *progname)
>  {
> @@ -19,15 +18,21 @@ static __attribute__ ((__noreturn__)) void usage(cons=
t char *progname)
>  =09exit(1);
>  }
> =20
> -static int printmatchpathcon(const char *path, int header, int mode)
> +static int printmatchpathcon(struct selabel_handle *hnd, const char *pat=
h, int header, int mode, int notrans)
>  {
> -=09char *buf;
> -=09int rc =3D matchpathcon(path, mode, &buf);
> +=09char *buf =3D NULL;
> +=09int rc;
> +
> +=09if (notrans) {
> +=09=09rc =3D selabel_lookup_raw(hnd, &buf, path, mode);
> +=09} else {
> +=09=09rc =3D selabel_lookup(hnd, &buf, path, mode);
> +=09}
>  =09if (rc < 0) {
>  =09=09if (errno =3D=3D ENOENT) {
>  =09=09=09buf =3D strdup("<<none>>");
>  =09=09} else {
> -=09=09=09fprintf(stderr, "matchpathcon(%s) failed: %s\n", path,
> +=09=09=09fprintf(stderr, "selabel_lookup(%s) failed: %s\n", path,
>  =09=09=09=09strerror(errno));
>  =09=09=09return 1;
>  =09=09}
> @@ -66,15 +71,14 @@ static mode_t string_to_mode(char *s)
> =20
>  int main(int argc, char **argv)
>  {
> -=09int i, init =3D 0, force_mode =3D 0;
> +=09int i, force_mode =3D 0;
>  =09int header =3D 1, opt;
>  =09int verify =3D 0;
>  =09int notrans =3D 0;
>  =09int error =3D 0;
>  =09int quiet =3D 0;
> -
> -=09fprintf(stderr,
> -=09=09"Deprecated, use selabel_lookup\n");
> +=09struct selabel_handle *hnd;
> +=09struct selinux_opt options[SELABEL_NOPT] =3D {};
> =20
>  =09if (argc < 2)
>  =09=09usage(argv[0]);
> @@ -96,23 +100,10 @@ int main(int argc, char **argv)
>  =09=09=09break;
>  =09=09case 'N':
>  =09=09=09notrans =3D 1;
> -=09=09=09set_matchpathcon_flags(MATCHPATHCON_NOTRANS);
>  =09=09=09break;
>  =09=09case 'f':
> -=09=09=09if (init) {
> -=09=09=09=09fprintf(stderr,
> -=09=09=09=09=09"%s:  -f and -p are exclusive\n",
> -=09=09=09=09=09argv[0]);
> -=09=09=09=09exit(1);
> -=09=09=09}
> -=09=09=09init =3D 1;
> -=09=09=09if (matchpathcon_init(optarg)) {
> -=09=09=09=09fprintf(stderr,
> -=09=09=09=09=09"Error while processing %s:  %s\n",
> -=09=09=09=09=09optarg,
> -=09=09=09=09=09errno ? strerror(errno) : "invalid");
> -=09=09=09=09exit(1);
> -=09=09=09}
> +=09=09=09options[SELABEL_OPT_PATH].type =3D SELABEL_OPT_PATH;
> +=09=09=09options[SELABEL_OPT_PATH].value =3D optarg;
>  =09=09=09break;
>  =09=09case 'P':
>  =09=09=09if (selinux_set_policy_root(optarg) < 0 ) {
> @@ -124,20 +115,11 @@ int main(int argc, char **argv)
>  =09=09=09}
>  =09=09=09break;
>  =09=09case 'p':
> -=09=09=09if (init) {
> -=09=09=09=09fprintf(stderr,
> -=09=09=09=09=09"%s:  -f and -p are exclusive\n",
> -=09=09=09=09=09argv[0]);
> -=09=09=09=09exit(1);
> -=09=09=09}
> -=09=09=09init =3D 1;
> -=09=09=09if (matchpathcon_init_prefix(NULL, optarg)) {
> -=09=09=09=09fprintf(stderr,
> -=09=09=09=09=09"Error while processing %s:  %s\n",
> -=09=09=09=09=09optarg,
> -=09=09=09=09=09errno ? strerror(errno) : "invalid");
> -=09=09=09=09exit(1);
> -=09=09=09}
> +=09=09=09// This option has been deprecated since libselinux 2.5 (2016):
> +=09=09=09// https://github.com/SELinuxProject/selinux/commit/26e05da0fc2=
d0a4bd274320968a88f8acbb3b6a6
> +=09=09=09fprintf(stderr, "Warning: using %s -p is deprecated\n", argv[0]=
);
> +=09=09=09options[SELABEL_OPT_SUBSET].type =3D SELABEL_OPT_SUBSET;
> +=09=09=09options[SELABEL_OPT_SUBSET].value =3D optarg;
>  =09=09=09break;
>  =09=09case 'q':
>  =09=09=09quiet =3D 1;
> @@ -146,6 +128,13 @@ int main(int argc, char **argv)
>  =09=09=09usage(argv[0]);
>  =09=09}
>  =09}
> +=09hnd =3D selabel_open(SELABEL_CTX_FILE, options, SELABEL_NOPT);
> +=09if (!hnd) {
> +=09=09fprintf(stderr,
> +=09=09=09"Error while opening file contexts database: %s\n",
> +=09=09=09strerror(errno));
> +=09=09return -1;
> +=09}
>  =09for (i =3D optind; i < argc; i++) {
>  =09=09int rc, mode =3D 0;
>  =09=09struct stat buf;
> @@ -185,19 +174,19 @@ int main(int argc, char **argv)
>  =09=09=09=09if (rc >=3D 0) {
>  =09=09=09=09=09printf("%s has context %s, should be ",
>  =09=09=09=09=09       path, con);
> -=09=09=09=09=09printmatchpathcon(path, 0, mode);
> +=09=09=09=09=09printmatchpathcon(hnd, path, 0, mode, notrans);
>  =09=09=09=09=09freecon(con);
>  =09=09=09=09} else {
>  =09=09=09=09=09printf
>  =09=09=09=09=09    ("actual context unknown: %s, should be ",
>  =09=09=09=09=09     strerror(errno));
> -=09=09=09=09=09printmatchpathcon(path, 0, mode);
> +=09=09=09=09=09printmatchpathcon(hnd, path, 0, mode, notrans);
>  =09=09=09=09}
>  =09=09=09}
>  =09=09} else {
> -=09=09=09error |=3D printmatchpathcon(path, header, mode);
> +=09=09=09error |=3D printmatchpathcon(hnd, path, header, mode, notrans);
>  =09=09}
>  =09}
> -=09matchpathcon_fini();
> +=09selabel_close(hnd);
>  =09return error;
>  }
> --=20
> 2.28.0
>=20

--DSayHWYpDlRfCAAQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl+Fvh4ACgkQviIJHj72
InWMfA//egInp6w8o+9LzNQFLhoQSuJQ/leAMfQSA7TwYV+JNEgc84MN+ENU9lFf
bxCJwViLMN412Hqg9uFKWs2LACz6RgRix1GIujz8WvlLtJYi6WOCgj9KLdxXsFQM
I+7G3IM0OAPz92/Y4TAbB7pfZREzSHl0XAXg5PsVzzOBk44UydQQHtOBBGLI3pyp
sB+sGWSNEn2r0YUHSe3qDX/tmbDE//FXGcoVYO4UtoeyPcACS/ftwN9H/a14Phl+
fniAjne8yfi8vl+5HMYn2HrmiuDBgLrBU3HK7g/2KFE1dg8S3maXm89hFB+yzoc2
HsuQJd6BA3Aq5UqMbIVSdXgCpkR4z+nRG1FrhOVzjUnKxhSpaBfFAOyPDbNci1MH
LTN7YS/nPcsVCE811Jasv/pjvsiSHAzom0Jfv6A2DNea26PDMAZWnUwtS1vjh7Ij
o1GZNuCf5taP7o/GM5YIrzfIpnLtHiFUJGGZqtCeNC+z2bqqmaX2XV55mk0MUq3c
ZzonQBv5he7uJ9HYf0FT50lmESaw7Si12Q8EUwS+l4VkqWXPdKASgNfH1IXuQMQC
nPY3jM2i4hgKP/uGbiM6VRXOcSMM0ot+y9k6pCujgYi+mvqdeUgPRZi2d5wtfB1+
WoWeIDXtbcGUgEMgqlJYmGsCqYzkV18aSrWw1OzF7iCd+0NbKCo=
=eYUG
-----END PGP SIGNATURE-----

--DSayHWYpDlRfCAAQ--

