Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8RCY4Ns021216
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 08:34:04 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8RCSdpk001004
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 12:28:40 GMT
Received: from ICEMAN (iceman.columbia.tresys.com [10.1.13.108])
	by gotham.columbia.tresys.com (8.12.8/8.12.8) with ESMTP id j8RCSmYs025845
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 08:28:51 -0400
Message-Id: <200509271228.j8RCSmYs025845@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <selinux@tycho.nsa.gov>
Subject: [PATCH] semanage-functionality 3/17
Date: Tue, 27 Sep 2005 08:28:48 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0013_01C5C33D.7B974620"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0013_01C5C33D.7B974620
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Corresponding lexer changes to the config file parser changes.

------
Karl MacMillan
Tresys Technology
http://www.tresys.com 


------=_NextPart_000_0013_01C5C33D.7B974620
Content-Type: application/octet-stream;
	name="libsemanage_src_conf-scan.l.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="libsemanage_src_conf-scan.l.diff"

diff -purN -x .svn libsemanage/src/conf-scan.l =
libsemanage/src/conf-scan.l=0A=
--- libsemanage/src/conf-scan.l	2005-09-26 14:02:40.000000000 -0400=0A=
+++ libsemanage/src/conf-scan.l	2005-09-26 11:36:20.000000000 -0400=0A=
@@ -18,7 +18,9 @@=0A=
  */=0A=
 =0A=
 %{=0A=
+        =0A=
 #include "conf-parse.h"=0A=
+#include "dso.h"=0A=
 =0A=
 #include <ctype.h>=0A=
 #include <string.h>=0A=
@@ -26,9 +28,12 @@=0A=
 static char *my_strdup (char * s);=0A=
 static char *my_qstrdup (char * s);=0A=
 =0A=
+int yywrap(void);=0A=
+hidden_proto(yywrap);=0A=
+ =0A=
 %}=0A=
 =0A=
-%option stack prefix=3D"semod_"=0A=
+%option stack prefix=3D"semanage_"=0A=
 =0A=
 %x arg=0A=
 =0A=
@@ -38,7 +43,7 @@ static char *my_qstrdup (char * s);=0A=
 module-store      return MODULE_STORE;=0A=
 policy-version    return VERSION;=0A=
 "[load_policy]"   return LOAD_POLICY_START;=0A=
-"[setfiles]"      return LOAD_POLICY_START;=0A=
+"[setfiles]"      return SETFILES_START;=0A=
 "[verify module]" return VERIFY_MOD_START;=0A=
 "[verify linked]" return VERIFY_LINKED_START;=0A=
 "[verify kernel]" return VERIFY_KERNEL_START;=0A=
@@ -47,37 +52,39 @@ path              return PROG_PATH;=0A=
 args              return PROG_ARGS;=0A=
 [ \t]*=3D[ \t]*     BEGIN arg; return '=3D';=0A=
 [ \t\n]+          /* ignore */=0A=
-.                 return semod_text [0];=0A=
-<arg>\"\"         BEGIN INITIAL; semod_lval.s =3D NULL; return ARG;=0A=
-<arg>\".+\"       BEGIN INITIAL; semod_lval.s =3D my_qstrdup =
(semod_text); return ARG;=0A=
-<arg>.*[^\"\n]    BEGIN INITIAL; semod_lval.s =3D my_strdup =
(semod_text); return ARG;=0A=
-<arg>\n           BEGIN INITIAL; semod_lval.s =3D NULL; return ARG;=0A=
+.                 return semanage_text[0];=0A=
+<arg>\"\"         BEGIN INITIAL; semanage_lval.s =3D NULL; return ARG;=0A=
+<arg>\".+\"       BEGIN INITIAL; semanage_lval.s =3D =
my_qstrdup(semanage_text); return ARG;=0A=
+<arg>.*[^\"\n]    BEGIN INITIAL; semanage_lval.s =3D =
my_strdup(semanage_text); return ARG;=0A=
+<arg>.|\n         BEGIN INITIAL; semanage_lval.s =3D NULL; return ARG;=0A=
 =0A=
 %%=0A=
 =0A=
-int yywrap (void) {=0A=
-        return 1;=0A=
+int yywrap(void) {=0A=
+	return 1;=0A=
 }=0A=
 =0A=
 /* Like strdup(), but also trim leading and trailing whitespace.=0A=
  * Returns NULL on error. */=0A=
-static char *my_strdup (char *s) {=0A=
-        char *t;=0A=
-        while (isspace (*s)) {=0A=
-                s++;=0A=
-        }=0A=
-        t =3D s + strlen (s) - 1;=0A=
-        while (t >=3D s && isspace (*t)) {=0A=
-                *t =3D '\0';=0A=
-                t--;=0A=
-        }=0A=
-        return strdup (s);=0A=
+static char *my_strdup(char *s) {=0A=
+	char *t;=0A=
+	while (isspace(*s)) {=0A=
+		s++;=0A=
+	}=0A=
+	t =3D s + strlen(s) - 1;=0A=
+	while (t >=3D s && isspace(*t)) {=0A=
+		*t =3D '\0';=0A=
+		t--;=0A=
+	}=0A=
+	return strdup(s);=0A=
 }=0A=
 =0A=
 /* strdup() a string sans initial and trailing characters.  Does /not/=0A=
- * trim any whitespace.  Returns NULL on error. */=0A=
-static char *my_qstrdup (char *s) {=0A=
-        s++;=0A=
-        s [strlen (s) - 1] =3D '\0';=0A=
-        return strdup (s);=0A=
+ * trim any whitespace.	 Returns NULL on error. */=0A=
+static char *my_qstrdup(char *s) {=0A=
+	s++;=0A=
+	s[strlen(s) - 1] =3D '\0';=0A=
+	return strdup(s);=0A=
 }=0A=
+=0A=
+hidden_def(yywrap);=0A=

------=_NextPart_000_0013_01C5C33D.7B974620--



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
