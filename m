Subject: Re: seobject_mls.patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1226071870.16320.58.camel@moss-spartans.epoch.ncsc.mil>
References: <4914545F.7050102@redhat.com>
	 <1226071870.16320.58.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-2IpD+Pa/EZpdnM2xAAWG"
Date: Fri, 07 Nov 2008 10:50:51 -0500
Message-Id: <1226073051.16320.66.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-2IpD+Pa/EZpdnM2xAAWG
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2008-11-07 at 10:31 -0500, Stephen Smalley wrote:
> On Fri, 2008-11-07 at 09:44 -0500, Daniel J Walsh wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > This patch might be somewhat controversial, it basically sets the
> > default for semanage to MLS mode when selinux is disabled.
> > 
> > System can not determine if the policy is MLS or not, so current default
> > is not, so semanage blows up on disabled machines.  A better long term
> > solution would be to add a interface to libsemanage to look at the
> > installed policy and decipher what the policy supports.
> 
> Yes, we need to migrate to testing for MLS enabled vs. disabled against
> a particular policy store.  Something like the following un-tested
> patch, and then you'd have to test semanage_mls_enabled(handle) after
> connecting to the store.

Oops, forgot to create the policydb.  Revised patch attached.

-- 
Stephen Smalley
National Security Agency

--=-2IpD+Pa/EZpdnM2xAAWG
Content-Disposition: attachment; filename=semanage_mls_enabled.diff
Content-Type: text/x-patch; name=semanage_mls_enabled.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

diff --git a/libsemanage/include/semanage/handle.h b/libsemanage/include/semanage/handle.h
index e065070..0123d1d 100644
--- a/libsemanage/include/semanage/handle.h
+++ b/libsemanage/include/semanage/handle.h
@@ -117,6 +117,9 @@ int semanage_access_check(semanage_handle_t * sh);
 /* returns 0 if not connected, 1 if connected */
 int semanage_is_connected(semanage_handle_t * sh);
 
+/* returns 1 if policy is MLS, 0 otherwise. */
+int semanage_mls_enabled(semanage_handle_t *sh);
+
 /* META NOTES
  *
  * For all functions a non-negative number indicates success. For some
diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 1732758..88f35a6 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -1050,3 +1050,22 @@ int semanage_direct_access_check(semanage_handle_t * sh)
 
 	return semanage_store_access_check(sh);
 }
+
+int semanage_direct_mls_enabled(semanage_handle_t * sh)
+{
+	sepol_policydb_t *p = NULL;
+	int retval;
+
+	retval = sepol_policydb_create(&p);
+	if (retval < 0)
+		goto cleanup;
+	
+	retval = semanage_read_policydb(sh, p);
+	if (retval < 0)
+		goto cleanup;
+
+	retval = sepol_policydb_mls_enabled(p);
+cleanup:
+	sepol_policydb_free(p);
+	return retval;
+}
diff --git a/libsemanage/src/direct_api.h b/libsemanage/src/direct_api.h
index 8f625f5..ffd428e 100644
--- a/libsemanage/src/direct_api.h
+++ b/libsemanage/src/direct_api.h
@@ -37,4 +37,6 @@ int semanage_direct_is_managed(struct semanage_handle *sh);
 
 int semanage_direct_access_check(struct semanage_handle *sh);
 
+int semanage_direct_mls_enabled(struct semanage_handle *sh);
+
 #endif
diff --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c
index b94db11..95e10c1 100644
--- a/libsemanage/src/handle.c
+++ b/libsemanage/src/handle.c
@@ -157,6 +157,20 @@ int semanage_is_managed(semanage_handle_t * sh)
 	return -1;
 }
 
+int semanage_mls_enabled(semanage_handle_t * sh)
+{
+	assert(sh != NULL);
+	switch (sh->conf->store_type) {
+	case SEMANAGE_CON_DIRECT:
+		return semanage_direct_mls_enabled(sh);
+	default:
+		ERR(sh,
+		    "The connection type specified within your semanage.conf file has not been implemented yet.");
+		/* fall through */
+	}
+	return -1;
+}
+
 int semanage_connect(semanage_handle_t * sh)
 {
 	assert(sh != NULL);
diff --git a/libsemanage/src/libsemanage.map b/libsemanage/src/libsemanage.map
index 56a83f0..ae11ade 100644
--- a/libsemanage/src/libsemanage.map
+++ b/libsemanage/src/libsemanage.map
@@ -14,5 +14,6 @@ LIBSEMANAGE_1.0 {
 	  semanage_node_*;
 	  semanage_fcontext_*; semanage_access_check; semanage_set_create_store;
 	  semanage_is_connected; semanage_set_disable_dontaudit;
+	  semanage_mls_enabled;
   local: *;
 };
diff --git a/libsemanage/src/semanage.py b/libsemanage/src/semanage.py
index 6a2327a..56e5a14 100644
--- a/libsemanage/src/semanage.py
+++ b/libsemanage/src/semanage.py
@@ -76,6 +76,7 @@ SEMANAGE_CAN_READ = _semanage.SEMANAGE_CAN_READ
 SEMANAGE_CAN_WRITE = _semanage.SEMANAGE_CAN_WRITE
 semanage_access_check = _semanage.semanage_access_check
 semanage_is_connected = _semanage.semanage_is_connected
+semanage_mls_enabled = _semanage.semanage_mls_enabled
 semanage_module_install = _semanage.semanage_module_install
 semanage_module_upgrade = _semanage.semanage_module_upgrade
 semanage_module_install_base = _semanage.semanage_module_install_base
diff --git a/libsemanage/src/semanageswig_wrap.c b/libsemanage/src/semanageswig_wrap.c
index 86736b0..afa3dc2 100644
--- a/libsemanage/src/semanageswig_wrap.c
+++ b/libsemanage/src/semanageswig_wrap.c
@@ -3400,6 +3400,28 @@ fail:
 }
 
 
