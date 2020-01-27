Return-Path: <SRS0=e1+f=3Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D530C2D0DB
	for <selinux@archiver.kernel.org>; Mon, 27 Jan 2020 14:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B7D32071E
	for <selinux@archiver.kernel.org>; Mon, 27 Jan 2020 14:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgA0OI2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Jan 2020 09:08:28 -0500
Received: from agnus.defensec.nl ([80.100.19.56]:36050 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbgA0OI2 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 27 Jan 2020 09:08:28 -0500
Received: from brutus.lan (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 3AC231320038;
        Mon, 27 Jan 2020 15:08:27 +0100 (CET)
Date:   Mon, 27 Jan 2020 15:08:25 +0100
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Subject: Re: question about fs sid
Message-ID: <20200127140825.GB1998492@brutus.lan>
Mail-Followup-To: Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@vger.kernel.org
References: <20200127125228.GA1998492@brutus.lan>
 <e09a265c-83ad-8422-a67b-24b265ab8381@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
In-Reply-To: <e09a265c-83ad-8422-a67b-24b265ab8381@tycho.nsa.gov>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2020 at 08:55:00AM -0500, Stephen Smalley wrote:
> On 1/27/20 7:52 AM, Dominick Grift wrote:
> > What is the fs sid used for exactly? What, if any, is its relationship =
with persistent file systems with xattr support.
> > Were currently associating a type that is generally also associated wit=
h persistent filesystems that support xattr but i dont know why.
> > Why would it not apply to other filesystems, for example tmpfs or vfat =
or whatever?
> >=20
> > Is the fs sid still used and what do i need to consider when determinin=
g what context to associate with it?
>=20
> Are you referring to the fs initial SID, or to the SID associated with ea=
ch
> filesystem/superblock?

Thanks. Yes was referring to the fs initial sid.

I now moved it to the list of unused_isids. I'll see if that works

>=20
> The former appears to be unused by any kernel code other than the
> declaration (grep -r SECINITSID_FS).  At one time, it was the default SID=
 to
> use for the filesystem/superblock.  Looks like this has never been used in
> mainline Linux, just pre-mainline SELinux.  Sadly we cannot just remove
> obsolete initial SIDs until we fix
> https://github.com/SELinuxProject/selinux-kernel/issues/12
>=20
> The latter is still relevant but the defaults are now determined through
> fs_use_* or genfscon statements, default to the unlabeled SID if there is=
 no
> match, and can be overridden via the fscontext=3D mount option.  It is us=
ed in
> permission checks on the superblock/filesystem (e.g. mount, unmount, ...)
> and to limit what file contexts can be assigned to files within the
> filesystem (associate).

--=20
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEe2FOk94VrgBPlhBrAlFoDzf+eRMFAl4u7tMACgkQAlFoDzf+
eROYNw/+J6Wd7JktM+JhoUbjjbidwOcFYjG5gCAO3DdfKY7gNtm7yPPKwtZLBqLW
0/XcUsjn9zJH/0xUq+HwyiQM//Z4GmUIDuaXC5U+DsJ4hoN1eFlwxeaa4Wn8Vjm2
jcOxAaHE1lbwX8ufcR5iFyiu281TjJHY8/5jgw2dGIXHmVa80MG1W2wGx+L9a0TK
W/ndDaKKX6D2Mevr8jf08ozKxuq/fiHzgB2ZIIUQICLpIQC7rIrcAXve5A/x8JnC
/D1UreBwcqDeYqjpxnxJRwlBQgdw63edlWIn9JdPu0ci3KK2+7agcPjsY4zMnNGq
fJHXejNS6/EMcubxm3GsiU8M2/JiG76AQoJG0+4sSNctYtCK0EWMrLi21bip48ge
AoozljIoKU0qT1EUDEnZY9DN5kCPHpE8HZb3wCOdHepwG//qEKyTnbjepLiXZ1hX
HDzV1Y5R4bRy0H7JgJNUSLdy8Av1HFzjEvqvzFdl+/dfUVB8ed05j+PTNDXwNflH
4WP+5JWIrm4OiO+cCmeTHROUFOh9LSvIxr6K17OALiFXv5NYS7e7qq5kSa7sYCdc
u1LnmJIOVrFGM7PwQmZ/OLZot+wXpdfzBNbz1HhJ8Nk/lILTb0tQCLiTOGNOKLvj
DCbfe/tJ8o3H+ZSBQK7tabZqnU/zWJfxcBIGbB9FMg/I/re7R2o=
=pjFM
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
