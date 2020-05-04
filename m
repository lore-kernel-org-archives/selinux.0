Return-Path: <SRS0=mV6Z=6S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1766C3A5A9
	for <selinux@archiver.kernel.org>; Mon,  4 May 2020 14:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7694206D9
	for <selinux@archiver.kernel.org>; Mon,  4 May 2020 14:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NtPY6l/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgEDOxi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 May 2020 10:53:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60662 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728139AbgEDOxi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 May 2020 10:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588604016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JbHwVEjgR++cU3pYyXgUDVtBhZmnJ6qo/ozi2W3T3Ew=;
        b=NtPY6l/I3yZm45SCUI7X4l5ozijWr3RoK9yXLGNcw9n9HzVNhRkjvgLZY68k0pVVqPmhKJ
        WPlk3hg80RW8j3D7SlLOYISB5zNUUseNioRfz+qzt4zlvQBaw1TS/WX62Mlu5iIcECAmYQ
        9lgkIlbdqIN9W1D+UAClPzeEA9/KF5Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-GrtKzMz3NyGhsvqRUbEkZg-1; Mon, 04 May 2020 10:53:16 -0400
X-MC-Unique: GrtKzMz3NyGhsvqRUbEkZg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29E8C102C818;
        Mon,  4 May 2020 14:53:15 +0000 (UTC)
Received: from workstation (unknown [10.40.194.176])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 26528100238A;
        Mon,  4 May 2020 14:53:12 +0000 (UTC)
Date:   Mon, 4 May 2020 16:53:09 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: [PATCH] README: add much useful information
Message-ID: <20200504145309.GA274286@workstation>
References: <20200501092615.1143868-1-nicolas.iooss@m4x.org>
 <20200504105122.GA251987@workstation>
MIME-Version: 1.0
In-Reply-To: <20200504105122.GA251987@workstation>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 04, 2020 at 12:51:22PM +0200, Petr Lautrbach wrote:
> On Fri, May 01, 2020 at 11:26:15AM +0200, Nicolas Iooss wrote:
> > * Add SELinux logo
> > * Add a link to Travis-CI
> > * Add a link to lore.kernel.org archive
> > * Document that SELinux is packaged in several distributions, providing
> >   links to policycoreutils package (this package requires libsemanage,
> >   libselinux, libsepol, etc. so if it is packaged, most sub-projects
> >   have to also be)
> > * Make Fedora install command readable on GitHub without scrolling
> >   horizontally and update it
> > * Split installed packaged between the dependencies for the "main"
> >   libraries and programs, and the bindings
> >=20
> >   - The install command line has been tested using a container from
> >     image fedora:31
> >=20
> > * Document Debian dependencies
> >=20
> >   - The install command line has been tested using a container from
> >     image debian:10
> >=20
> > * Document running `make test` with `./scripts/env_use_destdir`
> > * Introduce "macOS" section for instructions specific to macOS.
> >=20
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>=20
> Acked-by: Petr Lautrbach <plautrba@redhat.com>
>=20
> Thanks!

Applied.

