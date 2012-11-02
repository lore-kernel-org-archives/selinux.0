From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] Update my email address.
Date: Fri,  2 Nov 2012 11:25:35 -0400
Message-Id: <1351869935-15243-1-git-send-email-sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 checkpolicy/checkmodule.8                     | 2 +-
 checkpolicy/checkpolicy.8                     | 4 ++--
 checkpolicy/checkpolicy.c                     | 2 +-
 checkpolicy/policy_define.c                   | 2 +-
 checkpolicy/policy_parse.y                    | 2 +-
 checkpolicy/policy_scan.l                     | 2 +-
 checkpolicy/queue.c                           | 2 +-
 checkpolicy/queue.h                           | 2 +-
 libselinux/src/avc.c                          | 2 +-
 libsepol/include/sepol/policydb/avtab.h       | 2 +-
 libsepol/include/sepol/policydb/constraint.h  | 2 +-
 libsepol/include/sepol/policydb/context.h     | 2 +-
 libsepol/include/sepol/policydb/ebitmap.h     | 2 +-
 libsepol/include/sepol/policydb/flask_types.h | 2 +-
 libsepol/include/sepol/policydb/hashtab.h     | 2 +-
 libsepol/include/sepol/policydb/mls_types.h   | 2 +-
 libsepol/include/sepol/policydb/policydb.h    | 2 +-
 libsepol/include/sepol/policydb/services.h    | 2 +-
 libsepol/include/sepol/policydb/sidtab.h      | 2 +-
 libsepol/include/sepol/policydb/symtab.h      | 2 +-
 libsepol/man/man3/sepol_genbools.3            | 2 +-
 libsepol/man/man8/genpolbools.8               | 2 +-
 libsepol/src/avtab.c                          | 2 +-
 libsepol/src/ebitmap.c                        | 2 +-
 libsepol/src/hashtab.c                        | 2 +-
 libsepol/src/mls.c                            | 2 +-
 libsepol/src/mls.h                            | 2 +-
 libsepol/src/policydb.c                       | 2 +-
 libsepol/src/services.c                       | 2 +-
 libsepol/src/sidtab.c                         | 2 +-
 libsepol/src/symtab.c                         | 2 +-
 libsepol/src/write.c                          | 2 +-
 policycoreutils/load_policy/load_policy.8     | 2 +-
 policycoreutils/newrole/hashtab.c             | 2 +-
 policycoreutils/newrole/hashtab.h             | 2 +-
 policycoreutils/setfiles/setfiles.8           | 2 +-
 36 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/checkpolicy/checkmodule.8 b/checkpolicy/checkmodule.8
index 40f73c5..b62ddc2 100644
--- a/checkpolicy/checkmodule.8
+++ b/checkpolicy/checkmodule.8
@@ -61,4 +61,4 @@ especially "Configuring the SELinux Policy".
 This manual page was copied from the checkpolicy man page 
 written by Arpad Magosanyi <mag@bunuel.tii.matav.hu>, 
 and edited by Dan Walsh <dwalsh@redhat.com>.
-The program was written by Stephen Smalley <sds@epoch.ncsc.mil>.
+The program was written by Stephen Smalley <sds@tycho.nsa.gov>.
diff --git a/checkpolicy/checkpolicy.8 b/checkpolicy/checkpolicy.8
index 6826938..7bb472c 100644
--- a/checkpolicy/checkpolicy.8
+++ b/checkpolicy/checkpolicy.8
@@ -52,5 +52,5 @@ especially "Configuring the SELinux Policy".
 
 .SH AUTHOR
 This manual page was written by Arpad Magosanyi <mag@bunuel.tii.matav.hu>,
