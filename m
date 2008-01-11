Message-ID: <4787936A.8030803@redhat.com>
Date: Fri, 11 Jan 2008 11:03:54 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Patch to add python audit2why bindings.
Content-Type: multipart/mixed;
 boundary="------------000601000502070807050009"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000601000502070807050009
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Updated policycoreutils will be coming to take advantage of these bindings.

setroubleshoot will also.

import selinux

will work the way it always did, but now you can execute

import selinux.audit2allow as audit2allow

audit2allow.init()

for i in avc:
	print audit2allow.analyze(i.scon, i,tcon, i,class, i.access)

audit2allow.finish()

And get the reason for the AVC.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkeHk2kACgkQrlYvE4MpobPJHACgqRs9BJ9tKwYSQJUR+AjjqXIF
7foAoLcHRAbEE4GAr9DFWopttFOqd/ra
=rrAB
-----END PGP SIGNATURE-----

--------------000601000502070807050009
Content-Type: text/plain;
 name="libselinux-audit2why.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-audit2why.patch"

--- nsalibselinux/src/Makefile	2007-09-26 19:37:45.000000000 -0400
+++ libselinux-2.0.46/src/Makefile	2008-01-11 10:51:06.000000000 -0500
@@ -18,6 +18,7 @@
 SWIGSO=_selinux.so
 SWIGFILES=$(SWIGSO) selinux.py 
 LIBSO=$(TARGET).$(LIBVERSION)
+AUDIT2WHYSO=audit2why.so
 
 ifeq ($(DISABLE_AVC),y)
 	UNUSED_SRCS+=avc.c avc_internal.c avc_sidtab.c mapping.c stringrep.c checkAccess.c
@@ -28,7 +29,7 @@
 ifeq ($(DISABLE_RPM),y)
 	UNUSED_SRCS+=rpm.c
 endif
-SRCS= $(filter-out $(UNUSED_SRCS), $(filter-out $(SWIGCOUT),$(wildcard *.c)))
+SRCS= $(filter-out $(UNUSED_SRCS), $(filter-out audit2why.c $(SWIGCOUT),$(wildcard *.c)))
 
 OBJS= $(patsubst %.c,%.o,$(SRCS))
 LOBJS= $(patsubst %.c,%.lo,$(SRCS))
@@ -47,7 +48,7 @@
 
 all: $(LIBA) $(LIBSO) 
 
-pywrap: all $(SWIGSO)
+pywrap: all $(SWIGSO) $(AUDIT2WHYSO)
 
 $(LIBA):  $(OBJS)
 	$(AR) rcs $@ $^
@@ -63,6 +64,12 @@
 	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -ldl -L$(LIBDIR) -Wl,-soname,$(LIBSO),-z,defs,-z,relro
 	ln -sf $@ $(TARGET) 
 
+audit2why.lo: audit2why.c
+	$(CC) $(CFLAGS) -I$(PYINC) -fPIC -DSHARED -c -o $@ $<
+
+$(AUDIT2WHYSO): audit2why.lo
+	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L. -lselinux ${LIBDIR}/libsepol.a -L$(LIBDIR) -Wl,-soname,$@
+
 %.o:  %.c policy.h
 	$(CC) $(CFLAGS) $(TLSFLAGS) -c -o $@ $<
 
@@ -77,20 +84,21 @@
 
 install: all 
 	test -d $(LIBDIR) || install -m 755 -d $(LIBDIR)
-	install -m 644 $(LIBA) $(LIBDIR)
 	test -d $(SHLIBDIR) || install -m 755 -d $(SHLIBDIR)
 	install -m 755 $(LIBSO) $(SHLIBDIR)
 	cd $(LIBDIR) && ln -sf ../../`basename $(SHLIBDIR)`/$(LIBSO) $(TARGET)
 
 install-pywrap: pywrap
-	test -d $(PYTHONLIBDIR)/site-packages || install -m 755 -d $(PYTHONLIBDIR)/site-packages
-	install -m 755 $(SWIGFILES) $(PYTHONLIBDIR)/site-packages
+	test -d $(PYTHONLIBDIR)/site-packages || install -m 755 -d $(PYTHONLIBDIR)/site-packages/selinux
+	install -m 755 $(SWIGSO) $(PYTHONLIBDIR)/site-packages/selinux
+	install -m 755 $(AUDIT2WHYSO) $(PYTHONLIBDIR)/site-packages/selinux
+	install -m 644  selinux.py $(PYTHONLIBDIR)/site-packages/selinux/__init__.py
 
 relabel:
 	/sbin/restorecon $(SHLIBDIR)/$(LIBSO)
 
 clean: 
