Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j75GiPOb001571
	for <selinux@tycho.nsa.gov>; Fri, 5 Aug 2005 12:44:25 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j75GaMrI005624
	for <selinux@tycho.nsa.gov>; Fri, 5 Aug 2005 16:36:22 GMT
Subject: patch: disallow policy from declaring the type 'self'
From: Jason Tang <jtang@tresys.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Fri, 05 Aug 2005 12:37:17 -0400
Message-Id: <1123259837.26243.25.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Recently we noticed that one may declare a type named "self".  The
following patch disallows the policy from doing this.
checkpolicy/checkmodule will treat "self" as a reserved word.

NOTE: This patch in no way affects the use of "self" as the target
within AV rules.


--- module_compiler.c	2005-07-06 13:46:23.000000000 -0400
+++ module_compiler.c-new	2005-08-05 11:47:12.000000000 -0400
@@ -262,6 +262,10 @@ type_datum_t *declare_type(unsigned char
                 yyerror("no type/attribute name?");
 		return NULL;
 	}
+        if (strcmp(id, "self") == 0) {
+                yyerror("'self' is a reserved type name and may not be
declared.");
+                return NULL;
+        }
 
 	typdatum = (type_datum_t *) malloc(sizeof(type_datum_t));
 	if (!typdatum) {


-- 
Jason Tang / jtang@tresys.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
