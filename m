Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9JKKBNs024592
	for <selinux@tycho.nsa.gov>; Wed, 19 Oct 2005 16:20:11 -0400 (EDT)
Received: from mailrelay1.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9JKH1mU012633
	for <selinux@tycho.nsa.gov>; Wed, 19 Oct 2005 20:17:02 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Wed, 19 Oct 2005 22:17:23 +0200
Date: Wed, 19 Oct 2005 22:17:20 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: Small patch for runuser: disallow suid operation
Message-Id: <20051019201719.GA9176@thorium.jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I think the following small patch should be applied to the coreutils
package, on top of the existing patch:

--- runuser.c.orig	2005-10-19 22:01:57.000000000 +0200
+++ runuser.c	2005-10-19 22:00:53.000000000 +0200
@@ -19,6 +19,8 @@
 	return PAM_SUCCESS;
 }
 int pam_open_session(pam_handle_t *pamh, int flags){
+	if (getuid() !=3D geteuid()) /* safety net: deny operation if we are suid=
 by accident */
+		error(EXIT_FAIL, 1, "runuser may not be setuid");
 	return PAM_SUCCESS;
 }
 int pam_close_session(pam_handle_t *pamh, int flags){

Rationale:
There are still a lot of scripts that assume they can use "su" to switch
uids. In some situations (eg mine :) it is simply too much work to audit
them all and keep up with updates. Instead I intend to "mv su su2; ln
runuser su" and teach the other admins to use su2 instead (users are not
allowed to use su anyway). The only problem currently is that if the
permissions on the new su are accidently set to the usual values (by
admin error or a permission check script) there is a security hole
immediately. This small patch prevents this problem; it should not
interfere with normal operation in any way.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDVqnPD9qpeVMU938RAgWXAJ0UlMIRKDomj9WdwEg9JhU7ecSprACgi1t7
ft9TkQ4rBG23II6CdRT57Uo=
=ah9i
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
