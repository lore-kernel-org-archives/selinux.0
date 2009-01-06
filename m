Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n06FLBms024587
	for <selinux@tycho.nsa.gov>; Tue, 6 Jan 2009 10:21:11 -0500
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n06FL9GJ029806
	for <selinux@tycho.nsa.gov>; Tue, 6 Jan 2009 15:21:09 GMT
Message-ID: <496376E0.8060109@redhat.com>
Date: Tue, 06 Jan 2009 10:21:04 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Add restorecon and install methods for libselinux python bindings.
References: <49218E1C.2040302@redhat.com> <49637258.1060108@manicmethod.com>
In-Reply-To: <49637258.1060108@manicmethod.com>
Content-Type: multipart/mixed;
 boundary="------------020706030704000508030106"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020706030704000508030106
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Joshua Brindle wrote:
> Daniel J Walsh wrote:
> Luke Macken wrote restorecon and install functions used in Fedora
> Infrastructure which can be used to install files with the proper
> context and to fix the labels of files/directories without having to
> exec restorecon.

> diff --exclude-from=exclude -N -u -r
> nsalibselinux/src/selinuxswig_python.i
> libselinux-2.0.75/src/selinuxswig_python.i
> --- nsalibselinux/src/selinuxswig_python.i    2008-08-28
> 09:34:24.000000000 -0400
> +++ libselinux-2.0.75/src/selinuxswig_python.i    2008-11-14
> 17:09:50.000000000 -0500
> @@ -6,6 +6,32 @@
>     #include "selinux/selinux.h"
> %}

> +%pythoncode %{
> +
> +import shutil, os
> +
> +def restorecon(path, recursive=False):
> +    """ Restore SELinux context on a given path """
> +    mode = os.stat(path)[stat.ST_MODE]

> stat doesn't exist here, perhaps he meant mode?

> +    status, context = matchpathcon(path, mode)
> +    if status == 0:
> +        lsetfilecon(path, context)
> +        if recursive:
> +            os.path.walk(path, lambda arg, dirname, fnames:
> +                             map(restorecon, [os.path.join(dirname, fname)
> +                              s                for fname in fnames]),
> None)

> typo, the s causes a syntax error

> +
> +def copytree(src, dest):
> +    """ An SELinux-friendly shutil.copytree method """
> +    shutil.copytree(src, dest)
> +    restorecon(dest, recursive=True)
> +
> +def install(src, dest):
> +    """ An SELinux-friendly shutil.move method """
> +    shutil.move(src, dest)
> +    restorecon(dest, recursive=True)
> +%}
> +
> /* security_get_boolean_names() typemap */
> %typemap(argout) (char ***names, int *len) {
>     PyObject* list = PyList_New(*$2);

> This patch doesn't appear correct, I'll fix the things above, have you
> been testing this at all?

Must have sent you a bad patch.


This is what the current patch looks like.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkljdt8ACgkQrlYvE4MpobMzpQCg5USqSeTJzdPipICo1MVwKn/c
sz0An2fm7yc8T1my5y3Zi4kzIQP2OStQ
=oQ4y
-----END PGP SIGNATURE-----

--------------020706030704000508030106
Content-Type: text/plain;
 name="libselinux-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-rhat.patch"

diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinuxswig_python.i libselinux-2.0.76/src/selinuxswig_python.i
--- nsalibselinux/src/selinuxswig_python.i	2008-08-28 09:34:24.000000000 -0400
+++ libselinux-2.0.76/src/selinuxswig_python.i	2008-12-02 09:14:48.000000000 -0500
@@ -6,6 +6,32 @@
 	#include "selinux/selinux.h"
 %}
 
+%pythoncode %{
+
+import shutil, os, stat
+
+def restorecon(path, recursive=False):
+    """ Restore SELinux context on a given path """
+    mode = os.stat(path)[stat.ST_MODE]
+    status, context = matchpathcon(path, mode)
+    if status == 0:
+        lsetfilecon(path, context)
+        if recursive:
+            os.path.walk(path, lambda arg, dirname, fnames:
+                             map(restorecon, [os.path.join(dirname, fname)
+                                              for fname in fnames]), None)
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

--------------020706030704000508030106
Content-Type: application/octet-stream;
 name="libselinux-rhat.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="libselinux-rhat.patch.sig"

iEYEABECAAYFAkljdt8ACgkQrlYvE4MpobMBEACdFzG2s3IsN9SK+1ol7nFoa7LptJ0AnjQS
gJZtFCfu8W7kHybr/dPHGaMZ
--------------020706030704000508030106--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
