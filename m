Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA03008
	for <selinux@tycho.nsa.gov>; Fri, 21 Feb 2003 17:14:28 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h1LMESI23425
	for <selinux@tycho.nsa.gov>; Fri, 21 Feb 2003 22:14:28 GMT
Received: from mx.nas-smoothtransition.com (nas-vm-195.nas-smoothtransition.com [66.95.157.195] (may be forged))
        by jazzband.ncsc.mil  with ESMTP id h1LMERf23421 for <selinux@tycho.nsa.gov>; Fri, 21 Feb 2003 22:14:27 GMT
Received: from BATMAN ([66.200.42.3])
	by mx.nas-smoothtransition.com (8.11.4/8.9.3) with ESMTP id h1LMERw05117
	for <selinux@tycho.nsa.gov>; Fri, 21 Feb 2003 17:14:27 -0500
From: "Frank Mayer" <mayerf@tresys.com>
To: <selinux@tycho.nsa.gov>
Subject: policy Makefile patch
Date: Fri, 21 Feb 2003 17:14:21 -0500
Message-ID: <006501c2d9f6$99401090$6600a8c0@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0066_01C2D9CC.B06A0890"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0066_01C2D9CC.B06A0890
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Attached is a patch that changes the policy make file.  The problem was
that the users file was being run through m4, but user names must
support any name that might be used for a Linux user.  Any name that is
also used as a macro name, or something as simple as "dnl" would cause
an error if defined as a user in the policy.  This patch excludes users
(as well as the flask definitions and the security context
specifications) from the m4 processing, but still has all the te and
rbac files, as well as the constraints file, pass through m4.

Frank

------=_NextPart_000_0066_01C2D9CC.B06A0890
Content-Type: application/octet-stream;
	name="policy-makefile.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="policy-makefile.patch"

--- nsa/selinux/policy/Makefile	Sat Jan 18 01:43:37 2003=0A=
+++ nsa-new/selinux/policy/Makefile	Fri Feb 21 17:02:22 2003=0A=
@@ -30,8 +30,9 @@=0A=
 ifeq ($(MLS),y)=0A=
 POLICYFILES +=3D mls=0A=
 endif=0A=
-POLICYFILES +=3D tmp/all.te =0A=
-POLICYFILES +=3D rbac users constraints=0A=
+POLICYFILES +=3D tmp/te-rbac.m4=0A=
+POLICYFILES +=3D users =0A=
+POLICYFILES +=3D tmp/contraints.m4=0A=
 POLICYFILES +=3D initial_sid_contexts fs_use genfs_contexts net_contexts=0A=
 =0A=
 FC =3D file_contexts/file_contexts=0A=
@@ -72,6 +73,14 @@=0A=
 	cp -R . $(SRCINSTALLDIR)/policy=0A=
 =0A=
 ALLTEFILES :=3D attrib.te tmp/program_used_flags.te tmp/all_macros.te =
tmp/all_types.te tmp/all_domains.te assert.te =0A=
+TE_RBAC_MACRO_FILES :=3D tmp/all.te rbac=0A=
+CONSTRAINT_MACRO_FILES :=3D tmp/program_used_flags.te tmp/all_macros.te =
constraints=0A=
+=0A=
+tmp/te-rbac.m4: $(TE_RBAC_MACRO_FILES)=0A=
+	m4 -Imacros -s $^ > $@=0A=
+	=0A=
+tmp/contraints.m4: $(CONSTRAINT_MACRO_FILES)=0A=
+	m4 -Imacros -s $^ > $@=0A=
 =0A=
 tmp/all.te: $(ALLTEFILES)=0A=
 	cat $^ > $@=0A=

------=_NextPart_000_0066_01C2D9CC.B06A0890--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
