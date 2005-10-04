Subject: [PATCH] checkpolicy - self leak
From: Joshua Brindle <jbrindle@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-vZnIjT28E4xYmre7liMC"
Date: Tue, 04 Oct 2005 10:30:22 -0400
Message-Id: <1128436222.28919.2.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-vZnIjT28E4xYmre7liMC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

These patches fix leaks when self is the identifier, both when declared
(in an error condition) and when used in an avrule.



--=-vZnIjT28E4xYmre7liMC
Content-Disposition: attachment; filename=2-checkpolicy-self-leak.diff
Content-Type: text/x-patch; name=2-checkpolicy-self-leak.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -pur -x .svn checkpolicy/module_compiler.c checkpolicy/module_compiler.c
--- checkpolicy/module_compiler.c	2005-09-29 09:10:43.000000000 -0400
+++ checkpolicy/module_compiler.c	2005-09-29 09:11:31.000000000 -0400
@@ -264,6 +262,7 @@ type_datum_t *declare_type(unsigned char
 	}
         if (strcmp(id, "self") == 0) {
                 yyerror("'self' is a reserved type name and may not be declared.");
+                free(id);
                 return NULL;
         }
 

--=-vZnIjT28E4xYmre7liMC
Content-Disposition: attachment; filename=6-checkpolicy-self-leak.diff
Content-Type: text/x-patch; name=6-checkpolicy-self-leak.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -pur -x .svn checkpolicy/policy_parse.y checkpolicy/policy_parse.y
--- checkpolicy/policy_parse.y	2005-09-26 17:27:11.000000000 -0400
+++ checkpolicy/policy_parse.y	2005-10-03 09:25:06.000000000 -0400
@@ -2253,6 +2255,7 @@ static int define_te_avtab_helper(int wh
         add = 1;
 	while ((id = queue_remove(id_queue))) {
 		if (strcmp(id, "self") == 0) {
+			free(id);
 			avrule->flags |= RULE_SELF;
 			continue;
 		}

--=-vZnIjT28E4xYmre7liMC--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
