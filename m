Message-ID: <488F2CF8.2010600@redhat.com>
Date: Tue, 29 Jul 2008 10:45:12 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Ruby bindings patch for libselinux
References: <4876284A.5070606@redhat.com> <1217336636.20373.175.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1217336636.20373.175.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2008-07-10 at 11:18 -0400, Daniel J Walsh wrote:
> I noticed that puppet is not SELinux aware.  We are using this in the
> Fedora Infrastructure.  Puppet is written in Ruby.  In order to get the
> packages to make Puppet SELinux aware we need at least matchpathcon,
> is_selinux_enabled, setfscreatecon and setfilecon to have Ruby bindings.
> 
> 
> So I try to learn as much Ruby in an afternoon as possible and converted
> as much libselinux python bindings to Ruby as I could.   Enough to get
> puppet going on working with selinux.
> 
> If some Ruby expert wants to fix the rest of the bindings that would be
> great. :^)
plain text document attachment (diff)
diff --exclude-from=exclude -N -u -r nsalibselinux/src/Makefile
libselinux-2.0.67/src/Makefile
--- nsalibselinux/src/Makefile	2008-06-22 09:40:25.000000000 -0400
+++ libselinux-2.0.67/src/Makefile	2008-07-09 16:56:37.000000000 -0400
@@ -44,11 +54,11 @@

 SWIG = swig -Wall -python -o $(SWIGCOUT) -outdir ./

-GENERATED=$(SWIGCOUT)
+SWIGRUBY = swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./

 all: $(LIBA) $(LIBSO)

-pywrap: all $(SWIGSO) $(AUDIT2WHYSO)
+pywrap: all $(SWIGSO) $(AUDIT2WHYSO) $(SWIGRUBYSO)

> Should there be a separate makefile target for the ruby bindings?

Yes


diff --exclude-from=exclude -N -u -r
nsalibselinux/src/selinuxswig_ruby.i
libselinux-2.0.67/src/selinuxswig_ruby.i
--- nsalibselinux/src/selinuxswig_ruby.i	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-2.0.67/src/selinuxswig_ruby.i	2008-07-09
16:52:33.000000000 -0400
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

> Rather than commenting out or #ifdef'ing python binding code, just
> remove it from this file.

I left it in t he hopes that someone who knew ruby would come in and fix it.

+%typemap(in,noblock=1,numinputs=0) security_context_t *
(security_context_t temp = 0) {
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

> Don't you need to handle the else clause in some manner?

I don't know.  This handling is just to make sure memory does not leak,
I believe.  I do not know what the default for ruby would do.

> What are the build dependencies?  Doesn't build for me on F8 or F9 with
> ruby, ruby-libs and ruby-devel installed.

Build fine for me on F9 and Rawhide.

Spec file has:

BuildRequires: python-devel ruby-devel ruby libsepol-static >=
%{libsepolver} swig


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
