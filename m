Return-Path: <SRS0=ZFtm=DI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B166CC4727E
	for <selinux@archiver.kernel.org>; Thu,  1 Oct 2020 17:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B64420759
	for <selinux@archiver.kernel.org>; Thu,  1 Oct 2020 17:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VbIVXPEX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732407AbgJARsv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Oct 2020 13:48:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52458 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732096AbgJARsv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Oct 2020 13:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601574529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tbEqsfsaEWhnUWcqmkBB1P5R1lnF+d7fzVhL3YXCReE=;
        b=VbIVXPEXiRjgBbLWj5437caT9n6I+yd9cpHY/GM0vI6Fp5wTF8ADVwG1T/AxWKFABOob61
        Z11TLjoW2S/27MM/6cX9J1okaC8xrNefhQSkSWPwP+Ge8Rhd0IiNjIKT5OnLsU9kRKig9c
        lI9EkdVHidnoFo5DwR86evgm7jLYfqM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-ecLqid2kM8iLClSIYVwdRA-1; Thu, 01 Oct 2020 13:48:42 -0400
X-MC-Unique: ecLqid2kM8iLClSIYVwdRA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6ED781DE0B;
        Thu,  1 Oct 2020 17:48:41 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.193.120])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 895CE5577C;
        Thu,  1 Oct 2020 17:48:40 +0000 (UTC)
Date:   Thu, 1 Oct 2020 19:48:37 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH 4/4] libsemanage: Bump libsemanage.so version
Message-ID: <20201001174837.GB33342@localhost.localdomain>
References: <20200930145031.910190-1-plautrba@redhat.com>
 <20200930145031.910190-4-plautrba@redhat.com>
 <CAEjxPJ6PHe7DqYh6mLGu+mjMLY43r4tbQzoiXH0=wgSuyVSpcw@mail.gmail.com>
 <20200930155614.GA864960@fedora.redhat.com>
 <CAEjxPJ41ryHsDCnpX7qRLJNw5t=vYX_UEb1z=kW91O10Je6nDA@mail.gmail.com>
 <20201001165551.GA33342@localhost.localdomain>
 <CAEjxPJ7tsyBGm2hqiABF=HeJvX6PfWdT5BSn+L4-miqsqexo+A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ7tsyBGm2hqiABF=HeJvX6PfWdT5BSn+L4-miqsqexo+A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=plautrba@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Content-Disposition: inline
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 01, 2020 at 01:08:27PM -0400, Stephen Smalley wrote:
> On Thu, Oct 1, 2020 at 12:56 PM Petr Lautrbach <plautrba@redhat.com> wrot=
e:
> >
> > On Thu, Oct 01, 2020 at 10:18:35AM -0400, Stephen Smalley wrote:
> > > On Wed, Sep 30, 2020 at 11:56 AM Petr Lautrbach <plautrba@redhat.com>=
 wrote:
> > > >
> > > > On Wed, Sep 30, 2020 at 11:22:21AM -0400, Stephen Smalley wrote:
> > > > > On Wed, Sep 30, 2020 at 10:51 AM Petr Lautrbach <plautrba@redhat.=
com> wrote:
> > > > > >
> > > > > > It's due to the previous ABI incompatible change
> > > > > >
> > > > > > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> > > > >
> > > > > My only real question is what are the implications for distros fo=
r
> > > > > this change?  Would Fedora end up having to carry both so version=
s for
> > > > > a time?  Or can you cleanly switch from the old to the new withou=
t
> > > > > disruption?
> > > > >
> > > >
> > > > Fedora and other distribution will need to temporary ship something=
 like libsepol-compat and
> > > > libsemanage-compat with libsepol.so.1 resp libsemanage.so.1 in orde=
r not to
> > > > break buildroots. Also all packages which require so.1, see bellow,=
 will have to
