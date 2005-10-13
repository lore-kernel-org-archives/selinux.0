Subject: Re: [ SEMANAGE ] [ SEPOL ] More database work
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux-dev@tresys.com,
   dwalsh@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <1129035115.3308.67.camel@moss-spartans.epoch.ncsc.mil>
References: <43454A61.8010907@cornell.edu>
	 <1128626875.15836.168.camel@moss-spartans.epoch.ncsc.mil>
	 <1128695426.1450.26.camel@moss-spartans.epoch.ncsc.mil>
	 <1128700358.1450.39.camel@moss-spartans.epoch.ncsc.mil>
	 <1128709856.1450.75.camel@moss-spartans.epoch.ncsc.mil>
	 <4346CE4C.1030201@tresys.com>
	 <1128714852.1450.90.camel@moss-spartans.epoch.ncsc.mil>
	 <1128719862.1450.119.camel@moss-spartans.epoch.ncsc.mil>
	 <1129035115.3308.67.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-Z8x+PNDzI+jumFQrE0D2"
Date: Thu, 13 Oct 2005 15:29:27 -0400
Message-Id: <1129231767.13490.31.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Z8x+PNDzI+jumFQrE0D2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2005-10-11 at 08:51 -0400, Stephen Smalley wrote:
> Any thoughts on the above question?  If we leave it publically defined,
> then users can still directly allocate/free sepol_module_package's
> rather than using the provided create/free interfaces and can directly
> access the policy, file_contexts, and file_context_len fields.  Do we
> anticipate sepol_module_package's including other information in the
> future?
> 
> Also, I wanted to note that when I introduced create/free interfaces for
> sepol_module_package, I had to rename the existing interface named
> "sepol_module_package_create" to "sepol_module_package_create_file".
> That interface was for creating a package file from a policy file and a
> file contexts file, not for creating the struct itself.

Patch below hides the sepol_module_package type definition within
libsepol, committed to cvs.

We still need to decide what to do about the
sepol_module_package_create_file interface to make it extensible; one
option is to discard it and require the caller to build up a
sepol_module_package struct via a create/set_xx/set_yy sequence and then
use the write interface to write the final package file.  It appears the
we would only need/want a set_file_contexts interface at present, as the
policydb is allocated by the create interface and can be extracted via
get and then populated using the other policydb interfaces (read,
expand_module, etc).  The only user of the create_file interface
presently is semodule_package.

Also need to deal with the package file format itself, i.e. versioning,
sections, etc. per the discussion on fedora-selinux-list.

-- 
Stephen Smalley
National Security Agency

--=-Z8x+PNDzI+jumFQrE0D2
Content-Disposition: attachment; filename=x.diff
Content-Type: text/x-patch; name=x.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: libsemanage/ChangeLog
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsemanage/ChangeLog,v
retrieving revision 1.24
retrieving revision 1.25
diff -u -p -r1.24 -r1.25
--- libsemanage/ChangeLog	13 Oct 2005 16:47:59 -0000	1.24
+++ libsemanage/ChangeLog	13 Oct 2005 19:09:34 -0000	1.25
@@ -1,3 +1,6 @@
+1.3.14 2005-10-13
+	* Updated to use get interfaces for hidden sepol_module_package type.
+
 1.3.13 2005-10-13
 	* Changed semanage_expand_sandbox and semanage_install_active
 	to generate/install the latest policy version supported	by libsepol
