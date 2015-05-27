From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: Expunge remaining references to flask.h and
 av_permissions.h.
Date: Wed, 27 May 2015 11:46:17 -0400
Message-Id: <1432741577-5472-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Missed a few references to these header files when they were
deprecated in 76913d8adb61b5afe28fd3b4ce91feab29e284dd.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/man/man3/security_class_to_string.3 | 2 --
 libselinux/man/man3/security_compute_av.3      | 2 --
 libselinux/src/selinuxswig.i                   | 2 --
 3 files changed, 6 deletions(-)

diff --git a/libselinux/man/man3/security_class_to_string.3 b/libselinux/man/man3/security_class_to_string.3
index 0e9f01d..1b1b88d 100644
--- a/libselinux/man/man3/security_class_to_string.3
+++ b/libselinux/man/man3/security_class_to_string.3
@@ -10,8 +10,6 @@ print_access_vector \- display an access vector in human-readable form.
 .
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
-.br
-.B #include <selinux/flask.h>
 .sp
 .BI "const char *security_class_to_string(security_class_t " tclass ");"
 .sp
diff --git a/libselinux/man/man3/security_compute_av.3 b/libselinux/man/man3/security_compute_av.3
index 04e7a0d..a56c3c8 100644
--- a/libselinux/man/man3/security_compute_av.3
+++ b/libselinux/man/man3/security_compute_av.3
@@ -6,8 +6,6 @@ the SELinux policy database in the kernel
 .
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
-.br
-.B #include <selinux/flask.h>
 .sp
 .BI "int security_compute_av(char * "scon ", char * "tcon ", security_class_t "tclass ", access_vector_t "requested ", struct av_decision *" avd );
 .sp
diff --git a/libselinux/src/selinuxswig.i b/libselinux/src/selinuxswig.i
index c72b818..c1e4ef7 100644
--- a/libselinux/src/selinuxswig.i
+++ b/libselinux/src/selinuxswig.i
@@ -57,9 +57,7 @@
 %ignore avc_netlink_check_nb;
 
 %include "../include/selinux/avc.h"
-%include "../include/selinux/av_permissions.h"
 %include "../include/selinux/context.h"
-%include "../include/selinux/flask.h"
 %include "../include/selinux/get_context_list.h"
 %include "../include/selinux/get_default_type.h"
 %include "../include/selinux/label.h"
-- 
2.1.0
