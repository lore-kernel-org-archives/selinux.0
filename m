Subject: [PATCH] permission value inconsistency
From: Joshua Brindle <jbrindle@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-1SPQjHJvhrorIEEpCwdA"
Date: Tue, 04 Oct 2005 10:31:01 -0400
Message-Id: <1128436261.28919.6.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-1SPQjHJvhrorIEEpCwdA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

These patches fix permission and common permission values being
incremented before they were successfully added. This may cause an
inconsistency in the policy in the error case.


--=-1SPQjHJvhrorIEEpCwdA
Content-Disposition: attachment; filename=4-checkpolicy-perm-value.diff
Content-Type: text/x-patch; name=4-checkpolicy-perm-value.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -pur -x .svn checkpolicy/module_compiler.c checkpolicy/module_compiler.c
--- checkpolicy/module_compiler.c	2005-09-29 09:10:43.000000000 -0400
+++ checkpolicy/module_compiler.c	2005-09-29 09:11:31.000000000 -0400
@@ -639,7 +638,7 @@ int require_class(int pass)
                         break;
                 }
                 case HASHTAB_SUCCESS: {
-                        perm->value = ++datum->permissions.nprim;
+                        perm->value = datum->permissions.nprim + 1;
                         break;
                 }
                 default: {
@@ -655,6 +654,9 @@ int require_class(int pass)
                         free(perm);
                         goto cleanup;
                 }
+                if (ret2 == HASHTAB_SUCCESS) {
+                        datum->permissions.nprim++;
+                }
         }
         return 0;
  cleanup:

--=-1SPQjHJvhrorIEEpCwdA
Content-Disposition: attachment; filename=5-checkpolicy-common-perm-value.diff
Content-Type: text/x-patch; name=5-checkpolicy-common-perm-value.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -pur -x .svn checkpolicy/policy_parse.y checkpolicy/policy_parse.y
--- checkpolicy/policy_parse.y	2005-09-26 17:27:11.000000000 -0400
+++ checkpolicy/policy_parse.y	2005-10-03 09:25:06.000000000 -0400
@@ -1127,11 +1127,12 @@ static int define_common_perms(void)
 		yyerror("hash table overflow");
 		goto bad;
 	}
-        comdatum->value = ++policydbp->p_commons.nprim;
+        comdatum->value = policydbp->p_commons.nprim + 1;
 	if (symtab_init(&comdatum->permissions, PERM_SYMTAB_SIZE)) {
 		yyerror("out of memory");
 		goto bad;
 	}
+        policydbp->p_commons.nprim++;
 	while ((perm = queue_remove(id_queue))) {
 		perdatum = (perm_datum_t *) malloc(sizeof(perm_datum_t));
 		if (!perdatum) {
@@ -1139,7 +1140,7 @@ static int define_common_perms(void)
 			goto bad_perm;
 		}
 		memset(perdatum, 0, sizeof(perm_datum_t));
-		perdatum->value = ++comdatum->permissions.nprim;
+		perdatum->value = comdatum->permissions.nprim + 1;
 
 		if (perdatum->value > (sizeof(sepol_access_vector_t) * 8)) {
 			yyerror("too many permissions to fit in an access vector");
@@ -1159,6 +1160,7 @@ static int define_common_perms(void)
 			yyerror("hash table overflow");
 			goto bad_perm;
 		}
+                comdatum->permissions.nprim++;
 	}
 
 	return 0;

--=-1SPQjHJvhrorIEEpCwdA--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
