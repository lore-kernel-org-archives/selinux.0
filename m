Message-Id: <200405141839.i4EIdUSf027316@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'SELinux'" <SELinux@tycho.nsa.gov>
Cc: "Stephen Smalley" <sds@epoch.ncsc.mil>, <selinux-dev@tresys.com>
Subject: selinuxfs patch
Date: Fri, 14 May 2004 14:39:34 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0030_01C439C1.4630EF60"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0030_01C439C1.4630EF60
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Steve,

Attached is a trivial patch to fix a potential deadlock in the selinuxfs
code on out-of-memory errors.

Karl

Karl MacMillan
Tresys Technology
http://www.tresys.com
(410)290-1411 ext 134 


------=_NextPart_000_0030_01C439C1.4630EF60
Content-Type: application/octet-stream;
	name="selinuxfs-deadlock-fix-5-14-2004.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="selinuxfs-deadlock-fix-5-14-2004.patch"

--- selinuxfs-old.c	2004-05-14 14:18:12.000000000 -0400=0A=
+++ selinuxfs.c	2004-05-14 14:19:02.000000000 -0400=0A=
@@ -833,8 +833,10 @@=0A=
 		goto out;=0A=
 	}=0A=
 	page =3D (char*)__get_free_page(GFP_KERNEL);=0A=
-	if (!page)=0A=
-		return -ENOMEM;=0A=
+	if (!page) {=0A=
+		length =3D -ENOMEM;=0A=
+		goto out;=0A=
+	}=0A=
 	memset(page, 0, PAGE_SIZE);=0A=
 =0A=
 	if (copy_from_user(page, buf, count))=0A=
@@ -889,8 +891,10 @@=0A=
 		goto out;=0A=
 	}=0A=
 	page =3D (char*)__get_free_page(GFP_KERNEL);=0A=
-	if (!page)=0A=
-		return -ENOMEM;=0A=
+	if (!page) {=0A=
+		length =3D -ENOMEM;=0A=
+		goto out;=0A=
+	}=0A=
 =0A=
 	memset(page, 0, PAGE_SIZE);=0A=
 =0A=

------=_NextPart_000_0030_01C439C1.4630EF60--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
