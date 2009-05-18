Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4IIASjS028788
	for <selinux@tycho.nsa.gov>; Mon, 18 May 2009 14:10:28 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n4IIANlT020014
	for <selinux@tycho.nsa.gov>; Mon, 18 May 2009 18:10:24 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n4IIAGFG006052
	for <selinux@tycho.nsa.gov>; Mon, 18 May 2009 14:10:17 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n4IIAGLX006637
	for <selinux@tycho.nsa.gov>; Mon, 18 May 2009 14:10:16 -0400
Received: from localhost.localdomain (vpn-10-81.bos.redhat.com [10.16.10.81])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n4IIAF8O001989
	for <selinux@tycho.nsa.gov>; Mon, 18 May 2009 14:10:15 -0400
Message-ID: <4A11A48A.1020307@redhat.com>
Date: Mon, 18 May 2009 14:10:18 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: This patch fixes the exception handling in libselinux-python bindings
Content-Type: multipart/mixed;
 boundary="------------090002080702060701090406"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090002080702060701090406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Basically we need to search for all interfaces that return an int and 
set those up as python exception handlers.

--------------090002080702060701090406
Content-Type: text/plain;
 name="libselinux_python_exception.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libselinux_python_exception.patch"

--- nsalibselinux/src/selinuxswig.i	2009-03-12 08:48:48.000000000 -0400
+++ libselinux-2.0.81/src/selinuxswig.i	2009-05-18 14:04:07.000000000 -0400
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
--- nsalibselinux/src/Makefile	2009-03-06 14:41:45.000000000 -0500
+++ libselinux-2.0.81/src/Makefile	2009-05-18 14:04:07.000000000 -0400
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
--- nsalibselinux/src/exception.sh	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-2.0.81/src/exception.sh	2009-05-18 14:04:07.000000000 -0400
@@ -0,0 +1,12 @@
+function except() {
+echo "
+%exception $1 {
+  \$action 
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     return NULL;
+  }
+}
+"
+}
+for i in `grep "extern *int" ../include/selinux/selinux.h | awk '{ print $3 }' | cut -d '(' -f 1`; do except $i ; done 
--- nsalibselinux/src/selinuxswig_python.i	2009-03-06 14:41:45.000000000 -0500
+++ libselinux-2.0.81/src/selinuxswig_python.i	2009-05-18 14:04:07.000000000 -0400
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

--------------090002080702060701090406--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
