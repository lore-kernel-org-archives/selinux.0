Return-Path: <SRS0=1V8V=AA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E47C433E3
	for <selinux@archiver.kernel.org>; Fri, 19 Jun 2020 13:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A69FD208C7
	for <selinux@archiver.kernel.org>; Fri, 19 Jun 2020 13:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eSUKlQ8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731816AbgFSNMb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 19 Jun 2020 09:12:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46416 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728851AbgFSNMb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 19 Jun 2020 09:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592572349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QK1QfGQ58J1ykYkEYo06UA0aC5e1A8/Vr26wXHPb52E=;
        b=eSUKlQ8FNmhpqqNP+icS8TAEOG/Bk5MZ1nkq1PEnapS/MuYv9IOYbtWlTvKY0CY8emW3qn
        UGtpujvb97vwEFglVThDkDrU9JHN+mHwLNfB819YdQEbujp9Rw3YREVnTFJz+Y1QQMdN4m
        f3fdio9x8W867XSTXWviDqOGM9bwHYk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-vaZpLRgqNCSfB9SNFi4MKg-1; Fri, 19 Jun 2020 09:12:23 -0400
X-MC-Unique: vaZpLRgqNCSfB9SNFi4MKg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9499418FF660
        for <selinux@vger.kernel.org>; Fri, 19 Jun 2020 13:12:22 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C517971662;
        Fri, 19 Jun 2020 13:12:21 +0000 (UTC)
Date:   Fri, 19 Jun 2020 15:12:19 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: Still Failing: SELinuxProject/selinux#444 (master - b3d8b99)
Message-ID: <20200619131219.GF785659@localhost.localdomain>
References: <SELinuxProject/selinux+700041658+stillfailing@travis-ci.org>
 <5eeca9a6c6c3f_13f81db917afc6197f@travis-tasks-8545cf558d-gwbmp.mail>
 <20200619124723.GD785659@localhost.localdomain>
 <CAFqZXNtnPU++Foy+SdeVwMFqJ14tEsNnqOFHZEsbUHmYs_-0rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0hHDr/TIsw4o3iPK"
Content-Disposition: inline
In-Reply-To: <CAFqZXNtnPU++Foy+SdeVwMFqJ14tEsNnqOFHZEsbUHmYs_-0rw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--0hHDr/TIsw4o3iPK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2020 at 02:54:47PM +0200, Ondrej Mosnacek wrote:
> On Fri, Jun 19, 2020 at 2:48 PM Petr Lautrbach <plautrba@redhat.com> wrot=
e:
> > On Fri, Jun 19, 2020 at 12:03:51PM +0000, Travis CI wrote:
> > > Build Update for SELinuxProject/selinux
> > > -------------------------------------
> > >
> > > Build: #444
> > > Status: Still Failing
> > >
> > > Duration: 17 mins and 45 secs
> > > Commit: b3d8b99 (master)
> > > Author: Petr Lautrbach
> > > Message: Update VERSIONs to 3.1-rc2 for release.
> > >
> > > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> > >
> > > View the changeset: https://github.com/SELinuxProject/selinux/compare=
/08f5e3017721...b3d8b99f0cb0
> > >
> > > View the full build log and details: https://travis-ci.org/github/SEL=
inuxProject/selinux/builds/700041658?utm_medium=3Dnotification&utm_source=
=3Demail
> > >
> >
> > Seems to be related to outage in Fedora infrastructure -
> > https://lists.fedoraproject.org/archives/list/devel@lists.fedoraproject=
=2Eorg/thread/MAGJJTVR777ARZ4TVMBQQ3YK6RC7ODE6/
> >
> > There's also ongoing datacentre move -
> > https://lists.fedoraproject.org/archives/list/devel-announce@lists.fedo=
raproject.org/thread/5DNRZ4OUUNGSUJONQLEXXP3CKME43SCE/
>=20
> Have you tried just restarting the build? Looking at the logs, it
> successfully connected to 152.19.134.145 when downloading the image,
> but then failed to connect to the same IP when downloading the
> checksum file, which would suggest the connection is just flaky and
> not completely down.
>=20

https://travis-ci.org/github/SELinuxProject/selinux/jobs/700041681 restarte=
d at
your request =20


--0hHDr/TIsw4o3iPK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl7suawACgkQviIJHj72
InVrQBAAtdOvnRo4uxl+Wi5UMsJk18AJLQJ9fp2+NnNFnVbVyBkx4MtFouOvauPI
JmQQUCAU14uHzU/C4KMMbQkJ3pk9jUQAZig5A/0t8AGX9nYhL/9Ls8ETAhI5Jd2V
1my0C165EkC/ntiqlxg2Awkd0/6Qh9shqnBNdfDuQcm+9fNUqZxJ678bxwWombmO
9qrvoZtu6bkBVAjhCmjPMIU1O5wG/vsLNYhLs/4kbmoZP5w/fyAWx92X8q6TefnH
SW1lWADRGGMuXyX7PRAxBeqVpOsywSqrd1yOhRu/YZs1sJqc4u2GACx31QHacTDT
cA4bRbn9QoHnUkwjOhY8jMc+EKUMYGqCLH3EJKhJ0FeWELqb+gkop/dK0b6NI4y+
Lac4v5fdQaRCsSaNWLfAmyRxdh7cGXzLWCbTHi2MP5Q7TJ+m+KBpgd3IlrQvHyWQ
7qOu3PynvnSYieolOesphq4EVGRHImHhCqJ5EuJsXPKIa5dF5JX1HY4DfR3bJ7gF
9cqTSnECntaMcrQRRfDDd02c2+HV/fdWk1Cy2i6avGh/4oVPEEkafvacLES3nHYt
Uux2AHRmmJOUdLDyQT1DFb+xt8/wiiOo+jEXadLwQwzNdUr8tze2iHHum/TRFtqG
Pe18imDRqTLAh2KSOKoiOYPMWz50YQr+wb47VMkrZ62xPtemi9M=
=0TeY
-----END PGP SIGNATURE-----

--0hHDr/TIsw4o3iPK--

