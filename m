Return-Path: <SRS0=if39=B4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B1BC433E1
	for <selinux@archiver.kernel.org>; Tue, 18 Aug 2020 13:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62F0020738
	for <selinux@archiver.kernel.org>; Tue, 18 Aug 2020 13:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XtNiZx1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgHRNlO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Aug 2020 09:41:14 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32805 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726633AbgHRNlF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Aug 2020 09:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597758053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZA02qwqVb8jiD64kP+/8G1iME9qQvICDX9g0qP+jWxU=;
        b=XtNiZx1kQjuxdrmluh/0EtqZCVtIa2yMy5QDsI6s9pYvcm3qc2oeGKSHykRMlUe6jTiX6o
        0q5STr2FPO4rwu3XvVFdNHxJFDz0rcmh68b/Ep8l7tNTS4ciFZq9FOT0AOStwHRahwKiZe
        E8GNHltZh78583zUSqisw9bjz+H7g+Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-JJSCXmlOODuocuRm9fgyVQ-1; Tue, 18 Aug 2020 09:40:41 -0400
X-MC-Unique: JJSCXmlOODuocuRm9fgyVQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70E161084C86;
        Tue, 18 Aug 2020 13:40:40 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.88])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A139D7A1E7;
        Tue, 18 Aug 2020 13:40:39 +0000 (UTC)
Date:   Tue, 18 Aug 2020 15:40:36 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: drop symbol versioning from libsepol and libsemanage?
Message-ID: <20200818134036.GB26265@localhost.localdomain>
References: <CAEjxPJ7khd7dprzEKgc5zeyaHWWRQ7P8pOg09LtiBVaOi6jYTg@mail.gmail.com>
 <20200813174722.GA14310@localhost.localdomain>
 <CAEjxPJ6_V9Uo7XwY89WKX9NBp4ACd5Sn3m7pDf2n+hYH0QYkMw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ6_V9Uo7XwY89WKX9NBp4ACd5Sn3m7pDf2n+hYH0QYkMw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=plautrba@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2020 at 01:56:57PM -0400, Stephen Smalley wrote:
> On Thu, Aug 13, 2020 at 1:47 PM Petr Lautrbach <plautrba@redhat.com> wrot=
e:
> >
> > On Fri, Aug 07, 2020 at 02:54:18PM -0400, Stephen Smalley wrote:
> > > As noted in https://github.com/SELinuxProject/selinux/issues/245,
> > > symbol versioning in libsepol causes problems for LTO.  libsepol and
> > > libsemanage have a handful of versioned symbols due to incompatible
> > > ABI changes made early in the CIL integration.  However, as far as I
> > > can tell, these symbols were only used by other components of the
> > > selinux userspace, not externally.  Should we stop supporting the old
> > > versions going forward and simplify the maps? If so, does this truly
> > > require bumping the .so version or can we omit that since there are n=
o
> > > external users?  Thoughts?
> > >
> >
> > AFAIK libsemanage is used by some 3rd parties. We've had requests to sh=
ip
> > libsemanage-devel in RHEL-8 repositories in order customers build their
> > applications.
> >
> >
> > From my packager POV I like symbol versioning - it helps to prevent som=
e
> > dependency issues in development branches, e.g. when libsemanage is bui=
lt with
> > new libsepol symbol but the new package doesn't require newer libsepol.=
 rpm is
> > able to solve that:
> >
> > $ rpm -q --requires libsemanage
> > ...
> > libselinux(x86-64) >=3D 3.1-2
> > libselinux.so.1()(64bit)
> > libselinux.so.1(LIBSELINUX_1.0)(64bit)
> > libsepol.so.1()(64bit)
> > libsepol.so.1(LIBSEPOL_1.0)(64bit)
> > libsepol.so.1(LIBSEPOL_1.1)(64bit)
> > libsepol.so.1(LIBSEPOL_3.0)(64bit)
> > ...
> >
> > $ rpm -q --provides libsemanage
> > config(libsemanage) =3D 3.1-2.fc33
> > libsemanage =3D 3.1-2.fc33
> > libsemanage(x86-64) =3D 3.1-2.fc33
> > libsemanage.so.1()(64bit)
> > libsemanage.so.1(LIBSEMANAGE_1.0)(64bit)
> > libsemanage.so.1(LIBSEMANAGE_1.1)(64bit)
> >
> >
> > LTO seems to cause problems to other projects as well
> > https://lists.fedoraproject.org/archives/list/devel@lists.fedoraproject=
.org/message/XMIQMN5KNAZUPX6O3LN6JJGTCZTP4B7J/
> >
> > So I'd prefer if we try to do and use symbol versioning correctly, but =
it's not
> > hard requirement from my side.
>=20
> Ok.  An alternative to dropping it altogether is just to try to fix
> the particular problem he is seeing with the duplicated symbols in
> LIBSEPOL_1_0 and LIBSEPOL_1_1.  If we can remove the duplicate without
> breaking anything, then that might suffice for LTO.  I'm not actually
> clear on whether it is correct - there are technically two different
> versions of the symbol aliased via symver.  If the seeming duplicate
> is required then I guess we just have to wait for LTO support to catch
> up with symbol versioning.
>=20

In this particular case I'd drop duplicate symbols from libsepol. It's abou=
t 4
years and 5 releases since it was added and it would slightly clean the cod=
e. It
would be properly announced in release notes. And if there's anybody else t=
hen
libsemage who uses it they would need either to rebuild their sources or st=
ay
with the current version.


--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl872k0ACgkQviIJHj72
InWvgA/8CBVOnw3QbnosJUfP8EKgdiIoy7faX4Qu7r6iGB1snvga0Wmp4hvJv06B
8NB4SMFOoAWn7bvJZLCyR2ybrMjFTq3BGuloSij7zOASdVSRreHrEI67B+nY23LM
4Hj2nnseE0e/o3CpAuBHsBVZUPLhlpBSvCSCL4iB8K4Nr+20vRI1Wbm6Bx8DQvNB
ny3W7+S8s/l+t++ZJWk2byZaAH43YfI1+dqqlnKvfsg3aR6SEkBtPdJ0LI523vkJ
aH9Zw/H4/QGMPJpbNJ+rlgXnRE7wX9MoPtRYaOvKl51atVY5DBIV976sSFYitl2m
0CBYzY9uskeEsxUWGSoLI5TOZk1JGfyl7HaDXM/cl5LKK9E75WtqlXtCK+cIy6rR
vUtDxlfUk7puV0eBuEJ0vnSKIUDtdKNvgjmAodI+Nk7Ytdlshw3dfazeQK1mDaiw
yCqqL0EyVQFlo+OeGVq0fNpgPgI27SosvpYYqznT+jDmu0Lz3qNW3lmdDoWaUNHo
SY0sgIJwTDWphIm1s1vOEwFJzZI+77plqoqgMXPWF3o0nMFD1bDze8fbIscPx0Dk
rzRmFZEVrFfULLMR3Tjxhu/q3vI8tKQ97iYm2VLGiijdbgI4ImXJ56MZ9xmYqHsz
Vz781PBaXyTT9AOw+ukNgHP9wFL3sHcBnxoMr4aBhmxyTH24MFI=
=QEVF
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--

