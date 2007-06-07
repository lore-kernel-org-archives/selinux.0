Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l57DhIpF014049
	for <selinux@tycho.nsa.gov>; Thu, 7 Jun 2007 09:43:18 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l57DhHWW001050
	for <selinux@tycho.nsa.gov>; Thu, 7 Jun 2007 13:43:17 GMT
Subject: [PATCH 4/5] libselinux: add checking for kernel object class
	discovery
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 07 Jun 2007 13:41:58 +0000
Message-Id: <1181223718.6578.87.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Detect if object class discovery kernel support exists.  Fall back to hardcoded
values for compatibility.

Signed-off-by: Chris PeBenito <cpebenito@tresys.com>

---
 libselinux/src/init.c      |   25 +++++++++++++++++++++++++
 libselinux/src/stringrep.c |   14 ++++++++++++++
 2 files changed, 39 insertions(+)

Index: selinux-obj-class-discovery/libselinux/src/init.c
===================================================================
--- selinux-obj-class-discovery.orig/libselinux/src/init.c
+++ selinux-obj-class-discovery/libselinux/src/init.c
@@ -9,6 +9,7 @@
 #include <dlfcn.h>
 #include <sys/vfs.h>
 #include <stdint.h>
+#include <limits.h>
 
 #include "dso.h"
 #include "policy.h"
@@ -17,6 +18,7 @@
 
 char *selinux_mnt = NULL;
 int selinux_page_size = 0;
+int obj_class_compat = 1;
 
 static void init_selinuxmnt(void)
 {
@@ -87,11 +89,33 @@ void set_selinuxmnt(char *mnt)
 
 hidden_def(set_selinuxmnt)
 
+static void init_obj_class_compat(void)
+{
+	char path[PATH_MAX];
+	struct stat s;
+
+	if (!selinux_mnt)
+		return;
+
+	snprintf(path,PATH_MAX,"%s/class",selinux_mnt);
+	if (stat(path,&s) < 0)
+		return;
+
+	if (S_ISDIR(s.st_mode))
+		obj_class_compat = 0;
+}
+
+static void fini_obj_class_compat(void)
+{
+	obj_class_compat = 1;
+}
+
 static void init_lib(void) __attribute__ ((constructor));
 static void init_lib(void)
 {
 	selinux_page_size = sysconf(_SC_PAGE_SIZE);
 	init_selinuxmnt();
+	init_obj_class_compat();
 	init_context_translations();
 }
 
@@ -99,5 +123,6 @@ static void fini_lib(void) __attribute__
 static void fini_lib(void)
 {
 	fini_selinuxmnt();
+	fini_obj_class_compat();
 	fini_context_translations();
 }
Index: selinux-obj-class-discovery/libselinux/src/stringrep.c
===================================================================
--- selinux-obj-class-discovery.orig/libselinux/src/stringrep.c
+++ selinux-obj-class-discovery/libselinux/src/stringrep.c
@@ -151,6 +151,8 @@ static const struct av_inherit {
 #define NVECTORS ARRAY_SIZE(av_perm_to_string)
 #define MAXVECTORS 8*sizeof(access_vector_t)
 
+extern int obj_class_compat;
+
 struct discover_class_node {
 	char *name;
 	security_class_t value;
@@ -417,6 +419,9 @@ security_class_t string_to_security_clas
 {
 	struct discover_class_node *node;
 
+	if (obj_class_compat)
+		return string_to_security_class_compat(s);
+
 	node = get_class_cache_entry_name(s);
 	if (node == NULL) {
 		node = discover_class(s);
@@ -434,6 +439,9 @@ access_vector_t string_to_av_perm(securi
 {
 	struct discover_class_node *node;
 
+	if (obj_class_compat)
+		return string_to_av_perm_compat(tclass,s);
+
 	node = get_class_cache_entry_value(tclass);
 	if (node != NULL) {
 		size_t i;
@@ -450,6 +458,9 @@ const char *security_class_to_string(sec
 {
 	struct discover_class_node *node;
 
+	if (obj_class_compat)
+		return security_class_to_string_compat(tclass);
+
 	node = get_class_cache_entry_value(tclass);
 	if (node == NULL) {
 		errno = EINVAL;
@@ -464,6 +475,9 @@ const char *security_av_perm_to_string(s
 	struct discover_class_node *node;
 	size_t i;
 
+	if (obj_class_compat)
+		return security_av_perm_to_string_compat(tclass,av);
+
 	node = get_class_cache_entry_value(tclass);
 	if (av && node)
 		for (i = 0; i<MAXVECTORS; i++)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
