Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i79FU5rT025465
	for <selinux@tycho.nsa.gov>; Mon, 9 Aug 2004 11:30:05 -0400 (EDT)
Received: from moss-huskies.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i79FTTnn028644
	for <selinux@tycho.nsa.gov>; Mon, 9 Aug 2004 15:29:29 GMT
Received: from moss-huskies.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-huskies.epoch.ncsc.mil (8.12.11/8.12.11) with ESMTP id i79FU64T011824
	for <selinux@tycho.nsa.gov>; Mon, 9 Aug 2004 11:30:06 -0400
Received: (from hdholm@localhost)
	by moss-huskies.epoch.ncsc.mil (8.12.11/8.12.11/Submit) id i79FU62E011823
	for selinux@tycho.nsa.gov; Mon, 9 Aug 2004 11:30:06 -0400
Message-ID: <36282A1733C57546BE392885C061859231E505@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: "Stephen Smalley (E-mail)" <sds@epoch.ncsc.mil>,
   "SE Linux (E-mail)"
	 <SELinux@tycho.nsa.gov>
Subject: [patch] newrole  and libselinux
Date: Sat, 7 Aug 2004 16:24:45 -0400 
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C47CBC.93F09550"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C47CBC.93F09550
Content-Type: text/plain;
	charset="iso-8859-1"

Hi,

I have attached a patch which adds additional error checking into the
newrole command to prevent seg faults. Also, I have attached a patch to
libselinux to correct the handling the MLS contexts when used with
categories.

 <<selinux-usr.patch>> 

-Chad
____________________________
Chad Hanson
Senior Secure Systems Engineer

Trusted Computer Solutions
121 W Goose Alley
Urbana, IL  61801

www.TrustedCS.com

V: 217.384.0028  ext.12
F: 217.384.0288
E: chanson@TrustedCS.com


------_=_NextPart_000_01C47CBC.93F09550
Content-Type: application/octet-stream;
	name="selinux-usr.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="selinux-usr.patch"

--- policycoreutils/newrole/newrole.c	2004-05-04 14:41:25.000000000 =
-0500=0A=
+++ policycoreutils/newrole/newrole.c	2004-08-07 12:59:29.166205390 =
-0500=0A=
@@ -359,6 +359,10 @@=0A=
    * components easily. =0A=
    */=0A=
   context=3Dcontext_new(old_context);=0A=
+  if(context =3D=3D 0) {=0A=
+    fprintf(stderr,_("failed to get new context.\n"));=0A=
+    exit(-1);=0A=
+  }=0A=
 =0A=
   freecon(old_context);=0A=
   /* Make `pw' point to a structure containing the data              =
*=0A=
--- libselinux/src/context.c	2003-12-01 13:39:00.000000000 -0600=0A=
+++ libselinux/src/context.c	2004-08-07 13:03:26.342693089 -0500=0A=
@@ -35,12 +39,23 @@=0A=
                 case '\n': case '\t': case '\r': case ' ': goto err; =
/* sanity check */=0A=
                 }=0A=
         }=0A=
-        if ( count !=3D 2 && count !=3D 3 ) { /* might not have a =
range */=0A=
+	/*=0A=
+	 * Could be anywhere from 2 - 5=0A=
+	 * e.g user:role:type to user:role:type:sens1:cata-sens2:catb=0A=
+	 */=0A=
+        if ( count < 2 && count > 5 ) { /* might not have a range =
*/=0A=
                 goto err;=0A=
         }=0A=
+=0A=
         n->component[3] =3D 0;=0A=
         for ( i =3D 0, tok =3D str; *tok; i++ ) {=0A=
-                for ( p =3D tok; *p && *p !=3D ':'; p++ ) { /* empty =
*/ }=0A=
+		if (i<3)=0A=
+                	for ( p =3D tok; *p && *p !=3D ':'; p++ ) { /* empty =
*/ }=0A=
+		else=0A=
+		{=0A=
+			/* MLS range is one component */=0A=
+                	for ( p =3D tok; *p; p++ ) { /* empty */ }=0A=
+		}=0A=
                 n->component[i] =3D (char*) malloc(p-tok+1);=0A=
 		if (n->component[i] =3D=3D 0)=0A=
 		  goto err;=0A=

------_=_NextPart_000_01C47CBC.93F09550--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
