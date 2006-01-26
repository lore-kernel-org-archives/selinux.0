Subject: Re: [PATCH] libsemanage/semanage - permission check for semanage
From: Joshua Brindle <jbrindle@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux List <SELinux@tycho.nsa.gov>,
   selinuxdev <selinux-dev@tresys.com>
In-Reply-To: <1138033134.20815.107.camel@moss-spartans.epoch.ncsc.mil>
References: <1137707155.17672.2.camel@twoface.columbia.tresys.com>
	 <1137770413.3648.140.camel@moss-spartans.epoch.ncsc.mil>
	 <1137784500.31152.6.camel@twoface.columbia.tresys.com>
	 <1137790181.3648.250.camel@moss-spartans.epoch.ncsc.mil>
	 <43D1553B.3090701@tresys.com>
	 <1138026975.20815.62.camel@moss-spartans.epoch.ncsc.mil>
	 <43D4ED7A.3090805@tresys.com>
	 <1138030160.20815.97.camel@moss-spartans.epoch.ncsc.mil>
	 <43D4F8DD.30705@tresys.com>
	 <1138031978.20815.103.camel@moss-spartans.epoch.ncsc.mil>
	 <43D4FEBF.6020309@tresys.com>
	 <1138033134.20815.107.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-IRkXTPNqOwkBWBfhJL5Z"
Date: Thu, 26 Jan 2006 15:40:20 -0500
Message-Id: <1138308020.26199.5.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-IRkXTPNqOwkBWBfhJL5Z
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2006-01-23 at 11:18 -0500, Stephen Smalley wrote:
> On Mon, 2006-01-23 at 11:05 -0500, Joshua Brindle wrote:
> > Stephen Smalley wrote:
> > > On Mon, 2006-01-23 at 10:40 -0500, Joshua Brindle wrote:
> > > 
> > >>speaking of the create_store code path, That function is no longer in 
> > >>use and it was primarily used for bootstrapping non-managed systems so I 
> > >>didn't remove it yet but we can probably just require the package 
> > >>manager or make scripts to initialize the store and remove this from the 
> > >>library entirely.
> > > 
> > > 
> > > Hmm...I missed that side effect.  Moving aside my module store and
> > > trying to re-install the base module from /usr/share/selinux does indeed
> > > fail against the new libsemanage (upon connect).  So the policy package
> > > would have to pre-create the directory tree and the lock files so that
> > > the connect could succeed?  I'm not sure that is truly what we want.
> > > 
> > 
> > before it was implicitly happening if it didn't exist (which will now 
> > result in an 'unmanaged system' return which should tell the client not 
> > call connect and therefore not initialize the store (i love bootstrap 
> > issues btw). I'm alright with making an explicit option to initialize it 
> > via semanage or semodule (preferably semodule).. would this be better?
> 
> Why do we want changed behavior upon _connect at all?  Why not leave
> connect alone (i.e. still call create_store(...,1) there), and just
> change clients as desired to call access_check() when you don't want
> such bootstrapping (which it seems is desirable as the default for
> semodule -b)?

This patch adds semanage_set_create_store which is callable by the
client to create the store. Set to 1 by semodule when called with -b.
Otherwise the same access checks as before are done.

Also adds semanage_is_connected to avoid an assertion failure in
semodule if an error occurs before connecting.