-and edited by Stephen Smalley <sds@epoch.ncsc.mil>.
-The program was written by Stephen Smalley <sds@epoch.ncsc.mil>.
+and edited by Stephen Smalley <sds@tycho.nsa.gov>.
+The program was written by Stephen Smalley <sds@tycho.nsa.gov>.
diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index 544f235..6bb361e 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -1,6 +1,6 @@
 
 /*
- * Author : Stephen Smalley, <sds@epoch.ncsc.mil> 
+ * Author : Stephen Smalley, <sds@tycho.nsa.gov> 
  */
 
 /*
diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 2c12447..bd24deb 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -1,5 +1,5 @@
 /*
- * Author : Stephen Smalley, <sds@epoch.ncsc.mil> 
+ * Author : Stephen Smalley, <sds@tycho.nsa.gov> 
  */
 
 /*
diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
index d92cc32..87b8f7c 100644
--- a/checkpolicy/policy_parse.y
+++ b/checkpolicy/policy_parse.y
@@ -1,6 +1,6 @@
 
 /*
- * Author : Stephen Smalley, <sds@epoch.ncsc.mil> 
+ * Author : Stephen Smalley, <sds@tycho.nsa.gov> 
  */
 
 /*
diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index 62d03f0..b81fc18 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -1,6 +1,6 @@
 
 /* 
- * Author : Stephen Smalley, <sds@epoch.ncsc.mil> 
+ * Author : Stephen Smalley, <sds@tycho.nsa.gov> 
  */
 
 /* Updated: David Caplan, <dac@tresys.com>
diff --git a/checkpolicy/queue.c b/checkpolicy/queue.c
index 272079c..c06a48d 100644
--- a/checkpolicy/queue.c
+++ b/checkpolicy/queue.c
@@ -1,5 +1,5 @@
 
-/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
 
 /* FLASK */
 
diff --git a/checkpolicy/queue.h b/checkpolicy/queue.h
index 655c94b..60c07fe 100644
--- a/checkpolicy/queue.h
+++ b/checkpolicy/queue.h
@@ -1,5 +1,5 @@
 
-/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
 
 /* FLASK */
 
diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
index 802a07f..af8e2c3 100644
--- a/libselinux/src/avc.c
+++ b/libselinux/src/avc.c
@@ -4,7 +4,7 @@
  * Author : Eamon Walsh <ewalsh@epoch.ncsc.mil>
  *
  * Derived from the kernel AVC implementation by
- * Stephen Smalley <sds@epoch.ncsc.mil> and 
+ * Stephen Smalley <sds@tycho.nsa.gov> and 
  * James Morris <jmorris@redhat.com>.
  */
 #include <selinux/avc.h>
diff --git a/libsepol/include/sepol/policydb/avtab.h b/libsepol/include/sepol/policydb/avtab.h
index 6955ecf..cca099f 100644
--- a/libsepol/include/sepol/policydb/avtab.h
+++ b/libsepol/include/sepol/policydb/avtab.h
@@ -1,5 +1,5 @@
 
-/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
 
 /*
  * Updated: Yuichi Nakamura <ynakam@hitachisoft.jp>
diff --git a/libsepol/include/sepol/policydb/constraint.h b/libsepol/include/sepol/policydb/constraint.h
index 4c16ab0..10daf71 100644
--- a/libsepol/include/sepol/policydb/constraint.h
+++ b/libsepol/include/sepol/policydb/constraint.h
@@ -1,5 +1,5 @@
 
-/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
 
 /* FLASK */
 
diff --git a/libsepol/include/sepol/policydb/context.h b/libsepol/include/sepol/policydb/context.h
index 8d74a25..02459c9 100644
--- a/libsepol/include/sepol/policydb/context.h
+++ b/libsepol/include/sepol/policydb/context.h
@@ -1,5 +1,5 @@
 
-/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
 
 /* FLASK */
 
diff --git a/libsepol/include/sepol/policydb/ebitmap.h b/libsepol/include/sepol/policydb/ebitmap.h
index 214da95..e1eec78 100644
--- a/libsepol/include/sepol/policydb/ebitmap.h
+++ b/libsepol/include/sepol/policydb/ebitmap.h
@@ -1,5 +1,5 @@
 
-/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
 
 /* FLASK */
 
diff --git a/libsepol/include/sepol/policydb/flask_types.h b/libsepol/include/sepol/policydb/flask_types.h
index 575c6f2..fda86d9 100644
--- a/libsepol/include/sepol/policydb/flask_types.h
+++ b/libsepol/include/sepol/policydb/flask_types.h
@@ -2,7 +2,7 @@
 /* -*- linux-c -*- */
 
 /*
- * Author : Stephen Smalley, <sds@epoch.ncsc.mil> 
+ * Author : Stephen Smalley, <sds@tycho.nsa.gov> 
  */
 
 #ifndef _SEPOL_POLICYDB_FLASK_TYPES_H_
