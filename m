Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA16388
	for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2003 12:22:20 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA18666
	for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2003 17:19:07 GMT
Received: from mx.nas-smoothtransition.com (nas-vm-195.nas-smoothtransition.com [66.95.157.195] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id RAA18661
	for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2003 17:19:06 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: "'Frank Mayer'" <mayerf@tresys.com>, <selinux@tycho.nsa.gov>
Subject: RE: policy Makefile patch
Date: Mon, 24 Feb 2003 12:20:14 -0500
Message-ID: <001a01c2dc29$25b9d220$6600a8c0@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_001B_01C2DBFF.3CE3CA20"
In-Reply-To: <006501c2d9f6$99401090$6600a8c0@columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_001B_01C2DBFF.3CE3CA20
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Sorry there was a problem with the last patch file...here is a
correction.  Frank

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
On
> Behalf Of Frank Mayer
> Sent: Friday, February 21, 2003 5:14 PM
> To: selinux@tycho.nsa.gov
> Subject: policy Makefile patch
> 
> Attached is a patch that changes the policy make file.  The problem
was
> that the users file was being run through m4, but user names must
> support any name that might be used for a Linux user.  Any name that
is
> also used as a macro name, or something as simple as "dnl" would cause
> an error if defined as a user in the policy.  This patch excludes
users
> (as well as the flask definitions and the security context
> specifications) from the m4 processing, but still has all the te and
> rbac files, as well as the constraints file, pass through m4.
> 
> Frank

------=_NextPart_000_001B_01C2DBFF.3CE3CA20
Content-Type: application/octet-stream;
	name="policy-makefile.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="policy-makefile.patch"

--- nsa/selinux/policy/Makefile	Sat Jan 18 01:43:37 2003=0A=
+++ nsa-new/selinux/policy/Makefile	Mon Feb 24 12:07:14 2003=0A=
@@ -30,9 +30,9 @@=0A=
 ifeq ($(MLS),y)=0A=
 POLICYFILES +=3D mls=0A=
 endif=0A=
-POLICYFILES +=3D tmp/all.te =0A=
-POLICYFILES +=3D rbac users constraints=0A=
-POLICYFILES +=3D initial_sid_contexts fs_use genfs_contexts net_contexts=0A=
+POLICYFILES +=3D tmp/te-rbac.m4=0A=
+POLICYFILES +=3D users =0A=
+POLICYFILES +=3D tmp/contraints-contexts.m4=0A=
 =0A=
 FC =3D file_contexts/file_contexts=0A=
 FCFILES=3Dfile_contexts/types.fc $(patsubst =
domains/program/%.te,file_contexts/program/%.fc, $(wildcard =
domains/program/*.te))=0A=
@@ -63,7 +63,7 @@=0A=
 =0A=
 policy.conf: $(POLICYFILES) =0A=
 	mkdir -p tmp=0A=
-	m4 -Imacros -s $(POLICYFILES) > policy.conf=0A=
+	cat $^ > $@=0A=
 =0A=
 install-src: =0A=
 	rm -rf $(SRCINSTALLDIR)/policy.old=0A=
@@ -72,6 +72,14 @@=0A=
 	cp -R . $(SRCINSTALLDIR)/policy=0A=
 =0A=
 ALLTEFILES :=3D attrib.te tmp/program_used_flags.te tmp/all_macros.te =
tmp/all_types.te tmp/all_domains.te assert.te =0A=
+TE_RBAC_MACRO_FILES :=3D tmp/all.te rbac=0A=
+CONSTRAINT_CONTEXT_MACRO_FILES :=3D tmp/program_used_flags.te =
tmp/all_macros.te constraints initial_sid_contexts fs_use genfs_contexts =
net_contexts=0A=
+=0A=
+tmp/te-rbac.m4: $(TE_RBAC_MACRO_FILES)=0A=
+	m4 -Imacros -s $^ > $@=0A=
+	=0A=
+tmp/contraints-contexts.m4: $(CONSTRAINT_CONTEXT_MACRO_FILES)=0A=
+	m4 -Imacros -s $^ > $@=0A=
 =0A=
 tmp/all.te: $(ALLTEFILES)=0A=
 	cat $^ > $@=0A=

------=_NextPart_000_001B_01C2DBFF.3CE3CA20--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
