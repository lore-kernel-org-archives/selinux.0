Return-Path: <SRS0=obw9=P5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59932C282DB
	for <selinux@archiver.kernel.org>; Mon, 21 Jan 2019 08:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A5EF20855
	for <selinux@archiver.kernel.org>; Mon, 21 Jan 2019 08:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Mm5sVplq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbfAUINZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:13:25 -0500
Received: from ozlabs.org ([203.11.71.1]:40027 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728019AbfAUINY (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 21 Jan 2019 03:13:24 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43jQcm3mR1z9sLt;
        Mon, 21 Jan 2019 07:04:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548014669;
        bh=rogkvXGD99hY+rXlxFdtdopS7+HCncZyA0BAl2f47WI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Mm5sVplq5OdPbX5FnhbKbXmpWdwUmExAce8nXOu/xGHnZwl7lgtO4Ndfk7p/0bojC
         oXRgASIE4vel+b+O/F9otEGWl7Mim0lfdmFlBzG6VyP4fyvEGpeCcRGOTWlxOZ3D8o
         dTMFt6PjkJOTpDZIY8LZU46Q5HgDP4qzrplyiyhy8tOtSpw7rqIJSt6fJ3kanZQrJ3
         nrn7NCDeKyqkqOXaurw7y2Onybv9OaCM01MGGhOylWhzL6NauDmK9DpqNm2LSfcPtJ
         KHSHSbjbBL6wTWcN0iOo75jL1yzTDqTJ/2mMu/6X8asj6+Bsm9hgQzNr+wmKA0pekq
         qZewpxo0oOfDg==
Date:   Mon, 21 Jan 2019 07:04:09 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        peter enderborg <peter.enderborg@sony.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        selinux@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] selinux: Fix error return code in policydb_read()
Message-ID: <20190121070410.1c90552f@canb.auug.org.au>
In-Reply-To: <20190119112148.375edf4c@canb.auug.org.au>
References: <1547821427-157169-1-git-send-email-weiyongjun1@huawei.com>
        <CAHC9VhSbtqhiMQdNJ_6yeX5+ggwVNyGYXe-E=bMj2V2z2MmAsA@mail.gmail.com>
        <20190119112148.375edf4c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/eiBn__9W+5j3iIteUcllmTy"; protocol="application/pgp-signature"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--Sig_/eiBn__9W+5j3iIteUcllmTy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Sat, 19 Jan 2019 11:21:48 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Fri, 18 Jan 2019 16:28:07 -0500 Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Fri, Jan 18, 2019 at 9:18 AM Wei Yongjun <weiyongjun1@huawei.com> wr=
ote: =20
> > >
> > > Fix to return a negative error code -ENOMEM from the error handling
> > > case instead of 0, as done elsewhere in this function.
> > >
> > > Fixes: 31696241e96e ("selinux: convert to kvmalloc")   =20
> >=20
> > Unfortunately this commit isn't to be found in any of the SELinux
> > branches, or Linus' master branch; based on the subject line I'm
> > guessing the original patch is in a -next branch somewhere.  Please
> > find whoever pushed this patch to linux-next and have them apply the
> > fix. =20
>=20
> Yeah, Kent has a series doing conversions that is in Andrew Morton's
> mmotm patch series.

I have added that patch to the akpm-current tree in linux-next from today.

--=20
Cheers,
Stephen Rothwell

--Sig_/eiBn__9W+5j3iIteUcllmTy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxE1DoACgkQAVBC80lX
0GzXVAgAmOkvxTlVZZNL/cxrZq/LeYTgmjkLtt0L23Xkjoqw4oh+7jZx4Kpj4WwV
wr16k6rczB50NXNoWp8piajaSTtN1ClRCxIBaDwwc678GHDImxg8mN9bWUv6862L
Q9FLPKzEH7D6GKrdaK3Jya3bUc7wsQ85i0M5mngm86ftI4r5EMHvbJHoI3UnI981
XBwIdqJ20txvUgqwss3FzZzCrcQGl/xdj61C5O3ovreAPIZJKj3lM2fBFzmJPHD0
YiweP9ESPNP7Qdb4tYX90kQVdzLAqny4DY1zfFa03V1MsSB1lLa8soCCzrBNN2pn
olqsUZZSpV80EzFAJvnviQ8Uc/ETrA==
=yqDz
-----END PGP SIGNATURE-----

--Sig_/eiBn__9W+5j3iIteUcllmTy--