Index: libsemanage/VERSION
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsemanage/VERSION,v
retrieving revision 1.21
retrieving revision 1.22
diff -u -p -r1.21 -r1.22
--- libsemanage/VERSION	13 Oct 2005 16:47:59 -0000	1.21
+++ libsemanage/VERSION	13 Oct 2005 19:09:34 -0000	1.22
@@ -1 +1 @@
-1.3.13
+1.3.14
Index: libsemanage/src/direct_api.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsemanage/src/direct_api.c,v
retrieving revision 1.6
diff -u -p -r1.6 direct_api.c
--- libsemanage/src/direct_api.c	13 Oct 2005 15:56:29 -0000	1.6
+++ libsemanage/src/direct_api.c	13 Oct 2005 19:09:49 -0000
@@ -262,7 +262,7 @@ static int semanage_direct_commit(semana
 
 	/* write the linked file contexts */
 	if ((fc_filename = semanage_path(SEMANAGE_TMP, SEMANAGE_FC)) == NULL ||
-	    write_file(sh, fc_filename, base->file_contexts, base->file_contexts_len) == -1) {
+	    write_file(sh, fc_filename, sepol_module_package_get_file_contexts(base), sepol_module_package_get_file_contexts_len(base)) == -1) {
 		goto cleanup;
 	}
 
Index: libsemanage/src/semanage_store.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsemanage/src/semanage_store.c,v
retrieving revision 1.8
diff -u -p -r1.8 semanage_store.c
--- libsemanage/src/semanage_store.c	13 Oct 2005 16:47:59 -0000	1.8
+++ libsemanage/src/semanage_store.c	13 Oct 2005 19:09:49 -0000
@@ -1192,7 +1192,7 @@ int semanage_expand_sandbox(semanage_han
 	if (sepol_policydb_create(&out)) {
 		return -1;
 	}
-	if (sepol_expand_module(base->policy, out, 0,
+	if (sepol_expand_module(sepol_module_package_get_policy(base), out, 0,
 				buffer, sizeof(buffer)) == -1) {
 		if (*buffer != '\0')
 			ERR(sh, "%s", buffer);
Index: libsepol/ChangeLog
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/ChangeLog,v
retrieving revision 1.77
retrieving revision 1.78
diff -u -p -r1.77 -r1.78
--- libsepol/ChangeLog	13 Oct 2005 15:56:28 -0000	1.77
+++ libsepol/ChangeLog	13 Oct 2005 19:09:33 -0000	1.78
@@ -1,3 +1,6 @@
+1.9.17 2005-10-13
+	* Hid sepol_module_package type definition, and added get interfaces.
+
 1.9.16 2005-10-13
 	* Merged new callback-based error reporting system from Ivan
 	Gyurdiev.
Index: libsepol/VERSION
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/VERSION,v
retrieving revision 1.70
retrieving revision 1.71
diff -u -p -r1.70 -r1.71
--- libsepol/VERSION	13 Oct 2005 15:56:28 -0000	1.70
+++ libsepol/VERSION	13 Oct 2005 19:09:33 -0000	1.71
@@ -1 +1 @@
-1.9.16
+1.9.17
Index: libsepol/include/sepol/module.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/include/sepol/module.h,v
retrieving revision 1.3
diff -u -p -r1.3 module.h
--- libsepol/include/sepol/module.h	7 Oct 2005 20:10:14 -0000	1.3
+++ libsepol/include/sepol/module.h	13 Oct 2005 19:09:49 -0000
@@ -7,11 +7,7 @@
 
 #include <sepol/policydb.h> 
 
-struct sepol_module_package {
-	sepol_policydb_t *policy;
-	char 		*file_contexts;
-	uint32_t	file_contexts_len;
-};
+struct sepol_module_package;
 typedef struct sepol_module_package sepol_module_package_t;
 
 /* Module package public interfaces. */
@@ -20,6 +16,10 @@ extern int sepol_module_package_create(s
 
 extern void sepol_module_package_free(sepol_module_package_t *p);
 
+extern char *sepol_module_package_get_file_contexts(sepol_module_package_t *p);
+extern uint32_t sepol_module_package_get_file_contexts_len(sepol_module_package_t *p);
+extern sepol_policydb_t *sepol_module_package_get_policy(sepol_module_package_t *p);
+
 extern int sepol_link_packages(sepol_module_package_t *base,
                                sepol_module_package_t **modules, 
 			       int num_modules,
Index: libsepol/include/sepol/policydb/module.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/include/sepol/policydb/module.h,v
retrieving revision 1.1
diff -u -p -r1.1 module.h
--- libsepol/include/sepol/policydb/module.h	7 Oct 2005 20:10:14 -0000	1.1
+++ libsepol/include/sepol/policydb/module.h	13 Oct 2005 19:09:49 -0000
@@ -30,6 +30,12 @@
 
 #define SEPOL_MODULE_PACKAGE_MAGIC 0xf97cff8e
 
+struct sepol_module_package {
+	sepol_policydb_t *policy;
+	char 		*file_contexts;
+	uint32_t	file_contexts_len;
+};
+
 extern int sepol_module_package_init(sepol_module_package_t *p);
 
 #endif
Index: libsepol/src/libsepol.map
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/libsepol.map,v
retrieving revision 1.7
diff -u -p -r1.7 libsepol.map
--- libsepol/src/libsepol.map	13 Oct 2005 15:56:29 -0000	1.7
+++ libsepol/src/libsepol.map	13 Oct 2005 19:09:49 -0000
@@ -10,6 +10,7 @@
 	sepol_policydb_read; sepol_policydb_write;
 	sepol_policydb_from_image; sepol_policydb_to_image;
 	sepol_module_package_create; sepol_module_package_free; 
+	sepol_module_package_get_file_contexts; sepol_module_package_get_file_contexts_len; sepol_module_package_get_policy;
 	sepol_link_packages; 
 	sepol_module_package_read; sepol_module_package_info;
 	sepol_module_package_write; sepol_module_package_create_file;
Index: libsepol/src/module.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/module.c,v
retrieving revision 1.4
diff -u -p -r1.4 module.c
--- libsepol/src/module.c	11 Oct 2005 18:18:13 -0000	1.4
+++ libsepol/src/module.c	13 Oct 2005 19:09:49 -0000
@@ -54,6 +54,22 @@ void sepol_module_package_free(sepol_mod
         free(p);
 }
 
+char *sepol_module_package_get_file_contexts(sepol_module_package_t *p)
+{
+	return p->file_contexts;
+}
+
+
+uint32_t sepol_module_package_get_file_contexts_len(sepol_module_package_t *p)
+{
+	return p->file_contexts_len;
+}
+ 
+sepol_policydb_t *sepol_module_package_get_policy(sepol_module_package_t *p)
+{
+	return p->policy;
+}
+
 /* Append each of the file contexts from each module to the base
  * policy's file context.  'base_context' will be reallocated to a
  * larger size (and thus it is an in/out reference
Index: policycoreutils/ChangeLog
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policycoreutils/ChangeLog,v
retrieving revision 1.138
retrieving revision 1.139
diff -u -p -r1.138 -r1.139
--- policycoreutils/ChangeLog	13 Oct 2005 17:57:55 -0000	1.138
+++ policycoreutils/ChangeLog	13 Oct 2005 19:09:34 -0000	1.139
@@ -1,3 +1,6 @@
+1.27.11 2005-10-13
+	* Updated semodule_expand to use get interfaces for hidden sepol_module_package type.
+
 1.27.10 2005-10-13
 	* Merged newrole and run_init pam config patches from Dan Walsh (Red Hat).
 
Index: policycoreutils/VERSION
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policycoreutils/VERSION,v
retrieving revision 1.77
retrieving revision 1.78
diff -u -p -r1.77 -r1.78
--- policycoreutils/VERSION	13 Oct 2005 17:57:55 -0000	1.77
+++ policycoreutils/VERSION	13 Oct 2005 19:09:34 -0000	1.78
@@ -1 +1 @@
-1.27.10
+1.27.11
Index: policycoreutils/semodule_expand/semodule_expand.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policycoreutils/semodule_expand/semodule_expand.c,v
retrieving revision 1.5
diff -u -p -r1.5 semodule_expand.c
--- policycoreutils/semodule_expand/semodule_expand.c	11 Oct 2005 18:21:52 -0000	1.5
+++ policycoreutils/semodule_expand/semodule_expand.c	13 Oct 2005 19:09:49 -0000
@@ -123,7 +123,7 @@ int main(int argc, char **argv)
         }
 
         error_buf [0] = '\0';
-        if (sepol_expand_module(base->policy, out, verbose, error_buf, sizeof (error_buf))) {
+        if (sepol_expand_module(sepol_module_package_get_policy(base), out, verbose, error_buf, sizeof (error_buf))) {
         	fprintf(stderr, "Error expanding policy: %s\n", error_buf);
         	exit(1);
         }

--=-Z8x+PNDzI+jumFQrE0D2--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
