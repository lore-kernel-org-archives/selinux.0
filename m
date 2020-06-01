Return-Path: <SRS0=O06S=7O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72647C433DF
	for <selinux@archiver.kernel.org>; Mon,  1 Jun 2020 09:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40C6F206C3
	for <selinux@archiver.kernel.org>; Mon,  1 Jun 2020 09:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NipEDU5f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbgFAJfI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:35:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51030 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725290AbgFAJfI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 1 Jun 2020 05:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591004106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BOrhP4sPwXVnmChhbddRfL3B7EAczgxCcQDLJes6yyA=;
        b=NipEDU5fad/uOPxHWptoqNy6n49CZnac9uPJ7c0mq1p7NpWYprivahz0Tq5CNpaIgJJXuZ
        woJarZ/lhP7uuXpI9HOuSLzr+BHeWLikjLpUUOaxgnmXGQTbImzJv3oe5wUR7H8q9ggTIr
        hUOEEeN2CY4KNF765n/jhBdQn0QCWVk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-wYnmyhU8NR-S7YWZzoBbsw-1; Mon, 01 Jun 2020 05:34:59 -0400
X-MC-Unique: wYnmyhU8NR-S7YWZzoBbsw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FB3C835B41;
        Mon,  1 Jun 2020 09:34:58 +0000 (UTC)
Received: from workstation (unknown [10.40.194.171])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B2C72DE8B;
        Mon,  1 Jun 2020 09:34:56 +0000 (UTC)
Date:   Mon, 1 Jun 2020 11:34:53 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Laurent Bigonville <bigon@debian.org>,
        William Roberts <bill.c.roberts@gmail.com>
Subject: Re: CFLAGS overridden by distribution build system
Message-ID: <20200601093453.GB30453@workstation>
References: <d0fd6970-7aa6-c576-fb8a-1d1293416e97@debian.org>
 <CAFftDdobT3E1MvFptyAKLBJ73KyrMOSS3m8DCnPX9+QF-Rk24Q@mail.gmail.com>
 <CAEjxPJ6XwXLBKYFaNO-kZz-Vgvbb2B7VKqD3DKQFf_ebBuNiBg@mail.gmail.com>
 <CAFftDdovpeFWnmKGDnTOY4AmwzSW0sCZoRwePX-q=NW1HV2c8w@mail.gmail.com>
 <CAEjxPJ5weFXrFpyjWdW7D4tgOnK+jHMyD37Zb4JFEzDt1rQ8Dw@mail.gmail.com>
 <CAFftDdr3A=rKcbzWcMDmz-XrqBTGd7mNbLLxt2vzU71DsqZ_9w@mail.gmail.com>
 <CAEjxPJ5N8Htq0uEekR7M7mt17_h7rRSzHU=kRBU_F02JfxO4ew@mail.gmail.com>
 <CAFftDdoe0dYSCYrxVfCCeCKwtUHCwNkE2pLPSXONF6FT5dFTUA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFftDdoe0dYSCYrxVfCCeCKwtUHCwNkE2pLPSXONF6FT5dFTUA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2020 at 03:59:13PM -0500, William Roberts wrote:
> On Fri, May 29, 2020 at 1:18 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Fri, May 29, 2020 at 1:15 PM William Roberts
> > <bill.c.roberts@gmail.com> wrote:
> > >
> > > On Fri, May 29, 2020 at 11:40 AM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > >
> > > > On Fri, May 29, 2020 at 12:05 PM William Roberts
> > > > <bill.c.roberts@gmail.com> wrote:
> > > > >
> > > > > On Fri, May 29, 2020 at 8:31 AM Stephen Smalley
> > > > > <stephen.smalley.work@gmail.com> wrote:
> > > > > >
> > > > > > On Sat, May 23, 2020 at 11:59 AM William Roberts
> > > > > > <bill.c.roberts@gmail.com> wrote:
> > > > > > >
> > > > > > > On Sat, May 23, 2020 at 5:57 AM Laurent Bigonville <bigon@deb=
ian.org> wrote:
> > > > > > > >
> > > > > > > > Hello,
> > > > > > > >
> > > > > > > > The current build system of the userspace is setting a lot =
of CFLAGS,
> > > > > > > > but most of these are overridden by the distributions when =
building.
> > > > > > > >
> > > > > > > > Today I received a bug report[0] from Christian G=F6ttsche =
asking me to
> > > > > > > > set -fno-semantic-interposition again in libsepol. I see al=
so the same
> > > > > > > > flag and also a lot of others set in libselinux and libsema=
nage build
> > > > > > > > system.
> > > > > > >
> > > > > > > Why would it be again? The old DSO design made that option im=
potent.
> > > > > > > Clang does it by default.
> > > > > > >
> > > > > > > >
> > > > > > > > For what I understand some of these are just needed for cod=
e quality
> > > > > > > > (-W) and could be controlled by distributions but others mi=
ght actually
> > > > > > > > need to be always set (-f?).
> > > > > > >
> > > > > > > If you look at the Makefiles overall in all the projects, you=
'll see hardening
> > > > > > > flags, etc. Libsepol has a pretty minimal set compared to say=
 libselinux, but
