Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8M0I2xG009840
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 20:18:02 -0400
To: LSM <linux-security-module@vger.kernel.org>,
 James Morris <jmorris@namei.org>, SE Linux <selinux@tycho.nsa.gov>,
 LKLM <linux-kernel@vger.kernel.org>,
 John Johansen <john.johansen@canonical.com>,
 Kees Cook <keescook@chromium.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Alexey Dobriyan <adobriyan@gmail.com>, =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?=
 <mic@digikod.net>, Salvatore Mesoraca <s.mesoraca16@gmail.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <c7a864e4-1297-2973-9d4c-7c855a20a06d@schaufler-ca.com>
Date: Fri, 21 Sep 2018 17:17:34 -0700
MIME-Version: 1.0
In-Reply-To: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Subject: [PATCH v4 05/19] SELinux: Remove unused selinux_is_enabled
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

There are no longer users of selinux_is_enabled().
Remove it. As selinux_is_enabled() is the only reason
for include/linux/selinux.h remove that as well.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/cred.h             |  1 -
 include/linux/selinux.h          | 35 --------------------------------
 security/selinux/Makefile        |  2 +-
 security/selinux/exports.c       | 23 ---------------------
 security/selinux/hooks.c         |  1 -
 security/selinux/include/audit.h |  3 ---
 security/selinux/ss/services.c   |  1 -
 7 files changed, 1 insertion(+), 65 deletions(-)
 delete mode 100644 include/linux/selinux.h
 delete mode 100644 security/selinux/exports.c

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 7eed6101c791..2e715e202e6a 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -15,7 +15,6 @@
 #include <linux/capability.h>
 #include <linux/init.h>
 #include <linux/key.h>
-#include <linux/selinux.h>
 #include <linux/atomic.h>
 #include <linux/uidgid.h>
 #include <linux/sched.h>
diff --git a/include/linux/selinux.h b/include/linux/selinux.h
deleted file mode 100644
index 44f459612690..000000000000
--- a/include/linux/selinux.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/*
- * SELinux services exported to the rest of the kernel.
- *
- * Author: James Morris <jmorris@redhat.com>
- *
- * Copyright (C) 2005 Red Hat, Inc., James Morris <jmorris@redhat.com>
- * Copyright (C) 2006 Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
- * Copyright (C) 2006 IBM Corporation, Timothy R. Chavez <tinytim@us.ibm.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2,
- * as published by the Free Software Foundation.
- */
-#ifndef _LINUX_SELINUX_H
-#define _LINUX_SELINUX_H
-
-struct selinux_audit_rule;
-struct audit_context;
-struct kern_ipc_perm;
-
-#ifdef CONFIG_SECURITY_SELINUX
-
-/**
- * selinux_is_enabled - is SELinux enabled?
- */
-bool selinux_is_enabled(void);
-#else
-
-static inline bool selinux_is_enabled(void)
-{
-	return false;
-}
-#endif	/* CONFIG_SECURITY_SELINUX */
-
-#endif /* _LINUX_SELINUX_H */
diff --git a/security/selinux/Makefile b/security/selinux/Makefile
index c7161f8792b2..ccf950409384 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -6,7 +6,7 @@
 obj-$(CONFIG_SECURITY_SELINUX) := selinux.o
 
 selinux-y := avc.o hooks.o selinuxfs.o netlink.o nlmsgtab.o netif.o \
-	     netnode.o netport.o ibpkey.o exports.o \
+	     netnode.o netport.o ibpkey.o \
 	     ss/ebitmap.o ss/hashtab.o ss/symtab.o ss/sidtab.o ss/avtab.o \
 	     ss/policydb.o ss/services.o ss/conditional.o ss/mls.o ss/status.o
 
diff --git a/security/selinux/exports.c b/security/selinux/exports.c
deleted file mode 100644
index e75dd94e2d2b..000000000000
--- a/security/selinux/exports.c
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- * SELinux services exported to the rest of the kernel.
- *
- * Author: James Morris <jmorris@redhat.com>
- *
- * Copyright (C) 2005 Red Hat, Inc., James Morris <jmorris@redhat.com>
- * Copyright (C) 2006 Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
- * Copyright (C) 2006 IBM Corporation, Timothy R. Chavez <tinytim@us.ibm.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2,
- * as published by the Free Software Foundation.
- */
-#include <linux/module.h>
-#include <linux/selinux.h>
-
-#include "security.h"
-
-bool selinux_is_enabled(void)
-{
-	return selinux_enabled;
-}
-EXPORT_SYMBOL_GPL(selinux_is_enabled);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 80614ca25a2b..82b28ee878c4 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -79,7 +79,6 @@
 #include <linux/personality.h>
 #include <linux/audit.h>
 #include <linux/string.h>
-#include <linux/selinux.h>
 #include <linux/mutex.h>
 #include <linux/posix-timers.h>
 #include <linux/syslog.h>
diff --git a/security/selinux/include/audit.h b/security/selinux/include/audit.h
index 1bdf973433cc..36e1d44c0209 100644
--- a/security/selinux/include/audit.h
+++ b/security/selinux/include/audit.h
@@ -1,9 +1,6 @@
 /*
  * SELinux support for the Audit LSM hooks
  *
- * Most of below header was moved from include/linux/selinux.h which
- * is released under below copyrights:
- *
  * Author: James Morris <jmorris@redhat.com>
  *
  * Copyright (C) 2005 Red Hat, Inc., James Morris <jmorris@redhat.com>
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index f3def298a90e..e2235f1a99aa 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -49,7 +49,6 @@
 #include <linux/sched.h>
 #include <linux/audit.h>
 #include <linux/mutex.h>
-#include <linux/selinux.h>
 #include <linux/flex_array.h>
 #include <linux/vmalloc.h>
 #include <net/netlabel.h>
-- 
2.17.1
