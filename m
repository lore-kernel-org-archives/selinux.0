Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k71IgBmL000868
	for <selinux@tycho.nsa.gov>; Tue, 1 Aug 2006 14:42:11 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k71Ig2XQ011216
	for <selinux@tycho.nsa.gov>; Tue, 1 Aug 2006 18:42:02 GMT
Subject: [PATCH 2/6] netfilter integration take 2: add netfilter contexts
	package section
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Tue, 01 Aug 2006 14:43:08 -0400
Message-Id: <1154457788.31522.148.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add a section to the package for netfilter contexts.

 libsepol/include/sepol/module.h          |   10 ++
 libsepol/include/sepol/policydb/module.h |    2
 libsepol/src/module.c                    |  119 +++++++++++++++++++++++++++++++
 3 files changed, 131 insertions(+)

diff --exclude .svn -purN trunk/libsepol/include/sepol/module.h netfilter-integration/libsepol/include/sepol/module.h
--- trunk/libsepol/include/sepol/module.h	2006-07-03 10:42:01.031370000 -0400
+++ netfilter-integration/libsepol/include/sepol/module.h	2006-07-14 11:15:32.923435000 -0400
@@ -40,6 +40,16 @@ extern size_t sepol_module_package_get_u
 extern int sepol_module_package_set_user_extra(sepol_module_package_t * p,
 					       char *data, size_t len);
 
+extern char *sepol_module_package_get_netfilter_contexts(sepol_module_package_t
+							 * p);
+
+extern size_t
+sepol_module_package_get_netfilter_contexts_len(sepol_module_package_t * p);
+
+extern int sepol_module_package_set_netfilter_contexts(sepol_module_package_t *
+						       p, char *data,
+						       size_t len);
+
 extern sepol_policydb_t *sepol_module_package_get_policy(sepol_module_package_t
 							 * p);
 
diff --exclude .svn -purN trunk/libsepol/include/sepol/policydb/module.h netfilter-integration/libsepol/include/sepol/policydb/module.h
--- trunk/libsepol/include/sepol/policydb/module.h	2006-07-03 10:42:01.031370000 -0400
+++ netfilter-integration/libsepol/include/sepol/policydb/module.h	2006-07-14 11:15:32.871431750 -0400
@@ -39,6 +39,8 @@ struct sepol_module_package {
 	size_t seusers_len;
 	char *user_extra;
 	size_t user_extra_len;
+	char *netfilter_contexts;
+	size_t netfilter_contexts_len;
 };
 
 extern int sepol_module_package_init(sepol_module_package_t * p);
diff --exclude .svn -purN trunk/libsepol/src/module.c netfilter-integration/libsepol/src/module.c
--- trunk/libsepol/src/module.c	2006-07-03 10:42:01.031370000 -0400
+++ netfilter-integration/libsepol/src/module.c	2006-07-14 11:15:36.375650750 -0400
@@ -1,5 +1,6 @@
 /* Author: Karl MacMillan <kmacmillan@tresys.com>
  *         Jason Tang     <jtang@tresys.com>
+ *         Chris PeBenito <cpebenito@tresys.com>
  *
  * Copyright (C) 2004-2005 Tresys Technology, LLC
  *
@@ -33,6 +34,7 @@
 #define SEPOL_PACKAGE_SECTION_FC 0xf97cff90
 #define SEPOL_PACKAGE_SECTION_SEUSER 0x97cff91
 #define SEPOL_PACKAGE_SECTION_USER_EXTRA 0x97cff92
+#define SEPOL_PACKAGE_SECTION_NETFILTER 0x97cff93
 
 static int policy_file_seek(struct policy_file *fp, size_t offset)
 {
@@ -121,6 +123,7 @@ void sepol_module_package_free(sepol_mod
 	free(p->file_contexts);
 	free(p->seusers);
 	free(p->user_extra);
+	free(p->netfilter_contexts);
 	free(p);
 }
 
@@ -156,6 +159,17 @@ size_t sepol_module_package_get_user_ext
 	return p->user_extra_len;
 }
 
+char *sepol_module_package_get_netfilter_contexts(sepol_module_package_t * p)
+{
+	return p->netfilter_contexts;
+}
+
+size_t sepol_module_package_get_netfilter_contexts_len(sepol_module_package_t *
+						       p)
+{
+	return p->netfilter_contexts_len;
+}
+
 int sepol_module_package_set_file_contexts(sepol_module_package_t * p,
 					   char *data, size_t len)
 {
@@ -186,6 +200,16 @@ int sepol_module_package_set_user_extra(
 	return 0;
 }
 
+int sepol_module_package_set_netfilter_contexts(sepol_module_package_t * p,
+						char *data, size_t len)
+{
+	if (set_char(&p->netfilter_contexts, data, len))
+		return -1;
+
+	p->netfilter_contexts_len = len;
+	return 0;
+}
+
 sepol_policydb_t *sepol_module_package_get_policy(sepol_module_package_t * p)
 {
 	return p->policy;
@@ -223,6 +247,40 @@ static int link_file_contexts(sepol_modu
 	return 0;
 }
 
+/* Append each of the netfilter contexts from each module to the base
+ * policy's netfilter context.  'base_context' will be reallocated to a
+ * larger size (and thus it is an in/out reference
+ * variable). 'base_nc_len' is the length of base's netfilter contexts; it
+ * too is a reference variable.  Return 0 on success, -1 if out of
+ * memory. */
+static int link_netfilter_contexts(sepol_module_package_t * base,
+				   sepol_module_package_t ** modules,
+				   int num_modules)
+{
+	size_t base_nc_len;
+	int i;
+	char *base_context;
+
+	base_nc_len = base->netfilter_contexts_len;
+	for (i = 0; i < num_modules; i++) {
+		base_nc_len += modules[i]->netfilter_contexts_len;
+	}
+
+	if ((base_context =
+	     (char *)realloc(base->netfilter_contexts, base_nc_len)) == NULL) {
+		return -1;
+	}
+	base->netfilter_contexts = base_context;
+	for (i = 0; i < num_modules; i++) {
+		memcpy(base->netfilter_contexts + base->netfilter_contexts_len,
+		       modules[i]->netfilter_contexts,
+		       modules[i]->netfilter_contexts_len);
+		base->netfilter_contexts_len +=
+		    modules[i]->netfilter_contexts_len;
+	}
+	return 0;
+}
+
 /* Links the module packages into the base.  Returns 0 on success, -1
  * if a requirement was not met, or -2 for all other errors. */
 int sepol_link_packages(sepol_handle_t * handle,
@@ -254,6 +312,12 @@ int sepol_link_packages(sepol_handle_t *
 		ERR(handle, "Out of memory!");
 		return -2;
 	}
+
+	if (link_netfilter_contexts(base, modules, num_modules) == -1) {
+		ERR(handle, "Out of memory!");
+		return -2;
+	}
+
 	return 0;
 }
 