> > > > > > > they all get overridden by build time CFLAGS if you want.
> > > > > > >
> > > > > > > >
> > > > > > > > Shouldn't the flags that always need to be set (which ones?=
) be moved to
> > > > > > > > a "override CFLAGS" directive to avoid these to be unset by=
 distributions?
> > > > > > >
> > > > > > > If you we're cleaver with CFLAGS before, you could acually ci=
rcumvent
> > > > > > > the buildtime
> > > > > > > DSO stuff. While i'm not opposed to adding it to immutable fl=
ag, if
> > > > > > > you're setting
> > > > > > > CFLAGS, you're on your own. At least with the current design.
> > > > > > >
> > > > > > > I have no issues with adding it to override, but we would hav=
e to
> > > > > > > overhaul a bunch
> > > > > > > of them and make them consistent.
> > > > > >
> > > > > > I'm inclined to agree with Laurent here - we should always set =
this
> > > > > > flag in order to preserve the same behavior prior to the patche=
s that
> > > > > > removed hidden_def/hidden_proto and switched to relying on this
> > > > > > instead.
> > > > >
> > > > > Theirs a lot of features that rely on particular cflags, consider=
 hardening
> > > > > options. A lot of the warnings/error stuff is not just a code hyg=
iene, but also
> > > > > spotting potential issues that could arise as security issues. If=
 one starts
> > > > > tinkering with cflags, you can really change the code quite a bit=
. This is why
> > > > > some places only approve sanctioned builds of crypto libraries.
> > > >
> > > > I think the difference here is that we made a change in the source
> > > > code (hidden_def/hidden_proto removal) that requires use of
> > > > -fno-semantic-interposition to preserve existing behavior.
> > > >
> > > > > But one of the things to consider is that for clang builds, clang
> > > > > doesn't support
> > > > > this option, so we would need to move the compiler checking code =
into each
> > > > > projects root makefile and ensure any consuming subordinate leafs=
 add a
> > > > > default, or move it to the global makefile and make sure each lea=
f that needs it
> > > > > has a default.
> > > >
> > > > I think clang does support it now? https://reviews.llvm.org/D72724
> > >
> > > Yeah but that bug is all 2020 stuff. It is in the clang-10 release. I
> > > verified that
> > > with a local build from here:
> > >   - https://apt.llvm.org/
> > > So anything sub clang-10 won't support it, do you want to tie us to t=
hat
> > > new of a clang?
> >
> > No, I guess not.  So I guess our options are to leave it alone and
> > just make sure it is well documented or complicate the Makefiles.
>=20
> Pretty much, which is why I go back to, "If your setting CFLAGS, you bett=
er
> make sure you get em right". There are so many options and so many things
> that can affect the build output, you really need to get em right.
> This is the one area autoconf/automake is nice (I have a hate/hate
> relationship with it),
> but it does give one easy-peasy feature test macros, so this problem
> is simple to fix.
>=20
> The problem with documentation is no one reads it :-p. We could do someth=
ing
> like issue a warning, compiler agnostic, from make if we don't detect the
> -fsemantic-interposition option (easy). That would be simple, or I can
> work up the
> gcc/clang split patches (slightly harder).
>=20
> Or we can just say, if your messing with CFLAGS do it right and you shoul=
d
> probably add -fsemantic-interposition if your using gcc documentation (ea=
siest).
>=20
> If they didn't change the CFLAGS for their build, they wouldn't have this=
 issue.
> Which brings up the question, "can they add the flags they need to the
> Makefile?"
> or "What do they need added/removed/changed in CFLAGS overall?"
>=20
> I'd like to start with why they need to change CFLAGS, and can we just
> make that the default?
>=20

Fedora packager point of view:

From time to time, Fedora project decides to use new/different flags for
different reasons. In order to make it easier for packagers there are Fedor=
a
distribution macros available which can be used in .spec files and which se=
t all
needed flags, e.g:

$ grep CFLAGS libsepol.spec =20
make %{?_smp_mflags} CFLAGS=3D"%{optflags}" LDFLAGS=3D"%{?__global_ldflags}=
"

