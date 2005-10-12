Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9CLWuNs018112
	for <selinux@tycho.nsa.gov>; Wed, 12 Oct 2005 17:32:56 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9CLV2xN002621
	for <selinux@tycho.nsa.gov>; Wed, 12 Oct 2005 21:31:03 GMT
Message-Id: <200510122130.j9CLUoYs009954@gotham.columbia.tresys.com>
From: "Kevin Carr" <kcarr@tresys.com>
To: <selinux@tycho.nsa.gov>
Cc: <selinux-dev@tresys.com>, <russell@coker.com.au>,
   "Daniel J Walsh" <dwalsh@redhat.com>
Subject: new setools release
Date: Wed, 12 Oct 2005 17:30:50 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0333_01C5CF52.B1892430"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0333_01C5CF52.B1892430
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

There is a bug-fix release of setools available on the Tresys Technology
website.  This addresses an issue with loading mls policies and is required
for FC5.

http://www.tresys.com/selinux/selinux_policy_tools.shtml

I attached the patch against setools-2.1.2.  

Kevin Carr
Tresys Technology
410.290.1411 x137


------=_NextPart_000_0333_01C5CF52.B1892430
Content-Type: application/octet-stream;
	name="setools-2.1.3-patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="setools-2.1.3-patch"

diff -purN setools-2.1.2/apol/apol_help.txt =
setools-2.1.3/apol/apol_help.txt=0A=
--- setools-2.1.2/apol/apol_help.txt	2005-08-31 16:51:57.000000000 -0400=0A=
+++ setools-2.1.3/apol/apol_help.txt	2005-10-12 14:51:35.000000000 -0400=0A=
@@ -1,6 +1,6 @@=0A=
 SELinux Policy Analysis Tool Help File=0A=
 apol, version 2.1=0A=
-August 31, 2005=0A=
+October 12, 2005=0A=
 selinux@tresys.com=0A=
 =0A=
 This file contains basic help information for using apol, version=0A=
diff -purN setools-2.1.2/apol/dta_help.txt =
setools-2.1.3/apol/dta_help.txt=0A=
--- setools-2.1.2/apol/dta_help.txt	2005-08-31 16:51:57.000000000 -0400=0A=
+++ setools-2.1.3/apol/dta_help.txt	2005-10-12 14:51:35.000000000 -0400=0A=
@@ -1,6 +1,6 @@=0A=
 AN OVERVIEW OF DOMAIN TRANSITION ANALYSIS=0A=
 apol, version 2.1=0A=
-August 31, 2005=0A=
+October 12, 2005=0A=
 selinux@tresys.com=0A=
 =0A=
 A key feature of Type Enforcement (TE) security is the ability to =0A=
diff -purN setools-2.1.2/apol/file_relabel_help.txt =
setools-2.1.3/apol/file_relabel_help.txt=0A=
--- setools-2.1.2/apol/file_relabel_help.txt	2005-08-31 =
16:51:57.000000000 -0400=0A=
+++ setools-2.1.3/apol/file_relabel_help.txt	2005-10-12 =
14:51:35.000000000 -0400=0A=
@@ -1,6 +1,6 @@=0A=
 AN OVERVIEW OF FILE RELABEL ANALYSIS=0A=
 apol, version 2.1=0A=
-August 31, 2005=0A=
+October 12, 2005=0A=
 selinux@tresys.com=0A=
 =0A=
 UNDERSTANDING FILE RELABEL ANALYSIS=0A=
diff -purN setools-2.1.2/apol/flow_assertion_help.txt =
setools-2.1.3/apol/flow_assertion_help.txt=0A=
--- setools-2.1.2/apol/flow_assertion_help.txt	2005-08-31 =
16:51:57.000000000 -0400=0A=
+++ setools-2.1.3/apol/flow_assertion_help.txt	2005-10-12 =
14:51:36.000000000 -0400=0A=
@@ -1,6 +1,6 @@=0A=
 AN OVERVIEW OF INFORMATION FLOW ASSERTION=0A=
 apol, version 2.1=0A=
-August 31, 2005=0A=
+October 12, 2005=0A=
 selinux@tresys.com=0A=
 =0A=
 THE NEED FOR INFORMATION FLOW ASSERTION AND A FLOW ASSERTION LANGUAGE=0A=
diff -purN setools-2.1.2/apol/iflow_help.txt =
setools-2.1.3/apol/iflow_help.txt=0A=
--- setools-2.1.2/apol/iflow_help.txt	2005-08-31 16:51:57.000000000 -0400=0A=
+++ setools-2.1.3/apol/iflow_help.txt	2005-10-12 14:51:35.000000000 -0400=0A=
@@ -1,6 +1,6 @@=0A=
 AN OVERVIEW OF INFORMATION FLOW ANALYSIS=0A=
 apol, version 2.1=0A=
-August 31, 2005=0A=
+October 12, 2005=0A=
 selinux@tresys.com=0A=
 =0A=
 =0A=