diff --git a/libsepol/include/sepol/policydb/hashtab.h b/libsepol/include/sepol/policydb/hashtab.h
index 1081ff6..e8d1fe3 100644
--- a/libsepol/include/sepol/policydb/hashtab.h
+++ b/libsepol/include/sepol/policydb/hashtab.h
@@ -1,5 +1,5 @@
 
-/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
 
 /* FLASK */
 
diff --git a/libsepol/include/sepol/policydb/mls_types.h b/libsepol/include/sepol/policydb/mls_types.h
index e491209..b7040ba 100644
--- a/libsepol/include/sepol/policydb/mls_types.h
+++ b/libsepol/include/sepol/policydb/mls_types.h
@@ -1,5 +1,5 @@
 
-/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
 /*
  * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
  *
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index f53a499..9ebf717 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -1,5 +1,5 @@
 
-/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
 
 /*
  * Updated: Joshua Brindle <jbrindle@tresys.com>
diff --git a/libsepol/include/sepol/policydb/services.h b/libsepol/include/sepol/policydb/services.h
index aef0c7b..6335e97 100644
--- a/libsepol/include/sepol/policydb/services.h
+++ b/libsepol/include/sepol/policydb/services.h
@@ -2,7 +2,7 @@
 /* -*- linux-c -*- */
 
 /*
- * Author : Stephen Smalley, <sds@epoch.ncsc.mil> 
+ * Author : Stephen Smalley, <sds@tycho.nsa.gov> 
  */
 
 #ifndef _SEPOL_POLICYDB_SERVICES_H_
diff --git a/libsepol/include/sepol/policydb/sidtab.h b/libsepol/include/sepol/policydb/sidtab.h
index 33c7cb5..b86b652 100644
--- a/libsepol/include/sepol/policydb/sidtab.h
+++ b/libsepol/include/sepol/policydb/sidtab.h
@@ -1,5 +1,5 @@
 
-/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
 
 /* FLASK */
 
diff --git a/libsepol/include/sepol/policydb/symtab.h b/libsepol/include/sepol/policydb/symtab.h
index c8ad664..d455cf5 100644
--- a/libsepol/include/sepol/policydb/symtab.h
+++ b/libsepol/include/sepol/policydb/symtab.h
@@ -1,5 +1,5 @@
 
-/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
 
 /* FLASK */
 
diff --git a/libsepol/man/man3/sepol_genbools.3 b/libsepol/man/man3/sepol_genbools.3
index 0a30137..6e209d6 100644
--- a/libsepol/man/man3/sepol_genbools.3
+++ b/libsepol/man/man3/sepol_genbools.3
@@ -1,4 +1,4 @@
-.TH "sepol_genbools" "3" "11 August 2004" "sds@epoch.ncsc.mil" "SE Linux binary policy API documentation"
+.TH "sepol_genbools" "3" "11 August 2004" "sds@tycho.nsa.gov" "SE Linux binary policy API documentation"
 .SH "NAME"
 sepol_genbools \- Rewrite a binary policy with different boolean settings
 .SH "SYNOPSIS"
diff --git a/libsepol/man/man8/genpolbools.8 b/libsepol/man/man8/genpolbools.8
index afeaced..fc792c8 100644
--- a/libsepol/man/man8/genpolbools.8
+++ b/libsepol/man/man8/genpolbools.8
@@ -1,4 +1,4 @@
-.TH "genpolbools" "8" "11 August 2004" "sds@epoch.ncsc.mil" "SELinux Command Line documentation"
+.TH "genpolbools" "8" "11 August 2004" "sds@tycho.nsa.gov" "SELinux Command Line documentation"
 .SH "NAME"
 genpolbools \- Rewrite a binary policy with different boolean settings
 .SH "SYNOPSIS"
diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
index ea947cb..ea062ae 100644
--- a/libsepol/src/avtab.c
+++ b/libsepol/src/avtab.c
@@ -1,5 +1,5 @@
 
-/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
 
 /*
  * Updated: Yuichi Nakamura <ynakam@hitachisoft.jp>
diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
index be6b591..17993fe 100644
--- a/libsepol/src/ebitmap.c
+++ b/libsepol/src/ebitmap.c
@@ -1,5 +1,5 @@
 
-/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
 
 /* FLASK */
 
