Message-ID: <43DA88D1.5000408@tresys.com>
Date: Fri, 27 Jan 2006 15:55:45 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libsepol - cond_expr mapping and package num_sections bugs
Content-Type: multipart/mixed;
 boundary="------------010307090305030308060108"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010307090305030308060108
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes a bug where a boolean expression node which was an
operation was trying to map the boolean value to the base policy during
linking and getting an index from the previous map ( 0 - 1). The
solution is to not map the boolean value if the expr_type is not COND_BOOL.

It also fixes a bug where a base module getting written after being read
(during linking) would end up with a num_sections of 4 since
num_sections was initialized during the read and then incremented during
write. The solution is to move the num_sections incrementing to the
functions where the sections are actually set, so that it is already
correct when entering package_write.

Joshua Brindle



--------------010307090305030308060108
Content-Type: text/x-patch;
 name="1-condexpr-mapping.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="1-condexpr-mapping.diff"

diff -x.svn -pruN libsepol/src/link.c libsepol/src/link.c
--- libsepol/src/link.c	2006-01-06 10:02:02.000000000 -0500
+++ libsepol/src/link.c	2006-01-27 15:09:18.000000000 -0500
@@ -1010,6 +1010,9 @@ static int copy_cond_list(cond_node_t *l
                         goto cleanup;
                 /* go back through and remap the expression */
                 for (cur_expr = new_node->expr; cur_expr != NULL; cur_expr = cur_expr->next) {
+			/* expression nodes don't have a bool value of 0 - don't map them */
+			if (cur_expr->expr_type != COND_BOOL)
+				continue;
                         assert(module->map[SYM_BOOLS][cur_expr->bool - 1] != 0);
                         cur_expr->bool = module->map[SYM_BOOLS][cur_expr->bool - 1];
                 }
diff -x.svn -pruN libsepol/src/module.c libsepol/src/module.c
--- libsepol/src/module.c	2006-01-26 14:51:34.000000000 -0500
+++ libsepol/src/module.c	2006-01-27 15:09:18.000000000 -0500
@@ -78,7 +78,7 @@ static int module_package_init(sepol_mod
 	if (sepol_policydb_create(&p->policy))
 		return -1;
 
-	p->num_sections = 0;
+	p->num_sections = 1;
 	p->version = 1;
 	return 0;
 }
@@ -131,6 +131,7 @@ int sepol_module_package_set_file_contex
 		memcpy(p->file_contexts, data, len);
 	}
 	p->file_contexts_len = len;
+	p->num_sections++;
 	return 0;
 }
  
@@ -536,9 +537,7 @@ int sepol_module_package_write(sepol_mod
 		if (policydb_write(&p->policy->p, &polfile))
 			return -1;
 		len = polfile.len;
-		if (polfile.len)
-			p->num_sections++;
-		else 
+		if (!polfile.len)
 			return -1;
 		
 	} else {
@@ -546,9 +545,6 @@ int sepol_module_package_write(sepol_mod
 		return -1;
 	}
 
-	if (p->file_contexts)
-		p->num_sections++;
-
 	buf[0] = cpu_to_le32(SEPOL_MODULE_PACKAGE_MAGIC);
 	buf[1] = cpu_to_le32(p->version);
 	buf[2] = cpu_to_le32(p->num_sections);


--------------010307090305030308060108--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
