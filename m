Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i87HlCrT028080
	for <selinux@tycho.nsa.gov>; Tue, 7 Sep 2004 13:47:14 -0400 (EDT)
Received: from mbox-o00.iijmio.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i87HkCxo015302
	for <selinux@tycho.nsa.gov>; Tue, 7 Sep 2004 17:46:18 GMT
Message-Id: <200409071747.i87HkxJ6012464@mms-r00.iijmio.jp>
Date: Tue, 07 Sep 2004 13:46:35 -0400
From: Yuichi Nakamura <himainu-ynakam@miomio.jp>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Cc: himainu-ynakam@miomio.jp
Subject: Re: PAM in suse9.1 (Re: SuSE 9.1 SELinux)
Content-Type: text/plain; charset=ISO-2022-JP
In-Reply-To: <OF296DC5F7.062BA6BF-ON49256F08.000B7FC4-49256F08.000D462A@jp.ibm.com>
References: <OF296DC5F7.062BA6BF-ON49256F08.000B7FC4-49256F08.000D462A@jp.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Takuya Mishina <TMISHINA@jp.ibm.com> wrote:
> Nakamura-san's patch for pam_unix module is useful to make newrole running 
> without setuid bit.
> I've changed my SuSE 9.1 to use Nakamura-san's patched pam_unix.so.
> (modify /etc/pam.d/newrole and install patched pam_unix.so to 
> /lib/security)
> After that newrole runs correctly without setuid bit.
It is found that there is a problem in SUSE's PAM from this fact.

You are using pam_unix.so instead of pam_unix2.so.
I looked the code of "pam_unix2.so" 
but I could not find the code to use helper program(such as unix_chkpwd).
This is a problem.

> I've changed my SuSE 9.1 to use Nakamura-san's patched pam_unix.so.
I forgot to attach diff for this ML.
The following is diff between FC3-test1's pam_unix and SUSE9.1's pam_unix.
--- Linux-PAM-0.77/modules/pam_unix/support.c	2004-09-06 11:12:15.548643432 -0400
+++ Linux-PAM-0.77.rh/modules/pam_unix/support.c	2004-09-06 11:09:14.194213496 -0400
@@ -24,7 +28,12 @@
 
 #include "md5.h"
 #include "support.h"
-
+#ifdef WITH_SELINUX
+#include <selinux/selinux.h>
+#define SELINUX_ENABLED is_selinux_enabled()>0
+#else
+#define SELINUX_ENABLED 0
+#endif
 extern char *crypt(const char *key, const char *salt);
 extern char *bigcrypt(const char *key, const char *salt);
 
@@ -569,8 +766,9 @@
 	}
 
 	retval = PAM_SUCCESS;
-	if (pwd == NULL || salt == NULL || strlen(salt) == 1) {
-		if (geteuid()) {
+	if (pwd == NULL || salt == NULL || strlen(salt) == 1) {
+	  
+		if (geteuid() || SELINUX_ENABLED) {
 			/* we are not root perhaps this is the reason? Run helper */
 			D(("running helper binary"));
 			retval = _unix_run_helper_binary(pamh, p, ctrl, name);


---
Yuichi Nakamura
Japan SELinux Users Group(JSELUG)
　　http://www.selinux.gr.jp/
Hitachi Software
    http://www.selinux.hitachi-sk.co.jp/en
The George Washington University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
