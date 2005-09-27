Message-Id: <200509270012.j8R0CGYs019097@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'SELinux List'" <SELinux@tycho.nsa.gov>
Subject: [PATCH] libsepol fix
Date: Mon, 26 Sep 2005 20:12:16 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00E9_01C5C2D6.9722FE50"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_00E9_01C5C2D6.9722FE50
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

This fixes a typo in libsepol to allow clients dynamically linking to
libsemanage to compile correctly.

Please apply.

Thanks,

Karl

------
Karl MacMillan
Tresys Technology
http://www.tresys.com 


------=_NextPart_000_00E9_01C5C2D6.9722FE50
Content-Type: application/octet-stream;
	name="libsepol_src_user_record.c.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="libsepol_src_user_record.c.diff"

diff -purN -x .svn libsepol/src/user_record.c libsepol/src/user_record.c=0A=
--- libsepol/src/user_record.c	2005-09-26 14:02:39.000000000 -0400=0A=
+++ libsepol/src/user_record.c	2005-09-26 16:38:33.000000000 -0400=0A=
@@ -117,7 +117,7 @@ int sepol_user_set_mlsrange(sepol_user_t=0A=
 }=0A=
 =0A=
 /* Roles */=0A=
-int sepol_user_get_numroles(sepol_user_t user) {=0A=
+int sepol_user_get_num_roles(sepol_user_t user) {=0A=
 	return user->num_roles;=0A=
 }=0A=
 =0A=

------=_NextPart_000_00E9_01C5C2D6.9722FE50--



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