--=-IRkXTPNqOwkBWBfhJL5Z
Content-Disposition: attachment; filename=1-semanage-write-check.diff
Content-Type: text/x-patch; name=1-semanage-write-check.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -x.svn -pruN libsemanage/include/semanage/handle.h libsemanage/include/semanage/handle.h
--- libsemanage/include/semanage/handle.h	2006-01-18 11:54:04.000000000 -0500
+++ libsemanage/include/semanage/handle.h	2006-01-26 15:35:51.000000000 -0500
@@ -64,6 +64,11 @@ void semanage_set_reload(semanage_handle
  * 1 for yes, 0 for no (default) */
 void semanage_set_rebuild(semanage_handle_t *handle, int do_rebuild);
 
+/* create the store if it does not exist, this only has an effect on 
+ * direct connections and must be called before semanage_connect 
+ * 1 for yes, 0 for no (default) */
+void semanage_set_create_store(semanage_handle_t *handle, int create_store);
+
 /* Check whether policy is managed via libsemanage on this system.
  * Must be called prior to trying to connect.
  * Return 1 if policy is managed via libsemanage on this system,
@@ -100,6 +105,15 @@ int semanage_begin_transaction(semanage_
  */
 int semanage_commit(semanage_handle_t *);
 
+#define SEMANAGE_CAN_READ 1
+#define SEMANAGE_CAN_WRITE 2
+/* returns SEMANAGE_CAN_READ or SEMANAGE_CAN_WRITE if the store is readable
+ * or writable, respectively. <0 if an error occured */ 
+int semanage_access_check(semanage_handle_t *sh);
+
+/* returns 0 if not connected, 1 if connected */
+int semanage_is_connected(semanage_handle_t *sh);
+
 /* META NOTES
  *
  * For all functions a non-negative number indicates success. For some
diff -x.svn -pruN libsemanage/src/direct_api.c libsemanage/src/direct_api.c
--- libsemanage/src/direct_api.c	2006-01-18 11:56:33.000000000 -0500
+++ libsemanage/src/direct_api.c	2006-01-26 14:55:44.000000000 -0500
@@ -82,7 +82,7 @@ int semanage_direct_is_managed(semanage_
 	if (semanage_check_init(polpath))
 		goto err;
 
-	if (semanage_create_store(sh, 0) < 0) 
+	if (semanage_access_check(sh) < 0) 
 		return 0;
 
 	return 1;
@@ -102,7 +102,11 @@ int semanage_direct_connect(semanage_han
 	if (semanage_check_init(polpath))
 		goto err;
 
-	if (semanage_create_store(sh, 1) < 0) 
+	if (sh->create_store)
+		if (semanage_create_store(sh, 1))
+			goto err;
+
+	if (semanage_access_check(sh) < SEMANAGE_CAN_READ) 
 		goto err;
 
 	sh->u.direct.translock_file_fd = -1;
@@ -226,6 +230,10 @@ static int semanage_direct_disconnect(se
 }
 
 static int semanage_direct_begintrans(semanage_handle_t *sh) {
+	
+	if (semanage_access_check(sh) != SEMANAGE_CAN_WRITE) {
+		return -1;
+	}
 	if (semanage_get_trans_lock(sh) < 0) {
 		return -1;
 	}
@@ -775,3 +783,14 @@ static int semanage_direct_list(semanage
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
diff -x.svn -pruN libsemanage/src/direct_api.h libsemanage/src/direct_api.h
--- libsemanage/src/direct_api.h	2006-01-18 11:56:33.000000000 -0500
+++ libsemanage/src/direct_api.h	2006-01-20 09:29:06.000000000 -0500
@@ -37,4 +37,6 @@ int semanage_direct_connect(
 int semanage_direct_is_managed(
 	struct semanage_handle *sh);
 
+int semanage_direct_access_check(struct semanage_handle *sh);
+
 #endif
diff -x.svn -pruN libsemanage/src/handle.c libsemanage/src/handle.c
--- libsemanage/src/handle.c	2006-01-18 11:56:33.000000000 -0500
+++ libsemanage/src/handle.c	2006-01-26 14:55:44.000000000 -0500
@@ -64,6 +64,9 @@ semanage_handle_t *semanage_handle_creat
 	/* By default always reload policy after commit if SELinux is enabled. */
 	sh->do_reload = (is_selinux_enabled() > 0);
 
+	/* By default do not create store */
+	sh->create_store = 0;
+
 	/* Set timeout: some default value for now, later use config */
 	sh->timeout = SEMANAGE_COMMIT_READ_WAIT; 
 
@@ -94,6 +97,19 @@ void semanage_set_reload(semanage_handle
 	return;
 }
 
+void semanage_set_create_store(semanage_handle_t *sh, int create_store) {
+	
+	assert(sh != NULL);
+
+	sh->create_store = create_store;
+	return;
+}
+
+int semanage_is_connected(semanage_handle_t *sh) {
+	assert(sh != NULL);
+	return sh->is_connected;
+}
+
 void semanage_select_store(semanage_handle_t *sh, char *storename,
 			  enum semanage_connect_type storetype) {
 	
@@ -142,6 +158,19 @@ int semanage_connect(semanage_handle_t *
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
diff -x.svn -pruN libsemanage/src/handle.h libsemanage/src/handle.h
--- libsemanage/src/handle.h	2006-01-18 11:56:33.000000000 -0500
+++ libsemanage/src/handle.h	2006-01-26 14:55:44.000000000 -0500
@@ -63,6 +63,8 @@ struct semanage_handle {
 	int do_reload;		/* whether to reload policy after commit */
 	int do_rebuild;		/* whether to rebuild policy if there were no changes */
 	int modules_modified;
+	int create_store;	/* whether to create the store if it does not exist
+				 * this will only have an effect on direct connections */
 
 	/* This timeout is used for transactions and waiting for lock
 	   -1 means wait indefinetely
diff -x.svn -pruN libsemanage/src/handle_internal.h libsemanage/src/handle_internal.h
--- libsemanage/src/handle_internal.h	2006-01-18 11:56:33.000000000 -0500
+++ libsemanage/src/handle_internal.h	2006-01-20 09:29:19.000000000 -0500
@@ -7,5 +7,6 @@
 hidden_proto(semanage_begin_transaction)
 hidden_proto(semanage_handle_destroy)
 hidden_proto(semanage_reload_policy)
+hidden_proto(semanage_access_check)
 
 #endif
diff -x.svn -pruN libsemanage/src/libsemanage.map libsemanage/src/libsemanage.map
--- libsemanage/src/libsemanage.map	2006-01-18 11:56:33.000000000 -0500
+++ libsemanage/src/libsemanage.map	2006-01-26 14:55:44.000000000 -0500
@@ -11,6 +11,7 @@ LIBSEMANAGE_1.0 {
 	  semanage_reload_policy; semanage_set_reload; semanage_set_rebuild;
 	  semanage_user_*; semanage_bool_*; semanage_seuser_*;
 	  semanage_iface_*; semanage_port_*; semanage_context_*;
-	  semanage_fcontext_*;
+	  semanage_fcontext_*; semanage_access_check; semanage_set_create_store;
+	  semanage_is_connected;
   local: *;
 };
diff -x.svn -pruN libsemanage/src/semanage.py libsemanage/src/semanage.py
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
 
diff -x.svn -pruN libsemanage/src/semanage_store.c libsemanage/src/semanage_store.c
--- libsemanage/src/semanage_store.c	2006-01-18 11:56:33.000000000 -0500
+++ libsemanage/src/semanage_store.c	2006-01-26 14:55:44.000000000 -0500
@@ -221,6 +221,8 @@ int semanage_create_store(semanage_handl
 	struct stat sb;
 	int mode_mask = R_OK | W_OK | X_OK;
 	const char *path = semanage_files[SEMANAGE_ROOT];
+	int fd;
+
 	if (stat(path, &sb) == -1) {
 		if (errno == ENOENT && create) {
 			if (mkdir(path, S_IRWXU) == -1) {
@@ -278,10 +280,76 @@ int semanage_create_store(semanage_handl
 			return -1;
 		}
 	}
+	path = semanage_files[SEMANAGE_READ_LOCK];
+	if (stat (path, &sb) == -1) {
+		if (errno == ENOENT && create) {
+			if ((fd = creat(path, S_IRUSR | S_IWUSR)) == -1) {
+				ERR(sh, "Could not create lock file at %s.", path);
+				return -2;
+			}
+		}
+		else {
+			ERR(sh, "Could not read lock file at %s.", path);
+			return -1;
+		}
+	}
+	else {
+		if (!S_ISREG(sb.st_mode) || access(path, R_OK | W_OK) == -1) {
+			ERR(sh, "Could not access lock file at %s.", path);
+			return -1;
+		}
+	}
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
+
+out:
+	return rc;
+}
 
 /********************* other I/O functions *********************/
 
diff -x.svn -pruN libsemanage/src/semanage_store.h libsemanage/src/semanage_store.h
--- libsemanage/src/semanage_store.h	2006-01-18 11:56:33.000000000 -0500
+++ libsemanage/src/semanage_store.h	2006-01-19 15:11:05.000000000 -0500
@@ -99,5 +99,6 @@ int semanage_verify_modules(
 int semanage_verify_linked(semanage_handle_t *sh);
 int semanage_verify_kernel(semanage_handle_t *sh);
 int semanage_split_fc(semanage_handle_t *sh);
+int semanage_store_writable(semanage_handle_t *sh);
 
 #endif
diff -x.svn -pruN libsemanage/src/semanageswig_wrap.c libsemanage/src/semanageswig_wrap.c
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
diff -x.svn -pruN policycoreutils/semanage/semanage policycoreutils/semanage/semanage
--- policycoreutils/semanage/semanage	2006-01-26 14:52:07.000000000 -0500
+++ policycoreutils/semanage/semanage	2006-01-26 14:54:10.000000000 -0500
@@ -24,9 +24,6 @@ import os, sys, getopt
 import seobject
 
 if __name__ == '__main__':
-	if os.getuid() > 0 or os.geteuid() > 0:
-		print "You must be root to run %s." % sys.argv[0]
-		sys.exit(0)
 
 	def usage(message = ""):
 		print '\
diff -x.svn -pruN policycoreutils/semanage/seobject.py policycoreutils/semanage/seobject.py
--- policycoreutils/semanage/seobject.py	2006-01-20 11:31:07.000000000 -0500
+++ policycoreutils/semanage/seobject.py	2006-01-26 15:11:45.000000000 -0500
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
+			raise ValueError("SELinux policy is not managed or store cannot be accessed.")
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
diff -x.svn -pruN policycoreutils/semodule/semodule.c policycoreutils/semodule/semodule.c
--- policycoreutils/semodule/semodule.c	2006-01-06 10:02:34.000000000 -0500
+++ policycoreutils/semodule/semodule.c	2006-01-26 15:11:45.000000000 -0500
@@ -41,6 +41,7 @@ static int num_commands = 0;
 static int verbose;
 static int reload;
 static int no_reload;
+static int create_store;
 static int build;
 
 static semanage_handle_t *sh = NULL;
@@ -169,9 +170,10 @@ static void parse_command_line(int argc,
         verbose = 0;
 	reload = 0;
 	no_reload = 0;
+	create_store = 0;
         while ((i = getopt_long(argc, argv, "s:b:hi:lvqr:u:RnB", opts, NULL)) != -1) {
                 switch (i) {
-                case 'b': set_mode(BASE_M, optarg); break;
+                case 'b': set_mode(BASE_M, optarg); create_store = 1; break;
                 case 'h': usage(argv[0]); exit(0);
                 case 'i': set_mode(INSTALL_M, optarg); break;
                 case 'l': set_mode(LIST_M, NULL); break;
@@ -233,6 +235,21 @@ int main(int argc, char *argv[]) {
 		 * location */
 		semanage_select_store(sh, store, SEMANAGE_CON_DIRECT);
 	}
+	
+	/* if installing base module create store if necessary, for bootstrapping */
+	semanage_set_create_store(sh, create_store);
+	
+	if (!create_store) {
+		if (!semanage_is_managed(sh)) {
+			fprintf(stderr, "%s: SELinux policy is not managed or store cannot be accessed.\n", argv[0]);
+			goto cleanup;
+		}
+	
+		if (semanage_access_check(sh) < SEMANAGE_CAN_READ) {
+			fprintf(stderr, "%s: Cannot read policy store.\n", argv[0]);
+			goto cleanup;
+		}
+	}
 
         if ((result = semanage_connect(sh)) < 0) {
                 fprintf(stderr, "%s:  Could not connect to policy handler\n", argv[0]);
@@ -359,9 +376,11 @@ int main(int argc, char *argv[]) {
         status = EXIT_SUCCESS;
 
  cleanup:
-        if (semanage_disconnect(sh) < 0) {
-		fprintf(stderr, "%s:  Error disconnecting\n", argv[0]);
-        }
+	if (semanage_is_connected(sh)) {
+	        if (semanage_disconnect(sh) < 0) {
+			fprintf(stderr, "%s:  Error disconnecting\n", argv[0]);
+		}
+	}
         semanage_handle_destroy(sh);
         cleanup();
         exit(status);

--=-IRkXTPNqOwkBWBfhJL5Z--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
