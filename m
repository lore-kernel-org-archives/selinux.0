Message-ID: <36282A1733C57546BE392885C0618592D975CA@chaos.tcs.tcs-sec.com>
From: Jonathan Kim <jkim@TrustedCS.com>
To: SELinux@tycho.nsa.gov
Cc: Chad Hanson <chanson@TrustedCS.com>
Subject: [PATCH] libselinux
Date: Thu, 3 Nov 2005 14:33:17 -0500 
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C5E0AD.70BA51B0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C5E0AD.70BA51B0
Content-Type: text/plain;
	charset="iso-8859-1"

This patch is for handling correctly when label portion is removed from
seusers file. 
Will refer to *.users file instead of asking role:type:level to user as
expected.

 <<libselinux_seusers.patch>> 

-----------------------------------
Jonghoon Jonathan
Secure Systems Engineer

Trusted Computer Solutions
121 W Goose Alley
Urbana, IL  61801

http://www.TrustedCS.com

V:  217.384.0028  ext.16
F:  217.384.0288


------_=_NextPart_000_01C5E0AD.70BA51B0
Content-Type: application/octet-stream;
	name="libselinux_seusers.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="libselinux_seusers.patch"

diff -Nur libselinux-1.27.17.orig/src/seusers.c =
libselinux-1.27.17/src/seusers.c=0A=
--- libselinux-1.27.17.orig/src/seusers.c	2005-10-27 17:50:31.000000000 =
+0000=0A=
+++ libselinux-1.27.17/src/seusers.c	2005-11-02 17:56:32.574237594 =
+0000=0A=
@@ -63,9 +63,11 @@=0A=
 		end++;=0A=
 	*end =3D 0;=0A=
 =0A=
-	level =3D strdup(start);=0A=
-	if (!level)=0A=
-		goto err;=0A=
+	if (*start && !isspace(*start)) {=0A=
+		level =3D strdup(start);=0A=
+		if (!level)=0A=
+			goto err;=0A=
+	}=0A=
 =0A=
 out:=0A=
 	free(newbuf);=0A=

------_=_NextPart_000_01C5E0AD.70BA51B0--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
