Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kALCPmIX030794
	for <selinux@tycho.nsa.gov>; Tue, 21 Nov 2006 07:25:48 -0500
Received: from wx-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kALCP6KX020343
	for <selinux@tycho.nsa.gov>; Tue, 21 Nov 2006 12:25:07 GMT
Received: by wx-out-0506.google.com with SMTP id t10so2257406wxc
        for <selinux@tycho.nsa.gov>; Tue, 21 Nov 2006 04:26:03 -0800 (PST)
Message-ID: <4562EFE0.5080807@kaigai.gr.jp>
Date: Tue, 21 Nov 2006 21:24:00 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Yoshinori Sato <yo-satoh@sios.com>,
        Yuichi Nakamura <ynakam@hitachisoft.jp>
Subject: Question about stat
Content-Type: multipart/mixed;
 boundary="------------060404060901090101010003"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060404060901090101010003
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

I found a strange behavior of the stat in coreutils-5.97-14.fc7.src.rpm.

see below,

[kaigai@masu ~]$ stat -c "%C" mytest.sql
(null)
[kaigai@masu ~]$ stat -Z -c "%C" mytest.sql
user_u:object_r:user_home_t:s0
[kaigai@masu ~]$

Because stat command without '-Z' option doesn't try to obtain
the security context of the files specified, the format string
which contains "%C" doesn't work correctly.

Is it expected behavior?

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--------------060404060901090101010003
Content-Type: text/x-patch;
 name="coreutils-selinux-fix-stat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="coreutils-selinux-fix-stat.patch"

--- coreutils-5.97.orig/src/stat.c	2006-11-21 20:44:35.000000000 +0900
+++ coreutils-5.97.kg/src/stat.c	2006-11-21 20:53:31.000000000 +0900
@@ -711,11 +711,15 @@ do_statfs (char const *filename, bool te
   STRUCT_STATVFS statfsbuf;
   SECURITY_ID_T scontext = NULL;
 #ifdef WITH_SELINUX
-  if(secure)
-    if (getfilecon(filename,&scontext)<0) {
-      perror (filename);
-      return false;
+  if (is_selinux_enabled()) {
+    if (getfilecon(filename,&scontext) < 0) {
+      if (secure) {
+	perror (filename);
+	return false;
+      }
+      scontext = NULL;
     }
+  }
 #endif
 
   if (STATFS (filename, &statfsbuf) != 0)
@@ -775,17 +779,17 @@ do_stat (char const *filename, bool foll
     }
 
 #ifdef WITH_SELINUX
-  if(secure) {
-    int i;
-    if (!follow_links) 
-      i=lgetfilecon(filename, &scontext);
-    else
-      i=getfilecon(filename, &scontext);
-    if (i == -1)
-      {
+  if (is_selinux_enabled()) {
+    int rc = (!follow_links
+	      ? lgetfilecon(filename, &scontext)
+	      : getfilecon(filename, &scontext));
+    if (rc < 0) {
+      scontext = NULL;
+      if (secure) {
 	perror (filename);
 	return false;
       }
+    }
   }
 #endif
 

--------------060404060901090101010003--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
