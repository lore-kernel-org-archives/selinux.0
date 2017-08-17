From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Date: Thu, 17 Aug 2017 14:19:46 -0400
Message-Id: <20170817181946.7444-1-sds@tycho.nsa.gov>
Subject: [PATCH] checkpolicy, libselinux, libsepol,
 policycoreutils: Update my email address
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Update my email address since epoch.ncsc.mil no longer exists.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
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
index ee95882..cf76591 100644
--- a/checkpolicy/checkmodule.8
+++ b/checkpolicy/checkmodule.8
@@ -64,4 +64,4 @@ especially "Configuring the SELinux Policy".
 This manual page was copied from the checkpolicy man page 
 written by Arpad Magosanyi <mag@bunuel.tii.matav.hu>, 
 and edited by Dan Walsh <dwalsh@redhat.com>.
-The program was written by Stephen Smalley <sds@epoch.ncsc.mil>.
+The program was written by Stephen Smalley <sds@tycho.nsa.gov>.
diff --git a/checkpolicy/checkpolicy.8 b/checkpolicy/checkpolicy.8
index 7b28696..1c8805d 100644
--- a/checkpolicy/checkpolicy.8
+++ b/checkpolicy/checkpolicy.8
@@ -58,5 +58,5 @@ especially "Configuring the SELinux Policy".
 
 .SH AUTHOR
 This manual page was written by Arpad Magosanyi <mag@bunuel.tii.matav.hu>,
-and edited by Stephen Smalley <sds@epoch.ncsc.mil>.
-The program was written by Stephen Smalley <sds@epoch.ncsc.mil>.
+and edited by Stephen Smalley <sds@tycho.nsa.gov>.
+The program was written by Stephen Smalley <sds@tycho.nsa.gov>.
diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index b75f2af..923b47c 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -1,6 +1,6 @@
 
 /*
- * Author : Stephen Smalley, <sds@epoch.ncsc.mil> 
+ * Author : Stephen Smalley, <sds@tycho.nsa.gov>
  */
 
 /*
diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index f12ebdb..2c5db55 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -1,5 +1,5 @@
 /*
- * Author : Stephen Smalley, <sds@epoch.ncsc.mil> 
+ * Author : Stephen Smalley, <sds@tycho.nsa.gov>
  */
 
 /*
diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
index 6b406c8..247bd4e 100644
--- a/checkpolicy/policy_parse.y
+++ b/checkpolicy/policy_parse.y
@@ -1,6 +1,6 @@
 
 /*
- * Author : Stephen Smalley, <sds@epoch.ncsc.mil> 
+ * Author : Stephen Smalley, <sds@tycho.nsa.gov>
  */
 
 /*
diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index e6c4898..e93ccb6 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -1,6 +1,6 @@
 
 /* 
- * Author : Stephen Smalley, <sds@epoch.ncsc.mil> 
+ * Author : Stephen Smalley, <sds@tycho.nsa.gov>
  */
 
 /* Updated: David Caplan, <dac@tresys.com>
diff --git a/checkpolicy/queue.c b/checkpolicy/queue.c
index acc991c..82e6673 100644
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
index 96b2678..5230efd 100644
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
index 958848e..10ecde9 100644
--- a/libsepol/include/sepol/policydb/avtab.h
+++ b/libsepol/include/sepol/policydb/avtab.h
@@ -1,5 +1,5 @@
 
-/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
 
 /*
  * Updated: Yuichi Nakamura <ynakam@hitachisoft.jp>
diff --git a/libsepol/include/sepol/policydb/constraint.h b/libsepol/include/sepol/policydb/constraint.h
index 927bdc0..b91fc4e 100644
--- a/libsepol/include/sepol/policydb/constraint.h
+++ b/libsepol/include/sepol/policydb/constraint.h
@@ -1,4 +1,4 @@
-/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
 
 /* FLASK */
 
diff --git a/libsepol/include/sepol/policydb/context.h b/libsepol/include/sepol/policydb/context.h
index 2eaa686..c27c334 100644
--- a/libsepol/include/sepol/policydb/context.h
+++ b/libsepol/include/sepol/policydb/context.h
@@ -1,4 +1,4 @@
-/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
 
 /* FLASK */
 
diff --git a/libsepol/include/sepol/policydb/ebitmap.h b/libsepol/include/sepol/policydb/ebitmap.h
index e90371e..94fb7ef 100644
--- a/libsepol/include/sepol/policydb/ebitmap.h
+++ b/libsepol/include/sepol/policydb/ebitmap.h
@@ -1,4 +1,4 @@
-/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
 
 /* FLASK */
 
diff --git a/libsepol/include/sepol/policydb/flask_types.h b/libsepol/include/sepol/policydb/flask_types.h
index e01669c..714176f 100644
--- a/libsepol/include/sepol/policydb/flask_types.h
+++ b/libsepol/include/sepol/policydb/flask_types.h
@@ -1,7 +1,7 @@
 /* -*- linux-c -*- */
 
 /*
- * Author : Stephen Smalley, <sds@epoch.ncsc.mil> 
+ * Author : Stephen Smalley, <sds@tycho.nsa.gov>
  */
 
 #ifndef _SEPOL_POLICYDB_FLASK_TYPES_H_
diff --git a/libsepol/include/sepol/policydb/hashtab.h b/libsepol/include/sepol/policydb/hashtab.h
index ae5674a..ef1bb67 100644
--- a/libsepol/include/sepol/policydb/hashtab.h
+++ b/libsepol/include/sepol/policydb/hashtab.h
@@ -1,4 +1,4 @@
-/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
 
 /* FLASK */
 
