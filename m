Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA24726
	for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2002 14:57:14 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA05277
	for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2002 18:55:27 GMT
Received: from mx.nas-smoothtransition.com ([66.95.157.159])
        by jazzband.ncsc.mil  with ESMTP id SAA05273 for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2002 18:55:27 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: <selinux@tycho.nsa.gov>
Cc: "'David Caplan'" <dac@tresys.com>
Subject: RE: checkpolicy and login names [patch]
Date: Thu, 26 Sep 2002 14:57:59 -0400
Message-ID: <006b01c2658e$a57e8990$6600a8c0@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_006C_01C2656D.1E6CE990"
In-Reply-To: <006a01c2658d$6b0b6c20$6600a8c0@columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_006C_01C2656D.1E6CE990
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Ok, correct patch is attached.  The cexpr_prim stuff is a 
> little tricky; hopefully I got it right in this patch!  Frank

It's just not my day.  I left the attachment off my last message.

------=_NextPart_000_006C_01C2656D.1E6CE990
Content-Type: application/octet-stream;
	name="cp.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cp.patch"

diff -ruN checkpolicy/policy_parse.y checkpolicy.new/policy_parse.y=0A=
--- checkpolicy/policy_parse.y	Thu Sep 26 14:39:14 2002=0A=
+++ checkpolicy.new/policy_parse.y	Thu Sep 26 14:24:48 2002=0A=
@@ -99,6 +99,7 @@=0A=
 %token U1 U2 R1 R2 T1 T2=0A=
 %token NOT AND OR =0A=
 %token IDENTIFIER=0A=
+%token USER_IDENTIFIER=0A=
 %token NUMBER=0A=
 %token EQUALS=0A=
 %token NOTEQUAL=0A=
@@ -322,10 +323,10 @@=0A=
 			| T1 op T2=0A=
 			{ $$ =3D (int) define_cexpr(CEXPR_ATTR, CEXPR_TYPE, $2);=0A=
 			  if ($$ =3D=3D 0) return -1; }=0A=
-			| U1 op { if (insert_separator(1)) return -1; } names_push=0A=
+			| U1 op { if (insert_separator(1)) return -1; } user_names_push=0A=
 			{ $$ =3D (int) define_cexpr(CEXPR_NAMES, CEXPR_USER, $2);=0A=
 			  if ($$ =3D=3D 0) return -1; }=0A=
-			| U2 op { if (insert_separator(1)) return -1; } names_push=0A=
+			| U2 op { if (insert_separator(1)) return -1; } user_names_push=0A=
 			{ $$ =3D (int) define_cexpr(CEXPR_NAMES, CEXPR_USER | CEXPR_TARGET, =
$2);=0A=
 			  if ($$ =3D=3D 0) return -1; }=0A=
 			| R1 op { if (insert_separator(1)) return -1; } names_push=0A=
@@ -377,7 +378,10 @@=0A=
 users			: user_def=0A=
 			| users user_def=0A=
 			;=0A=
-user_def		: USER identifier ROLES names opt_user_ranges ';'=0A=
+user_id			: identifier=0A=
+			| user_identifier=0A=
+			;=0A=
+user_def		: USER user_id ROLES names opt_user_ranges ';'=0A=
 	                {if (define_user()) return -1;}=0A=
 			;=0A=
 opt_user_ranges		: RANGES user_ranges =0A=
@@ -470,7 +474,7 @@=0A=
 			  $$ =3D addr;=0A=
 			}=0A=
     			;=0A=
-security_context_def	: identifier ':' identifier ':' identifier =
opt_mls_range_def=0A=
+security_context_def	: user_id ':' identifier ':' identifier =
opt_mls_range_def=0A=
 	                ;=0A=
 opt_mls_range_def	: ':' mls_range_def=0A=
 			|	=0A=
@@ -536,6 +540,23 @@=0A=
 identifier		: IDENTIFIER=0A=
 			{ if (insert_id(yytext,0)) return -1; }=0A=
 			;=0A=
+user_identifier		: USER_IDENTIFIER=0A=
+			{ if (insert_id(yytext,0)) return -1; }=0A=
+			;=0A=
+user_identifier_push	: USER_IDENTIFIER=0A=
+			{ if (insert_id(yytext, 1)) return -1; }=0A=
+			;=0A=
+user_identifier_list_push : user_identifier_push=0A=
+			| identifier_list_push user_identifier_push=0A=
+			| user_identifier_list_push identifier_push=0A=
+			| user_identifier_list_push user_identifier_push=0A=
+			;=0A=
+user_names_push		: names_push=0A=
+			| user_identifier_push=0A=
+			| '{' user_identifier_list_push '}'=0A=
+			| tilde_push user_identifier_push=0A=
+			| tilde_push '{' user_identifier_list_push '}'=0A=
+			;=0A=
 path     		: PATH=0A=
 			{ if (insert_id(yytext,0)) return -1; }=0A=
 			;=0A=
diff -ruN checkpolicy/policy_scan.l checkpolicy.new/policy_scan.l=0A=
--- checkpolicy/policy_scan.l	Thu Sep 26 14:39:14 2002=0A=
+++ checkpolicy.new/policy_scan.l	Thu Sep 26 14:19:29 2002=0A=
@@ -132,6 +132,7 @@=0A=
 T2				{ return(T2); }=0A=
 "/"({letter}|{digit}|_|"."|"-"|"/")*	{ return(PATH); }=0A=
 {letter}({letter}|{digit}|_)*	{ return(IDENTIFIER); }=0A=
+{letter}({letter}|{digit}|_|"."|"-")*	{ return(USER_IDENTIFIER); }=0A=
 {digit}{digit}*                 { return(NUMBER); }=0A=
 #[^\n]*                         { /* delete comments */ }=0A=
 [ \t\f]+			{ /* delete whitespace */ }=0A=

------=_NextPart_000_006C_01C2656D.1E6CE990--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
