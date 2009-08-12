Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7CIYXe8011613
	for <selinux@tycho.nsa.gov>; Wed, 12 Aug 2009 14:34:33 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n7CIZZ44002505
	for <selinux@tycho.nsa.gov>; Wed, 12 Aug 2009 18:35:36 GMT
Message-ID: <4A830B34.60402@redhat.com>
Date: Wed, 12 Aug 2009 14:34:28 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Chad Sellers <csellers@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: This patch fixes the exception handling in libselinux-python bindings
References: <C6A74D22.A99BD%csellers@tresys.com>
In-Reply-To: <C6A74D22.A99BD%csellers@tresys.com>
Content-Type: multipart/mixed;
 boundary="------------050103060806020803040304"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050103060806020803040304
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

What do you think of this one.  Removed excess swig cruft, 

You need to run 

make swigify to generate those changes.


--------------050103060806020803040304
Content-Type: text/plain;
 name="libselinux-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libselinux-rhat.patch"

--- nsalibselinux/include/selinux/selinux.h	2009-07-07 15:32:32.000000000 -0400
+++ libselinux-2.0.85/include/selinux/selinux.h	2009-08-12 13:36:34.000000000 -0400
@@ -346,7 +347,7 @@
 	const char *perms[sizeof(access_vector_t) * 8 + 1];
 };
 
-int selinux_set_mapping(struct security_class_mapping *map);
+extern int selinux_set_mapping(struct security_class_mapping *map);
 
 /* Common helpers */
 
@@ -556,17 +557,17 @@
 		     char **r_seuser, char **r_level);
 
 /* Compare two file contexts, return 0 if equivalent. */
-int selinux_file_context_cmp(const security_context_t a,
+extern int selinux_file_context_cmp(const security_context_t a,
 			     const security_context_t b);
 
 /* 
  * Verify the context of the file 'path' against policy.
  * Return 0 if correct. 
  */
-int selinux_file_context_verify(const char *path, mode_t mode);
+extern int selinux_file_context_verify(const char *path, mode_t mode);
 
 /* This function sets the file context on to the system defaults returns 0 on success */
-int selinux_lsetfilecon_default(const char *path);
+extern int selinux_lsetfilecon_default(const char *path);
 
 #ifdef __cplusplus
 }
--- nsalibselinux/src/exception.sh	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-2.0.85/src/exception.sh	2009-08-12 13:44:21.000000000 -0400
@@ -0,0 +1,21 @@
+function except() {
+case $1 in
+    selinux_file_context_cmp) # ignore
+    ;;
+    *)
+echo "
+%exception $1 {
+  \$action 
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     return NULL;
+  }
+}
+"
+;;
+esac
+}
+echo '#include "../include/selinux/selinux.h"' > temp.c
+gcc -c temp.c -aux-info temp.aux 
+for i in `awk '/..\/include\/selinux\/selinux.h.*extern int/ { print $6 }' temp.aux`; do except $i ; done 
+rm -f temp.c temp.aux temp.o
--- nsalibselinux/src/Makefile	2009-07-14 11:16:03.000000000 -0400
+++ libselinux-2.0.85/src/Makefile	2009-08-12 12:08:08.000000000 -0400
@@ -82,6 +82,9 @@
 	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -ldl -L$(LIBDIR) -Wl,-soname,$(LIBSO),-z,defs,-z,relro
 	ln -sf $@ $(TARGET) 
 
+selinuxswig_exception.i: ../include/selinux/selinux.h
+	sh exception.sh > $@ 
+
 audit2why.lo: audit2why.c
 	$(CC) $(CFLAGS) -I$(PYINC) -fPIC -DSHARED -c -o $@ $<
 
@@ -100,8 +103,8 @@
 $(SWIGRUBYCOUT): $(SWIGRUBYIF)
 	$(SWIGRUBY) $^
 
-swigify: $(SWIGIF)
-	$(SWIG) $^
+swigify: $(SWIGIF) selinuxswig_exception.i
+	$(SWIG) $<
 
 install: all 
 	test -d $(LIBDIR) || install -m 755 -d $(LIBDIR)
@@ -124,7 +127,7 @@
 	/sbin/restorecon $(SHLIBDIR)/$(LIBSO)
 
 clean: 
-	-rm -f $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(SWIGLOBJ) $(SWIGSO) $(TARGET) $(AUDIT2WHYSO) *.o *.lo *~
+	-rm -f $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(SWIGLOBJ) $(SWIGSO) $(TARGET) $(AUDIT2WHYSO) *.o *.lo *~ selinuxswig_exception.i
 
 distclean: clean
 	rm -f $(GENERATED) $(SWIGFILES)
--- nsalibselinux/src/selinuxswig.i	2009-03-12 08:48:48.000000000 -0400
+++ libselinux-2.0.85/src/selinuxswig.i	2009-07-31 08:29:59.000000000 -0400
@@ -4,11 +4,14 @@
 
 %module selinux
 %{
-	#include "selinux/selinux.h"
 	#include "../include/selinux/avc.h"
-	#include "../include/selinux/selinux.h"
-	#include "../include/selinux/get_default_type.h"
+	#include "../include/selinux/av_permissions.h"
+	#include "../include/selinux/context.h"
+	#include "../include/selinux/flask.h"
 	#include "../include/selinux/get_context_list.h"
+	#include "../include/selinux/get_default_type.h"
+	#include "../include/selinux/label.h"
+	#include "../include/selinux/selinux.h"
 %}
 %apply int *OUTPUT { int *enforce };
 %apply int *OUTPUT { size_t * };
@@ -55,8 +58,11 @@
 %ignore avc_netlink_release_fd;
 %ignore avc_netlink_check_nb;
 
-%include "../include/selinux/selinux.h"
 %include "../include/selinux/avc.h"
-%include "../include/selinux/get_default_type.h"
+%include "../include/selinux/av_permissions.h"
+%include "../include/selinux/context.h"
+%include "../include/selinux/flask.h"
 %include "../include/selinux/get_context_list.h"
-
+%include "../include/selinux/get_default_type.h"
+%include "../include/selinux/label.h"
+%include "../include/selinux/selinux.h"
--- nsalibselinux/src/selinuxswig_python.i	2009-03-06 14:41:45.000000000 -0500
+++ libselinux-2.0.85/src/selinuxswig_python.i	2009-07-31 08:29:59.000000000 -0400
@@ -21,6 +21,15 @@
                              map(restorecon, [os.path.join(dirname, fname)
                                               for fname in fnames]), None)
 
+def copytree(src, dest):
+    """ An SELinux-friendly shutil.copytree method """
+    shutil.copytree(src, dest)
+    restorecon(dest, recursive=True)
+
+def install(src, dest):
+    """ An SELinux-friendly shutil.move method """
+    shutil.move(src, dest)
+    restorecon(dest, recursive=True)
 %}
 
 /* security_get_boolean_names() typemap */
@@ -150,4 +159,5 @@
 	free($1);
 }
 
+%include "selinuxswig_exception.i"
 %include "selinuxswig.i"

--------------050103060806020803040304--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
