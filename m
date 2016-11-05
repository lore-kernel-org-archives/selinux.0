Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uA5KucDv002332
 for <selinux@tycho.nsa.gov>; Sat, 5 Nov 2016 16:56:39 -0400
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 41C3B56478A
 for <selinux@tycho.nsa.gov>; Sat,  5 Nov 2016 21:56:04 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/1] libselinux: remove rpm_execcon from SWIG wrappers
Date: Sat,  5 Nov 2016 21:55:32 +0100
Message-Id: <20161105205532.3214-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The Python wrapper of rpm_execcon() has several flaws:
* An invalid call like selinux.rpm_execcon() triggers a segmentation
  fault.
* The size of the buffer which is allocated to copy argv and envp is
  too small to hold all the values.
* This allocated memory is leaked if one argument of rpm_execon() is not
  a sequence of bytes.

The Ruby wrapper has no such flaws but can not be used as it is because
it misses some glue code to convert argv and envp arguments to char
*const [] values (even though the destructor is present!).

As it is not possible to remove rpm_execcon() without changing
libselinux soname (it would be an ABI break) like b67fefd991dd
("libselinux: set DISABLE_RPM default to y.") tried to do, disable this
interface locally in the SWIG wrappers.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libselinux/src/selinuxswig_python.i | 42 +++++--------------------------------
 libselinux/src/selinuxswig_ruby.i   | 14 +++++--------
 2 files changed, 10 insertions(+), 46 deletions(-)

diff --git a/libselinux/src/selinuxswig_python.i b/libselinux/src/selinuxswig_python.i
index 43df29153d7c..a239f30b4d2c 100644
--- a/libselinux/src/selinuxswig_python.i
+++ b/libselinux/src/selinuxswig_python.i
@@ -1,6 +1,11 @@
 /* Author: James Athey
  */
 
+/* Never build rpm_execcon interface */
+#ifndef DISABLE_RPM
+#define DISABLE_RPM
+#endif
+
 %module selinux
 %{
 	#include "selinux/selinux.h"
@@ -153,42 +158,5 @@ def install(src, dest):
 	}
 }
 
-%typemap(in) char * const [] {
-	int i, size;
-	PyObject * s;
-
-	if (!PySequence_Check($input)) {
-		PyErr_SetString(PyExc_ValueError, "Expected a sequence");
-		return NULL;
-	}
-
-	size = PySequence_Size($input);
-	
-	$1 = (char**) malloc(size + 1);
-
-	for(i = 0; i < size; i++) {
-		if (!PyString_Check(PySequence_GetItem($input, i))) {
-			PyErr_SetString(PyExc_ValueError, "Sequence must contain only strings");
-			return NULL;
-		}
-	}
-		
-	for(i = 0; i < size; i++) {
-		s = PySequence_GetItem($input, i);
-		$1[i] = (char*) malloc(PyString_Size(s) + 1);
-		strcpy($1[i], PyString_AsString(s));
-	}
-	$1[size] = NULL;
-}
-
-%typemap(freearg,match="in") char * const [] {
-	int i = 0;
-	while($1[i]) {
-		free($1[i]);
-		i++;
-	}
-	free($1);
-}
-
 %include "selinuxswig_python_exception.i"
 %include "selinuxswig.i"
diff --git a/libselinux/src/selinuxswig_ruby.i b/libselinux/src/selinuxswig_ruby.i
index 12d63c4b1b29..51dacf877148 100644
--- a/libselinux/src/selinuxswig_ruby.i
+++ b/libselinux/src/selinuxswig_ruby.i
@@ -2,6 +2,11 @@
    Based on selinuxswig_python.i by James Athey
  */
 
+/* Never build rpm_execcon interface */
+#ifndef DISABLE_RPM
+#define DISABLE_RPM
+#endif
+
 %module selinux
 %{
 	#include "selinux/selinux.h"
@@ -40,13 +45,4 @@
 	}
 }
 
-%typemap(freearg,match="in") char * const [] {
-	int i = 0;
-	while($1[i]) {
-		free($1[i]);
-		i++;
-	}
-	free($1);
-}
-
 %include "selinuxswig.i"
-- 
2.10.2
