Date: Tue, 6 Feb 2007 11:31:20 -0500
From: Caleb Case <ccase@tresys.com>
Message-Id: <200702061631.l16GVKav018375@localhost.localdomain>
To: ccase@tresys.com, sds@tycho.nsa.gov, kmacmillan@mentalrootkit.com,
        jbrindle@tresys.com, selinux@tycho.nsa.gov
Subject: checkpolicy/policy_parse.y:define_class: allow class identifiers to contain dots
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Class identifiers are now allowed to contain dots.  This facilitates the new dot notation for class names used in metapolicy.
---
 checkpolicy/policy_parse.y |    5 -----
 1 file changed, 5 deletions(-)

Index: selinux-pms-support/checkpolicy/policy_parse.y
===================================================================
--- selinux-pms-support.orig/checkpolicy/policy_parse.y
+++ selinux-pms-support/checkpolicy/policy_parse.y
@@ -929,11 +929,6 @@ static int define_class(void)
 		yyerror("no class name for class definition?");
 		return -1;
 	}
-	if (id_has_dot(id)) {
-		free(id);
-		yyerror("class identifiers may not contain periods");
-		return -1;
-	}
 	datum = (class_datum_t *) malloc(sizeof(class_datum_t));
 	if (!datum) {
 		yyerror("out of memory");

-- 
Caleb Case
Tresys Technology
410.290.1411 x144


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
