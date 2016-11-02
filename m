Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uA2FOf5N006270
 for <selinux@tycho.nsa.gov>; Wed, 2 Nov 2016 11:24:41 -0400
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id AA7D81A1A8
 for <selinux@tycho.nsa.gov>; Wed,  2 Nov 2016 16:24:34 +0100 (CET)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id FqjN4HXjxo2n for <selinux@tycho.nsa.gov>;
 Wed,  2 Nov 2016 16:24:32 +0100 (CET)
Received: from valinor.bigon.be (d54c71dba.static.telenet.be [84.199.29.186])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id 746271A06E
 for <selinux@tycho.nsa.gov>; Wed,  2 Nov 2016 16:24:32 +0100 (CET)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH] Revert "libselinux: support new python3 functions"
Date: Wed,  2 Nov 2016 16:24:31 +0100
Message-Id: <20161102152431.30464-1-bigon@debian.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Laurent Bigonville <bigon@bigon.be>

With the reverted commit applied, some functions were returning arrays
of bytes instead of python strings under python3 this was causing issues
with string manipulation functions like split().

Swig (checked with 3.0.7) is adding compatibility macros that take care
of the differences between python2 and python3.

This reverts commit 63df0f7ef12844b9b86cc293299671da772fcf84.

Signed-off-by: Laurent Bigonville <bigon@bigon.be>
---
 libselinux/src/selinuxswig_python.i | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/libselinux/src/selinuxswig_python.i b/libselinux/src/selinuxswig_python.i
index 8cea18d..43df291 100644
--- a/libselinux/src/selinuxswig_python.i
+++ b/libselinux/src/selinuxswig_python.i
@@ -64,7 +64,7 @@ def install(src, dest):
 	PyObject* list = PyList_New(*$2);
 	int i;
 	for (i = 0; i < *$2; i++) {
-		PyList_SetItem(list, i, PyBytes_FromString((*$1)[i]));
+		PyList_SetItem(list, i, PyString_FromString((*$1)[i]));
 	}
 	$result = SWIG_Python_AppendOutput($result, list);
 }
@@ -97,9 +97,7 @@ def install(src, dest):
 			len++;
 		plist = PyList_New(len);
 		for (i = 0; i < len; i++) {
-			PyList_SetItem(plist, i,
-                                       PyBytes_FromString((*$1)[i])
-                                       );
+			PyList_SetItem(plist, i, PyString_FromString((*$1)[i]));
 		}
 	} else {
 		plist = PyList_New(0);
@@ -116,9 +114,7 @@ def install(src, dest):
 	if (*$1) {
 		plist = PyList_New(result);
 		for (i = 0; i < result; i++) {
-			PyList_SetItem(plist, i,
-                                       PyBytes_FromString((*$1)[i])
-                                       );
+			PyList_SetItem(plist, i, PyString_FromString((*$1)[i]));
 		}
 	} else {
 		plist = PyList_New(0);
@@ -171,20 +167,16 @@ def install(src, dest):
 	$1 = (char**) malloc(size + 1);
 
 	for(i = 0; i < size; i++) {
-		if (!PyBytes_Check(PySequence_GetItem($input, i))) {
-			PyErr_SetString(PyExc_ValueError, "Sequence must contain only bytes");
-
+		if (!PyString_Check(PySequence_GetItem($input, i))) {
+			PyErr_SetString(PyExc_ValueError, "Sequence must contain only strings");
 			return NULL;
 		}
-
 	}
 		
 	for(i = 0; i < size; i++) {
 		s = PySequence_GetItem($input, i);
-
-		$1[i] = (char*) malloc(PyBytes_Size(s) + 1);
-		strcpy($1[i], PyBytes_AsString(s));
-
+		$1[i] = (char*) malloc(PyString_Size(s) + 1);
+		strcpy($1[i], PyString_AsString(s));
 	}
 	$1[size] = NULL;
 }
-- 
2.10.2
