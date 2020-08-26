Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016E7C433DF
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 07:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBAEF20707
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 07:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fjcmA70u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgHZHrX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 03:47:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40054 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726698AbgHZHrW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 03:47:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598428040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FnKmQ9+EqYWWdaFY5crLoh1KZVlgGGUgnLQrZEFX+Po=;
        b=fjcmA70uzK25eoCobg+DBe7nOc87wP1bQyWlzFO3acaYAReKXRTkX81ZUKVhVp2TtzCM90
        zmcWqrX2V29D/3DVGpVCt/IptCZkhbfC10c/imTeb1GLk5PK8FncrZ/wEoiTHalQFqfkQi
        Hm5hgJ61cLPr9Q2hKvFWhVv9gCQSm7s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-m3iWxA-pOiCpbTG20yge3Q-1; Wed, 26 Aug 2020 03:47:13 -0400
X-MC-Unique: m3iWxA-pOiCpbTG20yge3Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 998718030BB;
        Wed, 26 Aug 2020 07:47:12 +0000 (UTC)
Received: from workstation (unknown [10.40.193.192])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 913476198B;
        Wed, 26 Aug 2020 07:47:11 +0000 (UTC)
Date:   Wed, 26 Aug 2020 09:47:08 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: drop symbol versioning from libsepol and libsemanage?
Message-ID: <20200826074708.GB401602@workstation>
References: <CAEjxPJ7khd7dprzEKgc5zeyaHWWRQ7P8pOg09LtiBVaOi6jYTg@mail.gmail.com>
 <20200813174722.GA14310@localhost.localdomain>
 <CAEjxPJ6_V9Uo7XwY89WKX9NBp4ACd5Sn3m7pDf2n+hYH0QYkMw@mail.gmail.com>
 <20200818134036.GB26265@localhost.localdomain>
 <CAEjxPJ5U4tGTwiPA9+ZCA_DJ88vO8YpAJmUNhfgEJNuaug_hBA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ5U4tGTwiPA9+ZCA_DJ88vO8YpAJmUNhfgEJNuaug_hBA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=plautrba@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2020 at 10:15:27AM -0400, Stephen Smalley wrote:
> On Tue, Aug 18, 2020 at 9:40 AM Petr Lautrbach <plautrba@redhat.com> wrot=
e:
> >
> > On Thu, Aug 13, 2020 at 01:56:57PM -0400, Stephen Smalley wrote:
> > > On Thu, Aug 13, 2020 at 1:47 PM Petr Lautrbach <plautrba@redhat.com> =
wrote:
> > > >
> > > > On Fri, Aug 07, 2020 at 02:54:18PM -0400, Stephen Smalley wrote:
> > > > > As noted in https://github.com/SELinuxProject/selinux/issues/245,
> > > > > symbol versioning in libsepol causes problems for LTO.  libsepol =
and
> > > > > libsemanage have a handful of versioned symbols due to incompatib=
le
> > > > > ABI changes made early in the CIL integration.  However, as far a=
s I
> > > > > can tell, these symbols were only used by other components of the
> > > > > selinux userspace, not externally.  Should we stop supporting the=
 old
> > > > > versions going forward and simplify the maps? If so, does this tr=
uly
> > > > > require bumping the .so version or can we omit that since there a=
re no
> > > > > external users?  Thoughts?
> > > > >
> > > >
> > > > AFAIK libsemanage is used by some 3rd parties. We've had requests t=
o ship
> > > > libsemanage-devel in RHEL-8 repositories in order customers build t=
heir
> > > > applications.
> > > >
> > > >
> > > > From my packager POV I like symbol versioning - it helps to prevent=
 some
> > > > dependency issues in development branches, e.g. when libsemanage is=
 built with
