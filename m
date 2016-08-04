Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u74IYMKY011354
 for <selinux@tycho.nsa.gov>; Thu, 4 Aug 2016 14:34:34 -0400
Received: by mail-pf0-f194.google.com with SMTP id y134so18686338pfg.3
 for <selinux@tycho.nsa.gov>; Thu, 04 Aug 2016 11:34:33 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 05/12] sepolicy: C Module init for python3
Date: Fri,  5 Aug 2016 02:33:58 +0800
Message-Id: <1470335645-24224-6-git-send-email-jason@perfinion.com>
In-Reply-To: <1470335645-24224-1-git-send-email-jason@perfinion.com>
References: <1470335645-24224-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

---
 policycoreutils/sepolicy/policy.c             | 29 ++++++++++++++++++++++++---
 policycoreutils/sepolicy/sepolicy/__init__.py |  2 +-
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/policycoreutils/sepolicy/policy.c b/policycoreutils/sepolicy/policy.c
index b7e3536..423a926 100644
--- a/policycoreutils/sepolicy/policy.c
+++ b/policycoreutils/sepolicy/policy.c
@@ -86,8 +86,31 @@ static PyMethodDef methods[] = {
 	{NULL, NULL, 0, NULL}	/* sentinel */
 };
 
+#if PY_MAJOR_VERSION >= 3
+
+static struct PyModuleDef module_def =
+{
+	PyModuleDef_HEAD_INIT,
+	"_policy", /* name of module */
+	"", /* module documentation, may be NULL */
+	-1, /* size of per-interpreter state of the module, or -1 if the module keeps state in global variables. */
+	(PyMethodDef*)&methods,
+};
+
+PyMODINIT_FUNC PyInit__policy(void)
+{
+	PyObject *m;
+	m = PyModule_Create(&module_def);
+	init_info(m);
+	return m;
+}
+
+#else // python 2
+
 void init_policy(void) {
-PyObject *m;
-m = Py_InitModule("_policy", methods);
-init_info(m);
+	PyObject *m;
+	m = Py_InitModule("_policy", methods);
+	init_info(m);
 }
+
+#endif
diff --git a/policycoreutils/sepolicy/sepolicy/__init__.py b/policycoreutils/sepolicy/sepolicy/__init__.py
index 693c6fe..7804b5c 100644
--- a/policycoreutils/sepolicy/sepolicy/__init__.py
+++ b/policycoreutils/sepolicy/sepolicy/__init__.py
@@ -3,7 +3,7 @@
 # Author: Dan Walsh <dwalsh@redhat.com>
 # Author: Ryan Hallisey <rhallise@redhat.com>
 
-import _policy
+from . import _policy
 import selinux
 import glob
 PROGNAME = "policycoreutils"
-- 
2.7.3