diff -purN setools-2.1.2/apol/obj_perms_help.txt =
setools-2.1.3/apol/obj_perms_help.txt=0A=
--- setools-2.1.2/apol/obj_perms_help.txt	2005-08-31 16:51:57.000000000 =
-0400=0A=
+++ setools-2.1.3/apol/obj_perms_help.txt	2005-10-12 14:51:35.000000000 =
-0400=0A=
@@ -1,6 +1,6 @@=0A=
 AN OVERVIEW OF OBJECT CLASSES AND PERMISSIONS=0A=
 apol, version 2.1=0A=
-August 31, 2005=0A=
+October 12, 2005=0A=
 selinux@tresys.com=0A=
 =0A=
 OVERVIEW=0A=
diff -purN setools-2.1.2/apol/types_relation_help.txt =
setools-2.1.3/apol/types_relation_help.txt=0A=
--- setools-2.1.2/apol/types_relation_help.txt	2005-08-31 =
16:51:57.000000000 -0400=0A=
+++ setools-2.1.3/apol/types_relation_help.txt	2005-10-12 =
14:51:35.000000000 -0400=0A=
@@ -1,6 +1,6 @@=0A=
 AN OVERVIEW OF TYPES RELATIONSHIP SUMMARY ANALYSIS=0A=
 apol, version 2.1=0A=
-August 31, 2005=0A=
+October 12, 2005=0A=
 selinux@tresys.com=0A=
 =0A=
 UNDERSTANDING TYPES RELATIONSHIP SUMMARY ANALYSIS=0A=
diff -purN setools-2.1.2/ChangeLog-setools =
setools-2.1.3/ChangeLog-setools=0A=
--- setools-2.1.2/ChangeLog-setools	2005-08-21 22:08:38.000000000 -0400=0A=
+++ setools-2.1.3/ChangeLog-setools	2005-10-12 14:51:36.000000000 -0400=0A=
@@ -1,5 +1,11 @@=0A=
 CHANGE LOG, SE Linux TOOLS (setools)=0A=
 =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=0A=
+October 12, 2005 Version 2.1.3=0A=
+=0A=
+libapol:=0A=
+	fixed a mls bug in the source parser.=0A=
+=0A=
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=0A=
 August 24, 2005 Version 2.1.2=0A=
 =0A=
 apol:=0A=
diff -purN setools-2.1.2/INSTALL setools-2.1.3/INSTALL=0A=
--- setools-2.1.2/INSTALL	2005-08-31 16:51:57.000000000 -0400=0A=
+++ setools-2.1.3/INSTALL	2005-10-12 14:51:35.000000000 -0400=0A=
@@ -1,8 +1,8 @@=0A=
-SELinux Tools (setools), version 2.1.2=0A=
+SELinux Tools (setools), version 2.1.3=0A=
 by Tresys Technology, LLC=0A=
 (selinux@tresys.com, www.tresys.com/selinux)=0A=
 =0A=
-August 31, 2005=0A=
+October 12, 2005=0A=
 =0A=
 BUILDING AND INSTALLING NOTES AND WARNINGS=0A=
 =0A=
diff -purN setools-2.1.2/KNOWN-BUGS setools-2.1.3/KNOWN-BUGS=0A=
--- setools-2.1.2/KNOWN-BUGS	2005-08-31 16:51:57.000000000 -0400=0A=
+++ setools-2.1.3/KNOWN-BUGS	2005-10-12 14:51:35.000000000 -0400=0A=
@@ -1,8 +1,8 @@=0A=
-SELinux Tools (setools), version 2.1.2=0A=
+SELinux Tools (setools), version 2.1.3=0A=
 by Tresys Technology, LLC=0A=
 (selinux@tresys.com, www.tresys.com/selinux)=0A=
 =0A=
-August 31, 2005=0A=
+October 12, 2005=0A=
 =0A=
 =0A=
 CURRENT BUGS AND ISSUES=0A=
