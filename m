Message-ID: <36282A1733C57546BE392885C061859236426F@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: "Stephen Smalley (E-mail)" <sds@epoch.ncsc.mil>,
   "SE Linux (E-mail)"
	 <SELinux@tycho.nsa.gov>
Subject: RE: [patch] newrole  and libselinux
Date: Wed, 18 Aug 2004 15:36:28 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C4855A.A814E8F0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C4855A.A814E8F0
Content-Type: text/plain;
	charset="iso-8859-1"


I have attached a minor logic fix to the previous patch.

-Chad

   <<context.c.diff>>  

------_=_NextPart_000_01C4855A.A814E8F0
Content-Type: application/octet-stream;
	name="context.c.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="context.c.diff"

--- libselinux/src/context.c	7 Aug 2004 20:18:59 -0000	=0A=
+++ libselinux/src/context.c	18 Aug 2004 19:25:45 -0000=0A=
@@ -39,7 +39,7 @@=0A=
 	 * Could be anywhere from 2 - 5=0A=
 	 * e.g user:role:type to user:role:type:sens1:cata-sens2:catb=0A=
 	 */=0A=
-        if ( count < 2 && count > 5 ) { /* might not have a range =
*/=0A=
+        if ( count < 2 || count > 5 ) { /* might not have a range =
*/=0A=
                 goto err;=0A=
         }=0A=
 =0A=

------_=_NextPart_000_01C4855A.A814E8F0--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
