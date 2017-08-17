From: Stephen Smalley <sds@tycho.nsa.gov>
To: paul@paul-moore.com
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 jmorris@namei.org, Stephen Smalley <sds@tycho.nsa.gov>
Date: Thu, 17 Aug 2017 13:32:36 -0400
Message-Id: <20170817173237.5858-1-sds@tycho.nsa.gov>
Subject: [PATCH 1/2] selinux: update my email address
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Update my email address since epoch.ncsc.mil no longer exists.
MAINTAINERS and CREDITS are already correct.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/avc.c              | 2 +-
 security/selinux/hooks.c            | 2 +-
 security/selinux/include/avc.h      | 2 +-
 security/selinux/include/avc_ss.h   | 2 +-
 security/selinux/include/objsec.h   | 2 +-
 security/selinux/include/security.h | 2 +-
 security/selinux/ss/avtab.c         | 2 +-
 security/selinux/ss/avtab.h         | 2 +-
 security/selinux/ss/constraint.h    | 2 +-
 security/selinux/ss/context.h       | 2 +-
 security/selinux/ss/ebitmap.c       | 2 +-
 security/selinux/ss/ebitmap.h       | 2 +-
 security/selinux/ss/hashtab.c       | 2 +-
 security/selinux/ss/hashtab.h       | 2 +-
 security/selinux/ss/mls.c           | 2 +-
 security/selinux/ss/mls.h           | 2 +-
 security/selinux/ss/mls_types.h     | 2 +-
 security/selinux/ss/policydb.c      | 2 +-
 security/selinux/ss/policydb.h      | 2 +-
 security/selinux/ss/services.c      | 2 +-
 security/selinux/ss/services.h      | 2 +-
 security/selinux/ss/sidtab.c        | 2 +-
 security/selinux/ss/sidtab.h        | 2 +-
 security/selinux/ss/symtab.c        | 2 +-
 security/selinux/ss/symtab.h        | 2 +-
 25 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 52f3c55..f14ae9c 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1,7 +1,7 @@
 /*
  * Implementation of the kernel access vector cache (AVC).
  *
- * Authors:  Stephen Smalley, <sds@epoch.ncsc.mil>
+ * Authors:  Stephen Smalley, <sds@tycho.nsa.gov>
  *	     James Morris <jmorris@redhat.com>
  *
  * Update:   KaiGai, Kohei <kaigai@ak.jp.nec.com>
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 04b8e10..2bd7b82 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3,7 +3,7 @@
  *
  *  This file contains the SELinux hook function implementations.
  *
- *  Authors:  Stephen Smalley, <sds@epoch.ncsc.mil>
+ *  Authors:  Stephen Smalley, <sds@tycho.nsa.gov>
  *	      Chris Vance, <cvance@nai.com>
  *	      Wayne Salamon, <wsalamon@nai.com>
  *	      James Morris <jmorris@redhat.com>
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index 0999df0..a5004e9 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -1,7 +1,7 @@
 /*
  * Access vector cache interface for object managers.
  *
- * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
+ * Author : Stephen Smalley, <sds@tycho.nsa.gov>
  */
 #ifndef _SELINUX_AVC_H_
 #define _SELINUX_AVC_H_
diff --git a/security/selinux/include/avc_ss.h b/security/selinux/include/avc_ss.h
index d5c3284..37d57da 100644
--- a/security/selinux/include/avc_ss.h
+++ b/security/selinux/include/avc_ss.h
@@ -1,7 +1,7 @@
 /*
  * Access vector cache interface for the security server.
  *
- * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
+ * Author : Stephen Smalley, <sds@tycho.nsa.gov>
  */
 #ifndef _SELINUX_AVC_SS_H_
 #define _SELINUX_AVC_SS_H_
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 6ebc61e..1649cd1 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -3,7 +3,7 @@
  *
  *  This file contains the SELinux security data structures for kernel objects.
  *
- *  Author(s):  Stephen Smalley, <sds@epoch.ncsc.mil>
+ *  Author(s):  Stephen Smalley, <sds@tycho.nsa.gov>
  *		Chris Vance, <cvance@nai.com>
  *		Wayne Salamon, <wsalamon@nai.com>
  *		James Morris <jmorris@redhat.com>
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 3e32317..28dfb2f 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -1,7 +1,7 @@
 /*
  * Security server interface.
  *
- * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
+ * Author : Stephen Smalley, <sds@tycho.nsa.gov>
  *
  */
 
diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 3628d3a..2c3c7d0 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -1,7 +1,7 @@
 /*
  * Implementation of the access vector table type.
  *
- * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
+ * Author : Stephen Smalley, <sds@tycho.nsa.gov>
  */
 
 /* Updated: Frank Mayer <mayerf@tresys.com> and Karl MacMillan <kmacmillan@tresys.com>
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index d946c9d..725853c 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -5,7 +5,7 @@
  * table is used to represent the type enforcement
  * tables.
  *
- *  Author : Stephen Smalley, <sds@epoch.ncsc.mil>
+ *  Author : Stephen Smalley, <sds@tycho.nsa.gov>
  */
 
 /* Updated: Frank Mayer <mayerf@tresys.com> and Karl MacMillan <kmacmillan@tresys.com>
diff --git a/security/selinux/ss/constraint.h b/security/selinux/ss/constraint.h
index 96fd947..33ae2ae 100644
--- a/security/selinux/ss/constraint.h
+++ b/security/selinux/ss/constraint.h
@@ -10,7 +10,7 @@
  * process from labeling an object with a different user
  * identity.
  *
- * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
+ * Author : Stephen Smalley, <sds@tycho.nsa.gov>
  */
 #ifndef _SS_CONSTRAINT_H_
 #define _SS_CONSTRAINT_H_
diff --git a/security/selinux/ss/context.h b/security/selinux/ss/context.h
index 212e347..a2c0f37c 100644
--- a/security/selinux/ss/context.h
+++ b/security/selinux/ss/context.h
@@ -10,7 +10,7 @@
  * security server and can be changed without affecting
  * clients of the security server.
  *
- * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
+ * Author : Stephen Smalley, <sds@tycho.nsa.gov>
  */
 #ifndef _SS_CONTEXT_H_
 #define _SS_CONTEXT_H_
diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index ad38299..fc28149 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -1,7 +1,7 @@
 /*
  * Implementation of the extensible bitmap type.
  *
- * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
+ * Author : Stephen Smalley, <sds@tycho.nsa.gov>
  */
 /*
  * Updated: Hewlett-Packard <paul@paul-moore.com>
diff --git a/security/selinux/ss/ebitmap.h b/security/selinux/ss/ebitmap.h
index 6d5a9ac..da1325d 100644
--- a/security/selinux/ss/ebitmap.h
+++ b/security/selinux/ss/ebitmap.h
@@ -9,7 +9,7 @@
  * an explicitly specified starting bit position within
  * the total bitmap.
  *
- * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
+ * Author : Stephen Smalley, <sds@tycho.nsa.gov>
  */
 #ifndef _SS_EBITMAP_H_
 #define _SS_EBITMAP_H_
diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
index 3858706..686c391 100644
--- a/security/selinux/ss/hashtab.c
+++ b/security/selinux/ss/hashtab.c
@@ -1,7 +1,7 @@
 /*
  * Implementation of the hash table type.
  *
- * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
+ * Author : Stephen Smalley, <sds@tycho.nsa.gov>
  */
 #include <linux/kernel.h>
 #include <linux/slab.h>
diff --git a/security/selinux/ss/hashtab.h b/security/selinux/ss/hashtab.h
index 953872c..009fb5e 100644
--- a/security/selinux/ss/hashtab.h
+++ b/security/selinux/ss/hashtab.h
@@ -5,7 +5,7 @@
  * functions for hash computation and key comparison are
  * provided by the creator of the table.
  *
- * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
+ * Author : Stephen Smalley, <sds@tycho.nsa.gov>
  */
 #ifndef _SS_HASHTAB_H_
 #define _SS_HASHTAB_H_
diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index e108884..d9dc34f4 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -1,7 +1,7 @@
 /*
  * Implementation of the multi-level security (MLS) policy.
  *
- * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
+ * Author : Stephen Smalley, <sds@tycho.nsa.gov>
  */
 /*
  * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
diff --git a/security/selinux/ss/mls.h b/security/selinux/ss/mls.h
index e4369e3..0f0a1d6 100644
--- a/security/selinux/ss/mls.h
+++ b/security/selinux/ss/mls.h
@@ -1,7 +1,7 @@
 /*
  * Multi-level security (MLS) policy operations.
  *
- * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
+ * Author : Stephen Smalley, <sds@tycho.nsa.gov>
  */
 /*
  * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
diff --git a/security/selinux/ss/mls_types.h b/security/selinux/ss/mls_types.h
index e936487..47f3702 100644
--- a/security/selinux/ss/mls_types.h
+++ b/security/selinux/ss/mls_types.h
@@ -1,7 +1,7 @@
 /*
  * Type definitions for the multi-level security (MLS) policy.
  *
- * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
+ * Author : Stephen Smalley, <sds@tycho.nsa.gov>
  */
 /*
  * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index aa6500a..6e8c805 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1,7 +1,7 @@
 /*
  * Implementation of the policy database.
  *
- * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
+ * Author : Stephen Smalley, <sds@tycho.nsa.gov>
  */
 
 /*
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 5d23eed..215f8f3 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -2,7 +2,7 @@
  * A policy database (policydb) specifies the
  * configuration data for the security policy.
  *
- * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
+ * Author : Stephen Smalley, <sds@tycho.nsa.gov>
  */
 
 /*
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 16c55de..e4a1c0d 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1,7 +1,7 @@
 /*
  * Implementation of the security services.
  *
- * Authors : Stephen Smalley, <sds@epoch.ncsc.mil>
+ * Authors : Stephen Smalley, <sds@tycho.nsa.gov>
  *	     James Morris <jmorris@redhat.com>
  *
  * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
diff --git a/security/selinux/ss/services.h b/security/selinux/ss/services.h
index 6abcd87..3d9fa95 100644
--- a/security/selinux/ss/services.h
+++ b/security/selinux/ss/services.h
@@ -1,7 +1,7 @@
 /*
  * Implementation of the security services.
  *
- * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
+ * Author : Stephen Smalley, <sds@tycho.nsa.gov>
  */
 #ifndef _SS_SERVICES_H_
 #define _SS_SERVICES_H_
diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index c5f436b..6ae08ef 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -1,7 +1,7 @@
 /*
  * Implementation of the SID table type.
  *
- * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
+ * Author : Stephen Smalley, <sds@tycho.nsa.gov>
  */
 #include <linux/kernel.h>
 #include <linux/slab.h>
diff --git a/security/selinux/ss/sidtab.h b/security/selinux/ss/sidtab.h
index 84dc154..de5d0ea 100644
--- a/security/selinux/ss/sidtab.h
+++ b/security/selinux/ss/sidtab.h
@@ -2,7 +2,7 @@
  * A security identifier table (sidtab) is a hash table
  * of security context structures indexed by SID value.
  *
- * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
+ * Author : Stephen Smalley, <sds@tycho.nsa.gov>
  */
 #ifndef _SS_SIDTAB_H_
 #define _SS_SIDTAB_H_
diff --git a/security/selinux/ss/symtab.c b/security/selinux/ss/symtab.c
index 160326e..d1a6745 100644
--- a/security/selinux/ss/symtab.c
+++ b/security/selinux/ss/symtab.c
@@ -1,7 +1,7 @@
 /*
  * Implementation of the symbol table type.
  *
- * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
+ * Author : Stephen Smalley, <sds@tycho.nsa.gov>
  */
 #include <linux/kernel.h>
 #include <linux/string.h>
diff --git a/security/selinux/ss/symtab.h b/security/selinux/ss/symtab.h
index ca422b4..0bc12d5 100644
--- a/security/selinux/ss/symtab.h
+++ b/security/selinux/ss/symtab.h
@@ -4,7 +4,7 @@
  * is arbitrary.  The symbol table type is implemented
  * using the hash table type (hashtab).
  *
- * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
+ * Author : Stephen Smalley, <sds@tycho.nsa.gov>
  */
 #ifndef _SS_SYMTAB_H_
 #define _SS_SYMTAB_H_
-- 
2.9.4
