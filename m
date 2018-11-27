Return-Path: <SRS0=Cb3q=OG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA728C43441
	for <selinux@archiver.kernel.org>; Tue, 27 Nov 2018 11:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2666E2086B
	for <selinux@archiver.kernel.org>; Tue, 27 Nov 2018 11:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="QhARiQG4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2666E2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbeK0WsM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 27 Nov 2018 17:48:12 -0500
Received: from ozlabs.org ([203.11.71.1]:48601 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbeK0WsM (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 27 Nov 2018 17:48:12 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4342Cn3JRlz9s55;
        Tue, 27 Nov 2018 22:50:29 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543319431;
        bh=koxy2zQ4IY8nyV80M/AILnecurgvhzmjOAmOhPM6BrA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QhARiQG4yB3pQqa5bNEUiuY/CJJLbhVLpR6AJ/4BohFlyBZwJlDD4gIl9qnFVBUoM
         zuk24ZMtxEaeXi/Q/yNoIBnrBJKoScGTjMLt6SQP1/dTLzwc2SdHPXuBgL40e9sB9a
         zziUFJbZjNtVC+EZD5KzfKyB+PS/3A8b1DjEU4MWEi7JOA5CxknlgxUxyp+PDOremO
         2vUw+9+Ix+Ewp7Ca6F2KNUE7moqR2fmE2uRVoMZlwcauJJv+cfjzhtr698A7fRLYyB
         ckTGiMr7dbNb6xl6i1gO0V3l06E5xVUQRBQbVNylakmAB7PPVpCEbTajtqIwWdDxu3
         MCb01PUHoeTag==
Date:   Tue, 27 Nov 2018 22:50:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-next@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, selinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: linux-next: manual merge of the selinux tree with the vfs tree
Message-ID: <20181127225013.133adc7d@canb.auug.org.au>
In-Reply-To: <CAFqZXNs6XTOx2-EQ5P9bK3vPsPby7rzryHPqzqsVD9XsbsG20w@mail.gmail.com>
References: <20181127115246.00967523@canb.auug.org.au>
        <CAFqZXNs6XTOx2-EQ5P9bK3vPsPby7rzryHPqzqsVD9XsbsG20w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/YkvK3WE_k3dKyW++C4mhphL"; protocol="application/pgp-signature"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--Sig_/YkvK3WE_k3dKyW++C4mhphL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Ondrej,

On Tue, 27 Nov 2018 09:53:32 +0100 Ondrej Mosnacek <omosnace@redhat.com> wr=
ote:
>
> Hm... seems that there was some massive overhaul in the VFS code right
> at the wrong moment... There are new hooks for mounting now and the

The mount changes have been in linux-next since before the last
release ...

> code that our commit changes is now here:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/tree/securit=
y/selinux/hooks.c?h=3Dfor-next#n3131
>=20
> It seems that the logic is still the same, just now our patch (or the
> VFS one) needs to be updated to change the above line as such
> (untested pseudo-patch):
>=20
> - if (fc->purpose =3D=3D FS_CONTEXT_FOR_KERNEL_MOUNT)
> + if (fc->purpose =3D=3D (FS_CONTEXT_FOR_KERNEL_MOUNT|FS_CONTEXT_FOR_SUBM=
OUNT))

OK, so from tomorrow I will use that merge resolution.  Someone needs
to remember to tell Linus about this when the latter of the vfs and
selinux trees reach him.

Thanks for the better resolution.
--=20
Cheers,
Stephen Rothwell

--Sig_/YkvK3WE_k3dKyW++C4mhphL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlv9L3UACgkQAVBC80lX
0Gy73Af+MA5I4pLotm7nRlo1YtazY/j8g8wiiIn/ewKfi/HgHZEXAsLK7omb0d1O
H5t/0RchuJyjKwS9jaSWUBOXINtRA6jxuGWcn8pEDtuczu4nRMeZIai2T3a7Vq4F
woTD1xt96C93n9cAn1KsJFouVWN/gUjl4MeW082bo56dPNx1t5E5pFSlGHb9v0Fh
WnG2AHugu1gcODBR7cUbpj80pEnPYjHK2Mqar9G7EV16kV0HY2h9uVFb/hunQFfn
5re+JPAMBLYJOZEvDFnfErCzshMkcAQpGkc/LICbfYczD3hxGJhMmp5VzbfpQ1lt
DfLrTCSMY8SApGzyP1ZCs0jdqS72cA==
=HX9m
-----END PGP SIGNATURE-----

--Sig_/YkvK3WE_k3dKyW++C4mhphL--
