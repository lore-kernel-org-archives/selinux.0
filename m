Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oBDIPESv003308
	for <selinux@tycho.nsa.gov>; Mon, 13 Dec 2010 13:25:14 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id oBDIPC4b020646
	for <selinux@tycho.nsa.gov>; Mon, 13 Dec 2010 18:25:13 GMT
Message-ID: <4D066505.7060101@redhat.com>
Date: Mon, 13 Dec 2010 13:25:09 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "'Chad Sellers'" <csellers@tresys.com>, SELinux <selinux@tycho.nsa.gov>
Subject: This patch adds python3 bindings.
Content-Type: multipart/mixed;
 boundary="------------030205000105090109090304"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030205000105090109090304
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------030205000105090109090304
Content-Type: text/plain;
 name="libselinux.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libselinux.patch"

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index bf665ab..8aeb7a1 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -1,9 +1,10 @@
 # Installation directories.
+PYTHON ?= python
 PREFIX ?= $(DESTDIR)/usr
 LIBDIR ?= $(PREFIX)/lib
 SHLIBDIR ?= $(DESTDIR)/lib
 INCLUDEDIR ?= $(PREFIX)/include
-PYLIBVER ?= $(shell python -c 'import sys;print "python%d.%d" % sys.version_info[0:2]')
+PYLIBVER ?= $(shell $(PYTHON) -c 'import sys;print("python%d.%d" % sys.version_info[0:2])')
 PYINC ?= /usr/include/$(PYLIBVER)
 PYLIB ?= /usr/lib/$(PYLIBVER)
 PYTHONLIBDIR ?= $(LIBDIR)/$(PYLIBVER)
@@ -23,13 +24,13 @@ SWIGIF= selinuxswig_python.i selinuxswig_python_exception.i
 SWIGRUBYIF= selinuxswig_ruby.i
 SWIGCOUT= selinuxswig_wrap.c
 SWIGRUBYCOUT= selinuxswig_ruby_wrap.c
-SWIGLOBJ:= $(patsubst %.c,%.lo,$(SWIGCOUT)) 
+SWIGLOBJ:= $(patsubst %.c,$(PYPREFIX)%.lo,$(SWIGCOUT)) 
 SWIGRUBYLOBJ:= $(patsubst %.c,%.lo,$(SWIGRUBYCOUT)) 
-SWIGSO=_selinux.so
+SWIGSO=$(PYPREFIX)_selinux.so
 SWIGFILES=$(SWIGSO) selinux.py selinuxswig_python_exception.i
 SWIGRUBYSO=_rubyselinux.so
 LIBSO=$(TARGET).$(LIBVERSION)
-AUDIT2WHYSO=audit2why.so
+AUDIT2WHYSO=$(PYPREFIX)audit2why.so
 
 ifeq ($(DISABLE_AVC),y)
 	UNUSED_SRCS+=avc.c avc_internal.c avc_sidtab.c mapping.c stringrep.c checkAccess.c
@@ -91,10 +92,10 @@ $(LIBPC): $(LIBPC).in
 selinuxswig_python_exception.i: ../include/selinux/selinux.h
 	bash exception.sh > $@ 
 
-audit2why.lo: audit2why.c
+$(PYPREFIX)audit2why.lo: audit2why.c
 	$(CC) $(CFLAGS) -I$(PYINC) -fPIC -DSHARED -c -o $@ $<
 
-$(AUDIT2WHYSO): audit2why.lo
+$(AUDIT2WHYSO): $(PYPREFIX)audit2why.lo
 	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L. -lselinux ${LIBDIR}/libsepol.a -L$(LIBDIR) -Wl,-soname,$@
 
 %.o:  %.c policy.h
@@ -123,8 +124,8 @@ install: all
 
 install-pywrap: pywrap
 	test -d $(PYTHONLIBDIR)/site-packages/selinux || install -m 755 -d $(PYTHONLIBDIR)/site-packages/selinux
-	install -m 755 $(SWIGSO) $(PYTHONLIBDIR)/site-packages/selinux
-	install -m 755 $(AUDIT2WHYSO) $(PYTHONLIBDIR)/site-packages/selinux
+	install -m 755 $(SWIGSO) $(PYTHONLIBDIR)/site-packages/selinux/_selinux.so
+	install -m 755 $(AUDIT2WHYSO) $(PYTHONLIBDIR)/site-packages/selinux/audit2why.so
 	install -m 644  selinux.py $(PYTHONLIBDIR)/site-packages/selinux/__init__.py
 
 install-rubywrap: rubywrap
diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
index 691bc67..12e8614 100644
--- a/libselinux/src/audit2why.c
+++ b/libselinux/src/audit2why.c
@@ -1,3 +1,6 @@
+/* Workaround for http://bugs.python.org/issue4835 */
+#define SIZEOF_SOCKET_T SIZEOF_INT
+
 #include <Python.h>
 #include <unistd.h>
 #include <stdlib.h>
@@ -287,8 +292,10 @@ static int __policy_init(const char *init_path)
 static PyObject *init(PyObject *self __attribute__((unused)), PyObject *args) {
   int result;
   char *init_path=NULL;
-  if (PyArg_ParseTuple(args,(char *)"|s:policy_init",&init_path)) 
-	  result = __policy_init(init_path);
+  if (!PyArg_ParseTuple(args,(char *)"|s:policy_init",&init_path)) {
+    return NULL;
+  }
+  result = __policy_init(init_path);
   return Py_BuildValue("i", result);
 }
 
