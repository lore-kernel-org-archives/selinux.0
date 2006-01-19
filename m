Subject: [PATCH] libsemanage/semanage - permission check for semanage
From: Joshua Brindle <jbrindle@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Cc: selinuxdev <selinux-dev@tresys.com>, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-lQ8TCibwI+MnDAXBn23z"
Date: Thu, 19 Jan 2006 16:45:55 -0500
Message-Id: <1137707155.17672.2.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-lQ8TCibwI+MnDAXBn23z
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

- add semanage_can_write to libsemanage which does a silent check for
access on the active store, modules directory and binary policy
directory
- chance semanage_is_managed to use can_write instead of create_store
for access check
- add access check to seobject.py, in semanageRecord init
- remove dans UID == 0 check
- make the bottom level Makefile propagate install-pywrap target
- make install-pywrap target in libselinux depend on pywrap


It appears that the last commit didn't have make swigify run in
libsemanage so the generated swig wrappers were out of date, the ones in
this patch include my changes as well as the last ones.

Also, it seems that the current semanage is not disconnecting from the
store or freeing the handle. While this isn't too much of a problem
(aside from memory leaks) now, it will be in the future with the policy
server.

--=-lQ8TCibwI+MnDAXBn23z
Content-Disposition: attachment; filename=1-semanage-write-check.diff
Content-Type: text/x-patch; name=1-semanage-write-check.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -purN -x.svn libselinux/src/Makefile libselinux/src/Makefile
--- libselinux/src/Makefile	2006-01-18 11:53:22.000000000 -0500
+++ libselinux/src/Makefile	2006-01-19 15:11:06.000000000 -0500
@@ -63,7 +63,7 @@ install: all 
 	install -m 755 $(LIBSO) $(SHLIBDIR)
 	cd $(LIBDIR) && ln -sf ../../`basename $(SHLIBDIR)`/$(LIBSO) $(TARGET)
 
-install-pywrap: 
+install-pywrap: pywrap
 	test -d $(PYTHONLIBDIR)/site-packages || install -m 755 -d $(PYTHONLIBDIR)/site-packages
 	install -m 755 $(SWIGFILES) $(PYTHONLIBDIR)/site-packages
 
diff -purN -x.svn libsemanage/include/semanage/handle.h libsemanage/include/semanage/handle.h
--- libsemanage/include/semanage/handle.h	2006-01-18 11:54:04.000000000 -0500
+++ libsemanage/include/semanage/handle.h	2006-01-19 16:33:23.000000000 -0500
@@ -100,6 +100,9 @@ int semanage_begin_transaction(semanage_
  */
 int semanage_commit(semanage_handle_t *);
 
+/* returns -1 if the store is probably not writable by the current UID/GID */
+int semanage_can_write(semanage_handle_t *sh);
+
 /* META NOTES
  *
  * For all functions a non-negative number indicates success. For some
diff -purN -x.svn libsemanage/src/direct_api.c libsemanage/src/direct_api.c
--- libsemanage/src/direct_api.c	2006-01-18 11:56:33.000000000 -0500
+++ libsemanage/src/direct_api.c	2006-01-19 15:11:05.000000000 -0500
@@ -82,7 +82,8 @@ int semanage_direct_is_managed(semanage_
 	if (semanage_check_init(polpath))
 		goto err;
 
-	if (semanage_create_store(sh, 0) < 0) 
+	/* manage test should be silent */
+	if (semanage_can_write(sh) < 0) 
 		return 0;
 
 	return 1;
@@ -775,3 +776,9 @@ static int semanage_direct_list(semanage
         }
 	return retval;
 }