+SWIGINTERN PyObject *_wrap_semanage_mls_enabled(PyObject *SWIGUNUSEDPARM(self), PyObject *args) {
+  PyObject *resultobj = 0;
+  semanage_handle_t *arg1 = (semanage_handle_t *) 0 ;
+  int result;
+  void *argp1 = 0 ;
+  int res1 = 0 ;
+  PyObject * obj0 = 0 ;
+  
+  if (!PyArg_ParseTuple(args,(char *)"O:semanage_mls_enabled",&obj0)) SWIG_fail;
+  res1 = SWIG_ConvertPtr(obj0, &argp1,SWIGTYPE_p_semanage_handle, 0 |  0 );
+  if (!SWIG_IsOK(res1)) {
+    SWIG_exception_fail(SWIG_ArgError(res1), "in method '" "semanage_mls_enabled" "', argument " "1"" of type '" "semanage_handle_t *""'"); 
+  }
+  arg1 = (semanage_handle_t *)(argp1);
+  result = (int)semanage_mls_enabled(arg1);
+  resultobj = SWIG_From_int((int)(result));
+  return resultobj;
+fail:
+  return NULL;
+}
+
+
 SWIGINTERN PyObject *_wrap_semanage_module_install(PyObject *SWIGUNUSEDPARM(self), PyObject *args) {
   PyObject *resultobj = 0;
   semanage_handle_t *arg1 = (semanage_handle_t *) 0 ;
@@ -11391,6 +11413,7 @@ static PyMethodDef SwigMethods[] = {
 	 { (char *)"semanage_commit", _wrap_semanage_commit, METH_VARARGS, NULL},
 	 { (char *)"semanage_access_check", _wrap_semanage_access_check, METH_VARARGS, NULL},
 	 { (char *)"semanage_is_connected", _wrap_semanage_is_connected, METH_VARARGS, NULL},
+	 { (char *)"semanage_mls_enabled", _wrap_semanage_mls_enabled, METH_VARARGS, NULL},
 	 { (char *)"semanage_module_install", _wrap_semanage_module_install, METH_VARARGS, NULL},
 	 { (char *)"semanage_module_upgrade", _wrap_semanage_module_upgrade, METH_VARARGS, NULL},
 	 { (char *)"semanage_module_install_base", _wrap_semanage_module_install_base, METH_VARARGS, NULL},

--=-2IpD+Pa/EZpdnM2xAAWG--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