@@ -353,7 +360,11 @@ static PyObject *analyze(PyObject *self __attribute__((unused)) , PyObject *args
 		strObj = PyList_GetItem(listObj, i); /* Can't fail */
 		
 		/* make it a string */
+#if PY_MAJOR_VERSION >= 3
+		permstr = _PyUnicode_AsString( strObj );
+#else
 		permstr = PyString_AsString( strObj );
+#endif
 		
 		perm = string_to_av_perm(tclass, permstr);
 		if (!perm) {
@@ -423,10 +434,39 @@ static PyMethodDef audit2whyMethods[] = {
     {NULL, NULL, 0, NULL}        /* Sentinel */
 };
 
+#if PY_MAJOR_VERSION >= 3
+/* Module-initialization logic specific to Python 3 */
+struct module_state {
+	/* empty for now */
+};
+static struct PyModuleDef moduledef = {
+	PyModuleDef_HEAD_INIT,
+	"audit2why",
+	NULL,
+	sizeof(struct module_state),
+	audit2whyMethods,
+	NULL,
+	NULL,
+	NULL,
+	NULL
+};
+
+PyMODINIT_FUNC
+PyInit_audit2why(void)
+#else
 PyMODINIT_FUNC
 initaudit2why(void)
+#endif
 {
-	PyObject *m = Py_InitModule("audit2why", audit2whyMethods);
+	PyObject *m;
+#if PY_MAJOR_VERSION >= 3
+	m = PyModule_Create(&moduledef);
+	if (m == NULL) {
+		return NULL;
+	}
+#else
+	m  = Py_InitModule("audit2why", audit2whyMethods);
+#endif
 	PyModule_AddIntConstant(m,"UNKNOWN", UNKNOWN);
 	PyModule_AddIntConstant(m,"BADSCON", BADSCON);
 	PyModule_AddIntConstant(m,"BADTCON", BADTCON);
@@ -440,4 +480,8 @@ initaudit2why(void)
 	PyModule_AddIntConstant(m,"BOOLEAN", BOOLEAN);
 	PyModule_AddIntConstant(m,"CONSTRAINT", CONSTRAINT);
 	PyModule_AddIntConstant(m,"RBAC", RBAC);
+
+#if PY_MAJOR_VERSION >= 3
+	return m;
+#endif
 }
diff --git a/libselinux/src/selinuxswig_python.i b/libselinux/src/selinuxswig_python.i
index dea0e80..bb227e9 100644
--- a/libselinux/src/selinuxswig_python.i
+++ b/libselinux/src/selinuxswig_python.i
@@ -45,7 +45,7 @@ def install(src, dest):
 	PyObject* list = PyList_New(*$2);
 	int i;
 	for (i = 0; i < *$2; i++) {
-		PyList_SetItem(list, i, PyString_FromString((*$1)[i]));
+		PyList_SetItem(list, i, PyBytes_FromString((*$1)[i]));
 	}
 	$result = SWIG_Python_AppendOutput($result, list);
 }
@@ -74,7 +74,9 @@ def install(src, dest):
 			len++;
 		plist = PyList_New(len);
 		for (i = 0; i < len; i++) {
-			PyList_SetItem(plist, i, PyString_FromString((*$1)[i]));
+			PyList_SetItem(plist, i, 
+                                       PyBytes_FromString((*$1)[i])
+                                       );
 		}
 	} else {
 		plist = PyList_New(0);
@@ -91,7 +93,9 @@ def install(src, dest):
 	if (*$1) {
 		plist = PyList_New(result);
 		for (i = 0; i < result; i++) {
-			PyList_SetItem(plist, i, PyString_FromString((*$1)[i]));
+			PyList_SetItem(plist, i, 
+                                       PyBytes_FromString((*$1)[i])
+                                       );
 		}
 	} else {
 		plist = PyList_New(0);
@@ -144,16 +148,20 @@ def install(src, dest):
 	$1 = (char**) malloc(size + 1);
 
 	for(i = 0; i < size; i++) {
-		if (!PyString_Check(PySequence_GetItem($input, i))) {
-			PyErr_SetString(PyExc_ValueError, "Sequence must contain only strings");
+		if (!PyBytes_Check(PySequence_GetItem($input, i))) {
+			PyErr_SetString(PyExc_ValueError, "Sequence must contain only bytes");
+
 			return NULL;
 		}
+
 	}
 		
 	for(i = 0; i < size; i++) {
 		s = PySequence_GetItem($input, i);
-		$1[i] = (char*) malloc(PyString_Size(s) + 1);
-		strcpy($1[i], PyString_AsString(s));
+
+		$1[i] = (char*) malloc(PyBytes_Size(s) + 1);
+		strcpy($1[i], PyBytes_AsString(s));
+
 	}
 	$1[size] = NULL;
 }

--------------030205000105090109090304
Content-Type: application/pgp-signature;
 name="libselinux.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="libselinux.patch.sig"

iEYEABECAAYFAk0GZQUACgkQrlYvE4MpobMrPwCfV7afRCBlvEdzxgffyx1/lLbQCsoAoItl
6Yy2NHHq0Kf/Qq45wvKqxyE7
--------------030205000105090109090304--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
