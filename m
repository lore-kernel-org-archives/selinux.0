Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0PFtHXf010831
	for <selinux@tycho.nsa.gov>; Wed, 25 Jan 2006 10:55:17 -0500 (EST)
Received: from mailrelay1.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0PFs3Qk028508
	for <selinux@tycho.nsa.gov>; Wed, 25 Jan 2006 15:54:03 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Wed, 25 Jan 2006 16:55:14 +0100
Date: Wed, 25 Jan 2006 16:55:12 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: Refpolicy: Add target to create tags file
Message-Id: <20060125155512.GA8779@thorium.jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--LyciRD1jyfeSSjG0
Content-Type: multipart/mixed; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The attached patch adds a target to the makefile to create a tags-file.
It is ported from the old policy, with a few changes for refpolicy.
It allows vim (and others) to quickly jump to the definition of
interfaces, booleans, and so on.

Another neat feature: You can autocomplete all interface-names in vim
with C-N and C-P if you have an appropriate tags-file. I find this very
useful with the new (rather long) interface names.

Please apply.
Thomas

--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="tags-target.patch"
Content-Transfer-Encoding: quoted-printable

--- orig/Makefile
+++ mod/Makefile
@@ -319,6 +319,28 @@
=20
 ########################################
 #
+# Generate tags file
+#
+
+# we need exuberant ctags; unfortunately it is named differently on differ=
ent distros, sigh...
+pathsearch =3D $(firstword $(wildcard $(addsuffix /$(1),$(subst :, ,$(PATH=
))))) # taken from make-docs
+CTAGS :=3D $(call pathsearch,ctags-exuberant) # debian naming scheme
+ifeq ($(strip $(CTAGS)),)
+CTAGS :=3D $(call pathsearch,ctags) # suse naming scheme
+endif
+
+tags:
+	@($(CTAGS) --version | grep -q Exuberant) || (echo ERROR: Need exuberant-=
ctags to function!; exit 1)
+	@LC_ALL=3DC $(CTAGS) --langdef=3Dte --langmap=3Dte:..te.if.spt \
+	 --regex-te=3D'/^type[ \t]+(\w+)(,|;)/\1/t,type/' \
+	 --regex-te=3D'/^typealias[ \t]+\w+[ \t+]+alias[ \t]+(\w+);/\1/t,type/' \
+	 --regex-te=3D'/^attribute[ \t]+(\w+);/\1/a,attribute/' \
+	 --regex-te=3D'/^[ \t]*define\(`(\w+)/\1/d,define/' \
+	 --regex-te=3D'/^[ \t]*interface\(`(\w+)/\1/i,interface/' \
+	 --regex-te=3D'/^[ \t]*bool[ \t]+(\w+)/\1/b,bool/' policy/modules/*/*.{if=
,te} policy/support/*.spt
+
+########################################
+#
 # Clean everything
 #
 bare: clean
@@ -328,6 +350,7 @@
 	rm -f $(MOD_CONF)
 	rm -f $(BOOLEANS)
 	rm -fR $(HTMLDIR)
+	rm -f tags
 ifneq ($(GENERATED_TE),)
 	rm -f $(GENERATED_TE)
 endif
@@ -338,6 +361,6 @@
 	rm -f $(GENERATED_FC)
 endif
=20
-.PHONY: install-src install-appconfig conf html bare
+.PHONY: install-src install-appconfig conf html bare tags
 .SUFFIXES:
 .SUFFIXES: .c




--VS++wcV0S1rZb1Fb--

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFD159gD9qpeVMU938RAmwdAJ9M5cx5YWcCT7dIDEViiqe8N8do1QCffCRD
hd6UYhXkIyT2DTRBIbUAb3Q=
=XpnD
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
