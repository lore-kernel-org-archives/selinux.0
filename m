Subject: Re: [PATCH] libsemanage/semanage - permission check for semanage
From: Joshua Brindle <jbrindle@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux List <SELinux@tycho.nsa.gov>, selinuxdev <selinux-dev@tresys.com>
In-Reply-To: <1137770413.3648.140.camel@moss-spartans.epoch.ncsc.mil>
References: <1137707155.17672.2.camel@twoface.columbia.tresys.com>
	 <1137770413.3648.140.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-wvTRfN7Mgb5TRKnXS7qZ"
Date: Fri, 20 Jan 2006 14:14:59 -0500
Message-Id: <1137784500.31152.6.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-wvTRfN7Mgb5TRKnXS7qZ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2006-01-20 at 10:20 -0500, Stephen Smalley wrote:
> On Thu, 2006-01-19 at 16:45 -0500, Joshua Brindle wrote:
> > - make the bottom level Makefile propagate install-pywrap target
> > - make install-pywrap target in libselinux depend on pywrap
> > 
> > 
> > It appears that the last commit didn't have make swigify run in
> > libsemanage so the generated swig wrappers were out of date, the ones in
> > this patch include my changes as well as the last ones.
> 
> Merged the pywrap Makefile changes and regenerated the wrappers for the
> prior changes.
> 

attached patch addresses all of the concerns with the prior patch. The
main change is to make a function called semanage_access_check that
returns error, existance, readable or writable. Depending on where the
check is done test against one of them. 

