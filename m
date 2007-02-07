Message-ID: <45CA4A0E.7000500@redhat.com>
Date: Wed, 07 Feb 2007 16:52:14 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Small patch to allow semodule_deps to build
Content-Type: multipart/mixed;
 boundary="------------060907020306060605050903"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060907020306060605050903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------060907020306060605050903
Content-Type: text/x-patch;
 name="semod.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="semod.patch"

--- nsapolicycoreutils/semodule_deps/semodule_deps.c	2007-02-07 12:11:49.000000000 -0500
+++ policycoreutils-2.0.0/semodule_deps/semodule_deps.c	2007-02-07 16:46:18.000000000 -0500
@@ -16,7 +16,7 @@
  * of avrule_blocks - even in an ABI safe way - seems undesirable.
  */
 #include <sepol/module.h>
-#include <sepol/errno.h>
+#include <sepol/errcodes.h>
 #include <sepol/policydb/policydb.h>
 
 #include <getopt.h>

--------------060907020306060605050903--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
