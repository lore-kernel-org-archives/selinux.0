Subject: [PATCH] module.c, leak and double free
From: Joshua Brindle <jbrindle@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-1//x174VkONRWGfYbo2S"
Date: Thu, 22 Sep 2005 16:53:31 -0400
Message-Id: <1127422411.21806.43.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-1//x174VkONRWGfYbo2S
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch fixes 2 memory leaks and removes a double free if the
policy_read fails on a module.


Joshua Brindle

--=-1//x174VkONRWGfYbo2S
Content-Disposition: attachment; filename=9-sepol-module-leaks.patch
Content-Type: text/x-patch; name=9-sepol-module-leaks.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- libsepol/src/module.c	2005-09-22 09:41:17.000000000 -0400
+++ libsepol/src/module.c	2005-09-21 11:27:28.000000000 -0400
@@ -42,6 +42,7 @@ void sepol_module_package_destroy(sepol_
                 return;
         }
         policydb_destroy(p->policy);
+        free(p->policy);
         free(p->file_contexts);
         free(p);
 }
@@ -142,6 +143,7 @@ static int read_helper(char *buf, struct
 int sepol_module_package_read(sepol_module_package_t *mod, struct policy_file *file, int verbose)
 {
 	uint32_t *buf;
+        int retval;
 	
 	buf = next_entry(file, sizeof(uint32_t) * 2);
 	if (!buf)
@@ -156,11 +158,20 @@ int sepol_module_package_read(sepol_modu
 		if (!mod->file_contexts) {
 			return -1;	
 		}
-		if (read_helper(mod->file_contexts, file, mod->file_contexts_len))
+		if (read_helper(mod->file_contexts, file, mod->file_contexts_len)) {
+                        free(mod->file_contexts);
+                        mod->file_contexts = NULL;
 			return -1;
+                }
 	}
-	
-	return policydb_read(mod->policy, file, verbose);	
+
+	retval = policydb_read(mod->policy, file, verbose);
+        if (retval < 0) {
+                /* don't destroy the policy -- policydb did that already */
+                free(mod->policy);
+                mod->policy = NULL;
+        }
+        return retval;
 }
 
 int sepol_module_package_info(struct policy_file *file, int *type, char **name, char **version)
@@ -181,8 +192,10 @@ int sepol_module_package_info(struct pol
 		if (!buf2) {
 			return -1;	
 		}
-		if (read_helper((char*)buf2, file, len))
+		if (read_helper((char*)buf2, file, len)) {
+                        free(buf2);
 			return -1;
+                }
 		free(buf2);
 	}
 	

--=-1//x174VkONRWGfYbo2S--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
