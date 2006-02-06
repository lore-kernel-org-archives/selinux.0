Message-ID: <43E7D03D.4090909@tresys.com>
Date: Mon, 06 Feb 2006 17:39:57 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] Add seuser and user_extra to package format
Content-Type: multipart/mixed;
 boundary="------------070302060102030803070804"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070302060102030803070804
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds seuser and user_extra to the package format, adds
arguments to semodule_package and libsemanage code to write the files to
the store.



--------------070302060102030803070804
Content-Type: text/x-patch;
 name="1-seuser-userextra-in-package.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="1-seuser-userextra-in-package.diff"

diff -x.svn -pruN libsemanage/src/direct_api.c libsemanage/src/direct_api.c
--- libsemanage/src/direct_api.c	2006-01-30 20:59:55.000000000 -0500
+++ libsemanage/src/direct_api.c	2006-02-06 16:26:09.000000000 -0500
@@ -406,7 +406,7 @@ static int semanage_write_module(semanag
  */
 static int semanage_direct_commit(semanage_handle_t *sh) {
 	char **mod_filenames = NULL;
-	const char *linked_filename = NULL, *fc_filename = NULL;
+	const char *linked_filename = NULL, *ofilename = NULL;
 	sepol_module_package_t *base = NULL;
 	int retval = -1, num_modfiles = 0, i;
 	sepol_policydb_t* out = NULL;
@@ -476,8 +476,8 @@ static int semanage_direct_commit(semana
 		/* ==================== File contexts ================== */
 
 		/* write the linked file contexts template */
-		if ((fc_filename = semanage_path(SEMANAGE_TMP, SEMANAGE_FC_TMPL)) == NULL ||
-		    write_file(sh, fc_filename, sepol_module_package_get_file_contexts(base), 
+		if ((ofilename = semanage_path(SEMANAGE_TMP, SEMANAGE_FC_TMPL)) == NULL ||
+		    write_file(sh, ofilename, sepol_module_package_get_file_contexts(base), 
 				sepol_module_package_get_file_contexts_len(base)) == -1) {
 			goto cleanup;
 		}
@@ -488,6 +488,22 @@ static int semanage_direct_commit(semana
 		pfcontexts->dtable->drop_cache(pfcontexts->dbase);
 
 		/* ==================== Other file-backed ================== */
+	
+		if (sepol_module_package_get_seusers_len(base)) {
+			if ((ofilename = semanage_path(SEMANAGE_TMP, SEMANAGE_SEUSERS_SYSTEM)) == NULL ||
+			    write_file(sh, ofilename, sepol_module_package_get_seusers(base), 
+					sepol_module_package_get_seusers_len(base)) == -1) {
+				goto cleanup;
+			}
+		}
+
+		if (sepol_module_package_get_user_extra_len(base)) {
+			if ((ofilename = semanage_path(SEMANAGE_TMP, SEMANAGE_USER_EXTRA_SYSTEM)) == NULL ||
+			    write_file(sh, ofilename, sepol_module_package_get_user_extra(base), 
+					sepol_module_package_get_user_extra_len(base)) == -1) {
+				goto cleanup;
+			}
+		}
 
 		/* Clear any cache, will be regenerated */
 		if (pusers_extra->dtable->clear(sh, pusers_extra->dbase) < 0)
diff -x.svn -pruN libsemanage/src/semanage_store.c libsemanage/src/semanage_store.c
--- libsemanage/src/semanage_store.c	2006-01-30 21:01:38.000000000 -0500
+++ libsemanage/src/semanage_store.c	2006-02-06 16:26:09.000000000 -0500
@@ -96,7 +96,9 @@ static const char *semanage_sandbox_path
 	"/homedir_template",
 	"/file_contexts.template",
 	"/commit_num",
-	"/seusers.final"
+	"/seusers.final",
+	"/seusers.system",
+	"/users_extra.system"
 };
 
 /* Initialize the paths to config file, lock files and store root.
diff -x.svn -pruN libsemanage/src/semanage_store.h libsemanage/src/semanage_store.h
--- libsemanage/src/semanage_store.h	2006-01-27 14:50:54.000000000 -0500
+++ libsemanage/src/semanage_store.h	2006-02-06 16:26:09.000000000 -0500
@@ -46,6 +46,8 @@ enum semanage_sandbox_defs {
 	SEMANAGE_FC_TMPL,
 	SEMANAGE_COMMIT_NUM_FILE,
 	SEMANAGE_SEUSERS,
+	SEMANAGE_SEUSERS_SYSTEM,
+	SEMANAGE_USER_EXTRA_SYSTEM,
 	SEMANAGE_STORE_NUM_PATHS
 };
 
diff -x.svn -pruN libsepol/include/sepol/module.h libsepol/include/sepol/module.h
--- libsepol/include/sepol/module.h	2006-01-06 10:01:44.000000000 -0500
+++ libsepol/include/sepol/module.h	2006-02-06 16:26:09.000000000 -0500
@@ -25,6 +25,23 @@ extern int sepol_module_package_set_file
 						   char *data,
 						   size_t len);
 
+extern char *sepol_module_package_get_seusers(sepol_module_package_t *p);
+
+extern size_t sepol_module_package_get_seusers_len(sepol_module_package_t *p);
+
+extern int sepol_module_package_set_seusers(sepol_module_package_t *p, 
+						   char *data,
+						   size_t len);
+
+extern char *sepol_module_package_get_user_extra(sepol_module_package_t *p);
+
+extern size_t sepol_module_package_get_user_extra_len(sepol_module_package_t *p);
+
+extern int sepol_module_package_set_user_extra(sepol_module_package_t *p, 
+						   char *data,
+						   size_t len);
+
+
 extern sepol_policydb_t *sepol_module_package_get_policy(sepol_module_package_t *p);
 
 extern int sepol_link_packages(sepol_handle_t *handle,
diff -x.svn -pruN libsepol/include/sepol/policydb/module.h libsepol/include/sepol/policydb/module.h
--- libsepol/include/sepol/policydb/module.h	2006-01-30 21:02:39.000000000 -0500
+++ libsepol/include/sepol/policydb/module.h	2006-02-06 16:26:09.000000000 -0500
@@ -35,6 +35,10 @@ struct sepol_module_package {
 	uint32_t	 version;
 	char 		 *file_contexts;
 	size_t	         file_contexts_len;
+	char		 *seusers;
+	size_t		 seusers_len;
+	char		 *user_extra;
+	size_t		 user_extra_len;
 };
 
 extern int sepol_module_package_init(sepol_module_package_t *p);
diff -x.svn -pruN libsepol/src/module.c libsepol/src/module.c
--- libsepol/src/module.c	2006-01-30 21:03:09.000000000 -0500
+++ libsepol/src/module.c	2006-02-06 17:19:37.000000000 -0500
@@ -31,6 +31,8 @@
 #include <limits.h>
 
 #define SEPOL_PACKAGE_SECTION_FC 0xf97cff90
+#define SEPOL_PACKAGE_SECTION_SEUSER 0x97cff91
+#define SEPOL_PACKAGE_SECTION_USER_EXTRA 0x97cff92
 
 static int policy_file_seek(struct policy_file *fp, size_t offset) 
 {
@@ -82,6 +84,21 @@ static int module_package_init(sepol_mod
 	return 0;
 }
 
+static int set_char(char **field, char *data, size_t len) {
+	if (*field) {
+		free(*field);
+		*field = NULL;
+	}
+	if (len) {
+		*field = malloc(len);
+		if (!*field)
+			return -1;
+		memcpy(*field, data, len);
+	}
+	return 0;
+}
+
+
 int sepol_module_package_create(sepol_module_package_t **p)
 {
 	*p = calloc(1, sizeof(sepol_module_package_t));
@@ -109,29 +126,64 @@ char *sepol_module_package_get_file_cont
 	return p->file_contexts;
 }
 
-
 size_t sepol_module_package_get_file_contexts_len(sepol_module_package_t *p)
 {
 	return p->file_contexts_len;
 }
 
+char *sepol_module_package_get_seusers(sepol_module_package_t *p)
+{
+	return p->seusers;
+}
+
+size_t sepol_module_package_get_seusers_len(sepol_module_package_t *p)
+{
+	return p->seusers_len;
+}
+
+char *sepol_module_package_get_user_extra(sepol_module_package_t *p)
+{
+	return p->user_extra;
+}
+
+size_t sepol_module_package_get_user_extra_len(sepol_module_package_t *p)
+{
+	return p->user_extra_len;
+}
+
+
 int sepol_module_package_set_file_contexts(sepol_module_package_t *p, 
 					   char *data,
 					   size_t len)
 {
-	if (p->file_contexts) {
-		free(p->file_contexts);
-		p->file_contexts = NULL;
-	}
-	if (len) {
-		p->file_contexts = malloc(len);
-		if (!p->file_contexts)
-			return -1;
-		memcpy(p->file_contexts, data, len);
-	}
+	if (set_char(&p->file_contexts, data, len)) 
+		return -1;
+
 	p->file_contexts_len = len;
 	return 0;
 }
+
+int sepol_module_package_set_seusers(sepol_module_package_t *p, 
+					   char *data,
+					   size_t len)
+{
+	if (set_char(&p->seusers, data, len)) 
+		return -1;
+
+	p->seusers_len = len;
+	return 0;
+}
+
+int sepol_module_package_set_user_extra(sepol_module_package_t *p, 
+					   char *data,
+					   size_t len)
+{
+	if (set_char(&p->user_extra, data, len)) 
+		return -1;
+
+	p->user_extra_len = len;
+	return 0;
+}
  
 sepol_policydb_t *sepol_module_package_get_policy(sepol_module_package_t *p)
 {
@@ -288,6 +340,8 @@ static int module_package_read_offsets(s
 /* Flags for which sections have been seen during parsing of module package. */
 #define SEEN_MOD 1
 #define SEEN_FC  2
+#define SEEN_SEUSER 4
+#define SEEN_USER_EXTRA 8
 
 int sepol_module_package_read(sepol_module_package_t *mod, 
 			      struct sepol_policy_file *spf, int verbose)
@@ -347,6 +401,46 @@ int sepol_module_package_read(sepol_modu
         	        }
 			seen |= SEEN_FC;
 			break;
+		case SEPOL_PACKAGE_SECTION_SEUSER:
+			if (seen & SEEN_SEUSER) {
+				ERR(file->handle, "found multiple seuser sections in module package (at section %u)", i);
+				goto cleanup;
+			}
+		
+			mod->seusers_len = len - sizeof(uint32_t);
+			mod->seusers = (char *)malloc(mod->seusers_len);
+			if (!mod->seusers) {
+				ERR(file->handle, "out of memory");
+				goto cleanup;
+			}
+			if (read_helper(mod->seusers, file, mod->seusers_len)) {
+				ERR(file->handle, "invalid seuser section at section %u", i);
+                        	free(mod->seusers);
+	                        mod->seusers = NULL;
+				goto cleanup;
+        	        }
+			seen |= SEEN_SEUSER;
+			break;
+		case SEPOL_PACKAGE_SECTION_USER_EXTRA:
+			if (seen & SEEN_USER_EXTRA) {
+				ERR(file->handle, "found multiple user_extra sections in module package (at section %u)", i);
+				goto cleanup;
+			}
+			
+			mod->user_extra_len = len - sizeof(uint32_t);
+			mod->user_extra = (char *)malloc(mod->user_extra_len);
+			if (!mod->user_extra) {
+				ERR(file->handle, "out of memory");
+				goto cleanup;
+			}
+			if (read_helper(mod->user_extra, file, mod->user_extra_len)) {
+				ERR(file->handle, "invalid user_extra section at section %u", i);
+                        	free(mod->user_extra);
+	                        mod->user_extra= NULL;
+				goto cleanup;
+        	        }
+			seen |= SEEN_USER_EXTRA;
+			break;
 		case POLICYDB_MOD_MAGIC:
 			if (seen & SEEN_MOD) {
 				ERR(file->handle, "found multiple module sections in module package (at section %u)", i);
@@ -366,6 +460,7 @@ int sepol_module_package_read(sepol_modu
 			break;
 		default:
 			/* unknown section, ignore */	
+			ERR(file->handle, "unknown magic number at section %u, offset: %zx, number: %zx ",i, offsets[i],le32_to_cpu(buf[0]));
 			break;
 		}
 	}
@@ -429,6 +524,22 @@ int sepol_module_package_info(struct sep
 			}
 			seen |= SEEN_FC;
 			break;
+		case SEPOL_PACKAGE_SECTION_SEUSER:
+			/* skip seuser */
+			if (seen & SEEN_SEUSER) {
+				ERR(file->handle, "found seuser sections in module package (at section %u)", i);
+				goto cleanup;
+			}
+			seen |= SEEN_SEUSER;
+			break;
+		case SEPOL_PACKAGE_SECTION_USER_EXTRA:
+			/* skip user_extra*/
+			if (seen & SEEN_USER_EXTRA) {
+				ERR(file->handle, "found user_extra sections in module package (at section %u)", i);
+				goto cleanup;
+			}
+			seen |= SEEN_USER_EXTRA;
+			break;
 		case POLICYDB_MOD_MAGIC:
 			if (seen & SEEN_MOD) {
 				ERR(file->handle, "found multiple module sections in module package (at section %u)", i);
@@ -525,12 +636,30 @@ cleanup:
 	return -1;
 }
 
+static int write_helper(char *data, int len, struct policy_file *file) {
+	int idx = 0, len2;
+	while (len) {
+		if (len > BUFSIZ)
+			len2 = BUFSIZ;
+		else
+			len2 = len;
+	
+		if (put_entry(&data[idx], 1, len2, file) != len2) {
+			return -1;
+		}
+		len -= len2;
+		idx += len2;
+	}
+	return 0;
+}
+
 int sepol_module_package_write(sepol_module_package_t *p, 
 			       struct sepol_policy_file *spf)
 {
 	struct policy_file *file = &spf->pf;
 	policy_file_t polfile;
-	uint32_t buf[3], offsets[2], len, len2, idx, nsec = 0;
+	uint32_t buf[3], offsets[5], len, nsec = 0;
+	int i;
 
 	if (p->policy) {
 		/* compute policy length */
@@ -550,26 +679,56 @@ int sepol_module_package_write(sepol_mod
 		return -1;
 	}
 
+	/* seusers and user_extra only supported in base at the moment */
+	if ((p->seusers || p->user_extra) && (p->policy->p.policy_type != SEPOL_POLICY_BASE)) {
+		ERR(file->handle, "seuser and user_extra sections only supported in base");	
+		return -1;
+	}
+
 	if (p->file_contexts)
 		nsec++;
 
+	if (p->seusers)
+		nsec++;
+
+	if (p->user_extra)
+		nsec++;
+
 	buf[0] = cpu_to_le32(SEPOL_MODULE_PACKAGE_MAGIC);
 	buf[1] = cpu_to_le32(p->version);
 	buf[2] = cpu_to_le32(nsec);
 	if (put_entry(buf, sizeof(uint32_t), 3, file) != 3)
 		return -1;
 
-	/* first section offset */
+	/* calculate offsets */
 	offsets[0] = (nsec + 3) * sizeof(uint32_t);
 	buf[0] = cpu_to_le32(offsets[0]);
+
+	i = 1;
 	if (p->file_contexts) {
-		/* second section offset is offset[0] +  module length  */	
-		offsets[1] = offsets[0] + len;
-		buf[1] = cpu_to_le32(offsets[1]);
+		offsets[i] = offsets[i-1] + len;
+		buf[i] = cpu_to_le32(offsets[i]);
+		/* add a uint32_t to compensate for the magic number */
+		len = p->file_contexts_len + sizeof(uint32_t);
+		i++;
+	}
+	if (p->seusers) {
+		offsets[i] = offsets[i-1] + len;
+		buf[i] = cpu_to_le32(offsets[i]);
+		len = p->seusers_len + sizeof(uint32_t);
+		i++;
+	}
+	if (p->user_extra) {
+		offsets[i] = offsets[i-1] + len;
+		buf[i] = cpu_to_le32(offsets[i]);
+		len = p->user_extra_len + sizeof(uint32_t);
+		i++;
 	}
 	if (put_entry(buf, sizeof(uint32_t), nsec, file) != nsec)
 		return -1;
 
+	/* write sections */
+
 	if (policydb_write(&p->policy->p, file))
 		return -1;
 
@@ -577,20 +736,23 @@ int sepol_module_package_write(sepol_mod
 		buf[0] = cpu_to_le32(SEPOL_PACKAGE_SECTION_FC);
 		if (put_entry(buf, sizeof(uint32_t), 1, file) != 1)
 			return -1;
-		idx = 0;
-		len = p->file_contexts_len;
-		while (len) {
-			if (len > BUFSIZ)
-				len2 = BUFSIZ;
-			else
-				len2 = len;
-	
-			if (put_entry(&p->file_contexts[idx], 1, len2, file) != len2) {
-				return -1;
-			}
-			len -= len2;
-			idx += len2;
-		}
+		if (write_helper(p->file_contexts, p->file_contexts_len, file))
+			return -1;
+	}
+	if (p->seusers) {	
+		buf[0] = cpu_to_le32(SEPOL_PACKAGE_SECTION_SEUSER);
+		if (put_entry(buf, sizeof(uint32_t), 1, file) != 1)
+			return -1;
+		if (write_helper(p->seusers, p->seusers_len, file))
+			return -1;
+		
+	}
+	if (p->user_extra) {
+		buf[0] = cpu_to_le32(SEPOL_PACKAGE_SECTION_USER_EXTRA);
+		if (put_entry(buf, sizeof(uint32_t), 1, file) != 1)
+			return -1;
+		if (write_helper(p->user_extra, p->user_extra_len, file))
+			return -1;
 	}
 	return 0;
 }
diff -x.svn -pruN policycoreutils/semodule_package/semodule_package.c policycoreutils/semodule_package/semodule_package.c
--- policycoreutils/semodule_package/semodule_package.c	2005-10-25 10:48:27.000000000 -0400
+++ policycoreutils/semodule_package/semodule_package.c	2006-02-06 16:26:09.000000000 -0500
@@ -29,6 +29,8 @@ static void usage(char *progname)
         printf("  -o --outfile		Output file (required)\n");
         printf("  -m --module		Module file (required)\n");
         printf("  -f --fc		File contexts file\n");
+        printf("  -s --seuser		Seusers file (only valid in base)\n");
+        printf("  -u --user_extra	user_extra file (only valid in base)\n");
 	exit(1);
 }
 
@@ -50,7 +52,7 @@ static int file_to_policy_file(char *fil
 	return 0;
 }
 
-static int file_to_fc(const char *path, char **data, size_t *len)
+static int file_to_data(const char *path, char **data, size_t *len)
 {
 	int fd;
 	struct stat sb;
@@ -81,20 +83,22 @@ int main(int argc, char **argv)
 {
 	struct sepol_module_package *pkg;
 	struct sepol_policy_file *mod, *out;
-	char *module = NULL, *file_contexts = NULL;
-	char *fcdata = NULL, *outfile = NULL;
-	size_t fclen = 0;
+	char *module = NULL, *file_contexts = NULL, *seusers = NULL, *user_extra = NULL;
+	char *fcdata = NULL, *outfile = NULL, *seusersdata = NULL, *user_extradata = NULL;
+	size_t fclen = 0, seuserslen = 0, user_extralen = 0;
 	int i;
 
         static struct option opts [] = {
                 {"module", required_argument, NULL, 'm'},
                 {"fc", required_argument, NULL, 'f'},
+                {"seuser", required_argument, NULL, 's'},
+                {"user_extra", required_argument, NULL, 'u'},
 		{"outfile", required_argument, NULL, 'o'},
                 {"help", 0, NULL, 'h'},
 		{NULL, 0, NULL, 0}
 	};
 
-        while ((i = getopt_long(argc, argv, "m:f:o:h", opts, NULL)) != -1) {
+        while ((i = getopt_long(argc, argv, "m:f:s:u:o:h", opts, NULL)) != -1) {
                 switch (i) {
 		case 'h': usage(argv[0]); exit(0);
 		case 'm':  
@@ -124,6 +128,23 @@ int main(int argc, char **argv)
 			if (!outfile) 
 				exit(1);
 			break;
+		case 's':
+			if (seusers) {
+				fprintf(stderr, "May not specify more than one seuser file\n");
+				exit(1);
+			}
+			seusers = strdup(optarg);
+			if (!seusers)
+				exit(1);
+			break;
+		case 'u':
+			if (user_extra) {
+				fprintf(stderr, "May not specify more than one user_extra file\n");
+				exit(1);
+			}
+			user_extra = strdup(optarg);
+			if (!user_extra)
+				exit(1);
 		}
 	}
 
@@ -135,7 +156,17 @@ int main(int argc, char **argv)
 	}
 	
         if (file_contexts) {
-		if (file_to_fc(file_contexts, &fcdata, &fclen))
+		if (file_to_data(file_contexts, &fcdata, &fclen))
+			exit(1);
+        }
+
+        if (seusers) {
+		if (file_to_data(seusers, &seusersdata, &seuserslen))
+			exit(1);
+        }
+
+        if (user_extra) {
+		if (file_to_data(user_extra, &user_extradata, &user_extralen))
 			exit(1);
         }
 
@@ -155,6 +186,12 @@ int main(int argc, char **argv)
 
 	if (fclen)
 		sepol_module_package_set_file_contexts(pkg, fcdata, fclen);
+
+	if (seuserslen)
+		sepol_module_package_set_seusers(pkg, seusersdata, seuserslen);
+
+	if (user_extra)
+		sepol_module_package_set_user_extra(pkg, user_extradata, user_extralen);
 	
 	if (file_to_policy_file(outfile, &out, "w"))
 		exit(1);

--------------070302060102030803070804--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
