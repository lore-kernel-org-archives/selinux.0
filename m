Message-Id: <200509270008.j8R08jYs019019@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'SELinux List'" <SELinux@tycho.nsa.gov>
Subject: [PATCH] semanage-functionality 1/17
Date: Mon, 26 Sep 2005 20:08:44 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00B6_01C5C2D6.19298AF0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_00B6_01C5C2D6.19298AF0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch improves error handing in checkmodule.

------
Karl MacMillan
Tresys Technology
http://www.tresys.com 


------=_NextPart_000_00B6_01C5C2D6.19298AF0
Content-Type: application/octet-stream;
	name="checkpolicy_module_compiler.c.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="checkpolicy_module_compiler.c.diff"

diff -purN -x .svn checkpolicy/module_compiler.c =
checkpolicy/module_compiler.c=0A=
--- checkpolicy/module_compiler.c	2005-09-26 14:02:40.000000000 -0400=0A=
+++ checkpolicy/module_compiler.c	2005-09-21 11:27:28.000000000 -0400=0A=
@@ -145,9 +145,11 @@ int declare_symbol(uint32_t symbol_type,=0A=
         else if (retval =3D=3D -2) {=0A=
                 return -2;=0A=
         }=0A=
-        else if (retval =3D=3D -1 || retval =3D=3D -ENOMEM) {=0A=
+        else if (retval < 0) {=0A=
                 return -3;=0A=
         }=0A=
+        else {  /* fall through possible if retval is 0 */=0A=
+        }=0A=
         if (datum_value !=3D NULL) {=0A=
                 if (ebitmap_set_bit(decl->declared.scope + symbol_type,=0A=
                                     *datum_value - 1,=0A=
@@ -497,9 +499,11 @@ int require_symbol(uint32_t symbol_type,=0A=
         else if (retval =3D=3D -2) {=0A=
                 return -2;=0A=
         }=0A=
-        else if (retval =3D=3D -1 || retval =3D=3D -ENOMEM) {=0A=
+        else if (retval < 0) {=0A=
                 return -3;=0A=
         }=0A=
+        else {  /* fall through possible if retval is 0 */=0A=
+        }=0A=
         if (datum_value !=3D NULL) {=0A=
                 if (ebitmap_set_bit(decl->required.scope + symbol_type,=0A=
                                     *datum_value - 1,=0A=

------=_NextPart_000_00B6_01C5C2D6.19298AF0--



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