-	-rm -f $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(SWIGLOBJ) $(SWIGSO) $(TARGET) 
+	-rm -f $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(SWIGLOBJ) $(SWIGSO) $(TARGET) $(AUDIT2WHYSO) *.o *.lo *~
 
 distclean: clean
 	rm -f $(SWIGCOUT) $(SWIGFILES)
--- nsalibselinux/src/audit2why.c	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-2.0.46/src/audit2why.c	2008-01-11 10:51:10.000000000 -0500
@@ -0,0 +1,460 @@
+#include <unistd.h>
+#include <stdlib.h>
+#include <ctype.h>
+#include <errno.h>
+#include <getopt.h>
+#include <limits.h>
+#include <sepol/sepol.h>
+#include <sepol/policydb/services.h>
+#include <Python.h>
+#include <selinux/selinux.h>
+
+#define UNKNOWN -1
+#define BADSCON -2
+#define BADTCON -3
+#define BADTCLASS -4
+#define BADPERM -5
+#define BADCOMPUTE -6
+#define NOPOLICY -7
+#define ALLOW 0
+#define DONTAUDIT 1
+#define TERULE 2
+#define BOOLEAN 3
+#define CONSTRAINT 4
+#define RBAC 5
+
+struct boolean_t {
+	char *name;
+	int active;
+};
+
+static struct boolean_t **boollist = NULL;
+static int boolcnt = 0;
+
+struct avc_t {
+	sepol_handle_t *handle;
+	policydb_t policydb;
+	sepol_security_id_t ssid;
+	sepol_security_id_t tsid;
+	sepol_security_class_t tclass;
+	sepol_access_vector_t av;
+};
+
+static struct avc_t *avc = NULL;
+
+static sidtab_t sidtab;
+
+static int load_booleans(const sepol_bool_t * boolean,
+			 void *arg __attribute__ ((__unused__)))
+{
+	boollist[boolcnt] =
+	    (struct boolean_t *)malloc(sizeof(struct boolean_t));
+	boollist[boolcnt]->name = strdup(sepol_bool_get_name(boolean));
+	boollist[boolcnt]->active = sepol_bool_get_value(boolean);
+	boolcnt++;
+	return 0;
+}
+
+static int check_booleans(struct avc_t *avc, struct boolean_t ***bools)
+{
+	char errormsg[PATH_MAX];
+	struct sepol_av_decision avd;
+	unsigned int reason;
+	int rc;
+	int i;
+	sepol_bool_key_t *key = NULL;
+	sepol_bool_t *boolean = NULL;
+	int fcnt = 0;
+	int *foundlist = calloc(boolcnt, sizeof(int));
+	if (!foundlist) {
+		PyErr_SetString( PyExc_MemoryError, "Out of memory\n");
+		return fcnt;
+	}
+	for (i = 0; i < boolcnt; i++) {
+		char *name = boollist[i]->name;
+		int active = boollist[i]->active;
+		rc = sepol_bool_key_create(avc->handle, name, &key);
+		if (rc < 0) {
+			PyErr_SetString( PyExc_RuntimeError, 
+					 "Could not create boolean key.\n");
+			break;
+		}
+		rc = sepol_bool_query(avc->handle,
+				      (sepol_policydb_t *) & avc->policydb,
+				      key, &boolean);
+
+		if (rc < 0) {
+			snprintf(errormsg, sizeof(errormsg), 
+				 "Could not find boolean %s.\n", name);
+			PyErr_SetString( PyExc_RuntimeError, errormsg);
+			break;
+		}
+
+		sepol_bool_set_value(boolean, !active);
+
+		rc = sepol_bool_set(avc->handle,
+				    (sepol_policydb_t *) & avc->policydb,
+				    key, boolean);
+		if (rc < 0) {
+			snprintf(errormsg, sizeof(errormsg), 
+				 "Could not set boolean data %s.\n", name);
+			PyErr_SetString( PyExc_RuntimeError, errormsg);
+			break;
+		}
+
+		/* Reproduce the computation. */
+		rc = sepol_compute_av_reason(avc->ssid, avc->tsid, avc->tclass,
+					     avc->av, &avd, &reason);
+		if (rc < 0) {
+			snprintf(errormsg, sizeof(errormsg), 
+				 "Error during access vector computation, skipping...");
+			PyErr_SetString( PyExc_RuntimeError, errormsg);
+
+			sepol_bool_free(boolean);
+			break;
+		} else {
+			if (!reason) {
+				foundlist[fcnt] = i;
+				fcnt++;
+			}
+			sepol_bool_set_value((sepol_bool_t *) boolean, active);
+			rc = sepol_bool_set(avc->handle,
+					    (sepol_policydb_t *) & avc->
+					    policydb, key,
+					    (sepol_bool_t *) boolean);
+			if (rc < 0) {
+				snprintf(errormsg, sizeof(errormsg), 
+					 "Could not set boolean data %s.\n",
+					 name);
+			
+				PyErr_SetString( PyExc_RuntimeError, errormsg);
+				break;
+			}
+		}
+		sepol_bool_free(boolean);
+		sepol_bool_key_free(key);
+		key = NULL;
+		boolean = NULL;
+	}
+	if (key)
+		sepol_bool_key_free(key);
+
+	if (boolean)
+		sepol_bool_free(boolean);
+
+	if (fcnt > 0) {
+		*bools = (struct boolean_t **)
+			calloc(sizeof(struct boolean_t), fcnt + 1);
+		struct boolean_t *b = (struct boolean_t *) *bools;
+		for (i = 0; i < fcnt; i++) {
+			int ctr = foundlist[i];
+			b[i].name = strdup(boollist[ctr]->name);
+			b[i].active = !boollist[ctr]->active;
+		}
+	}
+	free(foundlist);
+	return fcnt;
+}
+
+static PyObject *finish(PyObject *self __attribute__((unused)), PyObject *args) {
+	PyObject *result = 0;
+  
+	if (PyArg_ParseTuple(args,(char *)":finish")) {
+		int i = 0;
+		for (i = 0; i < boolcnt; i++) {
+			free(boollist[i]->name);
+			free(boollist[i]);
+		}
+		free(boollist);
+		sepol_sidtab_shutdown(&sidtab);
+		sepol_sidtab_destroy(&sidtab);
+		policydb_destroy(&avc->policydb);
+		sepol_handle_destroy(avc->handle);
+		free(avc);
+		avc = NULL;
+		boollist = NULL;
+		boolcnt = 0;
+	  
+		/* Boilerplate to return "None" */
+		Py_RETURN_NONE;
+	}
+	return result;
+}
+
+
+static int __policy_init(const char *init_path)
+{
+	FILE *fp;
+	int vers = 0;
+	char path[PATH_MAX];
+	char errormsg[PATH_MAX];
+	struct policy_file pf;
+	int rc;
+	unsigned int cnt;
+
+	if (init_path) {
+		strncpy(path, init_path, PATH_MAX);
+		fp = fopen(path, "r");
+		if (!fp) {
+			snprintf(errormsg, sizeof(errormsg), 
+				 "unable to open %s:  %s\n",
+				 path, strerror(errno));
+			PyErr_SetString( PyExc_ValueError, errormsg);
+			return 0;    // trigger exception
+		}
+	} else {
+		vers = security_policyvers();
+		if (vers < 0) {
+			snprintf(errormsg, sizeof(errormsg), 
+				 "Could not get policy version:  %s\n",
+				 strerror(errno));
+			PyErr_SetString( PyExc_ValueError, errormsg);
+			return 1;
+		}
+		snprintf(path, PATH_MAX, "%s.%d",
+			 selinux_binary_policy_path(), vers);
+		fp = fopen(path, "r");
+		while (!fp && errno == ENOENT && --vers) {
+			snprintf(path, PATH_MAX, "%s.%d",
+				 selinux_binary_policy_path(), vers);
+			fp = fopen(path, "r");
+		}
+		if (!fp) {
+			snprintf(errormsg, sizeof(errormsg), 
+				 "unable to open %s.%d:  %s\n",
+				 selinux_binary_policy_path(),
+				 security_policyvers(), strerror(errno));
+			PyErr_SetString( PyExc_ValueError, errormsg);
+			return 1;
+		}
+	}
+
+	avc = calloc(sizeof(struct avc_t), 1);
+	if (!avc) {
+		PyErr_SetString( PyExc_MemoryError, "Out of memory\n");
+		return 1;
+	}
+
+	/* Set up a policydb directly so that we can mutate it later
+	   for booleans and user settings.  Otherwise we would just use
+	   sepol_set_policydb_from_file() here. */
+	pf.fp = fp;
+	pf.type = PF_USE_STDIO;
+	if (policydb_init(&avc->policydb)) {
+		snprintf(errormsg, sizeof(errormsg), 
+			 "policydb_init failed: %s\n", strerror(errno));
+		PyErr_SetString( PyExc_RuntimeError, errormsg);
+		fclose(fp);
+		return 1;
+	}
+	if (policydb_read(&avc->policydb, &pf, 0)) {
+		snprintf(errormsg, sizeof(errormsg), 
+			 "invalid binary policy %s\n", path);
+		PyErr_SetString( PyExc_ValueError, errormsg);
+		fclose(fp);
+		return 1;
+	}
+	fclose(fp);
+	sepol_set_policydb(&avc->policydb);
+	if (!init_path) {
+		/* If they didn't specify a full path of a binary policy file,
+		   then also try loading any boolean settings and user
+		   definitions from the active locations.  Otherwise,
+		   they can use genpolbools and genpolusers to build a
+		   binary policy file that includes any desired settings
+		   and then apply audit2why -p to the resulting file. 
+		   Errors are non-fatal as such settings are optional. */
+		sepol_debug(0);
+		(void)sepol_genbools_policydb(&avc->policydb,
+					      selinux_booleans_path());
+		(void)sepol_genusers_policydb(&avc->policydb,
+					      selinux_users_path());
+	}
+	avc->handle = sepol_handle_create();
+
+	rc = sepol_bool_count(avc->handle,
+			      (sepol_policydb_t *) & avc->policydb, &cnt);
+	if (rc < 0) {
+		PyErr_SetString( PyExc_RuntimeError, "unable to get bool count\n");
+		return 1;
+	}
+
+	boollist = calloc(cnt, sizeof(struct boolean_t));
+	if (!boollist) {
+		PyErr_SetString( PyExc_MemoryError, "Out of memory\n");
+		return 1;
+	}
+
+	sepol_bool_iterate(avc->handle,
+			   (const sepol_policydb_t *)&avc->policydb,
+			   load_booleans, (void *)NULL);
+
+	/* Initialize the sidtab for subsequent use by sepol_context_to_sid
+	   and sepol_compute_av_reason. */
+	rc = sepol_sidtab_init(&sidtab);
+	if (rc < 0) {
+		PyErr_SetString( PyExc_RuntimeError, "unable to init sidtab\n");
+		free(boollist);
+		return 1;
+	}
+	sepol_set_sidtab(&sidtab);
+	return 0;
+}
+
+static PyObject *init(PyObject *self __attribute__((unused)), PyObject *args) {
+  int result;
+  char *init_path=NULL;
+  if (PyArg_ParseTuple(args,(char *)"|s:policy_init",&init_path)) 
+	  result = __policy_init(init_path);
+  return Py_BuildValue("i", result);
+}
+
+#define RETURN(X) \
+	PyTuple_SetItem(result, 0, Py_BuildValue("i", X));	\
+	return result;						
+
+static PyObject *analyze(PyObject *self __attribute__((unused)) , PyObject *args) {
+	security_context_t scon; 
+	security_context_t tcon;
+	char *tclassstr; 
+	PyObject *listObj;
+	PyObject *strObj;
+	int numlines;
+	struct boolean_t **bools;
+	unsigned int reason;
+	sepol_security_id_t ssid, tsid;
+	sepol_security_class_t tclass;
+	sepol_access_vector_t perm, av;
+	struct sepol_av_decision avd;
+	int rc;
+	int i=0;
+	PyObject *result = PyTuple_New(2);
+	if (!result) return NULL;
+	Py_INCREF(Py_None);
+	PyTuple_SetItem(result, 1, Py_None);
+
+	if (!PyArg_ParseTuple(args,(char *)"sssO!:audit2why",&scon,&tcon,&tclassstr,&PyList_Type, &listObj)) 
+		return NULL;
+  
+	/* get the number of lines passed to us */
+	numlines = PyList_Size(listObj);
+
+	/* should raise an error here. */
+	if (numlines < 0)	return NULL; /* Not a list */
+
+	if (!avc) {
+		RETURN(NOPOLICY)
+	}
+
+	rc = sepol_context_to_sid(scon, strlen(scon) + 1, &ssid);
+	if (rc < 0) {
+		RETURN(BADSCON)
+	}
+	rc = sepol_context_to_sid(tcon, strlen(tcon) + 1, &tsid);
+	if (rc < 0) {
+		RETURN(BADTCON)
+	}
+	tclass = string_to_security_class(tclassstr);
+	if (!tclass) {
+		RETURN(BADTCLASS)
+	}
+	/* Convert the permission list to an AV. */
+	av = 0;
+
+	/* iterate over items of the list, grabbing strings, and parsing
+	   for numbers */
+	for (i=0; i<numlines; i++){
+		char *permstr;
+
+		/* grab the string object from the next element of the list */
+		strObj = PyList_GetItem(listObj, i); /* Can't fail */
+		
+		/* make it a string */
+		permstr = PyString_AsString( strObj );
+		
+		perm = string_to_av_perm(tclass, permstr);
+		if (!perm) {
+			RETURN(BADPERM)
+		}
+		av |= perm;
+	}
+
+	/* Reproduce the computation. */
+	rc = sepol_compute_av_reason(ssid, tsid, tclass, av, &avd, &reason);
+	if (rc < 0) {
+		RETURN(BADCOMPUTE)
+	}
+
+	if (!reason) {
+		RETURN(ALLOW)
+	}
+	if (reason & SEPOL_COMPUTEAV_TE) {
+		avc->ssid = ssid;
+		avc->tsid = tsid;
+		avc->tclass = tclass;
+		avc->av = av;
+		if (check_booleans(avc, &bools) == 0) {
+			if (av & ~avd.auditdeny) {
+				RETURN(DONTAUDIT)
+			} else {
+				RETURN(TERULE)
+			}
+		} else {
+			PyTuple_SetItem(result, 0, Py_BuildValue("i", BOOLEAN));
+			struct boolean_t *b=(struct boolean_t *) bools;
+			int len=0;
+			while (b->name) {
+				len++; b++;
+			}
+			b = (struct boolean_t *) bools;
+			PyObject *boollist = PyTuple_New(len);
+			len=0;
+			while(b->name) {
+				PyObject *bool = Py_BuildValue("(si)", b->name, b->active);
+				PyTuple_SetItem(boollist, len++, bool);
+				b++;
+			}
+			free(bools);
+			PyTuple_SetItem(result, 1, boollist);
+			return result;
+		}
+	}
+
+	if (reason & SEPOL_COMPUTEAV_CONS) {
+		RETURN(CONSTRAINT);
+	}
+
+	if (reason & SEPOL_COMPUTEAV_RBAC) {
+		RETURN(RBAC)
+	}
+        RETURN(BADCOMPUTE)
+}
+
+static PyMethodDef audit2whyMethods[] = {
+    {"init",  init, METH_VARARGS,
+     "Initialize policy database."},
+    {"analyze",  analyze, METH_VARARGS,
+     "Analyze AVC."},
+    {"finish",  finish, METH_VARARGS,
+     "Finish using policy, free memory."},
+    {NULL, NULL, 0, NULL}        /* Sentinel */
+};
+
+PyMODINIT_FUNC
+initaudit2why(void)
+{
+	PyObject *m = Py_InitModule("audit2why", audit2whyMethods);
+	PyModule_AddIntConstant(m,"UNKNOWN", UNKNOWN);
+	PyModule_AddIntConstant(m,"BADSCON", BADSCON);
+	PyModule_AddIntConstant(m,"BADTCON", BADTCON);
+	PyModule_AddIntConstant(m,"BADTCLASS", BADTCLASS);
+	PyModule_AddIntConstant(m,"BADPERM", BADPERM);
+	PyModule_AddIntConstant(m,"BADCOMPUTE", BADCOMPUTE);
+	PyModule_AddIntConstant(m,"NOPOLICY", NOPOLICY);
+	PyModule_AddIntConstant(m,"ALLOW", ALLOW);
+	PyModule_AddIntConstant(m,"DONTAUDIT", DONTAUDIT);
+	PyModule_AddIntConstant(m,"TERULE", TERULE);
+	PyModule_AddIntConstant(m,"BOOLEAN", BOOLEAN);
+	PyModule_AddIntConstant(m,"CONSTRAINT", CONSTRAINT);
+	PyModule_AddIntConstant(m,"RBAC", RBAC);
+}

--------------000601000502070807050009
Content-Type: application/octet-stream;
 name="libselinux-audit2why.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="libselinux-audit2why.patch.sig"

iEYEABECAAYFAkeHk2kACgkQrlYvE4MpobM9TwCgjVNYccImhY7GfDnnSEibkStRz/cAoJPG
V5OuWGmN6nWnH5EE7UGHEHLs
--------------000601000502070807050009--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
