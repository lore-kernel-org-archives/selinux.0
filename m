Subject: [PATCH] checkpolicy - no module version
From: Joshua Brindle <jbrindle@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-gtgjZJX52FdjWSpMmJw7"
Date: Tue, 04 Oct 2005 10:30:02 -0400
Message-Id: <1128436202.28919.0.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-gtgjZJX52FdjWSpMmJw7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch corrects an old behavior where module versions could be NULL,
this is no longer allowed per the grammar and therefore an error
condition.



--=-gtgjZJX52FdjWSpMmJw7
Content-Disposition: attachment; filename=1-checkpolicy-no-mod-ver.diff
Content-Type: text/x-patch; name=1-checkpolicy-no-mod-ver.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -pur -x .svn checkpolicy/module_compiler.c checkpolicy/module_compiler.c
--- checkpolicy/module_compiler.c	2005-09-29 09:10:43.000000000 -0400
+++ checkpolicy/module_compiler.c	2005-09-29 09:11:31.000000000 -0400
@@ -70,10 +70,8 @@ int define_policy(int pass, int module_h
                         }
                         policydbp->name = id;
                         if ((policydbp->version = queue_remove(id_queue)) == NULL) {
-                                if ((policydbp->version = strdup("")) == NULL) {
-                                        yyerror("Out of memory!");
-                                        return -1;
-                                }
+                                yyerror("Expected a module version but none was found.");
+                                return -1;
                         }
                 }
                 /* the first declaration within the global avrule

--=-gtgjZJX52FdjWSpMmJw7--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
