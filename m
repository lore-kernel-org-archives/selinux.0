Message-ID: <461D2A8D.5050902@redhat.com>
Date: Wed, 11 Apr 2007 14:35:57 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: libselinux patch with corrected call to get_all
Content-Type: multipart/mixed;
 boundary="------------050404000806070804090705"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050404000806070804090705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------050404000806070804090705
Content-Type: text/x-patch;
 name="libselinux-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-rhat.patch"

diff --exclude-from=exclude -N -u -r nsalibselinux/man/man8/matchpathcon.8 libselinux-2.0.9/man/man8/matchpathcon.8
--- nsalibselinux/man/man8/matchpathcon.8	2007-01-17 11:11:35.000000000 -0500
+++ libselinux-2.0.9/man/man8/matchpathcon.8	2007-04-05 13:20:43.000000000 -0400
@@ -28,4 +28,4 @@
 
 .SH "SEE ALSO"
 .BR selinux "(8), "
-.BR mathpathcon "(3), " 
+.BR matchpathcon "(3), " 
diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinuxswig.i libselinux-2.0.9/src/selinuxswig.i
--- nsalibselinux/src/selinuxswig.i	2007-02-22 08:53:23.000000000 -0500
+++ libselinux-2.0.9/src/selinuxswig.i	2007-04-05 16:47:42.000000000 -0400
@@ -115,9 +115,38 @@
 extern const char *selinux_path(void);
 extern int selinux_check_passwd_access(access_vector_t requested);
 extern int checkPasswdAccess(access_vector_t requested);
+
+// This tells SWIG to treat char ** as a special case
+%typemap(python,in) char ** {
+  /* Check if is a list */
+  if (PyList_Check($input)) {
+    int size = PyList_Size($input);
+    int i = 0;
+    $1 = (char **) malloc((size+1)*sizeof(char *));
+    if ($1 == NULL) {
+	PyErr_SetString(PyExc_MemoryError,"Out of memory");
+	return NULL;
+    }
+    for (i = 0; i < size; i++) {
+      PyObject *o = PyList_GetItem($input,i);
+      if (PyString_Check(o))
+	$1[i] = PyString_AsString(PyList_GetItem($input,i));
+      else {
+	PyErr_SetString(PyExc_TypeError,"list must contain strings");
+	free($1);
+	return NULL;
+      }
+    }
+    $1[i] = 0;
+  } else {
+    PyErr_SetString(PyExc_TypeError,"not a list");
+    return NULL;
+  }
+}
+
 extern int rpm_execcon(unsigned int verified, 
 		       const char *filename, 
-		       char *const argv[], char *const envp[]);
+		       char **, char **);
 
 extern int is_context_customizable (security_context_t scontext);
 
diff --exclude-from=exclude -N -u -r nsalibselinux/utils/getsebool.c libselinux-2.0.9/utils/getsebool.c
--- nsalibselinux/utils/getsebool.c	2006-11-16 17:15:17.000000000 -0500
+++ libselinux-2.0.9/utils/getsebool.c	2007-04-05 16:57:51.000000000 -0400
@@ -14,7 +14,7 @@
 
 int main(int argc, char **argv)
 {
-	int i, rc = 0, active, pending, len = 0, opt;
+	int i, get_all = 0, rc = 0, active, pending, len = 0, opt;
 	char **names;
 
 	while ((opt = getopt(argc, argv, "a")) > 0) {
@@ -39,6 +39,7 @@
 				printf("No booleans\n");
 				return 0;
 			}
+			get_all = 1;
 			break;
 		default:
 			usage(argv[0]);
@@ -72,6 +73,8 @@
 	for (i = 0; i < len; i++) {
 		active = security_get_boolean_active(names[i]);
 		if (active < 0) {
+			if (get_all && errno == EACCES) 
+				continue;
 			fprintf(stderr, "Error getting active value for %s\n",
 				names[i]);
 			rc = -1;

--------------050404000806070804090705--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
