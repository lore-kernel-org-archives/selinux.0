Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n06F1qBE021177
	for <selinux@tycho.nsa.gov>; Tue, 6 Jan 2009 10:01:52 -0500
Received: from manicmethod.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n06ExCrH021594
	for <selinux@tycho.nsa.gov>; Tue, 6 Jan 2009 14:59:12 GMT
Message-ID: <49637258.1060108@manicmethod.com>
Date: Tue, 06 Jan 2009 10:01:44 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Add restorecon and install methods for libselinux python bindings.
References: <49218E1C.2040302@redhat.com>
In-Reply-To: <49218E1C.2040302@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Luke Macken wrote restorecon and install functions used in Fedora
> Infrastructure which can be used to install files with the proper
> context and to fix the labels of files/directories without having to
> exec restorecon.
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
>
> iEYEARECAAYFAkkhjhwACgkQrlYvE4MpobPyDgCfZ3vdiX/irkv3A9ka89LvUV1s
> RjQAniK+8rHaotyzEVoCM/yIg8nvAk8x
> =bePO
> -----END PGP SIGNATURE-----
>   

diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinuxswig_python.i libselinux-2.0.75/src/selinuxswig_python.i
--- nsalibselinux/src/selinuxswig_python.i	2008-08-28 09:34:24.000000000 -0400
+++ libselinux-2.0.75/src/selinuxswig_python.i	2008-11-14 17:09:50.000000000 -0500
@@ -6,6 +6,32 @@
 	#include "selinux/selinux.h"
 %}
 
+%pythoncode %{
+
+import shutil, os
+
+def restorecon(path, recursive=False):
+    """ Restore SELinux context on a given path """
+    mode = os.stat(path)[stat.ST_MODE]

stat doesn't exist here, perhaps he meant mode?

+    status, context = matchpathcon(path, mode)
+    if status == 0:
+        lsetfilecon(path, context)
+        if recursive:
+            os.path.walk(path, lambda arg, dirname, fnames:
+                             map(restorecon, [os.path.join(dirname, fname)
+                              s                for fname in fnames]), None)

typo, the s causes a syntax error

+
+def copytree(src, dest):
+    """ An SELinux-friendly shutil.copytree method """
+    shutil.copytree(src, dest)
+    restorecon(dest, recursive=True)
+
+def install(src, dest):
+    """ An SELinux-friendly shutil.move method """
+    shutil.move(src, dest)
+    restorecon(dest, recursive=True)
+%}
+
 /* security_get_boolean_names() typemap */
 %typemap(argout) (char ***names, int *len) {
 	PyObject* list = PyList_New(*$2);

This patch doesn't appear correct, I'll fix the things above, have you been testing this at all?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
