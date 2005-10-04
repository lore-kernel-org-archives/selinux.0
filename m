Subject: [PATCH] checkpolicy - misleading error
From: Joshua Brindle <jbrindle@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-+Ccz7nAaPjThlDdNx4s+"
Date: Tue, 04 Oct 2005 10:30:35 -0400
Message-Id: <1128436235.28919.4.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-+Ccz7nAaPjThlDdNx4s+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This fixes a misleading error when a type or attribute could not be
declared but the error only said attribute.

--=-+Ccz7nAaPjThlDdNx4s+
Content-Disposition: attachment; filename=3-checkpolicy-misleading-type-error.diff
Content-Type: text/x-patch; name=3-checkpolicy-misleading-type-error.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -pur -x .svn checkpolicy/module_compiler.c checkpolicy/module_compiler.c
--- checkpolicy/module_compiler.c	2005-09-29 09:10:43.000000000 -0400
+++ checkpolicy/module_compiler.c	2005-09-29 09:11:31.000000000 -0400
@@ -308,7 +307,7 @@ type_datum_t *declare_type(unsigned char
                 return NULL;
         }
         case -1: {
-                yyerror("could not declare attribute here");
+                yyerror("could not declare type/attribute here");
                 return NULL;
         }
         case 0:

--=-+Ccz7nAaPjThlDdNx4s+--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
