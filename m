Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2AMBrDo004447
	for <selinux@tycho.nsa.gov>; Thu, 10 Mar 2005 17:11:53 -0500 (EST)
Received: from mailrelay2.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2AM4ITk001138
	for <selinux@tycho.nsa.gov>; Thu, 10 Mar 2005 22:04:18 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Thu, 10 Mar 2005 23:06:47 +0100
Date: Thu, 10 Mar 2005 23:06:46 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: James Carter <jwcart2@epoch.ncsc.mil>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: Latest policy
Message-Id: <20050310220646.GC5242@thorium.jmh.mhn.de>
References: <422E893D.1020802@redhat.com> <1110489782.662.15.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
In-Reply-To: <1110489782.662.15.camel@moss-lions.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* James Carter <jwcart2@epoch.ncsc.mil> [2005-03-10 22:39]:
> Do we need to add this?
> cy-1.21.15/file_contexts/program/nrpe.fc
> --- nsapolicy/file_contexts/program/nrpe.fc	2005-02-24 14:51:09.000000000=
 -0500
> +++ policy-1.21.15/file_contexts/program/nrpe.fc	2005-03-07 09:36:55.0000=
00000 -0500
> @@ -1,3 +1,5 @@
>  # nrpe
>  /usr/bin/nrpe		--	system_u:object_r:nrpe_exec_t
>  /etc/nagios/nrpe\.cfg	--	system_u:object_r:nrpe_etc_t
> +/usr/lib(64)?/netsaint/plugins(/.*)?	--	system_u:object_r:bin_t
> +/usr/lib(64)?/nagios/plugins(/.*)?	--	system_u:object_r:bin_t
>=20
> These same statements are also in nagios.fc

Probably yes. Both nagios and nrpe want to execute these plugins, but
they are independent from each other (need not be installed on the same
machine).

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCMMT2D9qpeVMU938RAtiFAJ98QKfv6jvmzCFeXSLx67ntMGMRdQCcCS/n
qudhVtjaN1NlT+16dQyd1FI=
=lJO0
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