$ rpm --eval 'make %{?_smp_mflags} CFLAGS=3D"%{optflags}" LDFLAGS=3D"%{?__g=
lobal_ldflags}"'          =20
make -j4 CFLAGS=3D"-O2 -g -pipe -Wall -Werror=3Dformat-security -Wp,-D_FORT=
IFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS -fexceptions -fstack-protector-str=
ong -grecord-gcc-switches -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 =
-specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric -fasy=
nchronous-unwind-tables -fstack-clash-protection -fcf-protection" LDFLAGS=
=3D"-Wl,-z,relro -Wl,--as-needed  -Wl,-z,now -specs=3D/usr/lib/rpm/redhat/r=
edhat-hardened-ld"=09


There's a simpler way using %set_build_flags in .spec file:

$ rpm --eval '%set_build_flags'                                            =
                          =20
  CFLAGS=3D"${CFLAGS:--O2 -g -pipe -Wall -Werror=3Dformat-security -Wp,-D_F=
ORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS -fexceptions -fstack-protector-=
strong -grecord-gcc-switches -specs=3D/usr/lib/rpm/redhat/redhat-hardened-c=
c1 -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric -f=
asynchronous-unwind-tables -fstack-clash-protection -fcf-protection}" ; exp=
ort CFLAGS ;=20
  CXXFLAGS=3D"${CXXFLAGS:--O2 -g -pipe -Wall -Werror=3Dformat-security -Wp,=
-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS -fexceptions -fstack-protec=
tor-strong -grecord-gcc-switches -specs=3D/usr/lib/rpm/redhat/redhat-harden=
ed-cc1 -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneri=
c -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection}" ;=
 export CXXFLAGS ;=20
  FFLAGS=3D"${FFLAGS:--O2 -g -pipe -Wall -Werror=3Dformat-security -Wp,-D_F=
ORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS -fexceptions -fstack-protector-=
strong -grecord-gcc-switches -specs=3D/usr/lib/rpm/redhat/redhat-hardened-c=
c1 -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric -f=
asynchronous-unwind-tables -fstack-clash-protection -fcf-protection -I/usr/=
lib64/gfortran/modules}" ; export FFLAGS ;=20
  FCFLAGS=3D"${FCFLAGS:--O2 -g -pipe -Wall -Werror=3Dformat-security -Wp,-D=
_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS -fexceptions -fstack-protecto=
r-strong -grecord-gcc-switches -specs=3D/usr/lib/rpm/redhat/redhat-hardened=
-cc1 -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric =
-fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -I/us=
r/lib64/gfortran/modules}" ; export FCFLAGS ;=20
  LDFLAGS=3D"${LDFLAGS:--Wl,-z,relro -Wl,--as-needed  -Wl,-z,now -specs=3D/=
usr/lib/rpm/redhat/redhat-hardened-ld}" ; export LDFLAGS ;=20
  LT_SYS_LIBRARY_PATH=3D"${LT_SYS_LIBRARY_PATH:-/usr/lib64:}" ; export LT_S=
YS_LIBRARY_PATH


From this POV it would be great to have -fno-semantic-interposition in CFLA=
GS
override in libsepol Makefile.

But given the compatibility problem described in this thread, I, as Fedora
packager, would consider as sufficient to have this requirement in the buil=
d instructions in
documentation, and also as part of new release notes as it's changed in the=
 latest release.


Petr


--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl7Uy60ACgkQviIJHj72
InWI1g//ZmEsePoA0rQUOBNbTru20VJ3EUWISJs7elFeDqM0/aG8YL9CpYaGAz7F
+E7UFoyd2PS4hbjrUUhYL35YRQESZnLFM6eYS0+vbg3kE9QGLaueUA1jX6EWWX6Q
TStIOgqRdsU0slpATQ/tQ1VU5W+bdYijVgQjJ5nG9rFR5MsDDL1vbtRXEJv8AUyh
PIdqyB1M4js06vUQrsZRa+fopEeXYc59kL5ha5Z5HGYZgufG9p2gqj9DqaYTbqyy
kbF45yyFhmD+OQa2MtibXPW7Za2DvwxpGp+jpsl2vizG/7lBqGuFrfYp9gT1Y4vx
jWlx3wc5lHVRVUoaZeA2yOK7NFeTozca1IvnyOCUEfr5NThcwmOoKtmgMwTQuHOb
SetGIIsHmQhM8WLzHhxye1N45/wGQn12yh5GwDPVm+DpoKP1XoHzpxGaD+PHa61w
NfCHCeGV+qVJ8Uwbzmr6b6JxRAN/FUWII4bOIKJM00C02q92aSENfqOpjDctQ3Dz
STMoOld98rX9zBHIoHUfIyRW92t3Fl0vSjKL5Pnc5k2cTeOw5L15mxnBd4mmawHl
9oPLut5C/2cwVJ+O1T4x1F8/daaJ2Obpmhauq4RjwhUBWA7pVefqktRGMZc0Hbdr
6j7QRc9OL6wCBeXKxiIntLXzNAkYGYijHRmII8Iz5k6RmEWZVMY=
=Uv6t
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--

