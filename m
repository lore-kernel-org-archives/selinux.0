Return-Path: <SRS0=ZFtm=DI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C360C47420
	for <selinux@archiver.kernel.org>; Thu,  1 Oct 2020 16:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C6EE206C1
	for <selinux@archiver.kernel.org>; Thu,  1 Oct 2020 16:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KESiABLS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732107AbgJAQ4B (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Oct 2020 12:56:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39338 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732016AbgJAQ4B (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Oct 2020 12:56:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601571359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ife3ghJrGMyUtGzWMrGrwQgUhsoH7qvnUc/vFxkdX9c=;
        b=KESiABLSGUxDnVBIwOyQm1YxoIxmBF/R2Ap3/ss0OsH7yZhxU52ltocIbA5K9xHRTXeQiO
        +rwOOP+2JOkFofk4D73rTO8/FdQ882+7azDK23KRGJ4zO4ApSbT2RyyJ2rM755xK7RScDy
        B6ksxvBPNrgKD9cGPhzuvuYDJeZqShI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-xJoX0gWIPHuyu75e6L6Wgg-1; Thu, 01 Oct 2020 12:55:55 -0400
X-MC-Unique: xJoX0gWIPHuyu75e6L6Wgg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9490B57240;
        Thu,  1 Oct 2020 16:55:54 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.193.120])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C573960BF1;
        Thu,  1 Oct 2020 16:55:53 +0000 (UTC)
Date:   Thu, 1 Oct 2020 18:55:51 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH 4/4] libsemanage: Bump libsemanage.so version
Message-ID: <20201001165551.GA33342@localhost.localdomain>
References: <20200930145031.910190-1-plautrba@redhat.com>
 <20200930145031.910190-4-plautrba@redhat.com>
 <CAEjxPJ6PHe7DqYh6mLGu+mjMLY43r4tbQzoiXH0=wgSuyVSpcw@mail.gmail.com>
 <20200930155614.GA864960@fedora.redhat.com>
 <CAEjxPJ41ryHsDCnpX7qRLJNw5t=vYX_UEb1z=kW91O10Je6nDA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ41ryHsDCnpX7qRLJNw5t=vYX_UEb1z=kW91O10Je6nDA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=plautrba@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 01, 2020 at 10:18:35AM -0400, Stephen Smalley wrote:
> On Wed, Sep 30, 2020 at 11:56 AM Petr Lautrbach <plautrba@redhat.com> wro=
te:
> >
> > On Wed, Sep 30, 2020 at 11:22:21AM -0400, Stephen Smalley wrote:
> > > On Wed, Sep 30, 2020 at 10:51 AM Petr Lautrbach <plautrba@redhat.com>=
 wrote:
> > > >
> > > > It's due to the previous ABI incompatible change
> > > >
> > > > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> > >
> > > My only real question is what are the implications for distros for
> > > this change?  Would Fedora end up having to carry both so versions fo=
r
> > > a time?  Or can you cleanly switch from the old to the new without
> > > disruption?
> > >
> >
> > Fedora and other distribution will need to temporary ship something lik=
e libsepol-compat and
> > libsemanage-compat with libsepol.so.1 resp libsemanage.so.1 in order no=
t to
> > break buildroots. Also all packages which require so.1, see bellow, wil=
l have to
> > be rebuilt against so.2
> >
> > # dnf repoquery --whatrequires libsepol.'so.1()(64bit)'
> > libselinux-utils-0:3.1-3.fc34.x86_64
> > libsemanage-0:3.1-2.fc33.x86_64
> > libsepol-devel-0:3.1-3.fc33.x86_64
> > parted-0:3.3-6.fc34.x86_64
> > policycoreutils-0:3.1-4.fc33.x86_64
> > python3-setools-0:4.3.0-5.fc33.x86_64
> > secilc-0:3.1-2.fc33.x86_64
> >
> > # dnf -C repoquery --whatrequires 'libsemanage.so.1()(64bit)'
> > libsemanage-devel-0:3.1-2.fc33.x86_64
> > policycoreutils-0:3.1-4.fc33.x86_64
> > python3-libsemanage-0:3.1-2.fc33.x86_64
> > shadow-utils-2:4.8.1-4.fc33.x86_64
> > sssd-common-0:2.3.1-4.fc33.x86_64
> > sssd-ipa-0:2.3.1-4.fc33.x86_64
> >
> > I've experienced with this, builds are available in
> > https://copr.fedorainfracloud.org/coprs/plautrba/selinux-fedora/
> >
> > E.g. for libsemanage, I've added
> >
> > +%set_build_flags
> > +CFLAGS=3D"$CFLAGS -fno-semantic-interposition"
> > +sed -i 's/LIBVERSION =3D 2/LIBVERSION =3D 1/' src/Makefile
> > +%make_build
> > +cp src/libsemanage.so.1 ${RPM_BUILD_ROOT}/%{_libdir}/libsemanage.so.1
> >
> > to the spec file in order to get libsemanage.so.1 which is shipped by
> > libsemanage.so.1
>=20
> The parted dependency looks suspect; seems to be an incorrect linking
> with libsepol despite not directly calling any sepol functions.
> Aside from that, if we have to bump the so version and deal with
> compat packages anyway, should we go ahead and purge all of the other
> deprecated functions in libsepol and libsemanage (grep -ri deprecated
> libsepol libsemanage)?
>=20

I'd like to ship compat only for short time until all dependent components =
are
rebuilt.

Purging deprecated functions could have much bigger impact than this patchs=
et as it affects API. With
this change, it's generally enough to rebuild a component. If we drop funct=
ions
and change API, different software could stop work. There are only few pack=
ages
using libsepol and libsemanage directly, but there might be much bigger gro=
up of
python or ruby scripts using deprecated symbols like matchpathcon*()

Petr

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl92CgIACgkQviIJHj72
InW2wRAAoed4uxsnHSjJ74KnUVeqv8lni2u+/kqtDBMiNvJ2DUDKtbpup/gIPcV1
a3bnkuaA3cwdacg40A5bthA0F130zsDhEhqfkKcgjpPCKbnBTVjokq/hFBYBzfwZ
yc6FGVWY3D2q6NzQuj3KbbDM2ixWEyMKS1xgPMHA3Sn5GTRPNfPmVmqeudjprefx
h3OiAfeIrsmLvaUzBj9fiRBsKUE62C+Bxu8gvhgxAZ5AxEY5w6+jRjCAmY5H6Kqg
UOkYD3cIUCXOD7xtUEPxjtLKn5IBVut7DHvRt8IO17phewr/NUAoSOLKcdeoZJ5A
SPkkFLe/ZCd4ISynEINo4x+ytMvYMvZZDDjHWiSnGRzHrhIya9KULgCRR/P0goo0
g0UXf+MQTLpWZUkgyZrk/uBguhf6E0OvORjRUr3C05Wnuff3Pm+1aVkd8XNImLuO
C5MqsLyNvIP+4oaX0eZUVM+7mevuC574LT07vinP6jJMcRz5lwc3PlniO+K39q2D
eoB0qQzrhj6FEU4fX+54hf6PfMb7Vu0zGe/QIntFfflnxLpYJjfOkmRXN7JZJ6Ke
WzL2aqJWt5v4NPdrHCudVk+bHYH8CZsebdxiMlPY9OdVgy4kDaRR/o7H0ZjasfDY
Qr5ewINxNWHDZLnojr6AtQHx+c5KAMy9U9q2fNaTHRAupZBYaZA=
=wsAz
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--