>
> > ---
> >=20
> > The rendered README is currently available on my GitHub repo:
> > https://github.com/fishilico/selinux/blob/wip/README.md
> >=20
> >  README.md | 95 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 92 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/README.md b/README.md
> > index 974280f9d14f..f3257ef52d21 100644
> > --- a/README.md
> > +++ b/README.md
> > @@ -1,22 +1,107 @@
> >  SELinux Userspace
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =20
> > +![SELinux logo](https://github.com/SELinuxProject.png)
> > +[![Build Status](https://travis-ci.org/SELinuxProject/selinux.svg?bran=
ch=3Dmaster)](https://travis-ci.org/SELinuxProject/selinux)
> > +
> >  Please submit all bug reports and patches to <selinux@vger.kernel.org>=
.
> > =20
> >  Subscribe by sending "subscribe selinux" in the body of an email
> >  to <majordomo@vger.kernel.org>.
> > =20
> > +Archive of this mailing list is available on https://lore.kernel.org/s=
elinux/.
> > +
> > +
> >  Installation
> >  ------------
> > =20
> > -Build dependencies on Fedora:
> > +SELinux libraries and tools are packaged in several Linux distribution=
s:
> > +
> > +* Alpine Linux (https://pkgs.alpinelinux.org/package/edge/testing/x86/=
policycoreutils)
> > +* Arch Linux User Repository (https://aur.archlinux.org/packages/polic=
ycoreutils/)
> > +* Buildroot (https://git.buildroot.net/buildroot/tree/package/policyco=
reutils)
> > +* Debian and Ubuntu (https://packages.debian.org/sid/policycoreutils)
> > +* Gentoo (https://packages.gentoo.org/packages/sys-apps/policycoreutil=
s)
> > +* RHEL and Fedora (https://src.fedoraproject.org/rpms/policycoreutils)
> > +* Yocto Project (http://git.yoctoproject.org/cgit/cgit.cgi/meta-selinu=
x/tree/recipes-security/selinux)
> > +* and many more (https://repology.org/project/policycoreutils/versions=
)
> > +
> > +
> > +Building and testing
> > +--------------------
> > =20
> > -    yum install audit-libs-devel bison bzip2-devel dbus-devel dbus-gli=
b-devel flex flex-devel flex-static glib2-devel libcap-devel libcap-ng-deve=
l pam-devel pcre-devel python3-devel python3-setools swig xmlto redhat-rpm-=
config
> > +Build dependencies on Fedora:
> > =20
> > +```sh
> > +# For C libraries and programs
> > +dnf install \
> > +    audit-libs-devel \
> > +    bison \
> > +    bzip2-devel \
> > +    CUnit-devel \
> > +    diffutils \
> > +    flex \
> > +    gcc \
> > +    gettext \
> > +    glib2-devel \
> > +    make \
> > +    libcap-devel \
> > +    libcap-ng-devel \
> > +    pam-devel \
> > +    pcre-devel \
> > +    xmlto
> > +
> > +# For Python and Ruby bindings
> > +dnf install \
> > +    python3-devel \
> > +    ruby-devel \
> > +    swig
> > +```
> > +
> > +Build dependencies on Debian:
> > +
> > +```sh
> > +# For C libraries and programs
> > +apt-get install --no-install-recommends --no-install-suggests \
> > +    bison \
> > +    flex \
> > +    gawk \
> > +    gcc \
> > +    gettext \
> > +    make \
> > +    libaudit-dev \
> > +    libbz2-dev \
> > +    libcap-dev \
> > +    libcap-ng-dev \
> > +    libcunit1-dev \
> > +    libglib2.0-dev \
> > +    libpcre3-dev \
> > +    pkgconf \
> > +    python3 \
> > +    python3-distutils \
> > +    systemd \
> > +    xmlto
> > +
> > +# For Python and Ruby bindings
> > +apt-get install --no-install-recommends --no-install-suggests \
> > +    python3-dev \
> > +    ruby-dev \
> > +    swig
> > +```
> > =20
> >  To build and install everything under a private directory, run:
> > =20
> > -    make DESTDIR=3D~/obj install install-pywrap
> > +    make clean distclean
> > +
> > +    make DESTDIR=3D~/obj install install-rubywrap install-pywrap
> > +
> > +To run tests with the built libraries and programs, several paths (rel=
ative to `$DESTDIR`) need to be added to variables `$LD_LIBRARY_PATH`, `$PA=
TH` and `$PYTHONPATH`.
> > +This can be done using [./scripts/env_use_destdir](./scripts/env_use_d=
estdir):
> > +
> > +    DESTDIR=3D~/obj ./scripts/env_use_destdir make test
> > +
> > +Some tests require the reference policy to be installed (for example i=
n `python/sepolgen`).
> > +In order to run these ones, instructions similar to the ones in sectio=
n `install` of [./.travis.yml](./.travis.yml) can be executed.
> > =20
> >  To install as the default system libraries and binaries
> >  (overwriting any previously installed ones - dangerous!),
> > @@ -32,6 +117,10 @@ This may render your system unusable if the upstrea=
m SELinux userspace
> >  lacks library functions or other dependencies relied upon by your
> >  distribution.  If it breaks, you get to keep both pieces.
> > =20
> > +
> > +macOS
> > +-----
> > +
> >  To install libsepol on macOS (mainly for policy analysis):
> > =20
> >      cd libsepol; make PREFIX=3D/usr/local install
> > --=20
> > 2.26.2
> >=20
>=20
> --=20
> ()  ascii ribbon campaign - against html e-mail=20
> /\  www.asciiribbon.org   - against proprietary attachments



--=20
()  ascii ribbon campaign - against html e-mail=20
/\  www.asciiribbon.org   - against proprietary attachments

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl6wLE4ACgkQviIJHj72
InVcLw/+LJpuZYgmQBFijM/c2QkA2jJKYSEXYrWCUBJcmdRsfLvi/Muj/X3yLbCy
gV+tW4aIvtQ7PWZY4yOzgwtwtM17AfGtDQB7d3uAWTPmIEAcQRXc8OdG4RrZIJeC
8b/HGuLS/0jx+mRuagLCQkwELqBsMYVxIlud/Fq6StEkzSL4SdxhlUZKYemSSxtL
hMFss5ZpBZZOUxmAl6Q4ZAJh/QW6FQwAPcNOLEWzTPkIbtL1ErABHHTWYPcQHk/P
ReNksjETqCsHaODYdrykgsfAm5NwLhgtppd3oiX4KLqLdZGd8hhmp0UsDrnVcEsP
kc/BI7sesAXSSxnUL1FJOsnm1EoHXOSt/ympr7zUZVMzu3vNdEe5Ez7mBBCvjtS+
cfrqbMsJiRSQJBEzqy1GB6ERTYNy2S79djL6Bx7hQ74GGN09LMbGGfNw2OifsNeL
Cew4OwaNTPTHUarrSShIDM21crUjWm+LxqTaMLEzUjOHFMXLDA19dtEEeevs6M4k
YP8HwjKcG/AIZ/JSjy+Y4w4bbvctwAW9pS7Vbd2iEDCw4wvYp9G3oKKJB5SnckNd
2XkH1QXnjpNc+D+aD5HU9u08k8+imRcFshs4PuYZvjR15noVI/Pn7X00mi2j1T9U
io6//6449Co4nX7tWJU37xQFg/97waHHsDL8DB0EOMFVZZj/ji0=
=sELa
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--

