Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA24697
	for <selinux@tycho.nsa.gov>; Thu, 6 Sep 2001 09:02:10 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA08030
	for <selinux@tycho.nsa.gov>; Thu, 6 Sep 2001 13:01:45 GMT
Received: from blackbird.intercode.com.au (blackbird.intercode.com.au [203.32.101.10])
	by jazzband.ncsc.mil  with ESMTP id NAA08026
	for <selinux@tycho.nsa.gov>; Thu, 6 Sep 2001 13:01:42 GMT
Received: from localhost (jmorris@localhost)
	by blackbird.intercode.com.au (8.9.3/8.9.3) with ESMTP id XAA28173
	for <selinux@tycho.nsa.gov>; Thu, 6 Sep 2001 23:02:01 +1000
Date: Thu, 6 Sep 2001 23:02:01 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: <selinux@tycho.nsa.gov>
Subject: [PATCH] safe memory allocation flags
Message-ID: <Pine.LNX.4.31.0109062231390.28083-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The patch below allows netdev_precondition() to be called safely from
interrupt context.

This can occur, for example, in the IP networking input path, which runs
under a softirq.  Under these conditions, kernel memory needs to be
allocated with the GFP_ATOMIC flag.  If anyone has seen an oops upon
network traffic immedately after booting, this may have been the cause.

- James
-- 
James Morris
<jmorris@intercode.com.au>

diff -urN -X /tmp/xmdiff module.orig/selinux_plug/hooks.c module/selinux_plug/hooks.c
--- module.orig/selinux_plug/hooks.c	Thu Aug 23 14:20:50 2001
+++ module/selinux_plug/hooks.c	Thu Sep  6 21:57:33 2001
@@ -308,7 +308,7 @@
 {
 	struct netdev_security_struct *nsec = dev->security;

-	nsec = kmalloc(sizeof(struct netdev_security_struct), GFP_KERNEL);
+	nsec = kmalloc(sizeof(struct netdev_security_struct), SAFE_ALLOC);
 	if (!nsec)
 		return -ENOMEM;
 	memset(nsec, 0, sizeof(struct netdev_security_struct));
diff -urN -X /tmp/xmdiff module.orig/selinux_plug/include/linux/flask/flask_types.h module/selinux_plug/include/linux/flask/flask_types.h
--- module.orig/selinux_plug/include/linux/flask/flask_types.h	Thu Jul 19 06:38:10 2001
+++ module/selinux_plug/include/linux/flask/flask_types.h	Thu Sep  6 21:58:37 2001
@@ -76,5 +76,15 @@

 #define CUR_SID current->sid

+#ifdef __KERNEL__
+/*
+ * Use this for memory allocation flags (e.g. for kmalloc()) when the interrupt
+ * state is unknown.
+ */
+#include <linux/interrupt.h>
+
+#define SAFE_ALLOC (in_interrupt () ? GFP_ATOMIC : GFP_KERNEL)
+#endif
+
 #endif

diff -urN -X /tmp/xmdiff module.orig/selinux_plug/ss/global.h module/selinux_plug/ss/global.h
--- module.orig/selinux_plug/ss/global.h	Thu Jul 19 06:38:07 2001
+++ module/selinux_plug/ss/global.h	Thu Sep  6 22:19:22 2001
@@ -77,7 +77,7 @@
 #include <asm/uaccess.h>
 #include "selinux_plug.h"

-#define malloc(size) kmalloc(size, GFP_ATOMIC)
+#define malloc(size) kmalloc(size, SAFE_ALLOC)
 #define free(ptr) kfree(ptr)

 typedef struct file FILE;


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
