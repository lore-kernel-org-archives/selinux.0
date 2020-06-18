Return-Path: <SRS0=MecV=77=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52ECC433E6
	for <selinux@archiver.kernel.org>; Thu, 18 Jun 2020 15:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C093720732
	for <selinux@archiver.kernel.org>; Thu, 18 Jun 2020 15:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JsI9wQ95"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731650AbgFRPxE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Jun 2020 11:53:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33736 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731624AbgFRPxC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Jun 2020 11:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592495581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2kkYRqzTIeYHI9Op1N84j28lJhtw+ETduK11L29KnkQ=;
        b=JsI9wQ95FgN8jWbb/GFJQ+I9UsQwyI2YDsbawQ+JINhuXgPyMvkRiXk1C27bEzVF0dhS/h
        ciRroCIKQWDkK0UpXCgEyc7MFb2hqnqslnuWebaaIUmUgw9jUJDVPe/lkMQdKe3ieUYzkm
        gwjUJQsrc7KTlUH4j3veLvNIsPOdgR0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-y3l6NpnXPAq1yFVxE2jUeA-1; Thu, 18 Jun 2020 11:52:54 -0400
X-MC-Unique: y3l6NpnXPAq1yFVxE2jUeA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5A6A107ACCA;
        Thu, 18 Jun 2020 15:52:44 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5DE9A5BAC1;
        Thu, 18 Jun 2020 15:52:43 +0000 (UTC)
Date:   Thu, 18 Jun 2020 17:52:40 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        William Roberts <bill.c.roberts@gmail.com>,
        William Roberts <william.c.roberts@intel.com>
Subject: Re: [PATCH v2] ci: dont use hardcoded project name
Message-ID: <20200618155240.GA689512@localhost.localdomain>
References: <CAFftDdrszrtxO64GtiGKyszae-rNv9Kohzs-jwmxgtW3rfTnJw@mail.gmail.com>
 <20200611173039.21742-1-william.c.roberts@intel.com>
 <20200612053940.GA540562@localhost.localdomain>
 <CAEjxPJ7Zs_WY0F=O-gNVY_r8Bn1GcwxezZPXNuard3+9gmhq+w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ7Zs_WY0F=O-gNVY_r8Bn1GcwxezZPXNuard3+9gmhq+w@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=plautrba@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2020 at 01:07:35PM -0400, Stephen Smalley wrote:
> On Fri, Jun 12, 2020 at 1:39 AM Petr Lautrbach <plautrba@redhat.com> wrot=
e:
> >
> > On Thu, Jun 11, 2020 at 12:30:39PM -0500, bill.c.roberts@gmail.com wrot=
e:
> > > From: William Roberts <william.c.roberts@intel.com>
> > >
> > > Not everyone's github project is "selinux" so use the projects
> > > name, as derived from TRAVIS_BUILD_DIR. TRAVIS_BUILD_DIR is
> > > the absolute path to the project checkout on disk, so the
> > > basename should be sufficient. The script that runs in the KVM
> > > environment also needs to be updated where it can find the
> > > selinux project code, so we pass it in through an env variable
> > > in the ssh command.
> > >
> > > Tested on Travis CI here:
> > >   - https://travis-ci.org/github/williamcroberts/selinux/jobs/6973078=
24
> > >
> > > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> >
> > Acked-by: Petr Lautrbach <plautrba@redhat.com>
>=20
> Since I saw that you have been creating and testing a 3.1-rc2 branch I
> have held off on merging any further patches even ones that have been
> acked; I'll wait until you finalize that with whatever set of patches
> you have picked up.
>=20

Thanks, I'll merge everything acked later today and create 3.1-rc2 tomorrow
morning.

And I'm sorry for big delays on my side.
--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl7rjb8ACgkQviIJHj72
InUjDQ//Rf2kkN0vA+2Eg16UgTeU2abToyNgkiBJmZeLfO4uFRdwLfYpvjtabOxM
CcpvJAH+w/IAXVt6WUW9hYzajSC7c3Mp1nbLyefsekDD/DRbALYDULgFZ7yKFgOC
X4o+q/+kFZfclkRb5nbLRUtCO3ZroSjJaxG5kd/aKyMUwOs6JSN3PZbOKqQPhM1A
ty8wKJiTvgbExemF2IBr+xe55ih1ScUNA80PjEVydHDxklnKAhVZgTePzWM8RuU4
nbvADDvbpiqyio3hZwZznwxWRRhaoceYxNw5nPmFRMG1qAdSCKHRu5oRlA79jId3
4oyIsIp8cLS8aaR4xjU8A1Ayes6AgDNS937u5bq5c74jE20XdmV7Zx5OUa32ev1B
eenI/JZq3AeM0LXAUBHDAnKBrfojmjDRJ2W3VcbVfcFZVit31qNpzWv//wqpSjYU
AzqxbFPXTzLijEnx6pnjhE1Easu2vGi82w17+GCK1L3/IFyIvB48i3k5fnH+vGuX
YHTtPyYcW+P0Isc1N4W1SBXIuVI73VKOjQZD4M3a+bvDzPFcjM+mTVfe3gxkxQXH
Ak0DBJiBAAe6KvwmLWdSqj4D68el4vaKUkDtg+rSRlvJoXiEmJKbJFgY/lNFy9us
s45Oo16eN04J0RtQTEJsxXZDGtWO2FbA+wq0H2EZDDv7TAbkBrk=
=PTtv
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--

