Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6AFJ3kl015549
	for <selinux@tycho.nsa.gov>; Thu, 10 Jul 2008 11:19:28 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6AFIrpm020728
	for <selinux@tycho.nsa.gov>; Thu, 10 Jul 2008 15:18:53 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m6AFIZvf004227
	for <selinux@tycho.nsa.gov>; Thu, 10 Jul 2008 11:18:35 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m6AFIZSv028635
	for <selinux@tycho.nsa.gov>; Thu, 10 Jul 2008 11:18:35 -0400
Received: from localhost.localdomain (dhcp-10-16-61-233.boston.devel.redhat.com [10.16.61.233])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m6AFIZhq021035
	for <selinux@tycho.nsa.gov>; Thu, 10 Jul 2008 11:18:35 -0400
Message-ID: <4876284A.5070606@redhat.com>
Date: Thu, 10 Jul 2008 11:18:34 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Ruby bindings patch for libselinux
Content-Type: multipart/mixed;
 boundary="------------060501060309000109070204"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060501060309000109070204
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I noticed that puppet is not SELinux aware.  We are using this in the
Fedora Infrastructure.  Puppet is written in Ruby.  In order to get the
packages to make Puppet SELinux aware we need at least matchpathcon,
is_selinux_enabled, setfscreatecon and setfilecon to have Ruby bindings.


So I try to learn as much Ruby in an afternoon as possible and converted
as much libselinux python bindings to Ruby as I could.   Enough to get
puppet going on working with selinux.

If some Ruby expert wants to fix the rest of the bindings that would be
great. :^)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkh2KEoACgkQrlYvE4MpobND1ACffm5i1ie3FumEXBc+qcm8Fyio
K+4An0Cur4swzMMFoj9blybxBYhzxUMR
=ylTu
-----END PGP SIGNATURE-----

--------------060501060309000109070204
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsalibselinux/src/Makefile libselinux-2.0.67/src/Makefile
--- nsalibselinux/src/Makefile	2008-06-22 09:40:25.000000000 -0400
+++ libselinux-2.0.67/src/Makefile	2008-07-09 16:56:37.000000000 -0400
@@ -7,16 +7,24 @@
 PYINC ?= /usr/include/$(PYLIBVER)
 PYLIB ?= /usr/lib/$(PYLIBVER)
 PYTHONLIBDIR ?= $(LIBDIR)/$(PYLIBVER)
+RUBYLIBVER ?= $(shell ruby -e 'print RUBY_VERSION.split(".")[0..1].join(".")')
+RUBYPLATFORM ?= $(shell ruby -e 'print RUBY_PLATFORM')
+RUBYINC ?= $(LIBDIR)/ruby/$(RUBYLIBVER)/$(RUBYPLATFORM)
+RUBYINSTALL ?= $(LIBDIR)/ruby/site_ruby/$(RUBYLIBVER)/$(RUBYPLATFORM)
 
 LIBVERSION = 1
 
 LIBA=libselinux.a 
 TARGET=libselinux.so
 SWIGIF= selinuxswig_python.i
+SWIGRUBYIF= selinuxswig_ruby.i
 SWIGCOUT= selinuxswig_wrap.c
+SWIGRUBYCOUT= selinuxswig_ruby_wrap.c
 SWIGLOBJ:= $(patsubst %.c,%.lo,$(SWIGCOUT)) 
+SWIGRUBYLOBJ:= $(patsubst %.c,%.lo,$(SWIGRUBYCOUT)) 
 SWIGSO=_selinux.so
 SWIGFILES=$(SWIGSO) selinux.py 
+SWIGRUBYSO=_rubyselinux.so
 LIBSO=$(TARGET).$(LIBVERSION)
 AUDIT2WHYSO=audit2why.so
 
@@ -29,7 +37,9 @@
 ifeq ($(DISABLE_RPM),y)
 	UNUSED_SRCS+=rpm.c
 endif
