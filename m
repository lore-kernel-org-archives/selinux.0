Subject: [PATCH] stack overflow in module parser
From: Joshua Brindle <jbrindle@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-5kF9Xgo9e4fnTS82kljS"
Date: Wed, 19 Oct 2005 13:50:22 -0400
Message-Id: <1129744223.15338.10.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-5kF9Xgo9e4fnTS82kljS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch fixes the recursion in avrule declarations and require
declarations which cause a stack overflow in the parser with very large
modules.

--=-5kF9Xgo9e4fnTS82kljS
Content-Disposition: attachment; filename=1-parser-overflow.diff
Content-Type: text/x-patch; name=1-parser-overflow.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -purN -x .svn checkpolicy/policy_parse.y checkpolicy/policy_parse.y
--- checkpolicy/policy_parse.y	2005-10-18 11:05:12.000000000 -0400
+++ checkpolicy/policy_parse.y	2005-10-19 09:11:15.000000000 -0400
@@ -803,7 +803,7 @@ version_identifier      : VERSION_IDENTI
                         ;
 avrules_block           : avrule_decls avrule_user_defs
                         ;
-avrule_decls            : avrule_decl avrule_decls
+avrule_decls            : avrule_decls avrule_decl
                         | avrule_decl
                         ;
 avrule_decl             : rbac_decl
@@ -815,7 +815,7 @@ avrule_decl             : rbac_decl
                         ;
 require_block           : REQUIRE '{' require_list '}'
                         ;
-require_list            : require_decl require_list
+require_list            : require_list require_decl
                         | require_decl
                         ;
 require_decl            : require_class ';'

--=-5kF9Xgo9e4fnTS82kljS--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
