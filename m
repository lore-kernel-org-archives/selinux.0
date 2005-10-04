Subject: [PATCH] checkpolicy - constraint destroy
From: Joshua Brindle <jbrindle@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-m5IRt+4lilP271EtR0K9"
Date: Tue, 04 Oct 2005 10:32:08 -0400
Message-Id: <1128436328.28919.9.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-m5IRt+4lilP271EtR0K9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On the constraint error path the constraint list cleanup was destroying
the wrong node. 

--=-m5IRt+4lilP271EtR0K9
Content-Disposition: attachment; filename=7-checkpolicy-constraint-destroy.diff
Content-Type: text/x-patch; name=7-checkpolicy-constraint-destroy.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -pur -x .svn checkpolicy/policy_parse.y checkpolicy/policy_parse.y
--- checkpolicy/policy_parse.y	2005-09-26 17:27:11.000000000 -0400
+++ checkpolicy/policy_parse.y	2005-10-03 09:25:06.000000000 -0400
@@ -2861,7 +2864,7 @@ oom:
 	while (e) {
 		l = e;
 		e = e->next;
-		constraint_expr_destroy(e);
+		constraint_expr_destroy(l);
 	}
 	return NULL;
 }

--=-m5IRt+4lilP271EtR0K9--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
