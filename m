Message-ID: <46EFF028.4040500@redhat.com>
Date: Tue, 18 Sep 2007 11:35:04 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Change default error handling in libselinux matchpathcon to use syslog
 instead of stderr.
Content-Type: multipart/mixed;
 boundary="------------050802090703040909000405"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050802090703040909000405
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Current behavior causes problems with network applications.

https://bugzilla.redhat.com/show_bug.cgi?id=273081

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFG7/AnrlYvE4MpobMRAksuAJ4uqcUDsSlB9uEpXePUEje39kNAywCeJbDE
sZ99tA7s4PgSxD/RnS4MHdg=
=g4kG
-----END PGP SIGNATURE-----

--------------050802090703040909000405
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsalibselinux/src/matchpathcon.c libselinux-2.0.33/src/matchpathcon.c
--- nsalibselinux/src/matchpathcon.c	2007-08-10 11:58:34.000000000 -0400
+++ libselinux-2.0.33/src/matchpathcon.c	2007-09-18 11:28:07.000000000 -0400
@@ -2,6 +2,7 @@
 #include <string.h>
 #include <errno.h>
 #include <stdio.h>
+#include <syslog.h>
 #include "selinux_internal.h"
 #include "label_internal.h"
 #include "callbacks.h"
@@ -55,10 +56,12 @@
 #endif
     default_printf(const char *fmt, ...)
 {
+	char buf[BUFSIZ];
 	va_list ap;
 	va_start(ap, fmt);
-	vfprintf(stderr, fmt, ap);
+	vsnprintf(buf, sizeof(buf) - 1, fmt, ap);
 	va_end(ap);
+	syslog(LOG_ERR, buf, strlen(buf));
 }
 
 void

--------------050802090703040909000405
Content-Type: application/octet-stream;
 name="diff.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diff.sig"

iD8DBQBG7/AnrlYvE4MpobMRApa4AJ48ag0ThcPfD1Lmh1WS1Kn6ohgCUwCdH1Nd97hUG9BK
QyeTMkPt/T3oqMo=
--------------050802090703040909000405--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
