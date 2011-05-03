Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p43DWJa5020094
	for <selinux@tycho.nsa.gov>; Tue, 3 May 2011 09:32:19 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p43DWIW6010814
	for <selinux@tycho.nsa.gov>; Tue, 3 May 2011 13:32:18 GMT
Message-ID: <4DC003DF.3000909@redhat.com>
Date: Tue, 03 May 2011 09:32:15 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Steve Lawrence <slawrence@tresys.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: I believe you will need this patch also to build reference policy.
Content-Type: multipart/mixed;
 boundary="------------050807060603000607030400"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050807060603000607030400
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Otherwise you end up with a conflict.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEUEARECAAYFAk3AA98ACgkQrlYvE4MpobM0JwCYt5OI6SdmIG7GkrnNwFBpfSPm
CACffGaVis6oLfIYejhFeYSPJ+f6pbU=
=k2jf
-----END PGP SIGNATURE-----

--------------050807060603000607030400
Content-Type: text/plain;
 name="checkpolicy-filename.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="checkpolicy-filename.patch"

diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index 427c189..1331c04 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -219,10 +219,11 @@ PERMISSIVE			{ return(PERMISSIVE); }
 {letter}({alnum}|[_\-])*([\.]?({alnum}|[_\-]))*	{ return(IDENTIFIER); }
 {digit}+|0x{hexval}+            { return(NUMBER); }
 {alnum}*                        { return(FILENAME); }
+\.({alnum}|[_\.\-])*	        { return(FILENAME); }
 {digit}{1,3}(\.{digit}{1,3}){3}    { return(IPV4_ADDR); }
 {hexval}{0,4}":"{hexval}{0,4}":"({hexval}|[:.])*  { return(IPV6_ADDR); }
 {digit}+(\.({alnum}|[_.])*)?    { return(VERSION_IDENTIFIER); }
-{alnum}+([_\.]|{alnum})+      { return(FILENAME); }
+{letter}+([-_\.]|{alnum})+      { return(FILENAME); }
 ([_\.]){alnum}+                 { return(FILENAME); }
 #line[ ]1[ ]\"[^\n]*\"		{ set_source_file(yytext+9); }
 #line[ ]{digit}+	        { source_lineno = atoi(yytext+6)-1; }

--------------050807060603000607030400
Content-Type: application/pgp-signature;
 name="checkpolicy-filename.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="checkpolicy-filename.patch.sig"

iEYEABECAAYFAk3AA98ACgkQrlYvE4MpobOu4QCdE3RFtBq0H8vKnMSw0DZVu2MThEIAoNUA
Y6YgBrhQH+QdjQBcl7HcnE9I
--------------050807060603000607030400--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
