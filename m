Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q711KtY3000797
	for <selinux@tycho.nsa.gov>; Tue, 31 Jul 2012 21:20:55 -0400
Received: by ghbz13 with SMTP id z13so6916572ghb.12
        for <selinux@tycho.nsa.gov>; Tue, 31 Jul 2012 18:20:54 -0700 (PDT)
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Cc: William Roberts <w.roberts@sta.samsung.com>
Subject: [PATCH] Spelling correction and formatting fixed.
Date: Tue, 31 Jul 2012 18:20:31 -0700
Message-Id: <1343784031-23573-1-git-send-email-w.roberts@sta.samsung.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following commits introduced the issue:
75776a76
482698a6

Please apply to SEAndroidManager branch master

Change-Id: Id6f0ca6da33a001cf86b6ad4e83cbc2e523880c7
---
 jni/exception.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/jni/exception.c b/jni/exception.c
index 4189fe2..22bc1a7 100644
--- a/jni/exception.c
+++ b/jni/exception.c
@@ -23,10 +23,10 @@ throwNoClassDefError(JNIEnv *env, char *message) {
 	exClass = (*env)->FindClass( env, className );
 
 	if(exClass == NULL) {
-        ALOGE("Could no throw java/lang/NoClassDefFoundError");
-        /* If this happens, the program is out of control */
-        exit(42);
-    }
+            ALOGE("Could not throw java/lang/NoClassDefFoundError");
+            /* If this happens, the program is out of control */
+            exit(42);
+        }
 	return (*env)->ThrowNew( env, exClass, message );
 }
 
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
