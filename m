Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0PEhJFn025857
	for <selinux@tycho.nsa.gov>; Thu, 25 Jan 2007 09:43:19 -0500
Received: from wx-out-0506.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0PEi5XF019513
	for <selinux@tycho.nsa.gov>; Thu, 25 Jan 2007 14:44:18 GMT
Received: by wx-out-0506.google.com with SMTP id s17so554583wxc
        for <selinux@tycho.nsa.gov>; Thu, 25 Jan 2007 06:44:19 -0800 (PST)
Message-ID: <45B8C23B.5090503@kaigai.gr.jp>
Date: Thu, 25 Jan 2007 23:44:11 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: busybox@busybox.net, selinux@tycho.nsa.gov
CC: rob@landley.net, dwalsh@redhat.com, russell@coker.com.au,
        busybox@kaigai.gr.jp
Subject: [PATCH 3/8] busybox -- libselinux utilities applets
References: <45B8C039.10907@kaigai.gr.jp>
In-Reply-To: <45B8C039.10907@kaigai.gr.jp>
Content-Type: multipart/mixed;
 boundary="------------000607060702090305070107"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000607060702090305070107
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

[3/8] busybox-libselinux-03-selinuxenabled.patch
  selinuxenabled returns 0 as a command exit code,
  if SELinux is enabled.
  Typically, shell-scripts use it to decide whether
  SELinux is working, or not.

Signed-off-by: Hiroshi Shinji <shiroshi@my.email.ne.jp>
Signed-off-by: KaiGai Kohei <kaigai@kaigai.gr.jp>

--
KaiGai Kohei <kaigai@kaigai.gr.jp>


--------------000607060702090305070107
Content-Type: text/x-patch;
 name="busybox-libselinux-03-selinuxenabled.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="busybox-libselinux-03-selinuxenabled.patch"

Index: selinux/selinuxenabled.c
===================================================================
--- selinux/selinuxenabled.c	(revision 0)
+++ selinux/selinuxenabled.c	(revision 0)
@@ -0,0 +1,17 @@
+/*
+ * selinuxenabled
+ * 
+ * Based on libselinux 1.33.1
+ * Port to BusyBox  Hiroshi Shinji <shiroshi@my.email.ne.jp>
+ *
+ */
+#include "busybox.h"
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <selinux/selinux.h>
+
+int selinuxenabled_main(int argc, char **argv)
+{
+	return !is_selinux_enabled();
+}

--------------000607060702090305070107--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
