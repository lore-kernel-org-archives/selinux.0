Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i95LphrT000418
	for <selinux@tycho.nsa.gov>; Tue, 5 Oct 2004 17:51:43 -0400 (EDT)
Received: from ms-smtp-03.rdc-kc.rr.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i95Lpg7h012575
	for <selinux@tycho.nsa.gov>; Tue, 5 Oct 2004 21:51:42 GMT
Received: from sasami.localdomain (CPE-24-163-154-106.kc.rr.com [24.163.154.106])
	by ms-smtp-03.rdc-kc.rr.com (8.12.10/8.12.7) with ESMTP id i95LpajE021004
	for <selinux@tycho.nsa.gov>; Tue, 5 Oct 2004 16:51:39 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by sasami.localdomain (Postfix) with ESMTP id 248E84A658
	for <selinux@tycho.nsa.gov>; Tue,  5 Oct 2004 16:51:36 -0500 (CDT)
Received: from sasami.localdomain ([127.0.0.1])
	by localhost (sasami [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 06309-05 for <selinux@tycho.nsa.gov>;
	Tue, 5 Oct 2004 16:51:35 -0500 (CDT)
Received: from yggdrasil.localdomain (yggdrasil.localdomain [192.168.0.2])
	by sasami.localdomain (Postfix) with ESMTP id D8F694A650
	for <selinux@tycho.nsa.gov>; Tue,  5 Oct 2004 16:51:35 -0500 (CDT)
Date: Tue, 5 Oct 2004 16:51:35 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: need advice for ld_so_cache_t errors
Message-ID: <20041005215135.GB24275@yggdrasil.localdomain>
References: <20041001233554.GA26550@yggdrasil.localdomain> <20041002043740.GA28765@yggdrasil.localdomain> <20041002165041.GB30426@yggdrasil.localdomain> <200410040108.35839.russell@coker.com.au> <20041004014820.GA25896@yggdrasil.localdomain> <20041005003015.GA31681@yggdrasil.localdomain> <20041005010057.GA31754@yggdrasil.localdomain> <416218F1.2030105@comcast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
In-Reply-To: <416218F1.2030105@comcast.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 04, 2004 at 08:45:53PM -0700, Tom London wrote:
> see: https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D133505
>=20
> Believe there is a bug in mprotect().

That sounds like a very similar issue, but unfortunately the patch
didn't seem to make any difference.  On the plus side, reverting from
2.6.9-rc3 to 2.6.8.1 (plus the kernel patch from the NSA website) seems
to have taken care of it... guess I'll try that first in the future. ;-)

Thanx to everyone for your assistance.


--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBYxdngrEMyr8Cx2YRAqfQAKDIzyibxkGoH7d5/5xgFpMu65BY5ACeMUzl
nhCC/faIrrxnkBGMHSfVxsg=
=oiy7
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
