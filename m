Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i950UJrT022714
	for <selinux@tycho.nsa.gov>; Mon, 4 Oct 2004 20:30:19 -0400 (EDT)
Received: from ms-smtp-02.rdc-kc.rr.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i950UIs6004768
	for <selinux@tycho.nsa.gov>; Tue, 5 Oct 2004 00:30:18 GMT
Received: from sasami.localdomain (CPE-24-163-154-106.kc.rr.com [24.163.154.106])
	by ms-smtp-02.rdc-kc.rr.com (8.12.10/8.12.7) with ESMTP id i950UG9W002514
	for <selinux@tycho.nsa.gov>; Mon, 4 Oct 2004 19:30:16 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by sasami.localdomain (Postfix) with ESMTP id 6223D4A658
	for <selinux@tycho.nsa.gov>; Mon,  4 Oct 2004 19:30:17 -0500 (CDT)
Received: from sasami.localdomain ([127.0.0.1])
	by localhost (sasami [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 02143-03 for <selinux@tycho.nsa.gov>;
	Mon, 4 Oct 2004 19:30:17 -0500 (CDT)
Received: from yggdrasil.localdomain (yggdrasil.localdomain [192.168.0.2])
	by sasami.localdomain (Postfix) with ESMTP id 305614A650
	for <selinux@tycho.nsa.gov>; Mon,  4 Oct 2004 19:30:17 -0500 (CDT)
Date: Mon, 4 Oct 2004 19:30:15 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: need advice for ld_so_cache_t errors
Message-ID: <20041005003015.GA31681@yggdrasil.localdomain>
References: <20041001233554.GA26550@yggdrasil.localdomain> <20041002043740.GA28765@yggdrasil.localdomain> <20041002165041.GB30426@yggdrasil.localdomain> <200410040108.35839.russell@coker.com.au> <20041004014820.GA25896@yggdrasil.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
In-Reply-To: <20041004014820.GA25896@yggdrasil.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Another (probably related) oddity... I'm seeing a number of the=20
following messages logged.  This one isn't near as frequent as the=20
ld_so_cache_t error, but it seems to be a fairly regular occurrence. =20

   Oct  4 19:14:48 sasami kernel: audit(1096935288.401:0): avc:
     denied  { execute } for  pid=3D2786=20
     path=3D/usr/lib/locale/locale-archive dev=3Dhdb5=20
     ino=3D16191 scontext=3Dgnorris:staff_r:staff_t=20
     tcontext=3Dsystem_u:object_r:locale_t tclass=3Dfile

What I'm finding really confusing is why anything would be trying to
execute either ld.so.cache or locale-archive... neither have execute
permissions set normally anyway.

Ponderous!


--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBYesXgrEMyr8Cx2YRAvXJAJ4mNCdL0QX8T5Xavx4feSyuG4uARACgwbup
j2jGajw7aNsl2FFwGU0J3DI=
=FrSG
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