+
+/* returns -1 if the store or binary policy directory 
+ * is probably not writable by the current UID/GID */
+int semanage_direct_can_write(semanage_handle_t *sh) {
+	return semanage_store_writable(sh);
+}
diff -purN -x.svn libsemanage/src/direct_api.h libsemanage/src/direct_api.h
--- libsemanage/src/direct_api.h	2006-01-18 11:56:33.000000000 -0500
+++ libsemanage/src/direct_api.h	2006-01-19 15:11:05.000000000 -0500
@@ -37,4 +37,6 @@ int semanage_direct_connect(
 int semanage_direct_is_managed(
 	struct semanage_handle *sh);
 
+int semanage_direct_can_write(struct semanage_handle *sh);
+
 #endif
diff -purN -x.svn libsemanage/src/handle.c libsemanage/src/handle.c
--- libsemanage/src/handle.c	2006-01-18 11:56:33.000000000 -0500
+++ libsemanage/src/handle.c	2006-01-19 16:33:33.000000000 -0500
@@ -142,6 +142,20 @@ int semanage_connect(semanage_handle_t *
 	return 0;
 }
 
+int semanage_can_write(semanage_handle_t *sh) {
+	assert(sh != NULL);
+	switch (sh->conf->store_type) {
+	case SEMANAGE_CON_DIRECT: 
+		return semanage_direct_can_write(sh);
+	default:
+		return -1;
+	}
+
+	return -1; /* unreachable */
+}
+
+hidden_def(semanage_can_write)
+
 int semanage_disconnect(semanage_handle_t *sh) {
 	assert(sh != NULL && sh->funcs != NULL && sh->funcs->disconnect != NULL);
 	if (!sh->is_connected) {
diff -purN -x.svn libsemanage/src/handle_internal.h libsemanage/src/handle_internal.h
--- libsemanage/src/handle_internal.h	2006-01-18 11:56:33.000000000 -0500
+++ libsemanage/src/handle_internal.h	2006-01-19 11:37:11.000000000 -0500
@@ -7,5 +7,6 @@
 hidden_proto(semanage_begin_transaction)
 hidden_proto(semanage_handle_destroy)
 hidden_proto(semanage_reload_policy)
+hidden_proto(semanage_can_write)
 
 #endif
diff -purN -x.svn libsemanage/src/libsemanage.map libsemanage/src/libsemanage.map
--- libsemanage/src/libsemanage.map	2006-01-18 11:56:33.000000000 -0500
+++ libsemanage/src/libsemanage.map	2006-01-19 11:37:24.000000000 -0500
@@ -11,6 +11,6 @@ LIBSEMANAGE_1.0 {
 	  semanage_reload_policy; semanage_set_reload; semanage_set_rebuild;
 	  semanage_user_*; semanage_bool_*; semanage_seuser_*;
 	  semanage_iface_*; semanage_port_*; semanage_context_*;
-	  semanage_fcontext_*;
+	  semanage_fcontext_*; semanage_can_write;
   local: *;
 };
diff -purN -x.svn libsemanage/src/semanage.py libsemanage/src/semanage.py
--- libsemanage/src/semanage.py	2006-01-19 15:45:19.000000000 -0500
+++ libsemanage/src/semanage.py	2006-01-19 15:43:18.000000000 -0500
@@ -88,6 +88,8 @@ semanage_begin_transaction = _semanage.s
 
 semanage_commit = _semanage.semanage_commit
 
+semanage_can_write = _semanage.semanage_can_write
+
 semanage_module_install = _semanage.semanage_module_install
 
 semanage_module_upgrade = _semanage.semanage_module_upgrade
@@ -258,6 +260,10 @@ semanage_user_get_name = _semanage.seman
 
 semanage_user_set_name = _semanage.semanage_user_set_name
 
+semanage_user_get_prefix = _semanage.semanage_user_get_prefix
+
+semanage_user_set_prefix = _semanage.semanage_user_set_prefix
+
 semanage_user_get_mlslevel = _semanage.semanage_user_get_mlslevel
 
 semanage_user_set_mlslevel = _semanage.semanage_user_set_mlslevel
diff -purN -x.svn libsemanage/src/semanage_store.c libsemanage/src/semanage_store.c
--- libsemanage/src/semanage_store.c	2006-01-18 11:56:33.000000000 -0500
+++ libsemanage/src/semanage_store.c	2006-01-19 16:36:53.000000000 -0500
@@ -281,7 +281,41 @@ int semanage_create_store(semanage_handl
 	return 0;
 }
 
+/* returns -1 if the store or binary policy directory 
+ * is probably not writable by the current UID/GID */
+int semanage_store_writable(semanage_handle_t *sh) {
+	const char *path;
+	char *path2, *path3, polpath[PATH_MAX];
+	int rc;
 
+	snprintf(polpath, PATH_MAX, "%s%s", selinux_path(), sh->conf->store_path);
+
+	if (semanage_check_init(polpath))
+		return -1;
+
+	/* check the active directory */
+	path = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_TOPLEVEL);
+	if ((rc = access(path, R_OK | W_OK | X_OK)) != 0)
+		return rc;
+
+	/* check the binary policy install directory */
+	path = selinux_binary_policy_path();
+	path2 = strdup(path);
+	path3 = dirname(path2);
+
+	if ((rc = access(path3, R_OK | W_OK | X_OK)) != 0) {
+		free(path2);
+		return rc;
+	}
+	free(path2);
+
+	/* check the modules directory */
+	path = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_MODULES);
+	if ((rc = access(path, R_OK | W_OK | X_OK)) != 0)
+		return rc;
+	
+	return 0;
+}
 
 /********************* other I/O functions *********************/
 
diff -purN -x.svn libsemanage/src/semanage_store.h libsemanage/src/semanage_store.h
--- libsemanage/src/semanage_store.h	2006-01-18 11:56:33.000000000 -0500
+++ libsemanage/src/semanage_store.h	2006-01-19 15:11:05.000000000 -0500
@@ -99,5 +99,6 @@ int semanage_verify_modules(
 int semanage_verify_linked(semanage_handle_t *sh);
 int semanage_verify_kernel(semanage_handle_t *sh);
 int semanage_split_fc(semanage_handle_t *sh);
+int semanage_store_writable(semanage_handle_t *sh);
 
 #endif
diff -purN -x.svn libsemanage/src/semanageswig_wrap.c libsemanage/src/semanageswig_wrap.c
--- libsemanage/src/semanageswig_wrap.c	2006-01-19 15:45:19.000000000 -0500
+++ libsemanage/src/semanageswig_wrap.c	2006-01-19 15:43:18.000000000 -0500
@@ -1748,6 +1748,8 @@ int semanage_user_compare(semanage_user_
 int semanage_user_compare2(semanage_user_t const *,semanage_user_t const *);
 char const *semanage_user_get_name(semanage_user_t const *);
 int semanage_user_set_name(semanage_handle_t *,semanage_user_t *,char const *);
+char const *semanage_user_get_prefix(semanage_user_t const *);
+int semanage_user_set_prefix(semanage_handle_t *,semanage_user_t *,char const *);
 char const *semanage_user_get_mlslevel(semanage_user_t const *);
 int semanage_user_set_mlslevel(semanage_handle_t *,semanage_user_t *,char const *);
 char const *semanage_user_get_mlsrange(semanage_user_t const *);
@@ -2396,6 +2398,26 @@ static PyObject *_wrap_semanage_commit(P
 }
 
 
+static PyObject *_wrap_semanage_can_write(PyObject *self, PyObject *args) {
+    PyObject *resultobj;
+    semanage_handle_t *arg1 = (semanage_handle_t *) 0 ;
+    int result;
+    PyObject * obj0 = 0 ;
+    
+    if(!PyArg_ParseTuple(args,(char *)"O:semanage_can_write",&obj0)) goto fail;
+    SWIG_Python_ConvertPtr(obj0, (void **)&arg1, SWIGTYPE_p_semanage_handle, SWIG_POINTER_EXCEPTION | 0);
+    if (SWIG_arg_fail(1)) SWIG_fail;
+    result = (int)semanage_can_write(arg1);
+    
+    {
+        resultobj = SWIG_From_int((int)(result)); 
+    }
+    return resultobj;
+    fail:
+    return NULL;
+}
+
+
 static PyObject *_wrap_semanage_module_install(PyObject *self, PyObject *args) {
     PyObject *resultobj;
     semanage_handle_t *arg1 = (semanage_handle_t *) 0 ;
@@ -4658,6 +4680,53 @@ static PyObject *_wrap_semanage_user_set
 }
 
 
+static PyObject *_wrap_semanage_user_get_prefix(PyObject *self, PyObject *args) {
+    PyObject *resultobj;
+    semanage_user_t *arg1 = (semanage_user_t *) 0 ;
+    char *result;
+    PyObject * obj0 = 0 ;
+    
+    if(!PyArg_ParseTuple(args,(char *)"O:semanage_user_get_prefix",&obj0)) goto fail;
+    SWIG_Python_ConvertPtr(obj0, (void **)&arg1, SWIGTYPE_p_semanage_user, SWIG_POINTER_EXCEPTION | 0);
+    if (SWIG_arg_fail(1)) SWIG_fail;
+    result = (char *)semanage_user_get_prefix((semanage_user_t const *)arg1);
+    
+    resultobj = SWIG_FromCharPtr(result);
+    return resultobj;
+    fail:
+    return NULL;
+}
+
+
+static PyObject *_wrap_semanage_user_set_prefix(PyObject *self, PyObject *args) {
+    PyObject *resultobj;
+    semanage_handle_t *arg1 = (semanage_handle_t *) 0 ;
+    semanage_user_t *arg2 = (semanage_user_t *) 0 ;
+    char *arg3 = (char *) 0 ;
+    int result;
+    PyObject * obj0 = 0 ;
+    PyObject * obj1 = 0 ;
+    PyObject * obj2 = 0 ;
+    
+    if(!PyArg_ParseTuple(args,(char *)"OOO:semanage_user_set_prefix",&obj0,&obj1,&obj2)) goto fail;
+    SWIG_Python_ConvertPtr(obj0, (void **)&arg1, SWIGTYPE_p_semanage_handle, SWIG_POINTER_EXCEPTION | 0);
+    if (SWIG_arg_fail(1)) SWIG_fail;
+    SWIG_Python_ConvertPtr(obj1, (void **)&arg2, SWIGTYPE_p_semanage_user, SWIG_POINTER_EXCEPTION | 0);
+    if (SWIG_arg_fail(2)) SWIG_fail;
+    if (!SWIG_AsCharPtr(obj2, (char**)&arg3)) {
+        SWIG_arg_fail(3);SWIG_fail;
+    }
+    result = (int)semanage_user_set_prefix(arg1,arg2,(char const *)arg3);
+    
+    {
+        resultobj = SWIG_From_int((int)(result)); 
+    }
+    return resultobj;
+    fail:
+    return NULL;
+}
+
+
 static PyObject *_wrap_semanage_user_get_mlslevel(PyObject *self, PyObject *args) {
     PyObject *resultobj;
     semanage_user_t *arg1 = (semanage_user_t *) 0 ;
@@ -7423,6 +7492,7 @@ static PyMethodDef SwigMethods[] = {
 	 { (char *)"semanage_disconnect", _wrap_semanage_disconnect, METH_VARARGS, NULL},
 	 { (char *)"semanage_begin_transaction", _wrap_semanage_begin_transaction, METH_VARARGS, NULL},
 	 { (char *)"semanage_commit", _wrap_semanage_commit, METH_VARARGS, NULL},
+	 { (char *)"semanage_can_write", _wrap_semanage_can_write, METH_VARARGS, NULL},
 	 { (char *)"semanage_module_install", _wrap_semanage_module_install, METH_VARARGS, NULL},
 	 { (char *)"semanage_module_upgrade", _wrap_semanage_module_upgrade, METH_VARARGS, NULL},
 	 { (char *)"semanage_module_install_base", _wrap_semanage_module_install_base, METH_VARARGS, NULL},
@@ -7508,6 +7578,8 @@ static PyMethodDef SwigMethods[] = {
 	 { (char *)"semanage_user_compare2", _wrap_semanage_user_compare2, METH_VARARGS, NULL},
 	 { (char *)"semanage_user_get_name", _wrap_semanage_user_get_name, METH_VARARGS, NULL},
 	 { (char *)"semanage_user_set_name", _wrap_semanage_user_set_name, METH_VARARGS, NULL},
+	 { (char *)"semanage_user_get_prefix", _wrap_semanage_user_get_prefix, METH_VARARGS, NULL},
+	 { (char *)"semanage_user_set_prefix", _wrap_semanage_user_set_prefix, METH_VARARGS, NULL},
 	 { (char *)"semanage_user_get_mlslevel", _wrap_semanage_user_get_mlslevel, METH_VARARGS, NULL},
 	 { (char *)"semanage_user_set_mlslevel", _wrap_semanage_user_set_mlslevel, METH_VARARGS, NULL},
 	 { (char *)"semanage_user_get_mlsrange", _wrap_semanage_user_get_mlsrange, METH_VARARGS, NULL},
diff -purN -x.svn Makefile Makefile
--- Makefile	2005-10-13 13:36:35.000000000 -0400
+++ Makefile	2006-01-19 15:46:30.000000000 -0500
@@ -1,4 +1,5 @@
 SUBDIRS=libsepol libselinux libsemanage checkpolicy policycoreutils # policy
+PYSUBDIRS=libselinux libsemanage
 
 ifeq ($(DEBUG),1)
 	export CFLAGS = -g3 -O0 -gdwarf-2 -fno-strict-aliasing -Wall -Wshadow
@@ -9,7 +10,11 @@ install relabel: 
 	@for subdir in $(SUBDIRS); do \
 		(cd $$subdir && $(MAKE) $@) || exit 1; \
 	done
-#	cd policy && make install-src
+
+install-pywrap:
+	@for subdir in $(PYSUBDIRS); do \
+		(cd $$subdir && $(MAKE) $@) || exit 1; \
+	done
 
 clean:
 	@for subdir in $(SUBDIRS); do \
diff -purN -x.svn policycoreutils/semanage/semanage policycoreutils/semanage/semanage
--- policycoreutils/semanage/semanage	2006-01-19 15:04:23.000000000 -0500
+++ policycoreutils/semanage/semanage	2006-01-19 15:11:06.000000000 -0500
@@ -24,9 +24,6 @@ import os, sys, getopt
 import seobject
 
 if __name__ == '__main__':
-	if os.getuid() > 0 or os.geteuid() > 0:
-		print "You must be root to run %s." % sys.argv[0]
-		sys.exit(0)
 
 	def usage(message = ""):
 		print '\
diff -purN -x.svn policycoreutils/semanage/seobject.py policycoreutils/semanage/seobject.py
--- policycoreutils/semanage/seobject.py	2006-01-19 15:04:23.000000000 -0500
+++ policycoreutils/semanage/seobject.py	2006-01-19 16:34:36.000000000 -0500
@@ -142,6 +142,11 @@ class setransRecords:
 class semanageRecords:
 	def __init__(self):
 		self.sh = semanage_handle_create()
+		rc = semanage_can_write(self.sh)
+		if rc:
+			semanage_handle_destroy(self.sh)
+			raise ValueError("Cannot write to policy directory.")
+
 		self.semanaged = semanage_is_managed(self.sh)
 		if self.semanaged:
 			semanage_connect(self.sh)

--=-lQ8TCibwI+MnDAXBn23z--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
