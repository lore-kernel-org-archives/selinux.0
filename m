Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB9ILaIi014616
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 13:21:36 -0500 (EST)
Received: from mailrelay1.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB9ILdEj003426
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 18:21:39 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Thu, 9 Dec 2004 19:21:39 +0100
Date: Thu, 9 Dec 2004 19:21:39 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: patch: tags Makefile target
Message-Id: <20041209182139.GC8179@jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ChQOR20MqfxkMJg9"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--ChQOR20MqfxkMJg9
Content-Type: multipart/mixed; boundary="ep0oHQY+/Gbo/zt0"
Content-Disposition: inline


--ep0oHQY+/Gbo/zt0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch adds a Makefile target which creates a tags file. I find this
extremely handy when working on SELinux policy as I can directly jump to
the definition of a macro or type in the editor.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--ep0oHQY+/Gbo/zt0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tags.patch"
Content-Transfer-Encoding: quoted-printable

diff -urN orig/Makefile mod/Makefile
--- orig/Makefile	2004-10-26 00:19:49.000000000 +0200
+++ mod/Makefile	2004-12-09 19:08:07.000000000 +0100
@@ -162,8 +162,26 @@
 	@grep "^/root" $@.tmp >> $@
 	@-rm $@.tmp $@.root
=20
+# Create a tags-file for the policy:
+# we need exuberant ctags; unfortunately it is named differently on differ=
ent distros, sigh...
+pathsearch =3D $(firstword $(wildcard $(addsuffix /$(1),$(subst :, ,$(PATH=
))))) # taken from make-docs
+CTAGS :=3D $(call pathsearch,ctags-exuberant) # debian naming scheme
+ifeq ($(strip $(CTAGS)),)
+CTAGS :=3D $(call pathsearch,ctags) # suse naming scheme
+endif
+
+tags: $(wildcard *.te types/*.te domains/*.te domains/misc/*.te domains/pr=
ogram/*.te domains/program/unused/*.te macros/*.te macros/program/*.te)
+	@($(CTAGS) --version | grep -q Exuberant) || (echo ERROR: Need exuberant-=
ctags to function!; exit 1)
+	@LC_ALL=3DC $(CTAGS) --langdef=3Dte --langmap=3Dte:..te \
+	  --regex-te=3D'/^[ \t]*type[ \t]+(\w+)(,|;)/\1/t,type/' \
+	  --regex-te=3D'/^[ \t]*typealias[ \t]+\w+[ \t+]+alias[ \t]+(\w+);/\1/t,t=
ype/' \
+	  --regex-te=3D'/^[ \t]*attribute[ \t]+(\w+);/\1/a,attribute/' \
+	  --regex-te=3D'/^[ \t]*define\(`(\w+)/\1/d,define/' \
+	  --regex-te=3D'/^[ \t]*bool[ \t]+(\w+)/\1/b,bool/' $^
+=20
 clean:
 	rm -f policy.conf $(POLICYVER)
+	rm -f tags
 	rm -f tmp/*
 	rm -f $(FC)
 	rm -f flask/*.h

--ep0oHQY+/Gbo/zt0--

--ChQOR20MqfxkMJg9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBuJezxWIrrrL0q+cRAjCGAJ4scA8VKbpYnrqNLUh9X9vefhxvEQCfbe3k
SatRsLbiDSsmWLb7kcFrcZQ=
=F48B
-----END PGP SIGNATURE-----

--ChQOR20MqfxkMJg9--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
