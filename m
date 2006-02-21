Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k23NatJ0019373
	for <selinux@tycho.nsa.gov>; Fri, 3 Mar 2006 18:36:55 -0500
Received: from kokytos.rz.ifi.lmu.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k23NaqUU010490
	for <selinux@tycho.nsa.gov>; Fri, 3 Mar 2006 23:36:52 GMT
Received: from ferum.cip.ifi.lmu.de (ferum.cip.ifi.lmu.de [141.84.214.98])
	by kokytos.rz.ifi.lmu.de (Postfix) with ESMTP id 2E142435E3
	for <selinux@tycho.nsa.gov>; Sat,  4 Mar 2006 00:36:51 +0100 (CET)
Date: Tue, 21 Feb 2006 14:49:58 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: Refpolicy: Small fix to make refpolicy compile with make from CVS
Message-ID: <20060221134958.GB7338@thorium.jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

With the make shipped with Debian and Ubuntu (and also the current CVS
version) it is impossible to build the reference policy because make
always complains about "make: Circular tmp/all_te_files.conf <-
corenetwork.te dependency dropped." and produces incorrect output.

I'm not sure if this is a bug in make (see
https://savannah.gnu.org/bugs/index.php?func=detailitem&item_id=13529 ,
it seems like vpath and .SECONDARY interact badly here);
this small patch fixes the problem by not using .SECONDARY.
I think it doesn't have any negative consequences, but I don't know all
the make black magic, so maybe one of the make gurus can comment.

Thomas

--- Rules.modular.old   2006-02-18 00:49:29.000000000 +0000
+++ Rules.modular       2006-02-21 12:44:54.000000000 +0000
@@ -31,8 +31,6 @@
 vpath %.if $(ALL_LAYERS)
 vpath %.fc $(ALL_LAYERS)

-.SECONDARY:
-
 ########################################
 #
 # default action: create all module packages



--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFD+xqGD9qpeVMU938RAvwuAJ9FQs+tU8IULCrttjUWhI0tdUlkHQCdFLGr
y1019SC3cGvPNFaaSIh75LM=
=LhxV
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