diff --git a/libsepol/include/sepol/policydb/mls_types.h b/libsepol/include/sepol/policydb/mls_types.h
index 568386c..a06723b 100644
--- a/libsepol/include/sepol/policydb/mls_types.h
+++ b/libsepol/include/sepol/policydb/mls_types.h
@@ -1,4 +1,4 @@
-/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
 /*
  * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
  *
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index 1b2d782..f8626ef 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -1,4 +1,4 @@
-/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
 
 /*
  * Updated: Joshua Brindle <jbrindle@tresys.com>
diff --git a/libsepol/include/sepol/policydb/services.h b/libsepol/include/sepol/policydb/services.h
index efdf7de..6ef27a8 100644
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
index 2df1a50..893e6f0 100644
--- a/libsepol/include/sepol/policydb/sidtab.h
+++ b/libsepol/include/sepol/policydb/sidtab.h
@@ -1,4 +1,4 @@
-/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
 
 /* FLASK */
 
diff --git a/libsepol/include/sepol/policydb/symtab.h b/libsepol/include/sepol/policydb/symtab.h
index 68b5ad4..8b9ddca 100644
--- a/libsepol/include/sepol/policydb/symtab.h
+++ b/libsepol/include/sepol/policydb/symtab.h
@@ -1,5 +1,5 @@
 
-/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
 
 /* FLASK */
 
diff --git a/libsepol/man/man3/sepol_genbools.3 b/libsepol/man/man3/sepol_genbools.3
index dcfb69d..5363383 100644
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
index 3854d6f..257f051 100644
--- a/libsepol/src/avtab.c
+++ b/libsepol/src/avtab.c
@@ -1,5 +1,5 @@
 
-/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
 
 /*
  * Updated: Yuichi Nakamura <ynakam@hitachisoft.jp>
diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
index 218adc2..76e6e41 100644
--- a/libsepol/src/ebitmap.c
+++ b/libsepol/src/ebitmap.c
@@ -1,5 +1,5 @@
 
-/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
 
 /* FLASK */
 
diff --git a/libsepol/src/hashtab.c b/libsepol/src/hashtab.c
index ec49c15..f5407ab 100644
--- a/libsepol/src/hashtab.c
+++ b/libsepol/src/hashtab.c
@@ -1,5 +1,5 @@
 
-/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
 
 /*
  * Updated : Karl MacMillan <kmacmillan@mentalrootkit.com>
diff --git a/libsepol/src/mls.c b/libsepol/src/mls.c
index be85475..bf1fdbd 100644
--- a/libsepol/src/mls.c
+++ b/libsepol/src/mls.c
@@ -1,4 +1,4 @@
-/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
 /*
  * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
  *
diff --git a/libsepol/src/mls.h b/libsepol/src/mls.h
index 98da3d3..5ca3cd5 100644
--- a/libsepol/src/mls.h
+++ b/libsepol/src/mls.h
@@ -1,4 +1,4 @@
-/* Author: Stephen Smalley, <sds@epoch.ncsc.mil> 
+/* Author: Stephen Smalley, <sds@tycho.nsa.gov>
  * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
  * 
  *      Support for enhanced MLS infrastructure.
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 691101e..37788f3 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -1,5 +1,5 @@
 
-/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
 
 /*
  * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index 10338a6..d40793e 100644
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
index c1e625d..9a417ca 100644
--- a/libsepol/src/symtab.c
+++ b/libsepol/src/symtab.c
@@ -1,5 +1,5 @@
 
-/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
 
 /* FLASK */
 
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index e486e28..1fb3095 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -1,5 +1,5 @@
 
-/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
 
 /*
  * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
diff --git a/policycoreutils/load_policy/load_policy.8 b/policycoreutils/load_policy/load_policy.8
index 5f5550d..0810995 100644
--- a/policycoreutils/load_policy/load_policy.8
+++ b/policycoreutils/load_policy/load_policy.8
@@ -39,4 +39,4 @@ Initial policy load failed and enforcing mode requested
 .SH AUTHORS
 .nf
 This manual page was written by Dan Walsh <dwalsh@redhat.com>.
-The program was written by Stephen Smalley <sds@epoch.ncsc.mil>.
+The program was written by Stephen Smalley <sds@tycho.nsa.gov>.
diff --git a/policycoreutils/newrole/hashtab.c b/policycoreutils/newrole/hashtab.c
index 77ed143..24c65c4 100644
--- a/policycoreutils/newrole/hashtab.c
+++ b/policycoreutils/newrole/hashtab.c
@@ -1,5 +1,5 @@
 
-/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
 
 /* FLASK */
 
diff --git a/policycoreutils/newrole/hashtab.h b/policycoreutils/newrole/hashtab.h
index 9f737df..3790f0a 100644
--- a/policycoreutils/newrole/hashtab.h
+++ b/policycoreutils/newrole/hashtab.h
@@ -1,5 +1,5 @@
 
-/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
 
 /* FLASK */
 
diff --git a/policycoreutils/setfiles/setfiles.8 b/policycoreutils/setfiles/setfiles.8
index 9501845..ccaaf4d 100644
--- a/policycoreutils/setfiles/setfiles.8
+++ b/policycoreutils/setfiles/setfiles.8
@@ -255,7 +255,7 @@ being updated provided there are no errors.
 
 .SH "AUTHOR"
 This man page was written by Russell Coker <russell@coker.com.au>.
-The program was written by Stephen Smalley <sds@epoch.ncsc.mil>
+The program was written by Stephen Smalley <sds@tycho.nsa.gov>
 
 .SH "SEE ALSO"
 .BR restorecon (8),
-- 
2.9.4