> > > > be rebuilt against so.2
> > > >
> > > > # dnf repoquery --whatrequires libsepol.'so.1()(64bit)'
> > > > libselinux-utils-0:3.1-3.fc34.x86_64
> > > > libsemanage-0:3.1-2.fc33.x86_64
> > > > libsepol-devel-0:3.1-3.fc33.x86_64
> > > > parted-0:3.3-6.fc34.x86_64
> > > > policycoreutils-0:3.1-4.fc33.x86_64
> > > > python3-setools-0:4.3.0-5.fc33.x86_64
> > > > secilc-0:3.1-2.fc33.x86_64
> > > >
> > > > # dnf -C repoquery --whatrequires 'libsemanage.so.1()(64bit)'
> > > > libsemanage-devel-0:3.1-2.fc33.x86_64
> > > > policycoreutils-0:3.1-4.fc33.x86_64
> > > > python3-libsemanage-0:3.1-2.fc33.x86_64
> > > > shadow-utils-2:4.8.1-4.fc33.x86_64
> > > > sssd-common-0:2.3.1-4.fc33.x86_64
> > > > sssd-ipa-0:2.3.1-4.fc33.x86_64
> > > >
> > > > I've experienced with this, builds are available in
> > > > https://copr.fedorainfracloud.org/coprs/plautrba/selinux-fedora/
> > > >
> > > > E.g. for libsemanage, I've added
> > > >
> > > > +%set_build_flags
> > > > +CFLAGS=3D"$CFLAGS -fno-semantic-interposition"
> > > > +sed -i 's/LIBVERSION =3D 2/LIBVERSION =3D 1/' src/Makefile
> > > > +%make_build
> > > > +cp src/libsemanage.so.1 ${RPM_BUILD_ROOT}/%{_libdir}/libsemanage.s=
o.1
> > > >
> > > > to the spec file in order to get libsemanage.so.1 which is shipped =
by
> > > > libsemanage.so.1
> > >
> > > The parted dependency looks suspect; seems to be an incorrect linking
> > > with libsepol despite not directly calling any sepol functions.
> > > Aside from that, if we have to bump the so version and deal with
> > > compat packages anyway, should we go ahead and purge all of the other
> > > deprecated functions in libsepol and libsemanage (grep -ri deprecated
> > > libsepol libsemanage)?
> > >
> >
> > I'd like to ship compat only for short time until all dependent compone=
nts are
> > rebuilt.
> >
> > Purging deprecated functions could have much bigger impact than this pa=
tchset as it affects API. With
> > this change, it's generally enough to rebuild a component. If we drop f=
unctions
> > and change API, different software could stop work. There are only few =
packages
> > using libsepol and libsemanage directly, but there might be much bigger=
 group of
> > python or ruby scripts using deprecated symbols like matchpathcon*()
>=20
> Yes, I just meant libsepol and libsemanage deprecated functions not
> libselinux (so not matchpathcon) since you are already bumping the so
> version.  But it's fine if you don't want to do it at the same time.
>=20

I see, I missed that point, sorry. It seems to be reasonable, but I'll chec=
k it
again tomorrow.

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl92Fm4ACgkQviIJHj72
InVa2A/8Dr1w7cRCbMnPCwSajWg7hsG5qKet4ku0kmSKTXhY3lX4w62Vb1Ue7we3
e0nELRyTDuUJ/PfD4P91VaDwhiTV97HT3ZU3iDgfKLV+OtVBSoZwSB8pu3S9KF4q
S3zRK8dWCBRumwFmEFk5MyPa/+8gn2FCTPxWb9XfNnlOOXLb1tdrt3JD6ttNdizX
CHqsShb3DYEDas+MWbrPzZBdfLefrknZ/iJre9TrkHm53TDU6yfuSZzUp/IXuQL7
BL3Bl4DYlP1CqX3DHbzy1uLRPTKA3VvP7BXx55In0VEPI6DCBnI+QWrkh0izvEuF
v5aq7POYleRHxFkGSxscXxBh+raJSQo3dqJ6hFTlLcQVMDmY2dXPHJHKgYhx0tBB
wGdhSAmfsS3f9iEca2fHpoXdqjJO3PzUOG3xbfAPZhYls07u1OBkpqQvQnPXndAL
0pwRYLWipA++MEgYx2QXL7+OxhsTlq3SewRncc2lVDt6rXDFRqOMSPn8GReHHPbz
LhJlW9OhLYoKza2S0wghuXQeMgye4YbPq1/upRvxDpB1kDLHZWr5m33Mm0kbUp6w
Ktq879II9tOlXY9C2N8ZJ0cLoLt3m8vFwKOdtMcZCEeqp/8693+au3Q+VhqL3wUh
E0Usk1ADs3SygQyVLnUAakdZF+ISdHGs+Ns91JtFu+Ff2sRp1v0=
=5NEw
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--

