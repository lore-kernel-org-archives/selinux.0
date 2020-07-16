Return-Path: <SRS0=s7s9=A3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C592C433E0
	for <selinux@archiver.kernel.org>; Thu, 16 Jul 2020 08:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 260C52071B
	for <selinux@archiver.kernel.org>; Thu, 16 Jul 2020 08:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SauO77uE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgGPIBu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jul 2020 04:01:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22467 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725897AbgGPIBu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jul 2020 04:01:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594886509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0zf3NhJGBwJ8deFe+X620ROcAwpZLLJLXqXQrRm2ams=;
        b=SauO77uEiBqCUyo1Z73ZMhGUg77oZiOoehIcZ62KYPAAe9u4WLpCAaf/NromkfSFMbj4sW
        gyciVFpGyVuM3wN69OG6HvOn/Lq86tlFholP3G3aD2agn9lVbPW+DtOh4S48Tu/60/Qkd+
        glJ92wzb5vcL9EHcKK5CEmaY7iiCtRs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-i1x7vZM-OA6W_9ayg1J8pg-1; Thu, 16 Jul 2020 04:01:39 -0400
X-MC-Unique: i1x7vZM-OA6W_9ayg1J8pg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 077391080;
        Thu, 16 Jul 2020 08:01:37 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.186])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CC82F2B6CF;
        Thu, 16 Jul 2020 08:01:35 +0000 (UTC)
Date:   Thu, 16 Jul 2020 10:01:32 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: ANN: The SELinux Notebook in markdown on GitHub
Message-ID: <20200716080132.GA33036@localhost.localdomain>
References: <CAHC9VhTuDrgzeh9mXgkW98psssUCwy5i7_=Kx6hOyinfLjcd0w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTuDrgzeh9mXgkW98psssUCwy5i7_=Kx6hOyinfLjcd0w@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 07, 2020 at 04:55:20PM -0400, Paul Moore wrote:
> If you've followed the SELinux developers mailing list for a while,
> you've surely heard of The SELinux Notebook.  For those of you that
> haven't, The SELinux Notebook is an effort by Richard Haines to
> document all the different aspects of SELinux from the kernel up
> through policy.  It's an impressive piece of work, spanning ~345 pages
> in the current edition.
>=20
> Richard has always made The SELinux Notebook freely available, but
> with the latest edition Richard has converted the entire document to
> markdown and it is now available on GitHub at the link below:
>=20
> * https://github.com/SELinuxProject/selinux-notebook
>=20
> Richard has decided that he enjoys life enough without a GitHub
> account, so I've posted it on his behalf and with his approval.
> Needless to say, this is a significant gift to the SELinux community,
> and we all own Richard our thanks.
>=20
> I've made a few tweaks to the original import from Richard, but these
> have mostly been limited to boilerplate, organization, and some
> build/formatting fixes so that we could generate a reasonable PDF for
> this initial "release".  The latest edition (release?) can be found at
> the link below:
>=20
> * https://github.com/SELinuxProject/selinux-notebook/releases/tag/2020070=
7
>=20
> It is my hope that we can treat this as a living document, keeping it
> current so that it stays relevant and useful.  Those who wish to help
> and contribute to the effort can do so via patches to the SELinux
> mailing list or via GitHub PRs.  The CONTRIBUTING.md file in the
> repository has more information.
>=20
> Thank you Richard!


This is really great news. Thank you both for this.

Petr

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl8QCVYACgkQviIJHj72
InU6ShAAujgzmZnjePMuDIEZfkkai8TO3qBd8OEcnDnDilYh8lU50XWvmXsEvvrC
BYkOIeGyB2yxoMWfofcf7GIcaQKE05lw+WGbLFcQRP3H1dKp/PhzME1dSrfAm1Ab
1y84W1rVTswe9tn0S3ej0oJ6+U8FrEGjuregHHFg3+nf7en+5JN7wNdmur9jI7+V
PllVk0sKQIHb62ieQBw4cXcIHnW5j3jxSImmju/O+TNILHdWCsoCi474asMqJMyc
dFF51cY+hhZw+kEbMhX0T6szrCU8V9bOQQjIaI2W+28Vj6D1NhQD64yKCT4kmAww
f3YX0wRofqt4Q94tlRWKEZAIcum4vuEbJDeJ2M8l+djlJD7TTN3nH8tPSW2ISrBj
8crRGaKkOwSEyvJTKDKVSNzDm2XIQgcqgdfhc1f6AM5KHy//bdRRZz9u2aUSq9OR
A/Ld0ODFuAuolar9kaUFfsqNKzLMCiIPvUDWZ6AbSzDP+zeLATmLg6uS3xKjBvrl
Y53m1++xgzxVuRFDjwrqY6wk3Kim5BMRyQzSQC/v+rHQEEq5zhnx+mgtVYfD9kxd
BwFm5WxDhOzwb8f4DcPljW5YNxrHzyQn6r/8Q9vjGem+z9VydubkmBnMpf7zqTL0
jlEIkMTJyFZ/hFbWsuPmgiMEBOdkxHkqqagMpuYALeayoN+gDqs=
=9l6l
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--

