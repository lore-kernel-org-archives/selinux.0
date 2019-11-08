Return-Path: <SRS0=6fGn=ZA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE685FC6196
	for <selinux@archiver.kernel.org>; Fri,  8 Nov 2019 21:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAEB220869
	for <selinux@archiver.kernel.org>; Fri,  8 Nov 2019 21:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfKHVSr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 Nov 2019 16:18:47 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:44607 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfKHVSr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 Nov 2019 16:18:47 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M7bJ5-1iYOAj2BGX-0080Jg; Fri, 08 Nov 2019 22:18:12 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Subject: [PATCH 20/23] y2038: move itimer reset into itimer.c
Date:   Fri,  8 Nov 2019 22:12:19 +0100
Message-Id: <20191108211323.1806194-11-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191108210236.1296047-1-arnd@arndb.de>
References: <20191108210236.1296047-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:cftdQ2oVdyPSduyUoNgNl7M3dzVudAM9sTy5LloysVNTgOb6AnF
 rWXqgtgdMd4tNJEO8Zptvt6Ij2R8xkhKKyx8MAw0emvUWvRDDzLVMiXiGc0I0Ak8jDONE2Y
 l5AOm3FG0hq9BgEFNNf9atKgw9RpMbzswxCdlNS7MU/Qa8TAuhE5a379xft8BHVxVDKJOOr
 6MDtEPF3z3KPkkPP8Negw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pumRZ9ygdRQ=:mAfvNHDsRdbjS5FtIwu5tO
 XmueAej5h3fWLZhrNU75if+MPBoZdFuYGvQoZHcgCcCNb+i2lVUU7yhNGH9iZAC/84ir0vRV2
 8E/4uxZG3slPA1Ho4sjlYHj4uv2+w/lWIpRFw0SB6VHBYH4WdSdU7RHySejUKJ0182g6VDcfC
 SRcB0Ix8XkIz64A45fmdM8vyW6Wv5Eoa5hQMHE8+O5fQvZmOtzuHXQrztCAyELsVgBksXeXde
 RnehV0RRxZivXcsa2G1PW3RsKSHKitz87yswPv8WxX8mt4rrk4whGbIL/XQsJO5vOF86YRylN
 mX9Y6TMgL2OcAmDD1sU3bxv1wr7t3QRbSgHMk4BtRMsGLSCiF5i3D0100MTkyHfR2qcPxmXjh
 PJzWDyEOmi48jC0cc6p/Ae1eXEHlRAidvjv/TZK+GdCHzMXE/ciADdM9E/rDgDB+Qyi0Uk6Cl
 1zyGlaTfNMFcq/hj8CkTBEJNWRJB3UUJoafDzyMV5qy7YT47k/qUfWIKfTrssB8dgR5KGTz4e
 dMkLSFs+vU5H1DHKdyYRHlAy9MwfNF7yu9kqWP7D9PbubJiOImgYbm4BfqoORUiwF5t0MtB7p
 xruKDEOC/DYAezaRkqvTDRd17X+QqgAlzOCGUM8kJ5QDbFWPrjvB82AVCvXEIYWBB2fhb9dbc
 u7ouRVmtKSxrwz6KqdDeaCcl0IZfa6Kfuwx4flu+JHZLqNncL7UbOkzKe9HeJMLbwZZ37RtuZ
 ao1nf8cJ70MH1W5hFNkxyc2ltMpHz3PzISPaIKE/xCcZxJ5v61manKOmFAY96Rmi36vSaKKbw
 tM3TtAxv4y+lceSoYyeq4YO2Pn0U+IO3iiQcIXrsN6OSVZ/nFSTwsT8icbbYhzUuM/bi7YaCY
 HRW0OOtSH66GYFVyfwlg==
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Preparing for a change to the itimer internals, stop using the
do_setitimer() symbol and instead use a new higher-level interface.