diff -purN setools-2.1.2/libapol/apolicy_parse.y =
setools-2.1.3/libapol/apolicy_parse.y=0A=
--- setools-2.1.2/libapol/apolicy_parse.y	2005-08-21 09:37:33.000000000 =
-0400=0A=
+++ setools-2.1.3/libapol/apolicy_parse.y	2005-10-12 14:51:35.000000000 =
-0400=0A=
@@ -3041,11 +3041,23 @@ static int define_validatetrans(void)=0A=
 static int define_range_trans(void)=0A=
 {=0A=
 	char *id;=0A=
-	int rt;=0A=
+	int rt, l;=0A=
+=0A=
 	while ((id =3D queue_remove(id_queue)))=0A=
 		free(id);=0A=
 	while ((id =3D queue_remove(id_queue)))=0A=
 		free(id);=0A=
+	id =3D queue_remove(id_queue);=0A=
+	free(id);=0A=
+	for (l =3D 0; l < 2; l++) {=0A=
+		while ((id =3D queue_remove(id_queue))) {=0A=
+			free(id);=0A=
+		}=0A=
+		id =3D queue_remove(id_queue);=0A=
+		if (!id)=0A=
+			break;=0A=
+		free(id); =0A=
+	}=0A=
 	rt =3D set_policy_version(POL_VER_MLS, parse_policy);=0A=
 	if(rt !=3D 0) {=0A=
 		yyerror("error setting policy version");=0A=
diff -purN setools-2.1.2/libapol/VERSION setools-2.1.3/libapol/VERSION=0A=
--- setools-2.1.2/libapol/VERSION	2005-08-15 03:03:37.000000000 -0400=0A=
+++ setools-2.1.3/libapol/VERSION	2005-10-12 14:51:35.000000000 -0400=0A=
@@ -1 +1 @@=0A=
-2.0.2=0A=
+2.0.3=0A=
diff -purN setools-2.1.2/README setools-2.1.3/README=0A=
--- setools-2.1.2/README	2005-08-31 16:51:57.000000000 -0400=0A=
+++ setools-2.1.3/README	2005-10-12 14:51:35.000000000 -0400=0A=
@@ -1,8 +1,8 @@=0A=
-SELinux Tools (setools), version 2.1.2=0A=
+SELinux Tools (setools), version 2.1.3=0A=
 by Tresys Technology, LLC=0A=
 (selinux@tresys.com, www.tresys.com/selinux)=0A=
 =0A=
-August 31, 2005=0A=
+October 12, 2005=0A=
 =0A=
 OVERVIEW=0A=
 =0A=
diff -purN setools-2.1.2/seaudit/seaudit_help.txt =
setools-2.1.3/seaudit/seaudit_help.txt=0A=
--- setools-2.1.2/seaudit/seaudit_help.txt	2005-08-31 16:51:57.000000000 =
-0400=0A=
+++ setools-2.1.3/seaudit/seaudit_help.txt	2005-10-12 14:51:35.000000000 =
-0400=0A=
@@ -1,6 +1,6 @@=0A=
 Audit Log Analysis Tool for Security Enhanced Linux=0A=
 seaudit, version 1.4.1=0A=
-August 31, 2005=0A=
+October 12, 2005=0A=
 selinux@tresys.com=0A=
 =0A=
 Overview:  =0A=
diff -purN setools-2.1.2/sediff/sediff_help.txt =
setools-2.1.3/sediff/sediff_help.txt=0A=
--- setools-2.1.2/sediff/sediff_help.txt	2005-08-31 16:51:57.000000000 =
-0400=0A=
+++ setools-2.1.3/sediff/sediff_help.txt	2005-10-12 14:51:35.000000000 =
-0400=0A=
@@ -1,6 +1,6 @@=0A=
 Semantic Policy Difference Tool for Security Enhanced Linux=0A=
 sediff, Graphical User Interface version 1.1.1=0A=
-August 31, 2005=0A=
+October 12, 2005=0A=
 selinux@tresys.com=0A=
 =0A=
 Overview:=0A=
diff -purN setools-2.1.2/sepct/sepcut_help.txt =
setools-2.1.3/sepct/sepcut_help.txt=0A=
--- setools-2.1.2/sepct/sepcut_help.txt	2005-08-31 16:51:57.000000000 =
-0400=0A=
+++ setools-2.1.3/sepct/sepcut_help.txt	2005-10-12 14:51:36.000000000 =
-0400=0A=
@@ -1,6 +1,6 @@=0A=
 SE Linux Policy Customization and Editing Tool Help File=0A=
 sepcut, version 0.3.8=0A=
-August 31, 2005=0A=
+October 12, 2005=0A=
 selinux@tresys.com=0A=
 =0A=
 =0A=
diff -purN setools-2.1.2/seuser/seuser_help.txt =
setools-2.1.3/seuser/seuser_help.txt=0A=
--- setools-2.1.2/seuser/seuser_help.txt	2005-08-31 16:51:57.000000000 =
-0400=0A=
+++ setools-2.1.3/seuser/seuser_help.txt	2005-10-12 14:51:35.000000000 =
-0400=0A=
@@ -1,7 +1,7 @@=0A=
 =0A=
 SELinux User Manager Help File=0A=
 seuser, Version 0.6=0A=
-August 31, 2005=0A=
+October 12, 2005=0A=
 selinux@tresys.com=0A=
 ----------------------------------=0A=
 =0A=
diff -purN setools-2.1.2/VERSION setools-2.1.3/VERSION=0A=
--- setools-2.1.2/VERSION	2005-08-14 15:17:21.000000000 -0400=0A=
+++ setools-2.1.3/VERSION	2005-10-12 14:51:36.000000000 -0400=0A=
@@ -1 +1 @@=0A=
-2.1.2=0A=
+2.1.3=0A=

------=_NextPart_000_0333_01C5CF52.B1892430--



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