-SRCS= $(filter-out $(UNUSED_SRCS), $(filter-out audit2why.c $(SWIGCOUT),$(wildcard *.c)))
+
+GENERATED=$(SWIGCOUT) $(SWIGRUBYCOUT)
+SRCS= $(filter-out $(UNUSED_SRCS), $(filter-out audit2why.c $(GENERATED),$(wildcard *.c)))
 
 OBJS= $(patsubst %.c,%.o,$(SRCS))
 LOBJS= $(patsubst %.c,%.lo,$(SRCS))
@@ -44,11 +54,11 @@
 
 SWIG = swig -Wall -python -o $(SWIGCOUT) -outdir ./
 
-GENERATED=$(SWIGCOUT)
+SWIGRUBY = swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./
 
 all: $(LIBA) $(LIBSO) 
 
-pywrap: all $(SWIGSO) $(AUDIT2WHYSO)
+pywrap: all $(SWIGSO) $(AUDIT2WHYSO) $(SWIGRUBYSO) 
 
 $(LIBA):  $(OBJS)
 	$(AR) rcs $@ $^
@@ -57,8 +67,14 @@
 $(SWIGLOBJ): $(SWIGCOUT)
 	$(CC) $(filter-out -Werror,$(CFLAGS)) -I$(PYINC) -fPIC -DSHARED -c -o $@ $<
 
+$(SWIGRUBYLOBJ): $(SWIGRUBYCOUT)
+	$(CC) $(filter-out -Werror,$(CFLAGS)) -I$(RUBYINC) -fPIC -DSHARED -c -o $@ $<
+
 $(SWIGSO): $(SWIGLOBJ)
-	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $< -L. -lselinux -L$(LIBDIR) -Wl,-soname,$@
+	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L. -lselinux -L$(LIBDIR) -Wl,-soname,$@
+
+$(SWIGRUBYSO): $(SWIGRUBYLOBJ)
+	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L. -lselinux -L$(LIBDIR) -Wl,-soname,$@
 
 $(LIBSO): $(LOBJS)
 	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -ldl -L$(LIBDIR) -Wl,-soname,$(LIBSO),-z,defs,-z,relro
@@ -79,6 +95,9 @@
 $(SWIGCOUT): $(SWIGIF)
 	$(SWIG) $^
 
+$(SWIGRUBYCOUT): $(SWIGRUBYIF)
+	$(SWIGRUBY) $^
+
 swigify: $(SWIGIF)
 	$(SWIG) $^
 
@@ -95,6 +114,9 @@
 	install -m 755 $(AUDIT2WHYSO) $(PYTHONLIBDIR)/site-packages/selinux
 	install -m 644  selinux.py $(PYTHONLIBDIR)/site-packages/selinux/__init__.py
 
+	test -d $(RUBYINSTALL) || install -m 755 -d $(RUBYINSTALL) 
+	install -m 755 $(SWIGRUBYSO) $(RUBYINSTALL)/selinux.so
+
 relabel:
 	/sbin/restorecon $(SHLIBDIR)/$(LIBSO)
 
@@ -102,7 +124,7 @@
 	-rm -f $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(SWIGLOBJ) $(SWIGSO) $(TARGET) $(AUDIT2WHYSO) *.o *.lo *~
 
 distclean: clean
-	rm -f $(SWIGCOUT) $(SWIGFILES)
+	rm -f $(GENERATED) $(SWIGFILES)
 
 indent:
 	../../scripts/Lindent $(filter-out $(GENERATED),$(wildcard *.[ch]))
diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinuxswig_ruby.i libselinux-2.0.67/src/selinuxswig_ruby.i
--- nsalibselinux/src/selinuxswig_ruby.i	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-2.0.67/src/selinuxswig_ruby.i	2008-07-09 16:52:33.000000000 -0400
@@ -0,0 +1,147 @@
+/* Author: Dan Walsh, Converted from James Athey python code
+ */
+
+%module selinux
+%{
+	#include "selinux/selinux.h"
+%}
+
+/* security_get_boolean_names() typemap */
+/*
+%typemap(argout) (char ***names, int *len) {
+	PyObject* list = PyList_New(*$2);
+	int i;
+	for (i = 0; i < *$2; i++) {
+		PyList_SetItem(list, i, PyString_FromString((*$1)[i]));
+	}
+	$result = SWIG_Python_AppendOutput($result, list);
+}
+*/
+/* return a sid along with the result */
+%typemap(argout) (security_id_t * sid) {
+	if (*$1) {
+                %append_output(SWIG_NewPointerObj(*$1, $descriptor(security_id_t), 0));
+	} 
+/*	else {
+		Py_INCREF(Py_None);
+		%append_output(Py_None);
+	}
+*/
+}
+
+%typemap(in,numinputs=0) security_id_t *(security_id_t temp) {
+  $1 = &temp;
+}
+
+/* Makes security_compute_user() return a Python list of contexts */
+/*
+%typemap(argout) (security_context_t **con) {
+	PyObject* plist;
+	int i, len = 0;
+	
+	if (*$1) {
+		while((*$1)[len])
+			len++;
+		plist = PyList_New(len);
+		for (i = 0; i < len; i++) {
+			PyList_SetItem(plist, i, PyString_FromString((*$1)[i]));
+		}
+	} else {
+		plist = PyList_New(0);
+	}
+
+	$result = SWIG_Python_AppendOutput($result, plist);
+}
+*/
+/* Makes functions in get_context_list.h return a Python list of contexts */
+
+#ifdef fixme
+%typemap(argout) (security_context_t **list) {
+	PyObject* plist;
+	int i;
+	
+	if (*$1) {
+		plist = PyList_New(result);
+		for (i = 0; i < result; i++) {
+			PyList_SetItem(plist, i, PyString_FromString((*$1)[i]));
+		}
+	} else {
+		plist = PyList_New(0);
+	}
+	/* Only return the Python list, don't need to return the length anymore */
+	$result = plist;
+}
+#endif
+
+%typemap(in,noblock=1,numinputs=0) security_context_t * (security_context_t temp = 0) {
+	$1 = &temp;
+}
+%typemap(freearg,match="in") security_context_t * "";
+%typemap(argout,noblock=1) security_context_t * {
+	if (*$1) {
+		%append_output(SWIG_FromCharPtr(*$1));
+		freecon(*$1);
+	}
+/*
+	else {
+		Py_INCREF(Py_None);
+		%append_output(Py_None);
+	}
+*/
+}
+
+%typemap(in,noblock=1,numinputs=0) char ** (char * temp = 0) {
+	$1 = &temp;
+}
+%typemap(freearg,match="in") char ** "";
+%typemap(argout,noblock=1) char ** {
+	if (*$1) {
+		%append_output(SWIG_FromCharPtr(*$1));
+		free(*$1);
+	}
+/*
+	else {
+		Py_INCREF(Py_None);
+		%append_output(Py_None);
+	}
+*/
+}
+/*
+%typemap(in) char * const [] {
+	int i, size;
+	PyObject * s;
+
+	if (!PySequence_Check($input)) {
+		PyErr_SetString(PyExc_ValueError, "Expected a sequence");
+		return NULL;
+	}
+
+	size = PySequence_Size($input);
+	
+	$1 = (char**) malloc(size + 1);
+	for(i = 0; i < size; i++) {
+		if (!PyString_Check(PySequence_GetItem($input, i))) {
+			PyErr_SetString(PyExc_ValueError, "Sequence must contain only strings");
+			return NULL;
+		}
+	}
+		
+	for(i = 0; i < size; i++) {
+		s = PySequence_GetItem($input, i);
+		$1[i] = (char*) malloc(PyString_Size(s) + 1);
+		strcpy($1[i], PyString_AsString(s));
+	}
+	$1[size] = NULL;
+}
+*/
+
+%typemap(freearg,match="in") char * const [] {
+	int i = 0;
+	while($1[i]) {
+		free($1[i]);
+		i++;
+	}
+	free($1);
+}
+
+%include "selinuxswig.i"

--------------060501060309000109070204
Content-Type: application/octet-stream;
 name="diff.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diff.sig"

iEYEABECAAYFAkh2KEoACgkQrlYvE4MpobMWWwCg4hEx8uiHjpDTaJb+J9rxc+2VSBQAoOUx
MNdEFxRejTNFwPQm8wba9xiB
--------------060501060309000109070204--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
