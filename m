Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6LKOYis017525
 for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2016 16:24:34 -0400
Received: by mail-pf0-f173.google.com with SMTP id x72so33565657pfd.2
 for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2016 13:24:32 -0700 (PDT)
From: John Stultz <john.stultz@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: John Stultz <john.stultz@linaro.org>, Kees Cook <keescook@chromium.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Arjan van de Ven <arjan@linux.intel.com>,
 Oren Laadan <orenl@cellrox.com>, Ruchi Kandoi <kandoiruchi@google.com>,
 Rom Lemarchand <romlem@android.com>, Todd Kjos <tkjos@google.com>,
 Colin Cross <ccross@android.com>, Nick Kralevich <nnk@google.com>,
 Dmitry Shmidt <dimitrysh@google.com>, Elliott Hughes <enh@google.com>,
 James Morris <jmorris@namei.org>,
 Android Kernel Team <kernel-team@android.com>,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Subject: [PATCH 2/2 v4] proc: Add LSM hook checks to /proc/<tid>/timerslack_ns
Date: Thu, 21 Jul 2016 13:24:27 -0700
Message-Id: <1469132667-17377-2-git-send-email-john.stultz@linaro.org>
In-Reply-To: <1469132667-17377-1-git-send-email-john.stultz@linaro.org>
References: <1469132667-17377-1-git-send-email-john.stultz@linaro.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

As requested, this patch checks the existing LSM hooks
task_getscheduler/task_setscheduler when reading or modifying
the task's timerslack value.

Previous versions added new get/settimerslack LSM hooks, but
since they checked the same PROCESS__SET/GETSCHED values as
existing hooks, it was suggested we just use the existing ones.

Cc: Kees Cook <keescook@chromium.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
CC: Arjan van de Ven <arjan@linux.intel.com>
Cc: Oren Laadan <orenl@cellrox.com>
Cc: Ruchi Kandoi <kandoiruchi@google.com>
Cc: Rom Lemarchand <romlem@android.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Colin Cross <ccross@android.com>
Cc: Nick Kralevich <nnk@google.com>
Cc: Dmitry Shmidt <dimitrysh@google.com>
Cc: Elliott Hughes <enh@google.com>
Cc: James Morris <jmorris@namei.org>
Cc: Android Kernel Team <kernel-team@android.com>
Cc: linux-security-module@vger.kernel.org
Cc: selinux@tycho.nsa.gov
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2:
 * Initial swing at adding settimerslack LSM hook
v3:
 * Fix current/p switchup bug noted by NickK
 * Add gettimerslack hook suggested by NickK
v4:
 * Dropped adding get/settimerslack LSM hooks, and
   just reuse the get/setscheduler ones.

 fs/proc/base.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index c94abae..02f8389 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2286,6 +2286,12 @@ static ssize_t timerslack_ns_write(struct file *file, const char __user *buf,
 		goto out;
 	}
 
+	err = security_task_setscheduler(p);
+	if (err) {
+		count = err;
+		goto out;
+	}
+
 	task_lock(p);
 	if (slack_ns == 0)
 		p->timer_slack_ns = p->default_timer_slack_ns;
@@ -2314,6 +2320,10 @@ static int timerslack_ns_show(struct seq_file *m, void *v)
 		goto out;
 	}
 
+	err = security_task_getscheduler(p);
+	if (err)
+		goto out;
+
 	task_lock(p);
 	seq_printf(m, "%llu\n", p->timer_slack_ns);
 	task_unlock(p);
-- 
1.9.1