> > > > new libsepol symbol but the new package doesn't require newer libse=
pol. rpm is
> > > > able to solve that:
> > > >
> > > > $ rpm -q --requires libsemanage
> > > > ...
> > > > libselinux(x86-64) >=3D 3.1-2
> > > > libselinux.so.1()(64bit)
> > > > libselinux.so.1(LIBSELINUX_1.0)(64bit)
> > > > libsepol.so.1()(64bit)
> > > > libsepol.so.1(LIBSEPOL_1.0)(64bit)
> > > > libsepol.so.1(LIBSEPOL_1.1)(64bit)
> > > > libsepol.so.1(LIBSEPOL_3.0)(64bit)
> > > > ...
> > > >
> > > > $ rpm -q --provides libsemanage
> > > > config(libsemanage) =3D 3.1-2.fc33
> > > > libsemanage =3D 3.1-2.fc33
> > > > libsemanage(x86-64) =3D 3.1-2.fc33
> > > > libsemanage.so.1()(64bit)
> > > > libsemanage.so.1(LIBSEMANAGE_1.0)(64bit)
> > > > libsemanage.so.1(LIBSEMANAGE_1.1)(64bit)
> > > >
> > > >
> > > > LTO seems to cause problems to other projects as well
> > > > https://lists.fedoraproject.org/archives/list/devel@lists.fedorapro=
ject.org/message/XMIQMN5KNAZUPX6O3LN6JJGTCZTP4B7J/
> > > >
> > > > So I'd prefer if we try to do and use symbol versioning correctly, =
but it's not
> > > > hard requirement from my side.
> > >
> > > Ok.  An alternative to dropping it altogether is just to try to fix
> > > the particular problem he is seeing with the duplicated symbols in
> > > LIBSEPOL_1_0 and LIBSEPOL_1_1.  If we can remove the duplicate withou=
t
> > > breaking anything, then that might suffice for LTO.  I'm not actually
> > > clear on whether it is correct - there are technically two different
> > > versions of the symbol aliased via symver.  If the seeming duplicate
> > > is required then I guess we just have to wait for LTO support to catc=
h
> > > up with symbol versioning.
> > >
> >
> > In this particular case I'd drop duplicate symbols from libsepol. It's =
about 4
> > years and 5 releases since it was added and it would slightly clean the=
 code. It
> > would be properly announced in release notes. And if there's anybody el=
se then
> > libsemage who uses it they would need either to rebuild their sources o=
r stay
> > with the current version.
>=20
> Not entirely sure what this means.  We can do either of the following opt=
ions:
>=20
> 1.  Just remove the duplicated symbol names from libsepol.map.in (i.e.
> only define them once in either LIBSEPOL_1.0 or LIBSEPOL_1.1 not in
> both).  That might solve the problem for LTO without creating any
> compatibility issues for non-LTO; I'm not sure.
>=20
> -or-
>=20
> 2. Get rid of the duplicated symbols in libsepol.map.in AND drop the
> old symbol definitions and the old functions from cil/src/cil.c,
> renaming the new symbols to the exported name and dropping use of
> symver there.  This is an ABI change for libsepol but likely only
> affects libsemanage. If we do this, do we bump its .so version to
> reflect the incompatible change?
>=20

I'd go with 2 - get rid of old symbols, drop duplication from .map file and=
 bump
.so version.

I could prepare a patch with this next week.
--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl9GE3UACgkQviIJHj72
InVVhg/7BzBpsVHAuDg9TGOcbUgmkKW38ypCIswPStr8idAgzAb/VdIb6ceAq7A7
ngxcgMxo3xavXoEc1HqgMQ0FBVhIBQMA8s/qEIv2C/pMY4ohNtLj/3Pfpeu1GTSR
k/z6gsAQB6Uxj/tg+kLN8lCcLGBs38I45mqO3HGtLD1lqSurk6q6xKT7SqDAIcV6
qzK5KAw9yNBrKFTXH2MWo9zs9id41CMjdtDzC2Pxpt668vpPL+h6Ef49Z+fjXKCv
+hk0xcS1eU45+NWbeJVgObP+58G36sUPlIvjrmtw3Kq1NvK0WMY9waV5EZFCM6EN
PW/YHE3+M29VYTOY2U2cOcPZkjZG0mGPTEmc8avVFnFUg+S4A2/XNoZF0HdPM9SX
Ax36IetL98NtY8hZ1ZLGPyaHEPqnP1lzn4T/b20UjvZ0uu/V9KYIT6Y+y0hd04N2
chlCPRGOMJ/1P/rzbQuE3eB4x3zioha7Lc7ZbhG9NG2S8ITT12EmhFRSHdCSUb7R
WSFn1Tiw4OnGLfwfwRfUfvHJpqhlN3KlFH5EWJc3+8NeTU5+BClf8ZcGAVe/u1BN
HPkHZPOeYVhI7jLmxk9vqsVwV400YE+3VKYebEmtdSc7PTwQG/PGqz7NLFS2xxBV
1T/CL203K7GO9AzhH5sHfceMKrT6s76WEtUkpwCgcpZEjFL91Bo=
=js9m
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--

