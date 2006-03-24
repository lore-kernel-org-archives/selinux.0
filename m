Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2OAcMMe010972
	for <selinux@tycho.nsa.gov>; Fri, 24 Mar 2006 05:38:27 -0500
Received: from mailrelay2.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2OAaeV1021336
	for <selinux@tycho.nsa.gov>; Fri, 24 Mar 2006 10:36:41 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Fri, 24 Mar 2006 11:38:06 +0100
Date: Fri, 24 Mar 2006 11:38:05 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: Install several policy modules at once?
Message-Id: <20060324103805.GA7306@thorium.jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

I'm currently building a very modular policy so one compiled policy can
be used on many different machines. However, installing new policy is
very slow (This is on an otherwise idle system):

# time (for i in $(semodule -l | awk '{print $1}'); do semodule -i ./$i.pp; done)

real    1m38.796s
user    1m1.645s
sys     0m8.502s
# semodule -l | wc -l
23

(I don't use -u because I want to be sure I have exactly the policy
loaded which I just compiled)

Would it improve speed if semodule could process several modules at
once? Currently semodule doesn't allow this and I don't know enough
about its internals to estimate if it would be worth the effort.

Thomas


--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEI8wND9qpeVMU938RAp1MAJ0UzGognZnGlN1KZTEHoJVBnAe41gCeMdsA
1kSla8OiEoVr/VPVBxBHnxo=
=wDBh
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