diff --git a/libsepol/src/hashtab.c b/libsepol/src/hashtab.c
index c4be72c..dbf7721 100644
--- a/libsepol/src/hashtab.c
+++ b/libsepol/src/hashtab.c
@@ -1,5 +1,5 @@
 
-/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
 
 /*
  * Updated : Karl MacMillan <kmacmillan@mentalrootkit.com>
diff --git a/libsepol/src/mls.c b/libsepol/src/mls.c
index 1e84bb7..a620018 100644
--- a/libsepol/src/mls.c
+++ b/libsepol/src/mls.c
@@ -1,4 +1,4 @@
-/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
 /*
  * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
  *
diff --git a/libsepol/src/mls.h b/libsepol/src/mls.h
index 98da3d3..13eb48f 100644
--- a/libsepol/src/mls.h
+++ b/libsepol/src/mls.h
@@ -1,4 +1,4 @@
-/* Author: Stephen Smalley, <sds@epoch.ncsc.mil> 
+/* Author: Stephen Smalley, <sds@tycho.nsa.gov> 
  * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
  * 
  *      Support for enhanced MLS infrastructure.
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index ff292f6..7cbffb8 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -1,5 +1,5 @@
 
-/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
 
 /*
  * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index 9c2920c..91cb60c 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -1,6 +1,6 @@
 
 /*
- * Author : Stephen Smalley, <sds@epoch.ncsc.mil> 
+ * Author : Stephen Smalley, <sds@tycho.nsa.gov> 
  */
 /*
  * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
diff --git a/libsepol/src/sidtab.c b/libsepol/src/sidtab.c
index 5bd7999..23b2e8f 100644
--- a/libsepol/src/sidtab.c
+++ b/libsepol/src/sidtab.c
@@ -1,5 +1,5 @@
 
-/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
 
 /* FLASK */
 
diff --git a/libsepol/src/symtab.c b/libsepol/src/symtab.c
index b3a7aa8..f53357e 100644
--- a/libsepol/src/symtab.c
+++ b/libsepol/src/symtab.c
@@ -1,5 +1,5 @@
 
-/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
 
 /* FLASK */
 
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 22e6143..d8d2bd9 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -1,5 +1,5 @@
 
-/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
 
 /*
  * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
diff --git a/policycoreutils/load_policy/load_policy.8 b/policycoreutils/load_policy/load_policy.8
index f9ca36e..4769912 100644
--- a/policycoreutils/load_policy/load_policy.8
+++ b/policycoreutils/load_policy/load_policy.8
@@ -40,4 +40,4 @@ Initial policy load failed and enforcing mode requested
 .SH AUTHORS
 .nf
 This manual page was written by Dan Walsh <dwalsh@redhat.com>.
-The program was written by Stephen Smalley <sds@epoch.ncsc.mil>.
+The program was written by Stephen Smalley <sds@tycho.nsa.gov>.
diff --git a/policycoreutils/newrole/hashtab.c b/policycoreutils/newrole/hashtab.c
index 0442ab3..f49dc05 100644
--- a/policycoreutils/newrole/hashtab.c
+++ b/policycoreutils/newrole/hashtab.c
@@ -1,5 +1,5 @@
 
-/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
 
 /* FLASK */
 
diff --git a/policycoreutils/newrole/hashtab.h b/policycoreutils/newrole/hashtab.h
index abc80c3..5b6926f 100644
--- a/policycoreutils/newrole/hashtab.h
+++ b/policycoreutils/newrole/hashtab.h
@@ -1,5 +1,5 @@
 
-/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
 
 /* FLASK */
 
diff --git a/policycoreutils/setfiles/setfiles.8 b/policycoreutils/setfiles/setfiles.8
index 7ff54f9..44b49e3 100644
--- a/policycoreutils/setfiles/setfiles.8
+++ b/policycoreutils/setfiles/setfiles.8
@@ -123,7 +123,7 @@ option is used.
 
 .SH "AUTHOR"
 This man page was written by Russell Coker <russell@coker.com.au>.
-The program was written by Stephen Smalley <sds@epoch.ncsc.mil>
+The program was written by Stephen Smalley <sds@tycho.nsa.gov>
 
 .SH "SEE ALSO"
 .BR restorecon (8),
-- 
1.7.11.7


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