The do_getitimer()/do_setitimer functions can now be made static,
allowing the compiler to potentially produce better object code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/time.h     |  9 +++++----
 kernel/time/itimer.c     | 15 +++++++++++++--
 security/selinux/hooks.c | 10 +++-------
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/include/linux/time.h b/include/linux/time.h
index 27d83fd2ae61..0760a4f5a15c 100644
--- a/include/linux/time.h
+++ b/include/linux/time.h
@@ -35,10 +35,11 @@ extern time64_t mktime64(const unsigned int year, const unsigned int mon,
 extern u32 (*arch_gettimeoffset)(void);
 #endif
 
-struct itimerval;
-extern int do_setitimer(int which, struct itimerval *value,
-			struct itimerval *ovalue);
-extern int do_getitimer(int which, struct itimerval *value);
+#ifdef CONFIG_POSIX_TIMERS
+extern void clear_itimer(void);
+#else
+static inline void clear_itimer(void) {}
+#endif
 
 extern long do_utimes(int dfd, const char __user *filename, struct timespec64 *times, int flags);
 
diff --git a/kernel/time/itimer.c b/kernel/time/itimer.c
index 4664c6addf69..ce9cd19ce72e 100644
--- a/kernel/time/itimer.c
+++ b/kernel/time/itimer.c
@@ -73,7 +73,7 @@ static void get_cpu_itimer(struct task_struct *tsk, unsigned int clock_id,
 	value->it_interval = ns_to_timeval(interval);
 }
 
-int do_getitimer(int which, struct itimerval *value)
+static int do_getitimer(int which, struct itimerval *value)
 {
 	struct task_struct *tsk = current;
 
@@ -197,7 +197,7 @@ static void set_cpu_itimer(struct task_struct *tsk, unsigned int clock_id,
 #define timeval_valid(t) \
 	(((t)->tv_sec >= 0) && (((unsigned long) (t)->tv_usec) < USEC_PER_SEC))
 
-int do_setitimer(int which, struct itimerval *value, struct itimerval *ovalue)
+static int do_setitimer(int which, struct itimerval *value, struct itimerval *ovalue)
 {
 	struct task_struct *tsk = current;
 	struct hrtimer *timer;
@@ -249,6 +249,17 @@ int do_setitimer(int which, struct itimerval *value, struct itimerval *ovalue)
 	return 0;
 }
 
+#ifdef CONFIG_SECURITY_SELINUX
+void clear_itimer(void)
+{
+	struct itimerval v = {};
+	int i;
+
+	for (i = 0; i < 3; i++)
+		do_setitimer(i, &v, NULL);
+}
+#endif
+
 #ifdef __ARCH_WANT_SYS_ALARM
 
 /**
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9625b99e677f..c3f2e89acb87 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2549,9 +2549,8 @@ static void selinux_bprm_committing_creds(struct linux_binprm *bprm)
 static void selinux_bprm_committed_creds(struct linux_binprm *bprm)
 {
 	const struct task_security_struct *tsec = selinux_cred(current_cred());
-	struct itimerval itimer;
 	u32 osid, sid;
-	int rc, i;
+	int rc;
 
 	osid = tsec->osid;
 	sid = tsec->sid;
@@ -2569,11 +2568,8 @@ static void selinux_bprm_committed_creds(struct linux_binprm *bprm)
 	rc = avc_has_perm(&selinux_state,
 			  osid, sid, SECCLASS_PROCESS, PROCESS__SIGINH, NULL);
 	if (rc) {
-		if (IS_ENABLED(CONFIG_POSIX_TIMERS)) {
-			memset(&itimer, 0, sizeof itimer);
-			for (i = 0; i < 3; i++)
-				do_setitimer(i, &itimer, NULL);
-		}
+		if (IS_ENABLED(CONFIG_POSIX_TIMERS))
+			clear_itimer();
 		spin_lock_irq(&current->sighand->siglock);
 		if (!fatal_signal_pending(current)) {
 			flush_sigqueue(&current->pending);
-- 
2.20.0