@@ -345,6 +409,7 @@ static int module_package_read_offsets(s
 #define SEEN_FC  2
 #define SEEN_SEUSER 4
 #define SEEN_USER_EXTRA 8
+#define SEEN_NETFILTER 16
 
 int sepol_module_package_read(sepol_module_package_t * mod,
 			      struct sepol_policy_file *spf, int verbose)
@@ -461,6 +526,33 @@ int sepol_module_package_read(sepol_modu
 			}
 			seen |= SEEN_USER_EXTRA;
 			break;
+		case SEPOL_PACKAGE_SECTION_NETFILTER:
+			if (seen & SEEN_NETFILTER) {
+				ERR(file->handle,
+				    "found multiple netfilter contexts sections in module package (at section %u)",
+				    i);
+				goto cleanup;
+			}
+
+			mod->netfilter_contexts_len = len - sizeof(uint32_t);
+			mod->netfilter_contexts =
+			    (char *)malloc(mod->netfilter_contexts_len);
+			if (!mod->netfilter_contexts) {
+				ERR(file->handle, "out of memory");
+				goto cleanup;
+			}
+			if (read_helper
+			    (mod->netfilter_contexts, file,
+			     mod->netfilter_contexts_len)) {
+				ERR(file->handle,
+				    "invalid netfilter contexts section at section %u",
+				    i);
+				free(mod->netfilter_contexts);
+				mod->netfilter_contexts = NULL;
+				goto cleanup;
+			}
+			seen |= SEEN_NETFILTER;
+			break;
 		case POLICYDB_MOD_MAGIC:
 			if (seen & SEEN_MOD) {
 				ERR(file->handle,
@@ -577,6 +669,16 @@ int sepol_module_package_info(struct sep
 			}
 			seen |= SEEN_USER_EXTRA;
 			break;
+		case SEPOL_PACKAGE_SECTION_NETFILTER:
+			/* skip netfilter contexts */
+			if (seen & SEEN_NETFILTER) {
+				ERR(file->handle,
+				    "found multiple netfilter contexts sections in module package (at section %u)",
+				    i);
+				goto cleanup;
+			}
+			seen |= SEEN_NETFILTER;
+			break;
 		case POLICYDB_MOD_MAGIC:
 			if (seen & SEEN_MOD) {
 				ERR(file->handle,
@@ -754,6 +856,9 @@ int sepol_module_package_write(sepol_mod
 	if (p->user_extra)
 		nsec++;
 
+	if (p->netfilter_contexts)
+		nsec++;
+
 	buf[0] = cpu_to_le32(SEPOL_MODULE_PACKAGE_MAGIC);
 	buf[1] = cpu_to_le32(p->version);
 	buf[2] = cpu_to_le32(nsec);
@@ -784,6 +889,12 @@ int sepol_module_package_write(sepol_mod
 		len = p->user_extra_len + sizeof(uint32_t);
 		i++;
 	}
+	if (p->netfilter_contexts) {
+		offsets[i] = offsets[i - 1] + len;
+		buf[i] = cpu_to_le32(offsets[i]);
+		len = p->netfilter_contexts_len + sizeof(uint32_t);
+		i++;
+	}
 	if (put_entry(buf, sizeof(uint32_t), nsec, file) != nsec)
 		return -1;
 
@@ -814,6 +925,14 @@ int sepol_module_package_write(sepol_mod
 		if (write_helper(p->user_extra, p->user_extra_len, file))
 			return -1;
 	}
+	if (p->netfilter_contexts) {
+		buf[0] = cpu_to_le32(SEPOL_PACKAGE_SECTION_NETFILTER);
+		if (put_entry(buf, sizeof(uint32_t), 1, file) != 1)
+			return -1;
+		if (write_helper
+		    (p->netfilter_contexts, p->netfilter_contexts_len, file))
+			return -1;
+	}
 	return 0;
 }



-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
