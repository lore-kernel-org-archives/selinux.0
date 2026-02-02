Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B79F36C5A3
	for <selinux@vger.kernel.org>; Mon,  2 Feb 2026 14:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770042258; cv=none; b=l+K5wqbrsn8BqONL/akPkBIyZ9PFu3mohhcBTHdDwDiQwXheXU2qnZ2p2ytu9+nzS95vFx/E6ZODWpJr2F7i+g1AkrNm3x7XsXQ+N9uaPVYhcbeLQ6+TaNVLjhplPFxSDGC/0a5jTIkB2LzRvi+jjKspOx7rar5CelO4pptgKpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770042258; c=relaxed/simple;
	bh=4+wUxBbcX4JEqQuUegPMyj1N/1wBVk2s5ks2dbFFSKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gGSKntZStYl4IQR2wj7FlF5JTbVBAA255Wc4nQcwp1Q9yVJCAtgWDfB67+DCaruf1ZOAifRfoWM/RYUyikQ9g9DZp3r23SANZPcpFRJl0ZODzdEgCPkBvi3xjm+A/DyUOYkEDpvxSjFbueqmMofFu9Uh5sVE0MMPbHRw7988VvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=FUpjvML3; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="FUpjvML3"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1770042253;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7y5EproXaKEK1uPx/N9i02nukrmBumTKfw8wYrDpK90=;
	b=FUpjvML3kabUjMLH1hZgvNDJIYbouNFEP/ibGjhrbHjKmRnOepwkn7+92P9gwoZcPywLsu
	cm44d1duvAgWPSk0ehJWAqi2mHSmelf/mheZ1QoIARJ9ne3R7SRe0D5jsQfOoj7PM0keM/
	4sTEpwsFwdfSEs39OCfWjSeZW/0QBAR0Ku5KrSNVP5++QKk30SRRHimAORCoxvRWWGtaB0
	50/vbSik44Y6M7FXD1eV/Mt4K34B8ZMcaS1K1z2CqGQvqRM47hO3B8DCShFB3Vk7DWYKKe
	IhoUSguSMJJM5+bOD2duBpUfJxLI1UZqI1vqphx57d2h2XzSxnnU2/5OWJCbYA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 7/8] libselinux: drop Python 2 support from audit2why
Date: Mon,  2 Feb 2026 15:24:02 +0100
Message-ID: <20260202142404.92347-6-cgoettsche@seltendoof.de>
In-Reply-To: <20260202142404.92347-1-cgoettsche@seltendoof.de>
References: <20260202142404.92347-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Python 2 is unsupported since 2020.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/audit2why.c | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
index ad846cc3..801c8bd1 100644
--- a/libselinux/src/audit2why.c
+++ b/libselinux/src/audit2why.c
@@ -1,8 +1,3 @@
-/* Workaround for http://bugs.python.org/issue4835 */
-#ifndef SIZEOF_SOCKET_T
-#define SIZEOF_SOCKET_T SIZEOF_INT
-#endif
-
 #include <Python.h>
 #include <unistd.h>
 #include <stdlib.h>
@@ -169,7 +164,7 @@ static int check_booleans(struct boolean_t **bools)
 static PyObject *finish(PyObject *self __attribute__((unused)), PyObject *args) {
 	PyObject *result = 0;
   
-	if (PyArg_ParseTuple(args,(char *)":finish")) {
+	if (PyArg_ParseTuple(args, ":finish")) {
 		int i = 0;
 		if (! avc)
 			Py_RETURN_NONE;
@@ -307,7 +302,7 @@ static PyObject *init(PyObject *self __attribute__((unused)), PyObject *args) {
 	  PyErr_SetString( PyExc_RuntimeError, "init called multiple times");
 	  return NULL;
   }
-  if (!PyArg_ParseTuple(args,(char *)"|s:policy_init",&init_path))
+  if (!PyArg_ParseTuple(args, "|s:policy_init", &init_path))
     return NULL;
   result = __policy_init(init_path);
   return Py_BuildValue("i", result);
@@ -335,7 +330,7 @@ static PyObject *analyze(PyObject *self __attribute__((unused)) , PyObject *args
 	int rc;
 	int i = 0;
 
-	if (!PyArg_ParseTuple(args,(char *)"sssO!:audit2why",&scon,&tcon,&tclassstr,&PyList_Type, &listObj)) 
+	if (!PyArg_ParseTuple(args, "sssO!:audit2why", &scon, &tcon, &tclassstr, &PyList_Type, &listObj)) 
 		return NULL;
   
 	/* get the number of lines passed to us */
@@ -371,11 +366,7 @@ static PyObject *analyze(PyObject *self __attribute__((unused)) , PyObject *args
 		strObj = PyList_GetItem(listObj, i); /* Can't fail */
 		
 		/* make it a string */
-#if PY_MAJOR_VERSION >= 3
 		permstr = _PyUnicode_AsString( strObj );
-#else
-		permstr = PyString_AsString( strObj );
-#endif
 		
 		rc = sepol_string_to_av_perm(tclass, permstr, &perm);
 		if (rc < 0)
@@ -453,8 +444,7 @@ static PyMethodDef audit2whyMethods[] = {
     {NULL, NULL, 0, NULL}        /* Sentinel */
 };
 
-#if PY_MAJOR_VERSION >= 3
-/* Module-initialization logic specific to Python 3 */
+/* Module-initialization logic */
 static struct PyModuleDef moduledef = {
 	PyModuleDef_HEAD_INIT,
 	"audit2why",
@@ -469,20 +459,12 @@ static struct PyModuleDef moduledef = {
 
 PyMODINIT_FUNC PyInit_audit2why(void); /* silence -Wmissing-prototypes */
 PyMODINIT_FUNC PyInit_audit2why(void)
-#else
-PyMODINIT_FUNC initaudit2why(void); /* silence -Wmissing-prototypes */
-PyMODINIT_FUNC initaudit2why(void)
-#endif
 {
 	PyObject *m;
-#if PY_MAJOR_VERSION >= 3
 	m = PyModule_Create(&moduledef);
 	if (m == NULL) {
 		return NULL;
 	}
-#else
-	m  = Py_InitModule("audit2why", audit2whyMethods);
-#endif
 	PyModule_AddIntConstant(m,"UNKNOWN", UNKNOWN);
 	PyModule_AddIntConstant(m,"BADSCON", BADSCON);
 	PyModule_AddIntConstant(m,"BADTCON", BADTCON);
@@ -498,7 +480,5 @@ PyMODINIT_FUNC initaudit2why(void)
 	PyModule_AddIntConstant(m,"RBAC", RBAC);
 	PyModule_AddIntConstant(m,"BOUNDS", BOUNDS);
 
-#if PY_MAJOR_VERSION >= 3
 	return m;
-#endif
 }
-- 
2.51.0