I am now able to query the store as a non-root user after giving read
access to /modules and /modules/active{,/*} and read/write to
modules/semanage.read.LOCK

as expected I can query the store but not write to it, I also added a
check for writability at the beginning of begin_transaction so that the
user gets a nicer error when this happens.

--=-wvTRfN7Mgb5TRKnXS7qZ
Content-Disposition: attachment; filename=1-semanage-write-check.diff
Content-Type: text/x-patch; name=1-semanage-write-check.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -purN -x.svn libsemanage/include/semanage/handle.h libsemanage/include/semanage/handle.h
--- libsemanage/include/semanage/handle.h	2006-01-18 11:54:04.000000000 -0500
+++ libsemanage/include/semanage/handle.h	2006-01-20 09:43:33.000000000 -0500
@@ -100,6 +100,12 @@ int semanage_begin_transaction(semanage_
  */
 int semanage_commit(semanage_handle_t *);
 
+#define SEMANAGE_CAN_READ 1
+#define SEMANAGE_CAN_WRITE 2
+/* returns SEMANAGE_CAN_READ or SEMANAGE_CAN_WRITE if the store is readable
+ * or writable, respectively. <0 if an error occured */ 
+int semanage_access_check(semanage_handle_t *sh);
+
 /* META NOTES
  *
  * For all functions a non-negative number indicates success. For some
diff -purN -x.svn libsemanage/src/direct_api.c libsemanage/src/direct_api.c
--- libsemanage/src/direct_api.c	2006-01-18 11:56:33.000000000 -0500
+++ libsemanage/src/direct_api.c	2006-01-20 11:34:14.000000000 -0500
@@ -82,7 +82,7 @@ int semanage_direct_is_managed(semanage_
 	if (semanage_check_init(polpath))
 		goto err;
 
-	if (semanage_create_store(sh, 0) < 0) 
+	if (semanage_access_check(sh) < 0) 
 		return 0;
 
 	return 1;
@@ -102,7 +102,7 @@ int semanage_direct_connect(semanage_han
 	if (semanage_check_init(polpath))
 		goto err;
 
-	if (semanage_create_store(sh, 1) < 0) 
+	if (semanage_access_check(sh) < SEMANAGE_CAN_READ) 
 		goto err;
 
 	sh->u.direct.translock_file_fd = -1;
@@ -226,6 +226,10 @@ static int semanage_direct_disconnect(se
 }
 
 static int semanage_direct_begintrans(semanage_handle_t *sh) {
+	
+	if (semanage_access_check(sh) != SEMANAGE_CAN_WRITE) {
+		return -1;
+	}
 	if (semanage_get_trans_lock(sh) < 0) {
 		return -1;
 	}
@@ -775,3 +779,14 @@ static int semanage_direct_list(semanage
         }
 	return retval;
 }
+
+int semanage_direct_access_check(semanage_handle_t *sh) {
+	char polpath[PATH_MAX];	
+
+	snprintf(polpath, PATH_MAX, "%s%s", selinux_path(), sh->conf->store_path);
+
+	if (semanage_check_init(polpath))
+		return -1;
+
+	return semanage_store_access_check(sh);
+}
diff -purN -x.svn libsemanage/src/direct_api.h libsemanage/src/direct_api.h
--- libsemanage/src/direct_api.h	2006-01-18 11:56:33.000000000 -0500
+++ libsemanage/src/direct_api.h	2006-01-20 09:29:06.000000000 -0500
@@ -37,4 +37,6 @@ int semanage_direct_connect(
 int semanage_direct_is_managed(
 	struct semanage_handle *sh);
 
+int semanage_direct_access_check(struct semanage_handle *sh);
+
 #endif
diff -purN -x.svn libsemanage/src/handle.c libsemanage/src/handle.c
--- libsemanage/src/handle.c	2006-01-18 11:56:33.000000000 -0500
+++ libsemanage/src/handle.c	2006-01-20 09:26:57.000000000 -0500
@@ -142,6 +142,19 @@ int semanage_connect(semanage_handle_t *
 	return 0;
 }
 
+int semanage_access_check(semanage_handle_t *sh) {
+	assert(sh != NULL);
+	switch (sh->conf->store_type) {
+	case SEMANAGE_CON_DIRECT: 
+		return semanage_direct_access_check(sh);
+	default:
+		return -1;
+	}
+
+	return -1; /* unreachable */
+}
+hidden_def(semanage_access_check)
+
 int semanage_disconnect(semanage_handle_t *sh) {
 	assert(sh != NULL && sh->funcs != NULL && sh->funcs->disconnect != NULL);
 	if (!sh->is_connected) {
diff -purN -x.svn libsemanage/src/handle_internal.h libsemanage/src/handle_internal.h
--- libsemanage/src/handle_internal.h	2006-01-18 11:56:33.000000000 -0500
+++ libsemanage/src/handle_internal.h	2006-01-20 09:29:19.000000000 -0500
@@ -7,5 +7,6 @@
 hidden_proto(semanage_begin_transaction)
 hidden_proto(semanage_handle_destroy)
 hidden_proto(semanage_reload_policy)
+hidden_proto(semanage_access_check)
 
 #endif
diff -purN -x.svn libsemanage/src/libsemanage.map libsemanage/src/libsemanage.map
--- libsemanage/src/libsemanage.map	2006-01-18 11:56:33.000000000 -0500
+++ libsemanage/src/libsemanage.map	2006-01-20 09:27:13.000000000 -0500
@@ -11,6 +11,6 @@ LIBSEMANAGE_1.0 {
 	  semanage_reload_policy; semanage_set_reload; semanage_set_rebuild;
 	  semanage_user_*; semanage_bool_*; semanage_seuser_*;
 	  semanage_iface_*; semanage_port_*; semanage_context_*;
-	  semanage_fcontext_*;
+	  semanage_fcontext_*; semanage_access_check;
   local: *;
 };
diff -purN -x.svn libsemanage/src/semanage.py libsemanage/src/semanage.py
--- libsemanage/src/semanage.py	2006-01-20 11:30:59.000000000 -0500
+++ libsemanage/src/semanage.py	2006-01-20 11:42:19.000000000 -0500
@@ -87,6 +87,10 @@ semanage_disconnect = _semanage.semanage
 semanage_begin_transaction = _semanage.semanage_begin_transaction
 
 semanage_commit = _semanage.semanage_commit
+SEMANAGE_CAN_READ = _semanage.SEMANAGE_CAN_READ
+SEMANAGE_CAN_WRITE = _semanage.SEMANAGE_CAN_WRITE
+
+semanage_access_check = _semanage.semanage_access_check
 
 semanage_module_install = _semanage.semanage_module_install
 
diff -purN -x.svn libsemanage/src/semanage_store.c libsemanage/src/semanage_store.c
--- libsemanage/src/semanage_store.c	2006-01-18 11:56:33.000000000 -0500
+++ libsemanage/src/semanage_store.c	2006-01-20 11:28:36.000000000 -0500
@@ -281,7 +281,54 @@ int semanage_create_store(semanage_handl
 	return 0;
 }
 
+/* returns <0 if the active store cannot be read or doesn't exist
+ * 0 if the store exists but the lock file cannot be written to
+ * SEMANAGE_CAN_READ if the store can be read and the lock file written to
+ * SEMANAGE_CAN_WRITE if the modules directory and binary policy dir can be written to
+ */
+int semanage_store_access_check(semanage_handle_t *sh) {
+	const char *path;
+	char *path2, *path3;
+	int rc = -1;
+
+	/* read access on active store */
+	path = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_TOPLEVEL);
+	if (access(path, R_OK | X_OK) != 0)
+		goto out;
+
+	/* we can read the active store meaning it is managed
+	 * so now we return 0 to indicate no error */
+	rc = 0;
+
+	/* read/write access on lock file required for reading */
+	path = semanage_files[SEMANAGE_READ_LOCK];
+	if (access(path, R_OK | W_OK) != 0)
+		goto out;
+
+	/* everything needed for reading has been checked */
+	rc = SEMANAGE_CAN_READ;
+
+	/* check the modules directory */
+	path = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_MODULES);
+	if (access(path, R_OK | W_OK | X_OK) != 0)
+		goto out;
+
+	/* check the binary policy install directory */
+	path = selinux_binary_policy_path();
+	path2 = strdup(path);
+	path3 = dirname(path2);
+
+	if ((access(path3, R_OK | W_OK | X_OK)) != 0) {
+		free(path2);
+		goto out;
+	}
+	free(path2);
+	
+	rc = SEMANAGE_CAN_WRITE;
 
+out:
+	return rc;
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
--- libsemanage/src/semanageswig_wrap.c	2006-01-20 11:30:59.000000000 -0500
+++ libsemanage/src/semanageswig_wrap.c	2006-01-20 11:42:19.000000000 -0500
@@ -2398,6 +2398,26 @@ static PyObject *_wrap_semanage_commit(P
 }
 
 
+static PyObject *_wrap_semanage_access_check(PyObject *self, PyObject *args) {
+    PyObject *resultobj;
+    semanage_handle_t *arg1 = (semanage_handle_t *) 0 ;
+    int result;
+    PyObject * obj0 = 0 ;
+    
+    if(!PyArg_ParseTuple(args,(char *)"O:semanage_access_check",&obj0)) goto fail;
+    SWIG_Python_ConvertPtr(obj0, (void **)&arg1, SWIGTYPE_p_semanage_handle, SWIG_POINTER_EXCEPTION | 0);
+    if (SWIG_arg_fail(1)) SWIG_fail;
+    result = (int)semanage_access_check(arg1);
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
@@ -7472,6 +7492,7 @@ static PyMethodDef SwigMethods[] = {
 	 { (char *)"semanage_disconnect", _wrap_semanage_disconnect, METH_VARARGS, NULL},
 	 { (char *)"semanage_begin_transaction", _wrap_semanage_begin_transaction, METH_VARARGS, NULL},
 	 { (char *)"semanage_commit", _wrap_semanage_commit, METH_VARARGS, NULL},
+	 { (char *)"semanage_access_check", _wrap_semanage_access_check, METH_VARARGS, NULL},
 	 { (char *)"semanage_module_install", _wrap_semanage_module_install, METH_VARARGS, NULL},
 	 { (char *)"semanage_module_upgrade", _wrap_semanage_module_upgrade, METH_VARARGS, NULL},
 	 { (char *)"semanage_module_install_base", _wrap_semanage_module_install_base, METH_VARARGS, NULL},
@@ -8139,6 +8160,12 @@ SWIGEXPORT(void) SWIG_init(void) {
         PyDict_SetItemString(d,"SEMANAGE_CON_POLSERV_REMOTE", SWIG_From_int((int)(SEMANAGE_CON_POLSERV_REMOTE))); 
     }
     {
+        PyDict_SetItemString(d,"SEMANAGE_CAN_READ", SWIG_From_int((int)(1))); 
+    }
+    {
+        PyDict_SetItemString(d,"SEMANAGE_CAN_WRITE", SWIG_From_int((int)(2))); 
+    }
+    {
         PyDict_SetItemString(d,"SEMANAGE_PROTO_UDP", SWIG_From_int((int)(0))); 
     }
     {
diff -purN -x.svn policycoreutils/semanage/semanage policycoreutils/semanage/semanage
--- policycoreutils/semanage/semanage	2006-01-20 11:31:07.000000000 -0500
+++ policycoreutils/semanage/semanage	2006-01-20 11:37:33.000000000 -0500
@@ -24,9 +24,6 @@ import os, sys, getopt
 import seobject
 
 if __name__ == '__main__':
-	if os.getuid() > 0 or os.geteuid() > 0:
-		print "You must be root to run %s." % sys.argv[0]
-		sys.exit(0)
 
 	def usage(message = ""):
 		print '\
diff -purN -x.svn policycoreutils/semanage/seobject.py policycoreutils/semanage/seobject.py
--- policycoreutils/semanage/seobject.py	2006-01-20 11:31:07.000000000 -0500
+++ policycoreutils/semanage/seobject.py	2006-01-20 11:47:39.000000000 -0500
@@ -143,10 +143,19 @@ class semanageRecords:
 	def __init__(self):
 		self.sh = semanage_handle_create()
 		self.semanaged = semanage_is_managed(self.sh)
-		if self.semanaged:
-			rc = semanage_connect(self.sh)
-			if rc < 0:
-				raise ValueError("Could not establish semanage connection")
+		if not self.semanaged:
+			semanage_handle_destroy(self.sh)
+			raise ValueError("SELinux policy is not managed.")
+
+		rc = semanage_access_check(self.sh)
+		if rc < SEMANAGE_CAN_READ:
+			semanage_handle_destroy(self.sh)
+			raise ValueError("Cannot read policy store.")
+
+		rc = semanage_connect(self.sh)
+		if rc < 0:
+			semanage_handle_destroy(self.sh)
+			raise ValueError("Could not establish semanage connection")
 
 class loginRecords(semanageRecords):
 	def __init__(self):

--=-wvTRfN7Mgb5TRKnXS7qZ--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
