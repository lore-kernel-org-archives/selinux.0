Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9511ArT022859
	for <selinux@tycho.nsa.gov>; Mon, 4 Oct 2004 21:01:10 -0400 (EDT)
Received: from ms-smtp-04.rdc-kc.rr.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i950xvYE024248
	for <selinux@tycho.nsa.gov>; Tue, 5 Oct 2004 00:59:57 GMT
Received: from sasami.localdomain (CPE-24-163-154-106.kc.rr.com [24.163.154.106])
	by ms-smtp-04.rdc-kc.rr.com (8.12.8p1/8.12.7) with ESMTP id i950shpS015659
	for <selinux@tycho.nsa.gov>; Mon, 4 Oct 2004 19:54:46 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by sasami.localdomain (Postfix) with ESMTP id 179B64A658
	for <selinux@tycho.nsa.gov>; Mon,  4 Oct 2004 20:00:58 -0500 (CDT)
Received: from sasami.localdomain ([127.0.0.1])
	by localhost (sasami [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 02146-07 for <selinux@tycho.nsa.gov>;
	Mon, 4 Oct 2004 20:00:57 -0500 (CDT)
Received: from yggdrasil.localdomain (yggdrasil.localdomain [192.168.0.2])
	by sasami.localdomain (Postfix) with ESMTP id DA21E4A650
	for <selinux@tycho.nsa.gov>; Mon,  4 Oct 2004 20:00:57 -0500 (CDT)
Date: Mon, 4 Oct 2004 20:00:57 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: need advice for ld_so_cache_t errors
Message-ID: <20041005010057.GA31754@yggdrasil.localdomain>
References: <20041001233554.GA26550@yggdrasil.localdomain> <20041002043740.GA28765@yggdrasil.localdomain> <20041002165041.GB30426@yggdrasil.localdomain> <200410040108.35839.russell@coker.com.au> <20041004014820.GA25896@yggdrasil.localdomain> <20041005003015.GA31681@yggdrasil.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
In-Reply-To: <20041005003015.GA31681@yggdrasil.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ok, I've (finally) figured out what's actually failing.  When I strace a=20
tail command on my selinux box, the following entries seem of interest:

   open("/etc/ld.so.cache", O_RDONLY)      =3D 3
   fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D11997, ...}) =3D 0
   old_mmap(NULL, 11997, PROT_READ, MAP_PRIVATE, 3, 0) =3D -1 EACCES (Permi=
ssion denied)
   close(3)                                =3D 0

   open("/usr/lib/locale/locale-archive", O_RDONLY|O_LARGEFILE) =3D 3
   fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D1589840, ...}) =3D 0
   mmap2(NULL, 1589840, PROT_READ, MAP_PRIVATE, 3, 0) =3D -1 EACCES (Permis=
sion denied)
   close(3)                                =3D 0

When I strace the same command on my non-selinux box (also running
Debian sid), both of the mmaps are successful.  So I guess I need to
figure out why the the mmaps are being blocked.

I'm not sure why selinux would log that as a denied execute, tho.

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBYfJJgrEMyr8Cx2YRAgUnAKCr0M3qgJi+oa+aL6f8192PLlWKqgCghr+e
BjZHRqxNPLh6JQpEAgOMklE=
=Afjx
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
