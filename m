Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k1NCC6nW003742
	for <selinux@tycho.nsa.gov>; Thu, 23 Feb 2006 07:15:02 -0500
Received: from mailrelay2.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1NA7DAM002125
	for <selinux@tycho.nsa.gov>; Thu, 23 Feb 2006 10:07:14 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Thu, 23 Feb 2006 11:08:37 +0100
Date: Thu, 23 Feb 2006 11:08:36 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: Fwd: Refpolicy: Small fix to make refpolicy compile with make from CVS
Message-Id: <20060223100835.GA7967@thorium.jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jRHKVT23PllUwdXP"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hmm, it seems like my last message didn't make it to the list.
Try again...

(Sorry if anyone receives this message twice)

Thomas


--jRHKVT23PllUwdXP
Content-Type: message/rfc822
Content-Disposition: inline

Date: Tue, 21 Feb 2006 14:49:58 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: Refpolicy: Small fix to make refpolicy compile with make from CVS
Message-ID: <20060221134958.GB7338@thorium.jmh.mhn.de>
Mail-Followup-To: SELinux ML <selinux@tycho.nsa.gov>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline
X-Accept-Language: de, en
X-Operating-System: Linux 2.6.12-10-386 i686
User-Agent: Mutt/1.5.9i


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

--jRHKVT23PllUwdXP--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
