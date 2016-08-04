Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u74IYMKX011354
 for <selinux@tycho.nsa.gov>; Thu, 4 Aug 2016 14:34:31 -0400
Received: by mail-pf0-f194.google.com with SMTP id h186so18641365pfg.2
 for <selinux@tycho.nsa.gov>; Thu, 04 Aug 2016 11:34:31 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 04/12] sepolicy: Add python3 PyInt and PyString defs
Date: Fri,  5 Aug 2016 02:33:57 +0800
Message-Id: <1470335645-24224-5-git-send-email-jason@perfinion.com>
In-Reply-To: <1470335645-24224-1-git-send-email-jason@perfinion.com>
References: <1470335645-24224-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

---
 policycoreutils/sepolicy/common.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/policycoreutils/sepolicy/common.h b/policycoreutils/sepolicy/common.h
index dc3ce6a..e453def 100644
--- a/policycoreutils/sepolicy/common.h
+++ b/policycoreutils/sepolicy/common.h
@@ -11,6 +11,25 @@
 
 #define py_decref(x) { if (x) 	Py_DECREF(x); }
 
+#if PY_MAJOR_VERSION >= 3
+#	define PyIntObject                  PyLongObject
+#	define PyInt_Type                   PyLong_Type
+#	define PyInt_Check(op)              PyLong_Check(op)
+#	define PyInt_CheckExact(op)         PyLong_CheckExact(op)
+#	define PyInt_FromString             PyLong_FromString
+#	define PyInt_FromUnicode            PyLong_FromUnicode
+#	define PyInt_FromLong               PyLong_FromLong
+#	define PyInt_FromSize_t             PyLong_FromSize_t
+#	define PyInt_FromSsize_t            PyLong_FromSsize_t
+#	define PyInt_AsLong                 PyLong_AsLong
+#	define PyInt_AS_LONG                PyLong_AS_LONG
+#	define PyInt_AsSsize_t              PyLong_AsSsize_t
+#	define PyInt_AsUnsignedLongMask     PyLong_AsUnsignedLongMask
+#	define PyInt_AsUnsignedLongLongMask PyLong_AsUnsignedLongLongMask
+#	define PyString_FromString          PyUnicode_FromString
+#	define PyString_AsString            PyUnicode_AsUTF8
+#endif
+
 static int py_append_string(PyObject *list, const char* value)
 {
 	int rt;
-- 
2.7.3
